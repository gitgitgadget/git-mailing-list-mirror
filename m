From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Mon, 3 Nov 2014 19:54:39 +0700
Message-ID: <CACsJy8C34PyK4rPQC_wFgms=gVCs2FN_5aUSMfzJawErZHHwFg@mail.gmail.com>
References: <1413090791-14428-1-git-send-email-max@max630.net>
 <CACsJy8BUtkWKE+P_sHgpAY6wJ9tpzxZRtZHULiLoO=dGnBjkHQ@mail.gmail.com>
 <543D58D9.5060606@web.de> <xmqqoatezhnx.fsf@gitster.dls.corp.google.com>
 <20141014183431.GA8157@wheezy.local> <543D7EBA.4040206@web.de>
 <20141014221509.GA10580@wheezy.local> <543EC390.4000709@web.de>
 <20141016205453.GA8441@wheezy.local> <54441147.5080204@web.de> <20141020041109.GA5784@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>, Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 03 13:55:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlHAC-0002Qe-1O
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 13:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbaKCMzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 07:55:12 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:53907 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbaKCMzL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 07:55:11 -0500
Received: by mail-ie0-f179.google.com with SMTP id rl12so5221793iec.10
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 04:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DFz6KnZJij+zU0/h/acbe1dFnphrWt8Rct0G8ilWc28=;
        b=tTaiJtW3pjnMJOBdjraGnPtMa1wOQray7LXH1eVCQ96yOHzIGwxSlqY7WGC0xV1rqo
         bYgv54Es2ZYOZf4+FHr7L3GEk+GIgSiBjMo/5FI3IHI6Yn/g85N71N4nH+ZIMax2K9Pi
         vevHjhOmxsBuuT42WepR9b2c+XoW13MdyxK6lD/t/yaI9Zj3rwCp2itSgpLth5D9s+Va
         tQMjN1xkG28DZtrEiXbf+22go61RkP7O2YXk44MTmM7n5mi8blbXif8uZv3/HXYxglkY
         meBrO3yCStvbEnldGx5V11IWuIsbotsxFyM+QQZVbJOvTpXnsYFBcyj53Pby/k7NXz3C
         IuhA==
X-Received: by 10.50.41.99 with SMTP id e3mr16063316igl.41.1415019310641; Mon,
 03 Nov 2014 04:55:10 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Mon, 3 Nov 2014 04:54:39 -0800 (PST)
In-Reply-To: <20141020041109.GA5784@wheezy.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ping.. any idea how to go from here..

On Mon, Oct 20, 2014 at 11:11 AM, Max Kirillov <max@max630.net> wrote:
> On Sun, Oct 19, 2014 at 09:30:15PM +0200, Jens Lehmann wrote:
>> Am 16.10.2014 um 22:54 schrieb Max Kirillov:
>>> On Wed, Oct 15, 2014 at 08:57:20PM +0200, Jens Lehmann wrote:
>>>> Am 15.10.2014 um 00:15 schrieb Max Kirillov:
>>>>> I think the logic can be simple: it a submodule is not
>>>>> checked-out in the repository "checkout --to" is called
>>>>> from, then it is not checked-out to the new one also. If it
>>>>> is, then checkout calls itself recursively in the submodule
>>>>> and works like being run in standalone repository.
>
>>>> But when I later decide to populate the submodule in a
>>>> "checkout --to" work tree, should it automagically also
>>>> use the central storage, creating the modules/<name>
>>>> directory there if it doesn't exist yet? I think that'd
>>>> make sense to avoid having the work tree layout depend
>>>> on the order commands were ran in. And imagine new
>>>> submodules, they should not be handled differently from
>>>> those already present.
>
>>> Like place the common directory to
>>> $MAIN_REPO/.git/modules/$SUB/ and worktree-specific part to
>>> $MAIN_REPO/.git/worktrees/$WORKTREE/modules/$SUB, rather
>>> than placing all into the socond one? It would make sense to
>>> make, but then it would be imposible to checkout a diferent
>>> repository into the same submodule in different superproject
>>> checkouts. However stupid is sounds, there could be cases
>>> if, for example, at some moment submodule is being replaced
>>> by another one, and older worktrees should work with older
>>> submodule, while newer uses the newer submodule.
>
>> Yes, but I believe that the user must be careful to not
>> reuse the same submodule name for a different repo anyways,
>> no matter if shared or not. Currently you'll get a warning
>> about that when trying to add a submodule whose name is
>> already found in .git/modules to avoid such confusion.
>
> Yes, while trying to write tests for this case I discovered
> that there are warnings and the recommended way is to use
> different names for different repositories even if they are
> pointing to the same path. Then always placing common
> directory into the .git/modules/<module> could be a good
> idea, and in very special cases users could manually create
> repositories with custom placement.
>
>>> Also, could you clarify the usage of the /modules/
>>> directory. I did not notice it to affect anything after the
>>> submofule is placed there. Submodule operations use the
>>> submodule repositories directly (through the git link, which
>>> can point anywhere), or in .gitmodules file, or maybe in
>>> .git/config. So there is actually no need to have that
>>> gitdir there. Is it correct?
>
>> Nope. When submodules are cloned their git directory is
>> placed under .git/modules/<submodule name>, the .git file
>> in the work tree points there and the core.worktree setting
>> points back from there to the work tree.
>
> I meant is the fact that gitdir is placed in modules, rather
> than in any other place, is used anywhere. There are 2
> places to put the gitdir of submodule in linked copy:
> 1. $MAIN_REPO/.git/worktrees/$WORKTREE/modules/$SUB
> 2. $MAIN_REPO/.git/modules/$SUB/worktrees/$SUB_WTNAME
> First one is suggested by submodule way of placing gitdirs,
> and the second one by worrktree way. There are reasons to
> have the second one - garbage collection and check that 2
> branch is not checked out twice. Are there resons to have
> the 1st one? The one is to prevent use of different
> repositories with the same name, anything else?
>
> --
> Max



-- 
Duy
