Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7257C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 08:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJNIYu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 04:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJNIYr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 04:24:47 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCB21C19F9
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:24:28 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id 187so3312644iov.10
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHtSIvCv78ytyG6UGregKoRu0iCVZBZGV/bZmJI8+ig=;
        b=Ij+2e39Oh+Qq4MAB//RQymFnoOZX/DcHfHVgwR1SdDADHXnyO7RxI9bAhMIKZO043I
         YhJItl1Zz1+7jTuhG4lxAwoF4sE66LfzKNPeInT6H6mDojxWhSJcrfwHJldvftNNaRAT
         xyFGPtHFlKR5R0p3LQ1CRj6gQVmolaVEvq+xJL7as3gjYTI7vbd3sEPP/lR4iLSsDrPc
         lawXQfnVhxMm1hSY0LssAtSMHNNZGyT0D77oF4YQm3zeL3g2at/JYudwZZtUYLZb6tBF
         exeNLUVmTR6MfPfjTGa3gt5FGohArqT+ofA9yuNKrsrOIkpnYcVccp6AJvjiuefRx1cJ
         yyBQ==
X-Gm-Message-State: ACrzQf1ZNTSbGH/LwRbnLH0S6RDdxiBsop51QDHFxnlDj2u6KzCg7efg
        G5BUvcI9I66gddFcAg1Mal5+t6Rxcvh8qr8IoVBgQ+kmGdg=
X-Google-Smtp-Source: AMsMyM5LoIo8VcMQKN5AY8QIz7sZrgRDEUHVKFoBa17nVAw5w4MpkpeP9gxwxz2iWGSryodo9X1DE3xLlVsrCUsB+Hg=
X-Received: by 2002:a05:6638:490e:b0:363:c0fb:a5ea with SMTP id
 cx14-20020a056638490e00b00363c0fba5eamr2133219jab.285.1665735867250; Fri, 14
 Oct 2022 01:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1381.git.1665590389045.gitgitgadget@gmail.com> <pull.1381.v2.git.1665734440009.gitgitgadget@gmail.com>
In-Reply-To: <pull.1381.v2.git.1665734440009.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 14 Oct 2022 04:24:16 -0400
Message-ID: <CAPig+cSPWsiKBU6hgvP_BO7n23nLf7Q-59ZbO4fSL0idcw2qzA@mail.gmail.com>
Subject: Re: [PATCH v2] RFC: mergetool: new config guiDefault supports
 auto-toggling gui by DISPLAY
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"On Fri, Oct 14, 2022 at 4:07 AM Tao Klerks via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> As proposed in <xmqqmtb8jsej.fsf@gitster.g>, introduce new configuration
> options, difftool.guiDefault and mergetool.guiDefault, supporting a special
> value "auto" which causes the corresponding tool or guitool to be selected
> depending on the presence of a non-empty DISPLAY value. Also support "true"
> to say "default to the guitool (unless --no-gui is passed on the
> commandline)", and "false" as the previous default behavior when these new
> configuration options are not specified.
>
> Signed-off-by: Tao Klerks <tao@klerks.biz>
> ---
> diff --git a/Documentation/config/difftool.txt b/Documentation/config/difftool.txt
> @@ -34,3 +34,10 @@ See the `--trust-exit-code` option in linkgit:git-difftool[1] for more details.
> +difftool.guiDefault::
> +       Set 'true' to use the diff.guitool by default (equivalent to specifying
> +       the "--gui" argument), or "auto" to select diff.guitool or diff.tool
> +       depending on the presence of a DISPLAY environment variable value. The
> +       default is 'false', where the "--gui" argument must be provided
> +       explicitly for the diff.guitool to be used.

Let's use backticks rather than double-quotes to ensure that these get
typeset similar to other documentation; i.e. `--gui`, `auto`,
`diff.guitool`, `diff.tool`, `DISPLAY`.

> diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
> @@ -85,3 +85,10 @@ mergetool.writeToTemp::
> +mergetool.guiDefault::
> +       Set 'true' to use the merge.guitool by default (equivalent to
> +       specifying the "--gui" argument), or "auto" to select merge.guitool
> +       or merge.tool depending on the presence of a DISPLAY environment
> +       variable value. The default is 'false', where the "--gui" argument
> +       must be provided explicitly for the merge.guitool to be used.

Ditto.

> diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
> @@ -97,10 +97,12 @@ instead.  `--no-symlinks` is the default on Windows.
>  --[no-]gui::
>         When 'git-difftool' is invoked with the `-g` or `--gui` option
>         the default diff tool will be read from the configured
> +       `diff.guitool` variable instead of `diff.tool`. This may be
> +       autoselected using the configuration variable
> +       `difftool.guiDefault`. The `--no-gui` option can be used to
> +       override these settings. If `diff.guitool` is not set, we will
> +       fallback in the order of `merge.guitool`, `diff.tool`,
> +       `merge.tool` until a tool is found.

Correct use of backticks here. Good.

Probably want: s/autoselected/auto-selected/ or /.../selected automatically/

> diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
> @@ -85,12 +85,13 @@ success of the resolution after the custom tool has exited.
> +       configured under `merge.tool`. This may be autoselected using
> +       the configuration variable `mergetool.guiDefault`.

Ditto: "autoselected"

>  --no-gui::
> +       This overrides a previous `-g` or `--gui` setting or
> +       `mergetool.guiDefault` configuration and reads the default merge
> +       tool from the configured `merge.tool` variable.

Backticks; good.

> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> @@ -97,7 +97,33 @@ merge_mode () {
> +get_gui_default () {
> +       if diff_mode
> +       then
> +               GUI_DEFAULT_KEY="difftool.guiDefault"
> +       else
> +               GUI_DEFAULT_KEY="mergetool.guiDefault"
> +       fi
> +       GUI_DEFAULT_CONFIG_LCASE=$(git config --default false --get $GUI_DEFAULT_KEY  | tr 'A-Z' 'a-z')

Too many spaces before pipe symbol.

Nit: It doesn't matter in this case, but you could safeguard against
(possible?) future problems by using double-quotes in `--get
"$GUI_DEFAULT_KEY"`.

> +       if test "$GUI_DEFAULT_CONFIG_LCASE" = "auto"
> +       then
> +               if test -n "$DISPLAY"
> +               then
> +                       GUI_DEFAULT=true
> +               else
> +                       GUI_DEFAULT=false
> +               fi
> +       else
> +               GUI_DEFAULT=$(git config --default false --bool --get $GUI_DEFAULT_KEY)

Ditto: `--get "$GUI_DEFAULT_KEY"`

> +       fi
> +       echo $GUI_DEFAULT
> +}
> +
>  gui_mode () {
> +       if [ -z "$GIT_MERGETOOL_GUI" ]

Style: if test -z "$GIT_MERGETOOL_GUI"

> +       then
> +               GIT_MERGETOOL_GUI=$(get_gui_default)
> +       fi
>         test "$GIT_MERGETOOL_GUI" = true
>  }
>
> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> @@ -860,4 +860,43 @@ test_expect_success 'mergetool hideResolved' '
> +test_expect_success 'mergetool with guiDefault' '
> +       test_config mergetool.guiDefault true &&
> +       yes "" | git mergetool subdir/file3 &&
> +
> +       yes "d" | git mergetool file11 &&
> +       yes "d" | git mergetool file12 &&
> +       yes "l" | git mergetool submod &&
> +
> +
> +       echo "gui main updated" >expect &&
> +       test_cmp expect file1 &&

Accidental double-spacing?
