Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8840C43461
	for <git@archiver.kernel.org>; Thu, 20 May 2021 09:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1822613BA
	for <git@archiver.kernel.org>; Thu, 20 May 2021 09:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhETJ3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 05:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhETJ1u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 05:27:50 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFF8C061346
        for <git@vger.kernel.org>; Thu, 20 May 2021 02:26:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f19-20020a05600c1553b02901794fafcfefso4331053wmg.2
        for <git@vger.kernel.org>; Thu, 20 May 2021 02:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HjtFiuFKQ44d1mIOF3BnFX+u+wNNyi23oHcUifsYD1Y=;
        b=d8yXg2+BIHPJKKdgdo2Hbgp4g61zv6VKbwXiNk+q0B18/CfvM8Z/M12WvUefawJxtX
         I3N4C+7RT6m6rIsJmx6hDj4Xn5/4FiT5YijqXkKD7Q/LqOdfQNroVh1gxkVYnDaom0By
         kTr7/W/vYX0EompVI/EwxJH390BhoLsgfJ7LBLYbhR1Jv5vZqC3IgmlCEWjFKBEDvoin
         2BWwr+YQTKLvBIQRFR8977IHXPC4k7DEgjzmpoXxM4eLtq6p6VBpR+rIwl7Qd1cdaZ1+
         6HWrk+2Ejhkxzm8RLfrq5LC0P2esDV4bMV2Sm2682M502Sr4XEIfCiK9KVx+c8Ds0PwD
         0vDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HjtFiuFKQ44d1mIOF3BnFX+u+wNNyi23oHcUifsYD1Y=;
        b=eLfm1uUuumtWbIdQ2DAsmSgD5GOMkyPIh4+fvIDYk4VRfUQaWvi85qEvoRKEPiuEow
         nvo+Nc46okWdoxQ5mjxpKIiTfH/+oJ792GqSpMrvEVtxXu1Z4uLueqzn2rY2zdxVgc+a
         BncM/csVrRjFYs+mDPtL9jVsspAVNRuH3nJjOQSN5JbW3+pscIiDDg8mgyNYRQTDD7CY
         YxvZ3PXRz7dEuj/ECKQ+3NtZgYxWeYF/51WTXsC30F7n9UBt2I+Ka92HEyIo31YPTaZ3
         fGKCfiS6xjTNHSseZsTi/jkbgIZSyR5DyOBvfNcATMIao7MnMI3/VdNBBQvFSKbPmnMX
         Qh5w==
X-Gm-Message-State: AOAM533YDtX9eKh0o+Owt7WBb15OFGHEAHoAJZewk/QzQ2MJdn4uLOFU
        LO1nyYqaIiDf3gSYGwut3Zo=
X-Google-Smtp-Source: ABdhPJyyzW2MGwngGFW4bI0VagMcOCM0/XTFyjfixQ7qE2Cq74u/4K2qEy6isC+Ja4APjAyFSZhqIg==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr2664916wmh.151.1621502765822;
        Thu, 20 May 2021 02:26:05 -0700 (PDT)
Received: from [192.168.1.240] (88.22.198.146.dyn.plus.net. [146.198.22.88])
        by smtp.gmail.com with ESMTPSA id b81sm10473197wmd.18.2021.05.20.02.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 02:26:05 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] help: colorize man pages
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Leah Neukirchen <leah@vuxu.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
References: <20210520040725.133848-1-felipe.contreras@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <842221d6-51c4-e08a-4299-c4efb8bf1dcb@gmail.com>
Date:   Thu, 20 May 2021 10:26:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210520040725.133848-1-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/05/2021 05:07, Felipe Contreras wrote:
> We already colorize tools traditionally not colorized by default, like
> diff and grep. Let's do the same for man.

I think there is a distinction between 'diff' and 'grep' where we are 
generating the content and help where we are running man - I would 
expect a man page to look the same whether it is displayed by 'man git 
foo' or 'git help foo'

> Our man pages don't contain many useful colors (just blue links),
> moreover, many people have groff SGR disabled, so they don't see any
> colors with man pages.
> 
> We can set the LESS variable to render bold, underlined, and standout
> text with colors in the less pager.
> 
> Bold is rendered as red, underlined as blue, and standout (prompt and
> highlighted search) as inverse magenta.
> 
> Obviously this only works when the less pager is used.
> 
> If the user has already set the LESS variable in his/her environment,
> that is respected, and nothing changes.

However if they have specified the colors they would like by using the 
LESS_TERMCAP_xx environment variables that the previous versions of this 
patch used their choice is overridden by this new patch.

I've got LESS_TERMCAP_xx set and running
	LESS='Dd+r$Du+b$Ds' man git add
changes the output colors

> A new color configuration is added: `color.man` for the people that want
> to turn this feature off, otherwise `color.ui` is respected.
> Additionally, if color.pager is not enabled, this is disregarded.
> 
> Normally check_auto_color() would check the value of `color.pager`, but
> in this particular case it's not git the one executing the pager, but

s/git the one/git is not/

Best Wishes

Phillip

> man. Therefore we need to check pager_use_color ourselves.
> 
> Also--unlike other color.* configurations--color.man=always does not
> make any sense here; `git help` is always run for a tty (it would be very
> strange for a user to do `git help $page > output`, but in fact, that
> works automatically [probably thanks to less being smart], we don't even
> need to check if stdout is a tty, but just to be consistent we do). So
> it's simply a boolean in our case.
> 
> Moreover, just to be painstakingly comprehensive with people who have
> color-aversion; we honour NO_COLOR [1].
> 
> So, in order for this change to have any effect:
> 
>   1. The user must use less
>   2. Not have the LESS variable set
>   3. Have color.ui enabled
>   4. Not have color.pager disabled
>   5. Not have color.man disabled
>   6. Not have NO_COLOR set
>   7. Not have git with stdout directed to a file
> 
> Fortunately the vast majority of our users meet all of the above, and
> anybody who doesn't would not be affected negatively (plus very likely
> comprises a very tiny minority).
> 
> [1] https://no-color.org/
> 
> Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Comments-by: Jeff King <peff@peff.net>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> Range-diff against v3:
> 1:  db93bf432b ! 1:  7249785014 help: colorize man pages
>      @@ Metadata
>        ## Commit message ##
>           help: colorize man pages
>       
>      +    We already colorize tools traditionally not colorized by default, like
>      +    diff and grep. Let's do the same for man.
>      +
>           Our man pages don't contain many useful colors (just blue links),
>           moreover, many people have groff SGR disabled, so they don't see any
>           colors with man pages.
>       
>      -    We can set LESS_TERMCAP variables to render bold and underlined text
>      -    with colors in the pager; a common trick[1].
>      +    We can set the LESS variable to render bold, underlined, and standout
>      +    text with colors in the less pager.
>       
>      -    Bold is rendered as red, underlined as blue, and standout (messages and
>      +    Bold is rendered as red, underlined as blue, and standout (prompt and
>           highlighted search) as inverse magenta.
>       
>      -    This only works when the pager is less.
>      +    Obviously this only works when the less pager is used.
>       
>      -    If the user already has LESS_TERMCAP variables set in his/her
>      -    environment, those are respected and not overwritten.
>      +    If the user has already set the LESS variable in his/her environment,
>      +    that is respected, and nothing changes.
>       
>           A new color configuration is added: `color.man` for the people that want
>      -    to turn this feature off, otherwise `color.ui` is respected, and in
>      -    addition color.pager needs to be turned on.
>      +    to turn this feature off, otherwise `color.ui` is respected.
>      +    Additionally, if color.pager is not enabled, this is disregarded.
>       
>           Normally check_auto_color() would check the value of `color.pager`, but
>           in this particular case it's not git the one executing the pager, but
>           man. Therefore we need to check pager_use_color ourselves.
>       
>      -    Also, unlike other color.* configurations, color.man=always does not
>      -    make any sense; git help is always run for a tty (it would be very
>      +    Also--unlike other color.* configurations--color.man=always does not
>      +    make any sense here; `git help` is always run for a tty (it would be very
>           strange for a user to do `git help $page > output`, but in fact, that
>           works automatically [probably thanks to less being smart], we don't even
>           need to check if stdout is a tty, but just to be consistent we do). So
>           it's simply a boolean in our case.
>       
>      -    So in order for this to have an effect:
>      +    Moreover, just to be painstakingly comprehensive with people who have
>      +    color-aversion; we honour NO_COLOR [1].
>      +
>      +    So, in order for this change to have any effect:
>       
>            1. The user must use less
>      -     2. Not have the same LESS_TERMCAP variables set
>      +     2. Not have the LESS variable set
>            3. Have color.ui enabled
>      -     4. Have color.pager enabled
>      +     4. Not have color.pager disabled
>            5. Not have color.man disabled
>      -     6. Run git with stdout on a tty
>      +     6. Not have NO_COLOR set
>      +     7. Not have git with stdout directed to a file
>       
>      -    Otherwise the current behavior remains.
>      +    Fortunately the vast majority of our users meet all of the above, and
>      +    anybody who doesn't would not be affected negatively (plus very likely
>      +    comprises a very tiny minority).
>       
>      -    [1] https://unix.stackexchange.com/questions/119/colors-in-man-pages/147
>      +    [1] https://no-color.org/
>       
>           Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>           Comments-by: Jeff King <peff@peff.net>
>      @@ builtin/help.c: static void exec_man_konqueror(const char *path, const char *pag
>       +	if (!man_color || !want_color(GIT_COLOR_UNKNOWN) || !pager_use_color)
>       +		return;
>       +
>      ++	/* See: https://no-color.org/ */
>      ++	if (getenv("NO_COLOR"))
>      ++		return;
>      ++
>       +	/* Disable groff colors */
>       +	setenv("GROFF_NO_SGR", "1", 0);
>       +
>      -+	/* Bold */
>      -+	setenv("LESS_TERMCAP_md", GIT_COLOR_BOLD_RED, 0);
>      -+	setenv("LESS_TERMCAP_me", GIT_COLOR_RESET, 0);
>      -+
>      -+	/* Underline */
>      -+	setenv("LESS_TERMCAP_us", GIT_COLOR_BLUE GIT_COLOR_UNDERLINE, 0);
>      -+	setenv("LESS_TERMCAP_ue", GIT_COLOR_RESET, 0);
>      -+
>      -+	/* Standout */
>      -+	setenv("LESS_TERMCAP_so", GIT_COLOR_MAGENTA GIT_COLOR_REVERSE, 0);
>      -+	setenv("LESS_TERMCAP_se", GIT_COLOR_RESET, 0);
>      ++	/* Add red to bold, blue to underline, and magenta to standout */
>      ++	/* No visual information is lost */
>      ++	setenv("LESS", "Dd+r$Du+b$Ds", 0);
>       +}
>       +
>        static void exec_man_man(const char *path, const char *page)
>      @@ builtin/help.c: static int git_help_config(const char *var, const char *value, v
>        }
>        
>        static struct cmdnames main_cmds, other_cmds;
>      -
>      - ## color.h ##
>      -@@ color.h: struct strbuf;
>      - #define GIT_COLOR_FAINT		"\033[2m"
>      - #define GIT_COLOR_FAINT_ITALIC	"\033[2;3m"
>      - #define GIT_COLOR_REVERSE	"\033[7m"
>      -+#define GIT_COLOR_UNDERLINE	"\033[4m"
>      -
>      - /* A special value meaning "no color selected" */
>      - #define GIT_COLOR_NIL "NIL"
> 
>   Documentation/config/color.txt |  5 +++++
>   builtin/help.c                 | 28 +++++++++++++++++++++++++++-
>   2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
> index d5daacb13a..11278b7f72 100644
> --- a/Documentation/config/color.txt
> +++ b/Documentation/config/color.txt
> @@ -126,6 +126,11 @@ color.interactive.<slot>::
>   	or `error`, for four distinct types of normal output from
>   	interactive commands.
>   
> +color.man::
> +	This flag can be used to disable the automatic colorizaton of man
> +	pages when using the less pager. It's activated only when color.ui
> +	allows it, and also when color.pager is on. (`true` by default).
> +
>   color.pager::
>   	A boolean to enable/disable colored output when the pager is in
>   	use (default is true).
> diff --git a/builtin/help.c b/builtin/help.c
> index bb339f0fc8..298d97cc39 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -11,6 +11,7 @@
>   #include "config-list.h"
>   #include "help.h"
>   #include "alias.h"
> +#include "color.h"
>   
>   #ifndef DEFAULT_HELP_FORMAT
>   #define DEFAULT_HELP_FORMAT "man"
> @@ -43,6 +44,7 @@ static int verbose = 1;
>   static unsigned int colopts;
>   static enum help_format help_format = HELP_FORMAT_NONE;
>   static int exclude_guides;
> +static int man_color = 1;
>   static struct option builtin_help_options[] = {
>   	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
>   	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
> @@ -253,10 +255,29 @@ static void exec_man_konqueror(const char *path, const char *page)
>   	}
>   }
>   
> +static void colorize_man(void)
> +{
> +	if (!man_color || !want_color(GIT_COLOR_UNKNOWN) || !pager_use_color)
> +		return;
> +
> +	/* See: https://no-color.org/ */
> +	if (getenv("NO_COLOR"))
> +		return;
> +
> +	/* Disable groff colors */
> +	setenv("GROFF_NO_SGR", "1", 0);
> +
> +	/* Add red to bold, blue to underline, and magenta to standout */
> +	/* No visual information is lost */
> +	setenv("LESS", "Dd+r$Du+b$Ds", 0);
> +}
> +
>   static void exec_man_man(const char *path, const char *page)
>   {
>   	if (!path)
>   		path = "man";
> +
> +	colorize_man();
>   	execlp(path, "man", page, (char *)NULL);
>   	warning_errno(_("failed to exec '%s'"), path);
>   }
> @@ -264,6 +285,7 @@ static void exec_man_man(const char *path, const char *page)
>   static void exec_man_cmd(const char *cmd, const char *page)
>   {
>   	struct strbuf shell_cmd = STRBUF_INIT;
> +	colorize_man();
>   	strbuf_addf(&shell_cmd, "%s %s", cmd, page);
>   	execl(SHELL_PATH, SHELL_PATH, "-c", shell_cmd.buf, (char *)NULL);
>   	warning(_("failed to exec '%s'"), cmd);
> @@ -371,8 +393,12 @@ static int git_help_config(const char *var, const char *value, void *cb)
>   	}
>   	if (starts_with(var, "man."))
>   		return add_man_viewer_info(var, value);
> +	if (!strcmp(var, "color.man")) {
> +		man_color = git_config_bool(var, value);
> +		return 0;
> +	}
>   
> -	return git_default_config(var, value, cb);
> +	return git_color_default_config(var, value, cb);
>   }
>   
>   static struct cmdnames main_cmds, other_cmds;
> 
