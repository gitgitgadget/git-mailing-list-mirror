Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 032F91F461
	for <e@80x24.org>; Tue, 20 Aug 2019 18:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfHTS5J (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 14:57:09 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36392 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbfHTS5J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 14:57:09 -0400
Received: by mail-qk1-f194.google.com with SMTP id d23so5430120qko.3
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 11:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DhGrZDUMpQUZqyZ95sI5Kw1B+DRo1+h5xKBNjRv2zQE=;
        b=TQ9y6PcMMyiePkEsIYSejU6r9uyc9gmtxmIPWymNg9Bcaum7xYKtG39GO0fDkrvSwS
         +PwGwgKW+f23mwdp1IELeNOUlnP09CX5P5cyb45pxcuNdkudKWmn70yeQhZ0Y9C9ZX3+
         fdMrXdO5mH/gq3yv3AbfgDXjD4R85jpSYVw8BDhbwsuWaBr5CjIWOsy8ynJC3dBOKBC1
         2POQGzRCrOBs7cbZXKXVpkTp5cqLqxaXLWPsiIQlzrWUqsA8GBq9Jn0BWw73VobMfO9t
         zLQLDq0Bpz8PkvKtuOmv3rbvCM7bojLTPWFiTe9qFUX1AkAft7APon7Ks/tl2kD6QJvX
         qCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DhGrZDUMpQUZqyZ95sI5Kw1B+DRo1+h5xKBNjRv2zQE=;
        b=Qxj4BNNuwRcVIG6ILl3ITfIsql9N6qlzycq7a/BOQ+CSc7m1g4NklC1bLcp1t+OCHl
         Sr6YfHPOZ2wgh3FD4u0RUPObwPiB0YoERWEDLfwqSxUshwM1ZA2viIbsXSnzFTa29hBY
         3FMUGifCsToWKJ/GsgQY1C+NHDFLuTmDuvIe5XbtN5IIt1/FyYz3ex0YKxpk8WyIeKiu
         bC8tGpW9MQI43I3mGoP4Ej9mQQhkojqmCUBkSYTn11kOEV2CZ8cu/VdJ0WFPhKfMG1DO
         o4L68f/uHXvBPlMYbFItZTxFQAiuMG6jCwRlV1kQ4nOc5idjviQQgmoA6nKlKYLjcBI2
         Y9bg==
X-Gm-Message-State: APjAAAUCdOGwDyMf53EPBibW2poZWED3Av5JbR/oIexoiyumHo6UI4bb
        JQEAg4bikbcx0IWEJFmGDaQ=
X-Google-Smtp-Source: APXvYqylmCBASaOyZtIZykYuMrNiOHgb5hGaoqySJUJmRRVkq8PRq6r7BEIczR97pCcFRNelo+PWow==
X-Received: by 2002:a05:620a:659:: with SMTP id a25mr27191524qka.148.1566327427845;
        Tue, 20 Aug 2019 11:57:07 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:5ff:3a8e:8e40:6517? ([2001:4898:a800:1012:b732:3a8e:8e40:6517])
        by smtp.gmail.com with ESMTPSA id m3sm5020570qki.10.2019.08.20.11.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 11:57:07 -0700 (PDT)
Subject: Re: [PATCH] sha1-name: make sort_ambiguous_oid_array() thread-safe
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <a08751c7-170d-7faf-272e-79c589ec3eab@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7000e687-800b-c613-aa90-e022bd30a023@gmail.com>
Date:   Tue, 20 Aug 2019 14:57:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <a08751c7-170d-7faf-272e-79c589ec3eab@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/2019 2:49 PM, René Scharfe wrote:
> Use QSORT_S instead of QSORT, which allows passing the repository
> pointer to the comparison function without using a static variable.

Makes sense.

> -static struct repository *sort_ambiguous_repo;
> -static int sort_ambiguous(const void *a, const void *b)
> +static int sort_ambiguous(const void *a, const void *b, void *ctx)
>  {
> +	struct repository *sort_ambiguous_repo = ctx;
>  	int a_type = oid_object_info(sort_ambiguous_repo, a, NULL);
>  	int b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
>  	int a_type_sort;
> @@ -434,10 +434,7 @@ static int sort_ambiguous(const void *a, const void *b)
> 
>  static void sort_ambiguous_oid_array(struct repository *r, struct oid_array *a)
>  {
> -	/* mutex will be needed if this code is to be made thread safe */
> -	sort_ambiguous_repo = r;
> -	QSORT(a->oid, a->nr, sort_ambiguous);
> -	sort_ambiguous_repo = NULL;
> +	QSORT_S(a->oid, a->nr, sort_ambiguous, r);
>  }

LGTM!

Thanks,
-Stolee
