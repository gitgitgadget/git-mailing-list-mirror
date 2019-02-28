Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BD7A20248
	for <e@80x24.org>; Thu, 28 Feb 2019 20:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732799AbfB1Uzq (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 15:55:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36113 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbfB1Uzp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 15:55:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id o17so23542605wrw.3
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 12:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dvPKipG64+NvxBue1y9//upNpAguAyjjoB1vR71b1ZE=;
        b=kuNmNloF5SyDAmH2kJPXtbQJSk8IDeLDjppWCd0WmAaoC8phdMLZz5H6Z+oBPeWDPH
         KmBpaRfbKVfr17rRuhS6/p0ZnhbyttEipjUCQUpUp0ItxjqotPBRONmNWnnJeVuRO7LK
         FSNYrA2NdNj8kis7rX7C+uSIFvBod2AIMIDTUk+3ozfgzLAMYN0ama+jSNv4khkkMJgm
         nstuSejE6GApbLjuxCL/KE2pBP3gX9PcqwxBMWASpJ2LlavDqO6JWvC89XDzHEFhNFXz
         nKjzFrCPLJ13hICM09AZWDDxa42gRp4z2qb98mUnX9QgTa3NY3XDDYMnozlcdaYdzkrW
         0rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dvPKipG64+NvxBue1y9//upNpAguAyjjoB1vR71b1ZE=;
        b=TMUwajR5xMw/8YrYM+fgQ324tItLahw4elTYb6HgV82xQ09yyVb5z6/oTOCDBxdMok
         9qN+yPu6tG1MPJTC77vZgX4hVMW6sxgHQqlB2rJYeTFMfO8t9fDU52jxfQCI+mNK0A1w
         DxANnGvmSIeyO4SVe0qb09OteUkH0rhOC5qnubK2cs98dbfqy2i10nLU7a8v+nSEcgGb
         IMz3kM5+3Ox0ATEjYw3VbNsJMxaRx+4lkughqV2cENpfdGAVlK9PWsBLI5ERcOn2yeBe
         VNItsWX6rMRjnAzol6I46A/TcdUyCUIoPPm5/PL/uwxDqlgWTAzNXg2QXDBwEtTc2UyL
         OmWw==
X-Gm-Message-State: APjAAAUYDQzQbvLehC9nKVtt4/eHrLJ5EO8admtJNqWWBP7aNLKhzIyE
        z+W+wEqYVC5ZeDyDaUNjskBtX+7A0us=
X-Google-Smtp-Source: APXvYqwrXDEjPBsCdWH4R9LMUj4DjZKI7JG/BH4btkdUD5xjy1qp21o0ETUxQtL79yLD69eCDwLU0g==
X-Received: by 2002:adf:9004:: with SMTP id h4mr950084wrh.49.1551387343655;
        Thu, 28 Feb 2019 12:55:43 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-26-208.as13285.net. [92.22.26.208])
        by smtp.gmail.com with ESMTPSA id x17sm35188858wrd.95.2019.02.28.12.55.42
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 12:55:43 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] built-in rebase: no need to check out `onto` twice
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Nazri Ramliy <ayiehere@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.153.git.gitgitgadget@gmail.com>
 <2d99429387ba63526efe233bbefe851c5d556fdc.1551367664.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <7b1282bf-4b94-5725-00df-2dc63eaa93f0@gmail.com>
Date:   Thu, 28 Feb 2019 20:55:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <2d99429387ba63526efe233bbefe851c5d556fdc.1551367664.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

On 28/02/2019 15:27, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In the case that the rebase boils down to a fast-forward, the built-in
> rebase reset the working tree twice: once to start the rebase at `onto`,
> then realizing that the original HEAD was an ancestor, `reset_head()`
> was called to update the original ref and to point HEAD back to it.
> 
> That second `reset_head()` call does not need to touch the working tree,
> though, as it does not change the actual tip commit. So let's avoid that
> unnecessary work.

I'm confused by this I think I must be missing something. If we've 
checked out onto then why does the working copy not need updating when 
we fast forward. (also why to we checkout onto before seeing if we can 
fast-forward but that's not related to this patch series)

Best Wishes

Phillip

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   builtin/rebase.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 08ec4d52c7..813ec284ca 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1740,8 +1740,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		strbuf_addf(&msg, "rebase finished: %s onto %s",
>   			options.head_name ? options.head_name : "detached HEAD",
>   			oid_to_hex(&options.onto->object.oid));
> -		reset_head(NULL, "Fast-forwarded", options.head_name, 0,
> -			   "HEAD", msg.buf);
> +		reset_head(NULL, "Fast-forwarded", options.head_name,
> +			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf);
>   		strbuf_release(&msg);
>   		ret = !!finish_rebase(&options);
>   		goto cleanup;
> 
