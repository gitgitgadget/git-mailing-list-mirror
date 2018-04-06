Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E53E41F404
	for <e@80x24.org>; Fri,  6 Apr 2018 19:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeDFT1W (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 15:27:22 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34996 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbeDFT1V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 15:27:21 -0400
Received: by mail-pl0-f67.google.com with SMTP id 61-v6so1224121plb.2
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=H6TXKustq+ArzHRZDfhdrjSsB+BTVXDDTLAq2sIk/Lo=;
        b=PY0VktrHQq0sa44lmXPqpuxIHVdw4e6y5tG8cbzLa20nSCTYS/YI/F/fXNNM1TWMnE
         eEyL2y9Zyw+W/NHCWYUv4cHRy8gEBgME2OKe9fhRW2TblL0oR/Z8mPbWAl72Jy2zMg/Q
         VP02VIvSlRxeIlGHCqTGOh37XOIBryHRc9rayrawIaLfIn+W3DIipbGLsDuEgYzst7Hx
         j1RUB5JtGfe7p+9hEbeyLLnvuHTg1aODbTy5iFu/3HFRWTtDke2J/LeJK0XS7bx4mH4Z
         efIruB7NPwdep+Lx3QFDBiVQYwuhrOTgzib1fhw2Px8RdCN6tpYSyk9Xm4bJoCaFxgz4
         Lf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=H6TXKustq+ArzHRZDfhdrjSsB+BTVXDDTLAq2sIk/Lo=;
        b=YD3gfXvVvhwedJTrRcLcQdFfHyW6tz4JJj5jBGoVAVBB8kbnZmjUVZ0q9lU75vRAiE
         Nlg5OxVC1sc9cHbl2ucZZPmxzX6AEUdAF5c65IX/2OwMmnWQFqQujgtZSXMhQMqAz64i
         9XFNn94bFLSyiZWzNX+J5z96kWsH8ub0t+QG6N3IbzIfvbc+/W2NqV8AuVPhCKINzuEK
         tFdRGv/KwSCr05FvTDqo9O/yfy1ZkmTYFoHeoc1QGUusCaOHhESTYjng71iTlIxy+ArP
         34hrijnyzDwdS6byo2gBkgNWv7bUN5RJOHWC7AszXJQx8Z3JAx2qkZi1fwPX+ltPjcco
         eBmA==
X-Gm-Message-State: AElRT7G0dpeln1lAp93zRvT72ukZeizliaZ1rYzLnd5dxnDHwc1nNZOD
        cGfU9duae2BLRwxco8zsESuiIdqgeMY=
X-Google-Smtp-Source: AIpwx4+qrIM0y0kaeN9GzO55aXoy3K/Uoj802Sq2D8DDvJfcqjoFTPP5gGkom9v6LoE+/82Ef7uOlQ==
X-Received: by 2002:a17:902:82c2:: with SMTP id u2-v6mr27886731plz.401.1523042841294;
        Fri, 06 Apr 2018 12:27:21 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id t25sm22539269pfj.187.2018.04.06.12.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Apr 2018 12:27:20 -0700 (PDT)
Subject: Re: [PATCH 3/3] ref-filter: factor ref_array pushing into its own
 function
To:     Jeff King <peff@peff.net>,
        Harald Nordgren <haraldnordgren@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180406185801.GA921@sigill.intra.peff.net>
 <20180406185945.GC11108@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <51135137-97ea-354a-7acd-4e905ee69a80@gmail.com>
Date:   Fri, 6 Apr 2018 15:27:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180406185945.GC11108@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/6/2018 2:59 PM, Jeff King wrote:
> In preparation for callers constructing their own ref_array
> structs, let's move our own internal push operation into its
> own function.
>
> While we're at it, we can replace REALLOC_ARRAY() with
> ALLOC_GROW(), which should give the growth operation
> amortized linear complexity (as opposed to growing by one,
> which is potentially quadratic, though in-place realloc
> growth often makes this faster in practice).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   ref-filter.c | 16 +++++++++++++---
>   ref-filter.h |  8 ++++++++
>   2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index c1c3cc9480..6e9328b274 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1840,6 +1840,18 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
>   	return ref;
>   }
>   
> +struct ref_array_item *ref_array_push(struct ref_array *array,
> +				      const char *refname,
> +				      const struct object_id *oid)
> +{
> +	struct ref_array_item *ref = new_ref_array_item(refname, oid);
> +
> +	ALLOC_GROW(array->items, array->nr + 1, array->alloc);
> +	array->items[array->nr++] = ref;
> +
> +	return ref;
> +}
> +
>   static int ref_kind_from_refname(const char *refname)
>   {
>   	unsigned int i;
> @@ -1930,13 +1942,11 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>   	 * to do its job and the resulting list may yet to be pruned
>   	 * by maxcount logic.
>   	 */
> -	ref = new_ref_array_item(refname, oid);
> +	ref = ref_array_push(ref_cbdata->array, refname, oid);
>   	ref->commit = commit;
>   	ref->flag = flag;
>   	ref->kind = kind;
>   
> -	REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
> -	ref_cbdata->array->items[ref_cbdata->array->nr++] = ref;
>   	return 0;
>   }
>   
> diff --git a/ref-filter.h b/ref-filter.h
> index 68268f9ebc..76cf87cb6c 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -135,4 +135,12 @@ void setup_ref_filter_porcelain_msg(void);
>   void pretty_print_ref(const char *name, const struct object_id *oid,
>   		      const struct ref_format *format);
>   
> +/*
> + * Push a single ref onto the array; this can be used to construct your own
> + * ref_array without using filter_refs().
> + */
> +struct ref_array_item *ref_array_push(struct ref_array *array,
> +				      const char *refname,
> +				      const struct object_id *oid);
> +
>   #endif /*  REF_FILTER_H  */

The three patches in this series look good to me.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
