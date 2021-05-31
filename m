Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B1DC4708F
	for <git@archiver.kernel.org>; Mon, 31 May 2021 03:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 054F0610C9
	for <git@archiver.kernel.org>; Mon, 31 May 2021 03:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhEaDoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 23:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhEaDoE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 23:44:04 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0590BC061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 20:42:24 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id n12so4101663pgs.13
        for <git@vger.kernel.org>; Sun, 30 May 2021 20:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R74QbarQIVncpzN+6G/vXlkQBS1V66lOPIwISOWEKDU=;
        b=XU1gDKNoFqDJOD9J7JpYiizwJgOqz6/WFukO36mzfpQXeS+NtxSz+P9W8EggWY3aj/
         Q0WXv1nKvBSgbW7gB58GFkZLVoljatBqugocC1LOe9Xh5CRMOl6PnGJm4SW23uOhO33S
         RNz7oB1dRmyeVKiYsOIqPayDyMb5igDI3qC9Daa4bwzhXCo8BUdGOeH4pDBzdENUlOue
         faGmEL8iYHCWGXcyEyx0kdyduHLuaRhMvKNxs2xyoECJKRkVpjp0GFT+6ZCW839RIBWU
         krzZOuk90SwPhLjZp7k1LJnSk1tsenlETYEmHoAd1igqEpgqC2MrzTlzkm4r45YTyqeP
         vdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R74QbarQIVncpzN+6G/vXlkQBS1V66lOPIwISOWEKDU=;
        b=D4LoFV3nQ4obcDkkYTj7mP5zN7enNRmNHaStg2O2/q0eyTda/CeJCu6rqdMMC+gqSS
         BhICxpjvdPwdsfil96obu5mUAclPVWPhf/7JSOMMmUrEn82ceqbT6md+lC+s7IsXYd/R
         rB1Xdm0FTWnw56jyWwHWxSUMUA6Jt804DyPLD+AXgwt7qBXPLgwlZxBOXmlmRM6upAEO
         e/RF8MxvlGIhwSj41p1KWYwmC9hyiI5R0Pq89qX/fxpuH+dD0ZzTUTfV7snMudi3XutP
         y+3N9AXW3rQ7ERquYoqWNkYpniMCOgzhmHPbpVVw+JJ5UnMHaDda+NjLM648SphsQ1N6
         4XSQ==
X-Gm-Message-State: AOAM5306u9tax7u6SZz/zpGGhSallKcgd1pR3im+gpN5A33kGM1zP7+7
        1L7Z+ZGZFr+eE3pXIDMqjqw=
X-Google-Smtp-Source: ABdhPJyb1npkiw7xS6a9UUrHYq4sxziqjvM5QAhUe8TOEyLttNLPf6TBiYc1mpa/DcGRCb4c+okOOQ==
X-Received: by 2002:a63:4849:: with SMTP id x9mr3528896pgk.59.1622432544477;
        Sun, 30 May 2021 20:42:24 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-39.three.co.id. [116.206.28.39])
        by smtp.gmail.com with ESMTPSA id s15sm6239880pjr.18.2021.05.30.20.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 20:42:24 -0700 (PDT)
Subject: Re: [PATCH] refactor of git_setup_gettext method
To:     Dima Kov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Dima Kov <dima.kovol@gmail.com>
References: <pull.964.git.1622410962551.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <4df3a985-1359-cec9-c3db-fe069f24297d@gmail.com>
Date:   Mon, 31 May 2021 10:42:21 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <pull.964.git.1622410962551.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dima, welcome to Git mailing list!

> diff --git a/gettext.c b/gettext.c
> index af2413b47e85..e75c7bfdb1a8 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -109,17 +109,14 @@ void git_setup_gettext(void)
>   	if (!podir)
>   		podir = p = system_path(GIT_LOCALE_PATH);
>   
> -	if (!is_directory(podir)) {
> -		free(p);
> -		return;
> +	if (is_directory(podir)) {
> +		bindtextdomain("git", podir);
> +		setlocale(LC_MESSAGES, "");
> +		setlocale(LC_TIME, "");
> +		init_gettext_charset("git");
> +		textdomain("git");
>   	}
>   
> -	bindtextdomain("git", podir);
> -	setlocale(LC_MESSAGES, "");
> -	setlocale(LC_TIME, "");
> -	init_gettext_charset("git");
> -	textdomain("git");
> -

It seems like you move gettext initialization into if body, so the patch 
title should be better say "move gettext initialization to if body".

>   	free(p);
>   }
>   

Thanks for review.

-- 
An old man doll... just what I always wanted! - Clara
