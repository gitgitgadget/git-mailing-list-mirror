Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEEDC4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 19:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F5B36136E
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 19:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhFATQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 15:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbhFATQq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 15:16:46 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F693C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 12:15:04 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso277194otl.13
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 12:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=MYXcGXlfS4leUuv24Xn+PkgdluNyV3sCc2bZoihHcK0=;
        b=evsewkc/SR835reae17GbJ5xKwlYIW+QnkJfRJjFL7TeR26qGhR3OvyhwJLH7cW1B6
         u9jM8Wc2J3ng/ulySjUrqT0lwCwv3Ih/5zdwdQb33hOPNLfcbForoudYUFZnEEu1mRXW
         lkodRwtAsGNt8ChekbgvqFJwaBYu+lGvjV5+BK1wk23wsdFGKHOa3zNu6dUzONSaA9Dv
         cryKcQiF2Fe+k4GcAWcWOrHydw/WZsfJYZ212iYt4Z+ptgsqRtVKPgyxERzRmOk7upO4
         v9ON+98VklgkuZdutpKRIzpgfiMMBr3eNW9y9cr7fp0KlvoCwKRFTKByowszaEWsF3hZ
         pKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=MYXcGXlfS4leUuv24Xn+PkgdluNyV3sCc2bZoihHcK0=;
        b=A103l+uyveuasQv6cyJZkfkFBWGOkb8+YdQbHVukOlS8vJ+lsMANmtbuysTY3qVHjz
         EratqviqyD0l4P75keYRF3YTurTqGhflQDA9yzExiw3FX7QK4vazFbRLYxadjZX217QQ
         8oq7cbn5ppaeDGvQAiV0EkmP9/6HBpFvxtycX0nCw6wcIroWPTiWDLhvBETQzpARpJi1
         CxGjCQGZPYfPPTzt+e2t1ipViYiwKXrlGkFy4cVeKzLUCHtxQMAPl5rupPFuv3EPD1Tr
         ggXCbuvlESZJZLwiB4lVHx9gDeucvBzkAT/yG+gXUzpIuTiSSA3RGQWmy7VCE1iGG+b8
         1xGw==
X-Gm-Message-State: AOAM530/val+NoSxkWV/2B5dkESY88WIRwi51Vf4pShwu9AlJ+8SgKaB
        2pOGo8pxZlZ3rcXhfyGlZe2X94KGZ+h+dA==
X-Google-Smtp-Source: ABdhPJy5MKAtXpYvQ7jFYD41tkYHSPfuH7zzcKShke+myyi8bTeP7g2Feif3Nk8QUUMFEsotkm+nYw==
X-Received: by 2002:a9d:5a12:: with SMTP id v18mr22138359oth.306.1622574903744;
        Tue, 01 Jun 2021 12:15:03 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id l9sm3565226oou.43.2021.06.01.12.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 12:15:03 -0700 (PDT)
Date:   Tue, 01 Jun 2021 14:15:02 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>
Message-ID: <60b6873624c6f_1a702085e@natae.notmuch>
In-Reply-To: <20210601165254.18136-1-davvid@gmail.com>
References: <20210601165254.18136-1-davvid@gmail.com>
Subject: RE: [PATCH v3] contrib/completion: fix zsh completion regression from
 59d85a2a05
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar wrote:
> A recent change to make git-completion.bash use $__git_cmd_idx
> Add "git" to the "words" array in _git_zsh_main to guarantee
> that "git" is at least always in the completion list.

Hm, no. The current code already guarantees "git" is always at the start
of the completion list. In [1] I suggested to add git *if* $words is
used instead of $orig_words.

If you add "git" to $orig_words you end up with something like
"git git mv", so the __git_cmd_idx is definitely not 1.

You should probably try to test yourself:

  words=( git ${words[@]} )
  echo "$words" >> /tmp/words-log.txt

The problem is that zsh's _arguments eats all the words it finds, so for
example if you type:

  git mv --force <tab>

$words will be 'mv --force'.

It's better to use $words because in case there's arguments beforehand,
like:

  git --git-dir=/tmp/test/.git mv --force

$words will be 'mv --force', so we can get the proper index by just
adding 'git' beforehand.

But it doesn't work for arguments not in _arguments, like:

  git --foo mv --force

Which returns:

  --foo mv --force

And unfortunately upstream's version of the wrapper doesn't understand
many arguments, like -c, or -C. git-completion does have all of them

It's better to just leave the code as it is and just fix the regression
by adding __git_cmd_idx=1.

> Helped-by: Felipe Contreras <felipe.contreras@gmail.com>

I mean I kind of wrote 2 of the 3 lines you sent, can I get a
Suggested-by?

> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -251,7 +251,7 @@ __git_zsh_main ()
>  		done
>  		;;
>  	(arg)
> -		local command="${words[1]}" __git_dir
> +		local command="${words[1]}" __git_dir __git_cmd_idx=1

This is needed.

>  
>  		if (( $+opt_args[--bare] )); then
>  			__git_dir='.'
> @@ -261,7 +261,7 @@ __git_zsh_main ()
>  
>  		(( $+opt_args[--help] )) && command='help'
>  
> -		words=( ${orig_words[@]} )
> +		words=( git ${orig_words[@]} )

This is wrong. The current code is fine.

Cheers.

[1] https://lore.kernel.org/git/60b3c2d7557bd_be762089a@natae.notmuch/

-- 
Felipe Contreras
