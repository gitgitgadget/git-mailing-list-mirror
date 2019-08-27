Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B04E31F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 13:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfH0NbJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 09:31:09 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34409 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0NbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 09:31:09 -0400
Received: by mail-qt1-f195.google.com with SMTP id a13so480572qtj.1
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 06:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xmOQEIA6prKXZef8y+I38s9RfKdQsw/UJkRBruDeygs=;
        b=lij1bEflL4Sk+WizWkTqKLJavZn6CyRsJfIHBlLanvuVc10WFsaNQKUcjMBvMDmE9T
         EkRrqhNaFcSp/QdfcAOEIRO+ExOHdgTxT8LA2u23BwtFrarHiNddUlRVJT0XmhDaaENI
         V3HeyGBuoRRjy9p8aJWKfhO4PCUX4nJn+zKp5Eg42uR9Nov+utcgFzYOB5EF1uk7NAsQ
         fIuczJbog+3JkSSxvXai4aMqk4ZP/HwSZc57RdDyXeRQl1sOw5XdgxzICK//vfoIrK53
         v0+k5krXhsIVv688pINdNNLP69qbpDNW9uD2Ngtt2XgxZHvqtmut2KQKHSk1D9RmsFHh
         8Bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xmOQEIA6prKXZef8y+I38s9RfKdQsw/UJkRBruDeygs=;
        b=oqeoAayIxz+XrPMOrti9rMJYAM80o+vd/L0hakYVadhAYdP20kZfn893XHxZ08Rw4w
         irkxoaMbLAaUfOiUu7pHSfYHMMwdCbBOZrAhrshZLotFF4qwUBunEx+EkGe2Jn63v9zz
         nljPGnYRPbaLUuowfOrZPMxKrSqTadhXeF3GYBHSFhpTG/M4JqkYsyuVL8+xr/rgGC8e
         +sbeFy6FSe9xGQ6Ky3FkP52QhHXbAWohf/fUaZ/uHCd97MFjWAChHpXaewjZSuiruHwG
         iwz0KHfJu65yiurfrSjCVaMpS+bLq2X3v1VmO+lUe6LbQFqq3C21wOEzFsulz7zn3Uxh
         xWmQ==
X-Gm-Message-State: APjAAAXxO52b/URWOL+duRqO8+8gMWkltOvPnrzyfOGbNIc/m6uc8pII
        d7E+Lusk4pj+02h605+1GLTqaK45m2I=
X-Google-Smtp-Source: APXvYqxvH1Z3PQkA5nG1TJAHg15LuFo+HMENIp0NFs1jXTdOad4Ho72MuebbOdjbLdifoHIagkQX3Q==
X-Received: by 2002:ac8:4a12:: with SMTP id x18mr22100020qtq.218.1566912668171;
        Tue, 27 Aug 2019 06:31:08 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1d0f:5c09:ae47:3604? ([2001:4898:a800:1012:ce42:5c09:ae47:3604])
        by smtp.gmail.com with ESMTPSA id 65sm7931349qkk.132.2019.08.27.06.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 06:31:07 -0700 (PDT)
Subject: Re: [PATCH 01/11] diff: use hashmap_entry_init on moved_entry.ent
To:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20190826024332.3403-1-e@80x24.org>
 <20190826024332.3403-2-e@80x24.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6414b671-db5b-4422-664d-ffbb8ee1a39a@gmail.com>
Date:   Tue, 27 Aug 2019 09:31:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190826024332.3403-2-e@80x24.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/25/2019 10:43 PM, Eric Wong wrote:
> Otherwise, the hashmap_entry.next field appears to remain
> uninitialized, which can lead to problems when
> add_lines_to_move_detection calls hashmap_add.
> 
> I found this through manual inspection when converting
> hashmap_add callers to take "struct hashmap_entry *".
> 
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  diff.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/diff.c b/diff.c
> index efe42b341a..02491ee684 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -964,8 +964,9 @@ static struct moved_entry *prepare_entry(struct diff_options *o,
>  	struct moved_entry *ret = xmalloc(sizeof(*ret));
>  	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[line_no];
>  	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
> +	unsigned int hash = xdiff_hash_string(l->line, l->len, flags);
>  
> -	ret->ent.hash = xdiff_hash_string(l->line, l->len, flags);
> +	hashmap_entry_init(&ret->ent, hash);

I've typically seen these hashmap_entry_init() calls include the
hash function in-line instead of saving to a variable. But, this
looks fine and is obviously correct.

Thanks,
-Stolee
