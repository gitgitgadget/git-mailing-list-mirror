Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2624C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7985060F39
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhH3AKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 20:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhH3AKN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 20:10:13 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BE4C061575
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 17:09:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i6so19092579edu.1
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 17:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K1LWCJU1AKrUZpLSJ1Y+o0Nd379WYZV60Em6vs/hzII=;
        b=iDSDGugMNi9zrWzYAyWoXSnmMZZ+BxuVMie1PHLkOuo8x4g3Hr4tjJ2IRq5go8je61
         heR3VrMZkzuejbwbhZmr6fLvsvdj80kdXk6T7Qu2o++jD7kQBYngzE3Oq4EK0B04q85e
         UGGDv9dKNI8vflwsHmoO7OyInfIRRC5vQISj7H8K/usgWBTMOWkEQ7QMrKFcMCRRCd6g
         vhniwBUPUoIYI8BI0Qx2VqFzzAwLqJTcRonRyq3DIU9+I44DRiesIIghZyXnRua6wa7i
         ZqZ11kDOPdzELEI45ILDL0uyZ1YCdfdzIKCLFLtkFRPlKIxLLegCMkR6zVNLMuY9Qi0e
         mZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1LWCJU1AKrUZpLSJ1Y+o0Nd379WYZV60Em6vs/hzII=;
        b=oq9lnYytr9o/PRD/FTWQyqKgx96U1uPS2LJCVXEU1MwAjnaZLA+kLZAxDmKfJoxFJL
         W5lssNjnciDD5TpiNHZG1gYyfAW++lpdczEWo6egrTWKghSZqVMThMnMV3Yln9EB9n+z
         aPSiykv7EOhjVh6AwWQRTToHErSd0AIyJ0XCvUXWZN5K6fI1n+DqnUMz8ES6N+K+9Mg8
         YM0t13mBM5tK3zxISdVEiXB6AWNiN7UHiYyTEa5fJSJe23N1UrXr9axW3+jZMgTxQh6B
         P0OslGxttP3EgekDSFHDCeBTmJM9jFevDRYw15BIqzUdhx81dzrPrRxFoYGvVhJlbDSE
         LBuQ==
X-Gm-Message-State: AOAM531E6NGrbenAFaCY8dyCqeuWn2wTIT4u/6qEr3m5bkjS6JXXktla
        nWWvCkZ5JjsBU+ck4936sZA5Ozk6S0qS5Hd9xJhkKiFkAAY=
X-Google-Smtp-Source: ABdhPJwbJXZBuCzFUrHlvs3rI3gUP5caBe4VKUW3fMKKEgNf3yVtI1VgjrDZhifKA8I5UT8m16386+jU57ZVkiEaUsg=
X-Received: by 2002:a05:6402:452:: with SMTP id p18mr21146231edw.34.1630282159042;
 Sun, 29 Aug 2021 17:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1032.git.git.1623098845733.gitgitgadget@gmail.com>
In-Reply-To: <pull.1032.git.git.1623098845733.gitgitgadget@gmail.com>
From:   David Aguilar <davvid@gmail.com>
Date:   Sun, 29 Aug 2021 17:08:42 -0700
Message-ID: <CAJDDKr4rXEZDH4ZNU1ieUcfpOseikOVVfFQ=1tG9YNr2nibLCQ@mail.gmail.com>
Subject: Re: [PATCH] use get_merge_tool_path() also in is_available() to honor settings
To:     Michael Schindler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Schindler <michael@compressconsult.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for taking so long to review this change and thanks for taking a
stab at this. Comments inline below.

On Mon, Jun 7, 2021 at 1:52 PM Michael Schindler via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Michael Schindler <michael@compressconsult.com>
>
> fix the is_available test used in git mergetool --tool-help or
> git difftool --tool-help or to check the list of tools available when no
> tool is configured/given with --tool

Nit: the commit message can probably be fixed up a bit. Capitalize the
sentence and add "." full stops at the end.

There are some minor typos as well ~ s/symtoms/symptoms/.

>
> symtoms: the actual tool running run_merge_tool () considers the difftool.
> "$merge_tool".path and mergetool."$merge_tool".path and if configured
> honors these. See get_merge_tool_path () in git-mergetool--lib.sh
> If not set use fallback: translate_merge_tool_path "$merge_tool".
>
> The is_available () just uses translate_merge_tool_path "$merge_tool".

I think we can focus on explaining the intent of the patch. Maybe
something like..

"""
Teach the is_available() function to translate mergetool paths to handle the
case where the user has configured mergetool.<tool>.path. This fixes the
reported tools as displayed by "git difftool --tool-help".
"""

>
> repo 1: Configure an invalid path in mergetool."$merge_tool".path for a
> tool of your choice.
> You will be informed that the tool is available, but when trying to use
> it will not be found because the invalid configured path is used.
>
> repo2: Install a tool of your choice on a nonstandard place (e.g. rename
> the program) and configure mergetool."$merge_tool".path for this tool.
> You will be informed that the tool is not available (because not found on
> standard place), but when trying to run it will work.
>
> This fix will make the information consistent by using get_merge_tool_path()
> also in is_available()

There's not really a necessity to have two repos here. We could trim down these
notes to only mention the reproduction steps.

Maybe something along the lines of,

"""
A discrepancy occurs when configuring invalid paths in mergetool.<tool>.path
or when tools are not available in the default $PATH and mergetool.<tool>.path
contains the correct location.

When mergetool.<tool>.path contains invalid paths then you will be informed that
the tool is available. It will not be found when you try to use it,
though, because
the invalid configured path is used.

When mergetool.<tool>.path is configured to a custom path, and the tool does not
exist in the default $PATH, you will be informed that the tool is not available.
Yet it will actually work when trying to run it.

Fix the discrepancy by using the configured paths in is_available().

"""

>
> Signed-off-by: Michael Schindler <michael@compressconsult.com>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1032%2Fmichaelcompressconsult%2Fmergetoollib_is_available-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1032/michaelcompressconsult/mergetoollib_is_available-v1
> Pull-Request: https://github.com/git/git/pull/1032
>
>  git-mergetool--lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 542a6a75eb3c..8b946e585d7f 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -18,7 +18,7 @@ mode_ok () {
>  }
>
>  is_available () {
> -       merge_tool_path=$(translate_merge_tool_path "$1") &&
> +       merge_tool_path=$(get_merge_tool_path "$1") &&
>         type "$merge_tool_path" >/dev/null 2>&1
>  }

Thanks, you're on the right track. There's only a few minor
adjustments that're needed to help move this forward.

Running "git difftool --tool-help" with this patch applied prints a
bunch of new error messages:
"""
   The diff tool ecmerge is not available as 'ecmerge'
   The diff tool ... is not available as ... (dozens of times)
   ...
"""

The root cause is that get_merge_tool_path contains an "exit 1" and
error reporting when given an invalid tool.
Thus, it's not really suitable for this use case where we want to just
do the translation.

I think the path forward would be one of the following two options.

Option 1) split get_merge_tool_path into two functions. The wrapper can stay as
get_merge_tool_path() and a new helper function can handle the lookup
(the remainder of the function after the error checking).

Maybe the helper (without the "exit 1" and error print) can be called
lookup_merge_tool_path()
or maybe get_configured_merge_tool_path() to make it clear its purpose
is to get the configured paths.

This helper can then be used in is_available() since it will not
contain the error printing and exit call.
The error checking will remain in get_merge_tool_path() only.


Option 2) I kinda prefer this one because the code is simpler.
Technically we're changing the
behavior of get_merge_tool_path(), though.

Move the error reporting and exit 1 into run_merge_tool() since it's
the only caller that
cares about that stuff, and then remove it from get_merge_tool_path()
so that it can be
used inside is_available() like you've done here.

We have get_merge_tool_path documented in Documentation/git-mergetool--lib.txt
so it's a "semi-public" function. In practice it's really only for
mergetool/difftool's internal use.

The docs say, "This is not a command the end user would want to run.  Ever.
This documentation is meant for people who are studying the
Porcelain-ish scripts and/or are writing new ones."

With that in mind, it sounds like we don't really have to consider
external users because
it's only for people writing (in-tree) porcelain-ish scripts.

We never documented that it prints errors and exits on error, but the
fear is that
Hyrum's Law will bite because someone out there relies on the current behavior.

Despite what I interpret as mergetool--lib having "internal" status, I
did a search on github
to see if there are other users and all I got was hundreds of pages of
results pointing to
git-mergetool--lib.sh. I think we're mostly okay but I'll defer to
Junio and the list
as to whether we're comfortable with entertaining Option 2.

Option 2) seems okay to me if we agree that mergetool--lib is
considered "internal".


Oh, and sorry for inserting this random question (not directed at you,
but rather at the whole list) --

Is there a reliable shell idiom for detecting Windows / Git for Windows?

I noticed that our error messages are now printing "kdiff3.exe" on
Linux/unix/macOS.

The root cause is we do some win32 kdiff3 -> kdiff3.exe translation
when "kdiff3" is not found,
but we do it unconditionally. This is a cosmetic issue that only shows
up when the tool is missing.
It still works correctly when kdiff3 is installed.

I'd like to extend 47eb4c6890 (mergetools/kdiff3: make kdiff3 work on
Windows too, 2021-06-07)
but in order to do so I need a reliable way to special-case Windows so
that we only do the x -> x.exe translation there.

What's the best way to detect Windows? t/test-lib.sh seems to detect
Windows using "uname -s" and
checking for matches against *MINGW* or *CYGWIN*. Is that reliable /
recommended?

cheers,
-- 
David
