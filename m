From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 1/4] Add testcase for ammending and fixing author in
	git commit.
Date: Fri, 02 Nov 2007 17:13:50 -0400
Message-ID: <1194038030.25288.20.camel@hinata.boston.redhat.com>
References: <1194017589-4669-1-git-send-email-krh@redhat.com>
	 <7vy7dg1kdg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 22:15:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io3rD-00054t-Dc
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 22:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbXKBVO5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2007 17:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752272AbXKBVO4
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 17:14:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35035 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111AbXKBVO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 17:14:56 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA2LDvDI011481;
	Fri, 2 Nov 2007 17:13:57 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA2LDupw007224;
	Fri, 2 Nov 2007 17:13:56 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA2LDt9W007974;
	Fri, 2 Nov 2007 17:13:55 -0400
In-Reply-To: <7vy7dg1kdg.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63176>

On Fri, 2007-11-02 at 13:07 -0700, Junio C Hamano wrote:
> Kristian H=C3=B8gsberg <krh@redhat.com> writes:
>=20
> > Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
> > ---
> >  t/t7501-commit.sh |   10 ++++++++++
> >  1 files changed, 10 insertions(+), 0 deletions(-)
> >
> > diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> > index b151b51..3f2112a 100644
> > --- a/t/t7501-commit.sh
> > +++ b/t/t7501-commit.sh
> > @@ -163,4 +163,14 @@ test_expect_success 'partial commit that invol=
ves removal (3)' '
> > =20
> >  '
> > =20
> > +author=3D"The Real Author <someguy@his.email.org>"
> > +test_expect_success 'amend commit to fix author' '
> > +
> > +	git reset --hard
> > +	git cat-file -p HEAD | sed -e "s/author.*>/author $author/" > exp=
ected &&
> > +	git commit --amend --author=3D"$author" &&
> > +	git cat-file -p HEAD > current &&
> > +	diff expected current
> > +=09
> > +'
> >  test_done
>=20
> This can't be right.  How are you ignoring the differences in
> committer dates?

t/test-lib.sh fixes GIT_COMMITTER_DATE so all commits have the date

committer C O Mitter <committer@example.com> 1112911993 -0700

unless you use test_tick.

> By the way, I _think_ git-commit.sh allows fixing author name/email
> without molesting the author timestamp (i.e. takes it from the
> amended commit).  That should probably be checked with the test
> as well.

You're right, I need to pick GIT_AUTHOR_DATE from the ammended commit.
Ok, I'll need to rewrite determine_author_info() a little bit.  I might
get an update patch out this weekend.

cheers,
Kristian
