Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B701C4708C
	for <git@archiver.kernel.org>; Sun, 30 May 2021 03:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E6661073
	for <git@archiver.kernel.org>; Sun, 30 May 2021 03:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhE3DuT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 23:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhE3DuT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 23:50:19 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E2BC061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 20:48:40 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so7712569otk.5
        for <git@vger.kernel.org>; Sat, 29 May 2021 20:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=YOFhsEhq7sHFkf/CSBwMrf3mYIjdZp1kGWC93DL7V1Q=;
        b=hvhyo+lpEXXEUN9kGLS+qe3SiYR00sRIHbF9FgOY/7t5r/U37BHCrjBwVXMRAznfF7
         myeRxEPrmWpibHCzNB9jhDirfUuFqNH4/uRbpeqrpaVA1IGZ+QtyZFfVnIlr7OUly7lc
         kUuJnvcWRJvxzv2jDtYcVxEemmtJbNMji5Vmn9M3eU6eOMprc5uFn7c/dVXbzbLpxcKu
         Pw9WvSseZTK+R0MIUjzUEq5NCUqCPyKbpYFJ0jxaVzIAkHQefUq/TmSdUcjcFRBmV+Pp
         lEaQ2ycTF3XvGPAgwNe55q9O6uZTrYdiLzOU99WKQjFwM03rN/A3nCXPrdXmSzp5++nH
         ciiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=YOFhsEhq7sHFkf/CSBwMrf3mYIjdZp1kGWC93DL7V1Q=;
        b=t3usAxk4bay2VQJtZeEFPGi3v7ZpLn+qN5/KREh5S/OYEBxMK4Z0WECiIeaZQ5ptFT
         mDQ9+jBrGylk9V/7abmwRoRe5UxzMflTe0d6Dg4KtbGZD0ULgl8e85dPoFP43MasbiCN
         3enREqoNfnjp+RxSsJKzZIdPq8KKtWxL2dFbPDUGg7LdSD+XmmIoqgwDonhv/aJj5g9G
         VR56nZKUu6Gg8tqlx9gJm5FxLBO4joY2j0OpJeiUzigDmIy6mpq+cEcJ9bMubHyW3It8
         6rFn0gYnEjXbF8BEHadyM6oL4S52Hqh8GbxZ9AkHsMED0EWaIsVS02J7I0jqXjUd3wlC
         z/Sg==
X-Gm-Message-State: AOAM531f7PnGRG5nsDlHdmddZe0kLKqOvoDHhRA0xCK5fauU/EZPVzIL
        nydtlx3G+4o+JgGpV6k1CvU=
X-Google-Smtp-Source: ABdhPJyjSdV4+xtZQJy529yeVDt2gMVtBgrZnXlSAYSJf2Oslm/Ryh6a7xh79MIo9hfaVGupLtcFBA==
X-Received: by 2002:a9d:6a05:: with SMTP id g5mr12439440otn.354.1622346519567;
        Sat, 29 May 2021 20:48:39 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id g24sm72181otp.17.2021.05.29.20.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 20:48:39 -0700 (PDT)
Date:   Sat, 29 May 2021 22:48:37 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>
Message-ID: <60b30b159bda0_50fd208ee@natae.notmuch>
In-Reply-To: <20210530021528.21287-1-davvid@gmail.com>
References: <20210530021528.21287-1-davvid@gmail.com>
Subject: RE: [PATCH] contrib/completion: avoid empty arithemetic expressions
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar wrote:
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 3c5739b905..d51ff5302d 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1177,6 +1177,9 @@ __git_aliased_command ()
>  __git_find_on_cmdline ()
>  {
>  	local word c="$__git_cmd_idx" show_idx
> +	if [ -z "$c" ]; then
> +		c=1
> +	fi

This is not the correct location to fix this, it's here:

diff --git a/git-completion.zsh b/git-completion.zsh
index 0ef15ff..df98e68 100644
--- a/git-completion.zsh
+++ b/git-completion.zsh
@@ -233,7 +233,7 @@ __git_zsh_main ()
                emulate ksh -c __git_complete_config_variable_name_and_value
                ;;
        (arg)
-               local command="${words[1]}" __git_dir
+               local command="${words[1]}" __git_dir __git_cmd_idx=1
 
                if (( $+opt_args[--bare] )); then
                        __git_dir='.'

Commit 59d85a2a05 (git-completion.bash: use $__git_cmd_idx in more
places, 2021-04-22) broke zsh because it modified __git_main, but not
__git_zsh_main.

Cheers.

-- 
Felipe Contreras
