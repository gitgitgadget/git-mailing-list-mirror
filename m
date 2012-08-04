From: Adam Butcher <dev.lists@jessamine.co.uk>
Subject: Re: [PATCH] tests: Introduce =?utf-8?b?dGVzdF9zZXE=?=
Date: Sat, 4 Aug 2012 22:10:08 +0000 (UTC)
Message-ID: <loom.20120805T000957-218@post.gmane.org>
References: <7v3943bsuc.fsf@alter.siamese.dyndns.org> <1344032464-14104-1-git-send-email-michal.kiedrowicz@gmail.com> <7vfw83a7t5.fsf@alter.siamese.dyndns.org> <20120804101403.10ad79b5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 00:10:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxmYE-0007vN-E2
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 00:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab2HDWKV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Aug 2012 18:10:21 -0400
Received: from plane.gmane.org ([80.91.229.3]:47580 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753833Ab2HDWKU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 18:10:20 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SxmY7-0007sh-TY
	for git@vger.kernel.org; Sun, 05 Aug 2012 00:10:19 +0200
Received: from munkyhouse.force9.co.uk ([84.92.244.81])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 00:10:19 +0200
Received: from dev.lists by munkyhouse.force9.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 00:10:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 84.92.244.81 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202894>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz <at> gmail.com> writes:
> Junio C Hamano <gitster <at> pobox.com> wrote:
> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > index c8b4ae3..7dc70eb 100644
> > --- a/t/test-lib-functions.sh
> > +++ b/t/test-lib-functions.sh
> > @@ -543,11 +543,12 @@ test_cmp() {
> >  #	done
> > =20
> >  test_seq () {
> > -	test $# =3D 2 && { first=3D$1; shift; } || first=3D1
> > -	test $# =3D 1 ||
> > -	error "bug in the test script: not 1 or 2 parameters to test_seq"
> > -	last=3D$1
> > -	"$PERL_PATH" -le 'print for "$ARGV[0]".."$ARGV[1]"' "$first" "$la=
st"
> > +	case $# in
> > +	1)	set 1 "$@" ;;
> > +	2)	;;
> > +	*)	error "bug in the test script: not 1 or 2 parameters to=20
test_seq" ;;
> > +	esac
> > +	"$PERL_PATH" -le 'print for $ARGV[0]..$ARGV[1]' "$@"
> >  }
> > =20
> >  # This function can be used to schedule some commands to be run

-- >8 --
Subject: [PATCH] Fixup test_seq: ensure arguments passed to script.

If the arguments passed to to test_seq start with '-' (e.g. negative
integers) they are considered perl options and the program errors.  By
prefixing the user argument list with '--' when passing to perl, this
is avoid and sequences involving negative numbers are possible.
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 5a1a95a..ed44f5e 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -539,7 +539,7 @@ test_seq () {
 	2)	;;
 	*)	error "bug in the test script: not 1 or 2 parameters to=20
test_seq" ;;
 	esac
-	"$PERL_PATH" -le 'print for $ARGV[0]..$ARGV[1]' "$@"
+	"$PERL_PATH" -le 'print for $ARGV[0]..$ARGV[1]' -- "$@"
 }
=20
 # This function can be used to schedule some commands to be run
--=20
1.7.11.msysgit.1.1.gf0affa1
