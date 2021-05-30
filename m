Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0730BC47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 16:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB122608FE
	for <git@archiver.kernel.org>; Sun, 30 May 2021 16:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhE3QyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 12:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhE3QyU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 12:54:20 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65556C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 09:52:41 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso8822392ote.1
        for <git@vger.kernel.org>; Sun, 30 May 2021 09:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Su9B9fr+XEs/Plohjn/gYsOnHjERMQP4/zfdm/20MN8=;
        b=hGfM60icmwwiDKW2CaVKglnJV9Leu1DE0NsM1F7kAuiZrHYP4wUsthH4P8J1F1nYH8
         pAUw9tp+UcAWfqvOArtacCuN2lGLNsY+tU9cPnG1SIizzlmaH8fpU0Bb866WvLiUoS3N
         0LPA0vXctPiOo/v/RYL5oR76wxDu9S0ZJRr2INN9QYDTsYm6Im/AnoO9eyJkTXn5nL+p
         95v9U+Cb3FiXhZxIDD9J3qIj3cvY0I6l0cgmyEdbcj3Ohwqn02kMzmB716YS5XhTtciC
         DlJzsyPqjiKBsuQE8QrS4tVxYM2spHWhbXLVPu5cPqRoSOMdiSip/a94UbS/1nH5KOqc
         qkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Su9B9fr+XEs/Plohjn/gYsOnHjERMQP4/zfdm/20MN8=;
        b=FKXfvZGOVxbLJS6vpNR8RdkShHeEzgCWnWCg31meuoPPhcI6ZWHQoAvficg4enZoJH
         OSWtvsc5vDVtaQcimchL4GroxkTjwdzsd0rn0EwpyhrJDiAgUGK9VOColSaZ9uVbVGhz
         MLIJGFyCr1kEvl6MA9/ED8xjHgKFb8Z1gWx/YLX0J6zFyUfi9ysSB0hTkDRs9DjPQ4z+
         CEIld9WDUSZYVibvAOXt0vRA2D45qOudLCGsGoabblkW/9iJhFvMyG9Vn2XuNxkLAl7x
         omQU0ZhhnyPM9UJP4cL0XRmCwyPEMJGGh6MdD5/VM/TfOJ9hiSaScGOLK8HZkg5TBmoX
         OTTw==
X-Gm-Message-State: AOAM533uV/Awz5FGssYLpQO1xs4Y5LeKOqXzBU4OHygD1keN5B1vrRGd
        IG5+uh47cvEiOQ/4sWHk/E6bzPWyNT5scg==
X-Google-Smtp-Source: ABdhPJxUyvgMynhz8f+lowDLQsYQSfbsIdE1o65zEgL9KqVwXOyKN3V3iKzMhZvwdqopvUX48bWpgQ==
X-Received: by 2002:a05:6830:1256:: with SMTP id s22mr13710757otp.333.1622393560809;
        Sun, 30 May 2021 09:52:40 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id e29sm2346524oiy.53.2021.05.30.09.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 09:52:40 -0700 (PDT)
Date:   Sun, 30 May 2021 11:52:39 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>
Message-ID: <60b3c2d7557bd_be762089a@natae.notmuch>
In-Reply-To: <20210530062438.53527-1-davvid@gmail.com>
References: <20210530062438.53527-1-davvid@gmail.com>
Subject: RE: [PATCH v2] contrib/completion: fix zsh completion regression from
 59d85a2a05
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar wrote:
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -251,7 +251,7 @@ __git_zsh_main ()
>  		done
>  		;;
>  	(arg)
> -		local command="${words[1]}" __git_dir
> +		local command="${words[1]}" __git_dir __git_cmd_idx=1
>  
>  		if (( $+opt_args[--bare] )); then
>  			__git_dir='.'

Note that this is not the correct fix, since the index of the command
will not always be 1.

We would probably need to at least do something like:

--- a/git-completion.zsh
+++ b/git-completion.zsh
@@ -260,7 +260,7 @@ __git_zsh_main ()
 
                (( $+opt_args[--help] )) && command='help'
 
-               words=( ${orig_words[@]} )
+               words=( git ${words[@]} )
 
                __git_zsh_bash_func $command
                ;;

And then it will almost always do the correct thing (at least in
git-completion[1] which does have all the git main arguments).

For now doing __git_cmd_idx=1 should fix the regression.

Cheers.

[1] https://github.com/felipec/git-completion

-- 
Felipe Contreras
