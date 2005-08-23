From: Jan Veldeman <jan.veldeman@gmail.com>
Subject: Re: [RFC] Stgit - patch history / add extra parents
Date: Tue, 23 Aug 2005 23:23:05 +0200
Message-ID: <20050823212305.GA5936@fanta>
References: <20050818195753.GA9066@fanta> <tnx64u2p81k.fsf@arm.com> <20050819194832.GA8562@fanta> <1124572356.7512.21.camel@localhost.localdomain> <20050821094059.GA5453@fanta> <Pine.LNX.4.63.0508221707520.23242@iabervon.org> <tnxvf1wd24m.fsf@arm.com> <Pine.LNX.4.63.0508231304130.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 23:23:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7gCR-0000Dl-M3
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 23:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVHWVUt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 17:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVHWVUt
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 17:20:49 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:5437 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932146AbVHWVUs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 17:20:48 -0400
Received: by wproxy.gmail.com with SMTP id i20so318330wra
        for <git@vger.kernel.org>; Tue, 23 Aug 2005 14:20:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=U9rZ2ZxOQEw7Lq/NqAzHfnv1ygAE8zMj09VVzDL8O7LWZMPXBic9wbQPoB3mbvmQR2LSJqh0++4fQxeHZj3NcyqnMoxp0xwFBj0Ac34vg8C40G0N3uLpEEd+5zislUyffZrnaGyoAM9+YrWMSFokYCefJZfU6bFPcIjAS4KX8ds=
Received: by 10.54.52.16 with SMTP id z16mr2516611wrz;
        Tue, 23 Aug 2005 14:20:43 -0700 (PDT)
Received: from localhost ([84.195.185.241])
        by mx.gmail.com with ESMTP id 26sm3394454wrl.2005.08.23.14.20.40;
        Tue, 23 Aug 2005 14:20:43 -0700 (PDT)
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508231304130.23242@iabervon.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7671>

Daniel Barkalow wrote:

> On Tue, 23 Aug 2005, Catalin Marinas wrote:
> 
> Something is legitimate as a parent if someone took that commit and did
> something to it to get the new commit. The operation which caused the
> change is not specified. But you only want to include it if anyone cares
> about the parent.

This is indeed what I thought a parent should be used for. As an adition,
I'll try to explain why I would sometimes want to care about some parents:

I want to track a mailine tree, but have quite a few changes, which shoudn't
be commited to the mainline immediately (let's call it my development tree).
This is why I would use stgit. But I would also want to colaborate with
other developers on this development tree, so I sometimes want to make
updates available of this development tree to the others. This is where
current stgit falls short. To easily share this development tree, I want
some history (not all, only the ones I choose) of this development tree
included, so that the other developers can easily follow my development.

The parents which should be visible to the outside, will always be versions
of my development tree, which I have previously pushed out. My way of
working would become:
* make changes, all over the place, using stgit
* still make changes (none of these gets tracked, intermittent versions are
  lost)
* having a good day: changes looks good, I want to push this out:
  * push my tree out
  * stgit-free (which makes the pushed out commits, the new parents of my
    stgit patches)
* restart from top

[...]
> This also depends on how exactly freeze is used; if you use it before
> commiting a modification to the patch without rebasing, you get:
> 
> old-top -> new-top
>       ^    ^
>        \  /
>       bottom
> 
> bottom to old-top is the old patch
> bottom to new-top is the new patch
> old-top to new-top is the change to the patch
> 
> Then you want to keep new-top as a parent for rebasings until one of these
> is frozen. These links are not interesting to look at, but preserve the
> path to the old-top:new-top change, which is interesting.

my proposal does something like this, but a little more: not only does it
keep track of the link between old-top and new-top, it also keeps track of
the links between old-patch-in-between and new-patch-in-between.
(This makes sense when the top is being removed or reordered)

I hope this kind of clarifies my intension.


Thank you for clarifying the meaning of parents.

Best regards,
Jan
