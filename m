From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/4] reset: add test cases for "--merge-dirty" option
Date: Fri, 11 Sep 2009 07:05:34 +0200
Message-ID: <200909110705.35083.chriscool@tuxfamily.org>
References: <20090910200334.3722.20140.chriscool@tuxfamily.org> <20090910202333.3722.13214.chriscool@tuxfamily.org> <alpine.LNX.2.00.0909101757530.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 11 07:04:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlyJ7-0003CF-KO
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 07:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbZIKFEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 01:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbZIKFEQ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 01:04:16 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:55904 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbZIKFEP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 01:04:15 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 02402818036;
	Fri, 11 Sep 2009 07:04:10 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D2DDF8180BC;
	Fri, 11 Sep 2009 07:04:07 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LNX.2.00.0909101757530.28290@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128170>

On Friday 11 September 2009, Daniel Barkalow wrote:
> On Thu, 10 Sep 2009, Christian Couder wrote:
>
>     This shows that with the "--merge-dirty" option,
>
>   changes that are both in the work tree and the index are kept
>
>     in the work tree after the reset (but discarded in the index). As
> with the "--merge" option,
>
>   changes that are in both the work tree and the index are discarded
>
>     after the reset.
>
> I'm lost here.
>
> If you have:
>
>          working index HEAD target
> version     B      B     A     A
>
> You get:
>
>          working index HEAD target
> --m-d       B      A     A     A
> --merge     A      A     A     A
>
> ?

Yes, files that are not different between HEAD and target are changed like 
that. Thanks for explaining it better than I could!

And also when files are different between HEAD and target (and when the 
index is the same as the working tree but different than HEAD), the result 
from -m-d and --merge are different:

If you have:

          working index HEAD target
 version     B      B     A     C

You get:

          working index HEAD target
 --m-d       B      B     A     C   : --m-d fails (so no change)
 --merge     C      C     C     C   : success but changes B discarded

In t/t7110-reset-merge.sh these differences are shown by test cases 3, 4, 5 
and 6:

--merge: discard changes added to index 1
--merge: discard changes added to index 2
--merge-dirty: not ok with touched changes in index
--merge-dirty: keep untouched changes

> > ---
> >  t/t7110-reset-merge.sh |   54
> > +++++++++++++++++++++++++++++++++++++++++++---- 1 files changed, 49
> > insertions(+), 5 deletions(-)
> >
> > diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
> > index 45714ae..1e6d634 100755
> > --- a/t/t7110-reset-merge.sh
> > +++ b/t/t7110-reset-merge.sh
> > @@ -19,7 +19,7 @@ test_expect_success 'creating initial files' '
> >       git commit -m "Initial commit"
> >  '
> >
> > -test_expect_success 'ok with changes in file not changed by reset' '
> > +test_expect_success '--merge: ok if changes in file not touched by
> > reset' '
>
> Should probably have the "--merge: " from the beginning, since you're
> adding the test in this series anyway. That would make the diff come out
> clearer.

Yeah, but I am not sure that patches 3/4 and 4/4 will get merged in the end.
If they are not merged it will be better if there is no "--merge: ". 

If they get merged, the option name '--merge-dirty" will probably be changed 
to something else like "--merge-safe" so I will have to change some patches 
anyway.

Thanks,
Christian.
