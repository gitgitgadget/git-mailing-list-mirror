Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC1CC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 14:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D873B60F39
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 14:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240688AbhHTO7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 10:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240472AbhHTO7h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 10:59:37 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8D0C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 07:58:59 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so14261768otf.6
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uwLF1o0CtgpZa49AV79mTTSJ0pzdHdwVrnGl16DfMFU=;
        b=cRV+TRUX0yQTcCR+t9/qC1OL9Ryx6LjZV6xEPsfClnZVNxn4qWkVa4RiucZleMJAgT
         FWSf0TRWlFVAlM0thsb7wxEsX7/P/oJRr9apMyG1BjfWc0flgHx9iNkR6h6B4r/ei8An
         d4U9V5dZ98/68nNkbIb8G0o0/5exLHxUpT3cynQ8I6jBVFRjUnAvBFXa5ef52UCVA65U
         x8bUTmS7206tsvu8rVLkei09iIQ69R17rnP0tdDCvACRhlmINMM9l9Ft3VjVn+UJNC6p
         iQtvx7IjedbOY0YWad/o2Yfjv129daDd1pyK/0rE0zOXjjscLa/4cXZA4y0naTSDRvqh
         qRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uwLF1o0CtgpZa49AV79mTTSJ0pzdHdwVrnGl16DfMFU=;
        b=UmdviRXA2GvDpW0SVsUKJqd4EnZQLW/LVQFPYffa87wYuUoYPNdtIcmuN0xtEN4DLz
         aDFnlnZwQFf3M8QUnhlynIOwiTZzWbH+ioZRquUf0eldsvBCaudajrC/p76zN4Q0Z6Re
         SHt0Uss1naJAGL6f6gR0IjK/H6fASHrolJVKClLoKRRa0lObZQT4s18P2e0N1Hk5IelJ
         hliIPFyYDqYYsgj2P2jY1A6HrKMFH5mEbMKaHLKSvlnoPrzAJqXPCYb6pYbI7KZi++C2
         b7wm9QL2wVPE8sl2KzG/wO4ff5MIrXx5jmg+QUjCcs0ovgA8rqucRkQUME62XxPX0mmG
         xkzA==
X-Gm-Message-State: AOAM533JDI/4dNirEo58dbZsq5tjwuYeJMMoqQAxxQYgsh785Ub2erX/
        UwtLLP7rHGT6RrTSywpB8c0pmHmq0YBNQA==
X-Google-Smtp-Source: ABdhPJzi75z//d0DX5qV0JzTG7AkpKlET1Lfgd3s2sf7PzhhLbrdsNzUB9VagKbb+D61vGdU3nN0kw==
X-Received: by 2002:a9d:75d5:: with SMTP id c21mr7830949otl.118.1629471538252;
        Fri, 20 Aug 2021 07:58:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f436:fc6f:2dd3:d49? ([2600:1700:e72:80a0:f436:fc6f:2dd3:d49])
        by smtp.gmail.com with ESMTPSA id m24sm1436694oie.50.2021.08.20.07.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 07:58:57 -0700 (PDT)
Subject: Re: [PATCH] Fix leak in credential_apply_config
To:     Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20210820084413.1503711-1-mh@glandium.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ffa1786e-f69f-3d76-98dc-7fa5cdbd31c0@gmail.com>
Date:   Fri, 20 Aug 2021 10:58:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820084413.1503711-1-mh@glandium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/2021 4:44 AM, Mike Hommey wrote:
>  	normalized_url = url_normalize(url.buf, &config.url);
>  
>  	git_config(urlmatch_config_entry, &config);
> +	string_list_clear(&config.vars, 1);
>  	free(normalized_url);
>  	strbuf_release(&url);

A good find! This is obviously correct and a valuable change
to make. If you are interested in doing a little extra work,
then I think there is something more we could do here.

I took a look at the rest of "struct urlmatch_config" to see
if anything else needed to be cleared, and it turns out that
config.url.url is an allocated string, but happens to be
equal to normalized_url, which is freed here.

Perhaps the optimal organization would be to have a
clear_urlmatch_config() method that clears all allocated data
within the config, and change things like url_normalize()
return a 'const char *' to make it clear that the url should
be freed somewhere else.

It would help unify the handling of code that is somewhat
duplicated (but slightly different each time) across
credential_apply_config(), http_init(), get_urlmatch(),
and cmd__urlmatch_normalization().

Thanks,
-Stolee
