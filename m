Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E162C1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 21:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbfJCVo1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 17:44:27 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:39579 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbfJCVo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 17:44:26 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id A64571C0003;
        Thu,  3 Oct 2019 21:44:24 +0000 (UTC)
Date:   Fri, 4 Oct 2019 03:14:22 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     harish k <harish2704@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
Message-ID: <20191003214422.d4nocrxadxt47smg@yadavpratyush.com>
References: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com>
 <20160331164137.GA11150@gmail.com>
 <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com>
 <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Harish,

Thanks for the patch. Unfortunately, it seems your mail client messed up 
the formatting, and the patch won't apply. I'm guessing it is because 
your mail client broke long lines into two, messing up the diff.

We use an email-based workflow, so please either configure your mail 
client so it doesn't munge patches, or use `git send-email`. You can 
find a pretty good tutorial on sending patches via email over at [0]. 
The tutorial is for git.git, but works for git-gui.git as well.

If you feel more comfortable with GitHub pull requests, please take a 
look at Gitgitgadget [1]. Johannes (in Cc) has used it recently to send 
patches based on the git-gui repo (AFAIK, it was originally designed 
only for the git.git repo). Maybe ask the folks over there how they do 
it.

One more thing: your patch is based on the main Git repo. That repo is 
not where git-gui development takes place. The current "official" repo 
for git-gui is over at [2]. Please base your patches on top of that 
repo.

[0] https://matheustavares.gitlab.io/posts/first-steps-contributing-to-git#submitting-patches
[1] https://gitgitgadget.github.io/
[2] https://github.com/prati0100/git-gui

Now on to the nitty gritty details.

I like the idea. In fact, there were some discussions recently about 
having configurable key bindings for _all_ shortcuts in git-gui. Nothing 
concrete has been done in that direction yet though. But I feel like 
this is a pretty good first step.

On 03/10/19 08:18PM, harish k wrote:
> Hi All,
> I', Just reopening this feature request.
> A quick summary of my proposal is given below.
> 
> 1. This PR will allow an additional configuration option
> "guitool.<name>.gitgui-shortcut" which will allow us to specify
> keyboard shortcut  for custom commands in git-gui

A pretty nice way of doing it. But I would _really_ like it if there was 
an option in the "create tool" dialog to specify the shortcut. People of 
a gui tool shouldn't have to mess around with config files as much as 
possible.
 
> 2. Even there exists a parameter called "guitool.<name>.shortcut"
> which is used by git-cola, I suggest to keep this new additional
> config parameter as an independent config parameter, which will not
> interfere with git-cola in any way, because, both are different
> applications and it may have different "built-in" shortcuts already
> assigned. So, sharing shortcut scheme between two apps is not a good
> idea.

David has advocated inter-operability between git-gui and git-cola. 
While I personally don't know how many people actually use both the 
tools at the same time, it doesn't sound like a bad idea either.

So, sharing shortcuts with git-cola would be nice. Of course, it would 
then mean that we would have to parse the config parameter before 
feeding them to `bind`. I don't suppose that should be something too 
complicated to do, but I admit I haven't looked too deeply into it.

I'd like to hear what other people think about whether it is worth the 
effort to inter-operate with git-cola.
 
> 3. New parameter will expect shortcut combinations specified in TCL/TK
> 's format and we will not be doing any processing on it. Will keep it
> simple.

Are you sure that is a good idea? I think we should at least make sure 
we are not binding some illegal sequence, and if we are, we should warn 
the user about it. And a much more important case would be when a user 
over-writes a pre-existing shortcut for other commands like "commit", 
"reset", etc. In that case, the menu entires of those commands would 
still be labelled with the shortcut, but it won't actually work.

Yes, your current implementation keeps things simple, but I think some 
light processing would be beneficial. And if we do decide to go the 
inter-operability with git-cola route, then processing would be needed 
anyway, and we can validate there.
 
> ---
>  Documentation/config/guitool.txt | 15 +++++++++++++++
>  git-gui/lib/tools.tcl            | 15 ++++++++++++---
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/config/guitool.txt b/Documentation/config/guitool.txt
> index 43fb9466ff..79dac23ca3 100644
> --- a/Documentation/config/guitool.txt
> +++ b/Documentation/config/guitool.txt
> @@ -48,3 +48,18 @@ guitool.<name>.prompt::
>   Specifies the general prompt string to display at the top of
>   the dialog, before subsections for 'argPrompt' and 'revPrompt'.
>   The default value includes the actual command.
> +
> +guitool.<name>.gitgui-shortcut
> + Specifies a keyboard shortcut for the custom tool in the git-gui
> + application. The value must be a valid string ( without "<" , ">" wrapper )
> + understood by the TCL/TK 's bind command.See
> https://www.tcl.tk/man/tcl8.4/TkCmd/bind.htm
> + for more details about the supported values. Avoid creating shortcuts that
> + conflict with existing built-in `git gui` shortcuts.
> + Example:
> + [guitool "Terminal"]
> + cmd = gnome-terminal -e zsh
> + noconsole = yes
> + gitgui-shortcut = "Control-y"
> + [guitool "Sync"]
> + cmd = "git pull; git push"
> + gitgui-shortcut = "Alt-s"

The "Documentation/" subdirectory belongs to the Git project, and not to 
git-gui, so if you want to see this change, you'd have to submit a 
separate patch for it.

As far as git-gui's documentation is concerned, unfortunately there is 
none yet. I have been meaning to start working towards it, but just 
haven't found the time or motivation to do it yet.

> diff --git a/git-gui/lib/tools.tcl b/git-gui/lib/tools.tcl

Like I mentioned before, please base your patches on the git-gui.git 
repo, and not git.git. So, this should read "a/lib/tools.tcl" instead of 
"a/git-gui/lib/tools.tcl".

I haven't looked at the contents of the patch because I can't apply it, 
and I'd prefer to tinker around with it before commenting. So please 
re-send the patch in the proper format and we can discuss the 
implementation :).

> index 413f1a1700..40db3f6395 100644
> --- a/git-gui/lib/tools.tcl
> +++ b/git-gui/lib/tools.tcl
[snip]

-- 
Regards,
Pratyush Yadav
