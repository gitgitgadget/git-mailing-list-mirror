Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26B8C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 17:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjBARWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 12:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjBARWs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 12:22:48 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89404741C
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 09:22:43 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id z1so11608211plg.6
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 09:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ScoqwsTgYvYpWYsEZxHp6AVMGLGWRf30cTBLn4uwItw=;
        b=IyLegIs8xP99nxjLZ6uGqtT7JscoqUGN/rxPeKkBAaMmPrdwfxMihqXytIEdDustbP
         M5d8oVcXFL3V7le8j7LNoYB/c3Gs13YU7xpKjEUg3BHHAl442Ifbrd+pDD5qRCDL0Bks
         HZ/wEjzOvxx66mxdRV7WwbzwezfThccc4g4B+9lzwqbNz1BG9mZ11+1CYM74uvnoHfW5
         Irr06aJI5aSdPfOE2rixJJKd/Vtfkx/X34mbTRsN2BUhVGtBFlGdAST5/Fd+pgfEmoSh
         fOw8lEfKYz/xR6iM4SIlbWexpN7gXR5uglFDttWRsFs7mbEK76bCGMouwD3iZ5DmzIfS
         9GZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ScoqwsTgYvYpWYsEZxHp6AVMGLGWRf30cTBLn4uwItw=;
        b=GaOg5ZsUIGr0Yg6nsllJ0h0v3dMaucu+/C3hh+yQKhPAVO+b0sK5kfYayiShUiV4C3
         0mcILToW5tUKOKYsX0YYzesgFQNVCfT7F0HsE226zcz8sS703/bb1XHvcBuqcx4bCHN1
         YFVmKir/dWjkDDCBXuF+AuPzIdk3Q5hzn26UV8cNuJCsm4NLsVcU/JCLwSNU4wNHeE9D
         pBXGcNUjv+dz5+sl819p3ImFOean23ikswj/a0vFznC/Awnui1WdBaUq+qd+DTLupZFt
         vStvi+hqflt35IynCTA8hE/t0eqT2FZhO05f9Rw3lQt6DLcYBs6mpiqD9iupo4oUf+i7
         X3eA==
X-Gm-Message-State: AO0yUKVXWd/qwgbJ0cYvyKRonpRxYqna1o/ElzEIn4DOpfCjlwCk1o64
        3GlDkoMkR/zBYzgoXOd+Pc0=
X-Google-Smtp-Source: AK7set+1qMGnouqAUtgYQVkBChSffyhdzT2vhfB3beEGxBudOeoP/1uFEvH98lijeY6R/hR3trlqRA==
X-Received: by 2002:a17:90b:4c42:b0:22c:9c7e:a95d with SMTP id np2-20020a17090b4c4200b0022c9c7ea95dmr12726896pjb.30.1675272163242;
        Wed, 01 Feb 2023 09:22:43 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id n19-20020a637213000000b0044ed37dbca8sm10898133pgc.2.2023.02.01.09.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 09:22:42 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>,
        "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH] git-gui: fix inability to quit after closing another
 instance
References: <pull.1446.git.git.1675239967804.gitgitgadget@gmail.com>
Date:   Wed, 01 Feb 2023 09:22:42 -0800
In-Reply-To: <pull.1446.git.git.1675239967804.gitgitgadget@gmail.com> (Orgad
        Shaneh via GitGitGadget's message of "Wed, 01 Feb 2023 08:26:07
        +0000")
Message-ID: <xmqqy1ph1esd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Orgad, thanks for a patch.
Yadav, this came to git@vger.kernel.org, so I'm forwarding.

cf. Documentation/SubmittingPatches

    == Subsystems with dedicated maintainers

    Some parts of the system have dedicated maintainers with their own
    repositories.

    - `git-gui/` comes from git-gui project, maintained by Pratyush Yadav:

            https://github.com/prati0100/git-gui.git

"Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Orgad Shaneh <orgads@gmail.com>
>
> If you open 2 git gui instances in the same directory, then close one
> of them and try to close the other, an error message pops up, saying:
> 'error renaming ".git/GITGUI_BCK": no such file or directory', and it
> is no longer possible to close the window ever.
>
> Fix by catching this error, and proceeding even if the file no longer
> exists.
>
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
>     git-gui: fix inability to quit after closing another instance
>     
>     If you open 2 git gui instances in the same directory, then close one of
>     them and try to close the other, an error message pops up, saying:
>     'error renaming ".git/GITGUI_BCK": no such file or directory', and it is
>     no longer possible to close the window ever.
>     
>     Fix by catching this error, and proceeding even if the file no longer
>     exists.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1446%2Forgads%2Fgit-gui-no-quit-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1446/orgads/git-gui-no-quit-v1
> Pull-Request: https://github.com/git/git/pull/1446
>
>  git-gui/git-gui.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 201524c34ed..b00ee691e3b 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -2307,7 +2307,7 @@ proc do_quit {{rc {1}}} {
>  		#
>  		set save [gitdir GITGUI_MSG]
>  		if {$GITGUI_BCK_exists && ![$ui_comm edit modified]} {
> -			file rename -force [gitdir GITGUI_BCK] $save
> +			catch { file rename -force [gitdir GITGUI_BCK] $save }
>  			set GITGUI_BCK_exists 0
>  		} elseif {[$ui_comm edit modified]} {
>  			set msg [string trim [$ui_comm get 0.0 end]]
>
> base-commit: 2fc9e9ca3c7505bc60069f11e7ef09b1aeeee473
