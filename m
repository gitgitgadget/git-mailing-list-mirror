Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99B3C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 04:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJNExS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 00:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJNExR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 00:53:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24226169136
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 21:53:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r17so8061450eja.7
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 21:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nt/FHXqeA0l2X8/qDk2XwyvFDuaFPEzHbKiZQ8Gwa6I=;
        b=FSWkcCRm23E5L3AmoHOUYbSc+v5zriYfJ79QfFB9dihyHUVUTo41nmb5vpikGyDscR
         /TmxSDkJCeyJNruplfzIw5UrtFuL7damD5gw/YndCnJzdRWsbVabeMzKj98yWR6TSZt3
         He78AdbivLLYeSICR+YfOJB7m+CnLynu4paG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nt/FHXqeA0l2X8/qDk2XwyvFDuaFPEzHbKiZQ8Gwa6I=;
        b=kEMJL0JtRPS7Lse6Et0oyQlLW10SJk2gzByYVtP+jofN6mXI4RyRxnHpVGWBCw2zIK
         6lWM3DGEbrOsXJ4YvFBHnFvian+dGVml3Y4f/7ln1+oEXOdZ7gQQoT4hulVLBt+gZbrq
         vS1LPAjW7UaGiVefqFCk3eJYc+o78AOEsqVHm3VV5I9lE3NafhIzCFjmlMNcSfk7FyVI
         rbzfa8kPz1Yx7LFvc5pYptCvCLvmkYCXv6q7OVi/6kfxdVhP3OC0nx0Olc/9+EcVx0lu
         uqcfJ/Y0kvG5bURNACdEIIDj7l2duQlCxIuaZTkJmPPij7MyZwFAXWzIeo6qo2dKivFr
         rp6g==
X-Gm-Message-State: ACrzQf3dRDaimQeLWC6qPN5vGhQ0ZFtxHF4riiOjtRAQM66LUuQkDKfY
        HujgoSFji0dVIRLp7IU8U3nwrWCD2Cf/gkyH/UN9Jw==
X-Google-Smtp-Source: AMsMyM516uNjB0nFWaG3lwzpGssjWxCrPijQhPP/9Ow42MiHt40Kspmos70OfBxsXcaGo5FBAT5DXA3YJ7uGX+eGvdY=
X-Received: by 2002:a17:906:c14f:b0:78d:105b:e57f with SMTP id
 dp15-20020a170906c14f00b0078d105be57fmr2232613ejc.672.1665723194559; Thu, 13
 Oct 2022 21:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1381.git.1665590389045.gitgitgadget@gmail.com> <xmqqedvbcrnn.fsf@gitster.g>
In-Reply-To: <xmqqedvbcrnn.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 14 Oct 2022 06:53:03 +0200
Message-ID: <CAPMMpoigKVzhXu1WqSrx13MP1jR0J+ajkwRVVtY_LwHYAoWeTg@mail.gmail.com>
Subject: Re: [PATCH] mergetool: new config guiDefault supports auto-toggling
 gui by DISPLAY
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2022 at 11:58 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +     enum difftool_gui_mode gui_mode;
>
> This is left uninitialized ...
>

This is clearly a bug, and you've just solved a mystery for me. At one
point one test behaved "crazily", reporting an error as though --gui
had been specified in conflict with another option, despite it not
having been specified at all! I was unable to reproduce this behavior
in any way, and uncomfortably declared it must have been a "bit-flip"
error. Now I understand why, and how this class of error can occur in
C. Thank you for spotting this.

I had incorrectly assumed that it would be implicitly initialized to
0, meaning GUI_BY_CONFIG. Even if that had been true, it was a mistake
on my part to not be explicit about this default value - I failed to
use the enum for its intended purpose of making the code easy to
understand.

>
> [...] Isn't gui_mode variable ...
> ... still uninitialized here?  The old use_gui_tool was initialized
> to 0 so it wouldn't have had this problem.

Absolutely. This meant that *occasionally*, it would look like --gui
or --no-gui was specified even though it was not. Most of the time the
uninitialized value did not exactly match 1 or -1, so it looked like
things were working correctly, even though they were doing so
"accidentally".

>
> > -     die_for_incompatible_opt3(use_gui_tool, "--gui",
> > +     die_for_incompatible_opt3(gui_mode == GUI_ENABLED, "--gui",
> >                                 !!difftool_cmd, "--tool",
> >                                 !!extcmd, "--extcmd");
> >
> > -     if (use_gui_tool)
> > +     if (gui_mode == GUI_ENABLED)
> >               setenv("GIT_MERGETOOL_GUI", "true", 1);
>
> I suspect that there is no need to introduce a enum.

An enum is unnecessary, I only added it in order for a tristate
"gui_mode" value to be legible.

Case in point, you proposed that -1 could mean "_BY_CONFIG", whereas I
(possibly against all prior logic in this codebase) assumed it would
make more sense to have -1 be "_FALSE" in this case; the enum helps
avoid any confusion. If you find the enum has a nontrivial cost or
fails to improve understandability I am happy to remove it and use
simple int values instead.

> The flow would
> probably be
>
>  * git_config(difftool_config) would learn to parse the .guiDefault
>    option and initialize use_gui_tool to -1 when set to "auto" (and
>    to 0 with "false", to 1 with "true").
>
>  * Call to parse_options() then overwrites use_gui_tool with either
>    0 or 1 when --no-gui or --gui is given.
>
>  * After parse_options() returns, use_gui_tool can be examined and
>    when it is 0 or 1, then nothing need to change.  The current code
>    before this patch is doing what the user wants when an explicit
>    command line option is given.
>
>  * When use_gui_tool is -1, we need a new code that sets it to
>    either 0 or 1 depending on the running environment.
>
> But what is curious is that nothing in C code even looks at .guiDefault
> configuration, so I am not sure why you would even need to change
> anything in builtin/difftool.c file at all.
>
> Puzzled.
>

There are two interesting things here I guess:

1. Why add an OPT_CALLBACK_F arg handler, rather than keeping a simple
OPT_BOOL arg type?
Because OPT_BOOL always overwrites with either true or false, so in
order to have use_gui_tool retain its "_BY_CONFIG" value in the
absence of an arg, the explicit arg handler function is required.

2. Why is the "auto" case not explicitly addressed in this code at all?
Because both difftool and mergetool use the same tool-finding logic in
git-mergetool--lib.sh. The C code is just a (complex) "shell", setting
the environment such that git-mergetool--lib.sh knows what to do. Wrt
the gui decision, the implementation here has it set
"GIT_MERGETOOL_GUI" to "true" or "false" if the user has made an
explicit decision, and if it is blank or unset that means "use the
config". The tristate signal in difftool.c is "GUI, NO_GUI or
USE_CONFIG". It would be possible to parse the config in C and change
the tristate signal being passed down to instead be "GUI, NO_GUI or
AUTO", but I believe it would make things more complicated.

I understand "interesting things that need to be explained" are
something one tries to avoid in the source code - I will see if adding
a couple of well-placed comments makes things cleaner.

>
> Avoid [:class:] when 'A-Z' 'a-z' is sufficient.  Easier to read and
> you do not even need to worry about portability that way.
>

Sounds good!

>
> Check Documentation/CodingGuidelines with special attention to the
> "for shell scripts" section?

Will do.

As always, thank you for taking the time to look at this! V2 coming soon.
