From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Remove branch by putting a null sha1 into the ref file.
Date: Wed, 20 Sep 2006 04:56:24 +0200
Message-ID: <200609200456.24714.chriscool@tuxfamily.org>
References: <20060918065429.6f4de06e.chriscool@tuxfamily.org> <Pine.LNX.4.64.0609180926590.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 04:50:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPsAJ-0001um-TM
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 04:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWITCuV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 22:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWITCuV
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 22:50:21 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:18402 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750859AbWITCuU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 22:50:20 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 034B424BD0;
	Wed, 20 Sep 2006 04:50:17 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.9.4
In-Reply-To: <Pine.LNX.4.64.0609180926590.4388@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27325>

Linus Torvalds wrote:
> On Mon, 18 Sep 2006, Christian Couder wrote:
> > With the new packed ref file format from Linus, this should be
> > the new way to remove a branch.
>
> Well, it's not really sufficient.
>
> Somebody should add this test-case
>
> 	git branch test
> 	git branch -d test
> 	git branch test/first
>
> which should work.
>
> It's entirely possible that the proper way to do branch deletion with
> packed branches is to simply re-pack without the old branch, rather than
> the negative branch model. 

Yes, and anyway git-branch should probably use some other git command for 
this, like "git-update-ref <ref> 0" or "git-update-ref --delete <ref>".

> I couldn't really decide.
>
> However: this part is definitely correct, considering that we allow the
> null sha1 in other places.
>
> > "refs.c" is fixed so that a null sha1 for a deleted branch does
> > not result in "refs/head/deleted does not point to a valid
> > commit object!" messages.

Well, it was in one of your patch already but I had not seen it. And I 
wrongly assumed that your patches were all merged into next but this one 
was not.

> And this last part is conceptually ok, but I think the implementaion is
> wrong:
> > "t/t3200-branch.sh" is fixed so that it uses git-show-ref
> > instead of checking that the ref does not exist when a branch
> > is deleted.
>
> I think you should change the
>
> 	! git-show-ref --verify --quiet -- "refs/heads/d/e/f" &&
>
> into
>
> 	git-show-ref --verify --quiet -- "refs/heads/d/e/f" ||
>
> instead, no?

It seems Junio found it ok, and I still think it is ok, but my description 
of the change is bad.

Maybe git-show-ref should have an option to check that a ref does not exist 
for example "git-show-ref --inexistant --quiet -- "refs/heads/d/e/f".

Thanks for your comments.

Christian.
