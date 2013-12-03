From: Javier Domingo <javierdo1@gmail.com>
Subject: Re: Branching workflow
Date: Tue, 3 Dec 2013 20:10:02 +0100
Message-ID: <CALZVapk9bD7TWGbru8VJhjV_=BYJKhTfHG7Z5hiFpzz-d4BwCQ@mail.gmail.com>
References: <CALZVapnjN_69y0+PLFA2t8b72WDK+D4BhjDRnRPxU_9iX+_NuA@mail.gmail.com>
 <20131203184250.GB3163@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Dec 03 20:10:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnvMZ-0007c6-Dy
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 20:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab3LCTKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 14:10:24 -0500
Received: from mail-vc0-f176.google.com ([209.85.220.176]:60685 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab3LCTKX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 14:10:23 -0500
Received: by mail-vc0-f176.google.com with SMTP id lf12so10043580vcb.7
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 11:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0PxJVQTvsJjwZXt2dEgkXHq/LzD+OFh43ZZLfk30e/Y=;
        b=t2UVnTuMzrZHdJoHW6Y8q+SXj5TwebvXG+wNpLyx0AA3rQMvzR+RtHeOKQuWKVuCmt
         bwy/EWcamUlfhq3qb0ZtWKxV0QuK09G6HQcqegYE63/ClWXxjcctOGms5XzPZPJo/Evk
         iFAwanoOeaAkXJURGjeB76WD0LqRpWAj/arEBpoJ2HfNXD0I+BmklXTSZxZ9hppFrWec
         nqk3KJnnjPVeh+mBlztjt+1LX8W3ycSWjJPICYydYa5MpIG1L5kAWQ/N7SGSTVBOJ1CI
         ctZqpP5JdYvFG48FlkuxiejkREOVutjYKKcLao+Y4da0DSseaCSzaTq40ETYR1CcYemP
         e6Eg==
X-Received: by 10.221.64.17 with SMTP id xg17mr56877583vcb.5.1386097822495;
 Tue, 03 Dec 2013 11:10:22 -0800 (PST)
Received: by 10.58.233.203 with HTTP; Tue, 3 Dec 2013 11:10:02 -0800 (PST)
In-Reply-To: <20131203184250.GB3163@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238718>

Hi John!,

Thanks a lot for your tip, but I have the problem that I would need to
have a linear history in master (forgot to mention it explicitly) ;(

I build on master branch, and getting to a previous version is hereby needed.

I had thought about the revert workflow, but using --no-commit. I
would then have a way to mark stuff as re-mergeable.

I am pretty lost with this. Is like a non-ending hell, because I have
to provide linear history to master and develop, and allowing master
to be revertable.

Isn't there something like git revert <branch-name> so that all
commits that have been merged from that branch, and don't belong to
any other, can be reverted?

With this history:
A<-B<-C := develop
B<-D<-Z<-Y := feature/bad
B<-D<-G<-H := feature/good
A<-B<-C<-z<-g<-y<-h := master

(caps original commits, regular merged commits)

so that:
git checkout master
git revert feature/bad

would revert z and h in master history, in one single commit, and
making available merging feature/bad when it's ready, with all
conflicting if needed.

Ideas welcome =)
Javier Domingo Cansino


2013/12/3 John Keeping <john@keeping.me.uk>:
> On Tue, Dec 03, 2013 at 07:06:20PM +0100, Javier Domingo wrote:
>> I have been using a very basic workflow for branching, features each
>> in a branch.
>>
>> My branches would be:
>> - develop <= Main upstream branch
>> - feature/* fix/*  <= Feature and fix branches
>> - master <= Integration of the whole feature and fix branches
>>
>> So I have now came up with a very difficult task. I just discovered
>> that one of those branches, lest call it feature/bad, is evil and is
>> making the integration branch (master) fail horribly.
>>
>> In my workflow, I tend to merge develop (official updates) into my
>> feature branches, and them into master.
>>
>> So now I have the big problem on how to undo all changes from
>> feature/fix. I have been told that one alternative workflow would be
>> to revert the last merge and remerge it into master, so that I have
>> always just one commit to revert if necessary (instead of the
>> monstrous quantity I have now to).
>>
>> The workflow proposal should be in order of importance:
>> - Let me stay up-to-date with develop branch
>> - Easy to revert in master
>> - Have a clean history
>> - Easy to follow
>>
>> I think I should be capable of doing some sort of merge/rebase
>> branching workflow to avoid having to do that. I have thought about
>> rebasing always the feature branches, and rebasing master into all of
>> them, but it seems pretty strange to me.
>>
>> If anyone can give any advice, I would fully appreciate!
>
> It sounds like you want a throwaway integration branch.  This is similar
> to the workflow Junio uses with git.git's "pu" branch, which involves
> rebuilding a branch by:
>
>     * resetting it to some base ("develop" in your case)
>     * merging in the required feature branches
>
> This may not quite be what you want because it does mean that you cannot
> build on the integration branch - it is intended to be rewritten often,
> but it does provide a good platform for testing features and then
> merging them to a stable branch once they have proved to be good.
>
> The advantage is that you know that the integration merges are temporary
> and you can test on top of that without having set the result in stone.
>
> <shameless plug>If you are interested in such a workflow then you may
> want to try my git-integration program [1] to manage integration
> branches.
>
> There is also a reimplementation in Ruby with a slightly different
> feature set [2]
>
> [1] http://johnkeeping.github.io/git-integration
> [2] http://github.com/felipec/git-reintegrate
