From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] t6030 (bisect): work around Mac OS X "ls"
Date: Thu, 24 Jul 2008 08:06:47 +0200
Organization: glandium.org
Message-ID: <20080724060647.GA24587@glandium.org>
References: <Pine.GSO.4.62.0807232014030.14945@harper.uchicago.edu> <200807240757.26290.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@uchicago.edu>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Jul 24 08:08:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLtzn-0003DI-VH
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 08:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbYGXGHG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 02:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbYGXGHG
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 02:07:06 -0400
Received: from vuizook.err.no ([194.24.252.247]:51474 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752630AbYGXGHF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 02:07:05 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KLtyZ-0008Bj-34; Thu, 24 Jul 2008 08:07:01 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KLtyR-0006PM-LJ; Thu, 24 Jul 2008 08:06:47 +0200
Content-Disposition: inline
In-Reply-To: <200807240757.26290.chriscool@tuxfamily.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89839>

On Thu, Jul 24, 2008 at 07:57:26AM +0200, Christian Couder wrote:
> Le jeudi 24 juillet 2008, Jonathan Nieder a =E9crit :
> > t6030-bisect-porcelain.sh relies on "ls" exiting with nonzero
> > status when asked to list nonexistent files.  Unfortunately,
> > /bin/ls on Mac OS X 10.3 exits with exit code 0.  So use "echo
> > <shell glob pattern>" and grep instead.
> >
> > Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
> > ---
> > 	With this change, all the non-git-svn tests pass on my machine.
> > 	I think the fix is portable but I do not have the experience to
> > 	be sure.  So I would be happier if someone looks it over.
> >
> >  t/t6030-bisect-porcelain.sh |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain=
=2Esh
> > index 0626544..d19fc1c 100755
> > --- a/t/t6030-bisect-porcelain.sh
> > +++ b/t/t6030-bisect-porcelain.sh
> > @@ -76,7 +76,7 @@ test_expect_success 'bisect fails if given any ju=
nk
> > instead of revs' ' test_must_fail git bisect start foo $HASH1 -- &&
> >  	test_must_fail git bisect start $HASH4 $HASH1 bar -- &&
> >  	test -z "$(git for-each-ref "refs/bisect/*")" &&
> > -	test_must_fail ls .git/BISECT_* &&
> > +	echo .git/BISECT_* | test_must_fail grep BISECT_[^*] &&
>=20
> Perhaps the following is simpler:
>=20
> +	test -z "$(ls .git/BISECT_*)" &&

That is still a useless use of ls ;)

Mike
