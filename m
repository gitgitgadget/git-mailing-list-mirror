Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17C4C433E5
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 15:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1CC2068F
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 15:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rByHekZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgGMP4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbgGMP4V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 11:56:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E081C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 08:56:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ga4so17778084ejb.11
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wegH57RF5+fma1Vh/FrVu+zmp7kiDmXza7UQUAHzB1s=;
        b=rByHekZUm7VQsBd6jRm3Rax25RSy4gI7T5RXTCBY1SDXWjaBCTJmFQCPJ0EWI0MqwG
         HJ64HIa+dv72PkFX5OBnjHDwUo9Ee8hC9f85D+A7yFjSMTJZxf7LGuEsU46ohpvZ+u0y
         l9hy4LMIN6RnM7itm1p7tuH19cB8Yjb04532TxNiTVydUSkmd0gjv4H7qBSFZS1O7nlg
         ZFABKRACcRpJS7DNPcgfSyiI01Cd0Zs2EUxkNeeljxlG3attDH6Uvfhjf5NO1mPd/qPu
         DqPvPKAL7uyfgVeIhrw09l48zn3FMssLO/Fu4LWoW2piJ74uZ8mKGzjQA3jVZHVZRhNf
         nbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wegH57RF5+fma1Vh/FrVu+zmp7kiDmXza7UQUAHzB1s=;
        b=ZhmPFNuGXmEWIK1sLzvnKoKkJZyLRZTUCu3eTQK7e0TWhfopPHVsJg2p16M3/9XyrZ
         6sAlCLyMQGGMVJfuqv2eId2LbxYhSFSAL4jPGeTtkFWqmh8HPSnsLA2gNnPwbZEQi27p
         0NCVGDceYZgByXWlGHNsFW0lO/lwDyJL7j/9WplJCDapxN0WQI9610w+Zw7MmP+BkC9M
         vGfaEJzuH2uQpMxZPp6lY00N9h3wzVt4FAE7ufXGWMHArfWz0bRtgAu/wm8fpqgNBgw5
         8/tchk95YF9nzRv3zUKcAs8sH4Wq004ykEaYFBLSlZxbVEWq+XQveJFFti/PxpJJ44Iw
         ppPg==
X-Gm-Message-State: AOAM530/vDxyYhNjnUTiab51QwfRaoDjwFzCpjx2aaVWbyXuEXjBvXZC
        V89/fC0vWq0eBgSsTCzXHwA=
X-Google-Smtp-Source: ABdhPJys/tBVwt7TWJl0SvnpzU4Qta4OgNJZmHjqCnTzGTfVv/iLaZqrbVmruUKlH2UY/eFiORHagg==
X-Received: by 2002:a17:906:fa9a:: with SMTP id lt26mr390777ejb.502.1594655780338;
        Mon, 13 Jul 2020 08:56:20 -0700 (PDT)
Received: from szeder.dev (78-131-17-27.pool.digikabel.hu. [78.131.17.27])
        by smtp.gmail.com with ESMTPSA id cb7sm10041171ejb.12.2020.07.13.08.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2020 08:56:19 -0700 (PDT)
Date:   Mon, 13 Jul 2020 17:56:17 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 31/39] bundle: add new version for use with SHA-256
Message-ID: <20200713155617.GF11341@szeder.dev>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
 <20200713024909.3714837-32-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200713024909.3714837-32-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 13, 2020 at 02:49:01AM +0000, brian m. carlson wrote:
> @@ -23,17 +24,20 @@ static void add_to_ref_list(const struct object_id *oid, const char *name,
>  	list->nr++;
>  }
>  
> -static const struct git_hash_algo *detect_hash_algo(struct strbuf *buf)
> +static int parse_capability(struct bundle_header *header, const char *capability)
>  {
> -	size_t len = strcspn(buf->buf, " \n");
> -	int algo;
> -
> -	algo = hash_algo_by_length(len / 2);
> -	if (algo == GIT_HASH_UNKNOWN)
> -		return NULL;
> -	return &hash_algos[algo];
> +	const char *arg;
> +	if (skip_prefix(capability, "object-format=", &arg)) {
> +		int algo = hash_algo_by_name(arg);
> +		if (algo == GIT_HASH_UNKNOWN)
> +			return error(_("unable to detect hash algorithm"));
> +		header->hash_algo = &hash_algos[algo];
> +		return 0;
> +	}
> +	return error(_("unknown capability '%s'"), capability);
>  }


> +test_expect_success 'git bundle v3 rejects unknown extensions' '
> +	head -n2 bundle >new &&
> +	echo "@unknown=silly" >>new &&
> +	sed "1,2d" >>new &&
> +	test_must_fail git bundle verify new 2>output &&
> +	grep "unknown capability .unknown=silly." output

This "unknown capability" error message is translated, so it should be
checked with 'test_i18ngrep'.

> +'
> +
>  test_done
