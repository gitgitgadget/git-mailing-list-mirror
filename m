From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: add format-patch options to send-email
Date: Tue, 16 Oct 2012 01:55:37 +0200
Message-ID: <20121015235537.GB2156@goldbirke>
References: <1350231243-13485-1-git-send-email-felipe.contreras@gmail.com>
 <20121015224857.GA2156@goldbirke>
 <CAMP44s07iydg0aMDQMTX7qh4Kk8w--sp1DtmTUeu=95WzAXfRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 01:55:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNuVm-000344-84
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 01:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718Ab2JOXzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 19:55:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:62215 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab2JOXzl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 19:55:41 -0400
Received: from localhost6.localdomain6 (p5B1307B3.dip0.t-ipconnect.de [91.19.7.179])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0LejPS-1Th11g07qA-00qP1F; Tue, 16 Oct 2012 01:55:38 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s07iydg0aMDQMTX7qh4Kk8w--sp1DtmTUeu=95WzAXfRQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:VPTnD6uzWLNI7LhUqd2rLwwRSUfsI/w/V/C2KynfOXU
 ornTrNs7ALpN+OTqXpxOkxt4pSuBHunnnDsFWsNqwTSkdZRUnS
 prFxF1jvUpeGdU2ctmztdPw1wrZRIp3I+2MtIfSqqUiH/03hqI
 BT8D/udnHK+6NZCMgCm7hdOVPRn4M/BREnIxC0dfyRMDtUCeEf
 a26SJlLIoAAXOOSC7oymO5Axz3mVwm7tSZxGtk3Q1Ihlun6t3o
 LbAe5e0muAZhVCrwdIqzT0RVwswBZdnd7EYE9fZB67/ZQnK2e+
 cJNeE1a+7XCLlSYj0ckot0B3D6QCBtfX4Jbi2tRlL9CNEwVgIs
 BEfinpzGr+0lZFDMEjS8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207788>

On Tue, Oct 16, 2012 at 01:37:35AM +0200, Felipe Contreras wrote:
> On Tue, Oct 16, 2012 at 12:48 AM, SZEDER G=E1bor <szeder@ira.uka.de> =
wrote:
>=20
> >> @@ -1559,11 +1559,12 @@ _git_send_email ()
> >>                       --signed-off-by-cc --smtp-pass --smtp-server
> >>                       --smtp-server-port --smtp-encryption=3D --sm=
tp-user
> >>                       --subject --suppress-cc=3D --suppress-from -=
-thread --to
> >> -                     --validate --no-validate"
> >> +                     --validate --no-validate
> >> +                     $__git_format_patch_options"
> >>               return
> >>               ;;
> >>       esac
> >> -     COMPREPLY=3D()
> >> +     __git_complete_revlist_file
> >
> > While send-email accepts a rev-list, it doesn't accept
> > 'HEAD:Documentation', does it?  So __git_complete_revlist() would b=
e
> > better here, because that makes the intent clear.
>=20
> Then _git_send_email should be fixed first. I'm simply doing the same
> as _git_send_email.

I can't decipher this recursion here.

> >> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> >> index 92d7eb4..c4b6c13 100755
> >> --- a/t/t9902-completion.sh
> >> +++ b/t/t9902-completion.sh
> >> @@ -146,6 +146,22 @@ test_expect_success '__gitcomp - suffix' '
> >>       test_cmp expected out
> >>  '
> >>
> >> +setup_repository ()
> >> +{
> >> +     mkdir "$1" && (
> >> +     cd "$1" &&
> >> +     git init &&
> >> +     test_tick &&
> >> +     git commit --allow-empty -m "Initial"
> >> +     )
> >> +}
> >> +
> >> +test_expect_success 'prepare' '
> >> +     setup_repository one &&
> >> +     git clone one test &&
> >
> > Why are these new repositories needed?
>=20
> Because otherwise 'git send-email ma' wouldn't succeed.

Even then you don't need two additional repos, because just one
commit in the test repo would suffice.  And the test 'setup for ref
completion' already takes care of that.

> >> +     cd test
> >
> > This 'cd' makes all subsequent tests to be executed in a different
> > repository than previously, which breaks 'checkout completes ref
> > names'.
>=20
> I don't know which test you are talking about, it's not on my repo,
> and all the completion test pass with this patch.

It's in v1.8.0-rc0~1^2 (t9902: add completion tests for "odd" filenames=
,
2012-09-26), which is the commit your patch conflicts with.


Best,
G=E1bor
