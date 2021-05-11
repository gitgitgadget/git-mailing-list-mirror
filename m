Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D255C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 15:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B06E61364
	for <git@archiver.kernel.org>; Tue, 11 May 2021 15:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhEKPOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 11:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhEKPOV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 11:14:21 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C82EC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 08:13:15 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso17010071ots.10
        for <git@vger.kernel.org>; Tue, 11 May 2021 08:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FfNUZw2UXerusD60j1BnaQcUbSQmpszo25cl4sqz8Rk=;
        b=jtYr7bUTTxWo6iJShDnq4BgkrgJtbkObtliuaYyiC4IOj4apAuXFbpEZQ8+AhnfS9E
         0VE7g4t3aM1toqZIKZuBRtmlmH3WVbkZCievMRypwfCOGBAD1IodHvvz+4pvTI23B11s
         uNCvZtAJZoB8LDjlNDipc1xSFt121hZbTGIcmE4xp+h0fg1WtfTG2OP1bMdD1Bl53xza
         u6K4EppMHDP9Sc/oCMww63a5ku9DVJKU+lkKWmAo1pwhsyu5yuXNLZj8pYTfVV9Y1YeC
         mWHXia43dKrV9GlnsUv3tz9kQaaoryaVXyELkWsQBN4ykZPZvoyzVbV+2Aa74qwJAIkO
         FuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FfNUZw2UXerusD60j1BnaQcUbSQmpszo25cl4sqz8Rk=;
        b=hydjYK8inlRN3qZmJwdI8g0sXHrZfRj4IsESx9ja1wp5jMpzJpwo6toxdhEGhf8xLk
         2TfPb5K6j4fZ/tmyvY9dHJg0VSGlKHJCN/D5NGzWN85H/vPRTyFibBFAwooHkJjPJRJH
         5LkHyxAymgZiiZXG1Iwx3IIa70CiYtDglbCJzkeTCuIKv465cazWaV+BljfP7eezUEsu
         5RYZgP5EvfGxLzzS20XGbU2Svn41GW+34u3B3fvOugzgZYhhc7+x1sPtQPqAFmsBnTnI
         weWjfPa9XdVkh8T7dm/TTMi3pJeYsQjzdTjRtueUKymqPms2ctKQoD2knJR2i+kJAy66
         mnFg==
X-Gm-Message-State: AOAM5339Jw4G5hwrmepum1sC5yCRzlaMwYu2oPCzu59sVb6K7pMMOqp3
        XV9fsu+2RTyqOTfyPuoSwws=
X-Google-Smtp-Source: ABdhPJwUDpFo14iRh/eNnEIgGQHLwXTubf2M/iCF9fIUfP1WqPuKbxfG7SY1MYFCK3u1cGvahTjHZA==
X-Received: by 2002:a9d:6a88:: with SMTP id l8mr27213668otq.236.1620745994359;
        Tue, 11 May 2021 08:13:14 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:d53c:1a94:49a3:bce7? ([2600:1700:e72:80a0:d53c:1a94:49a3:bce7])
        by smtp.gmail.com with ESMTPSA id 21sm3820033otg.4.2021.05.11.08.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 08:13:13 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] maintenance: fix two memory leaks
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>, lilinchao@oschina.cn
References: <20210509221613.474887-1-lenaic@lhuard.fr>
 <20210510195909.621534-1-lenaic@lhuard.fr>
 <20210510195909.621534-2-lenaic@lhuard.fr>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <01dccb51-cb2e-ea6f-a05c-d76bb7ed725f@gmail.com>
Date:   Tue, 11 May 2021 11:13:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210510195909.621534-2-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/10/2021 3:59 PM, Lénaïc Huard wrote:
> Fixes two memory leaks when running `git maintenance start` or `git
> maintenance stop` in `update_background_schedule`:

Thanks for finding these leaks.

> ---
>  builtin/gc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index ef7226d7bc..484fe983d3 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1924,6 +1924,7 @@ static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
>  		else if (!in_old_region)
>  			fprintf(cron_in, "%s\n", line.buf);
>  	}
> +	strbuf_release(&line);
>  
>  	if (run_maintenance) {
>  		struct strbuf line_format = STRBUF_INIT;
> @@ -1986,8 +1987,10 @@ static int update_background_schedule(int enable)
>  		cmd = sep + 1;
>  	}
>  
> -	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
> -		return error(_("another process is scheduling background maintenance"));
> +	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
> +		result = error(_("another process is scheduling background maintenance"));
> +		goto cleanup;
> +	}
>  
>  	if (!strcmp(scheduler, "launchctl"))
>  		result = launchctl_update_schedule(enable, get_lock_file_fd(&lk), cmd);
> @@ -1999,6 +2002,9 @@ static int update_background_schedule(int enable)
>  		die("unknown background scheduler: %s", scheduler);
>  
>  	rollback_lock_file(&lk);
> +
> +cleanup:
> +	free(lock_path);

And I agree that this version looks good. 

Thanks,
-Stolee
