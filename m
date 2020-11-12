Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC60C5519F
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 14:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7507322240
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 14:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="THsrxRE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgKLOvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 09:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLOvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 09:51:16 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1317AC0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 06:51:16 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q5so5402124qkc.12
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 06:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UTlZ1/Tg4ClzrPuTdGQTVW5MTTCgPiQnCWU4i9kPmK0=;
        b=THsrxRE2QxkYfr15/1iWmMhi6xE6M/+JsDSd/hKXOuT6aLr+LHsiClSfrCFm4nDqOT
         lW6kMMxh3x2pyRfNB2NjwdfAqcCUviQTTBwYmGBXbrM+cGWrhGOpaUEKIwymXzn9WS0u
         +4ey/mFU+u3GZsqpBSGKs0SGCfqiIn7fghbLgvYPPVjGge8YU8FIg1YpvehsEybXIetB
         1lDQjHItBk7AKk2a08/JN+90hnT9nQEuCyLhZnVbznUbmqggwHouGdQpCRCrzk8NPrbY
         ZM5tUWYHvhN7m7OZxUCLi4phnY8i1oDAmtoZiWacVTem0kzxmFAqhwA6bUbvx6fPy+12
         qIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UTlZ1/Tg4ClzrPuTdGQTVW5MTTCgPiQnCWU4i9kPmK0=;
        b=pjZBluiyUPiYkb8xKw83dza/fXXze1/IJnDEU7JMXbJcpmNEUgeF3mv/zIJf+XzddD
         50LOiRd3LF/ylSPmgM3vxgiv7cINsxgnbv5BmlrHplZETiZVWOzES9vHLlg8vH+/kQ+J
         lSUl3JMZEFKGVaQ8KqZfI1l+aBKobLPgY+PGHjQro4Z2DhJQJmG/tt1coqBTqtkqlf77
         b5KjPOoxhq/vnJtrOJkaekrOiNsrWMEOPbGJjYnorLUW22qqs26+cxP1zOj/q/eg4WAG
         CFYWNtEiUowmQbOzcZCgl1AQhVNNLkphaje1hXviwn3mfGsix2BnOp+ZR0uO9e/sgf3Q
         VWBw==
X-Gm-Message-State: AOAM532ZMRo+fLTtJaXr3VxxMmMkQ7WgUVMQblFygRL/5V6yTWRa97AC
        c4XK9xW8X8RCNznMaWMCFejhxQ==
X-Google-Smtp-Source: ABdhPJzQ32p3PCBw+GInQKnu9uyZkcVTrZ8Igbcbh5mBqp+zBoQxraeuEQ8qOetWSNu1RvdeR1jtDg==
X-Received: by 2002:a37:b07:: with SMTP id 7mr98052qkl.370.1605192675116;
        Thu, 12 Nov 2020 06:51:15 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:508e:3ccd:52c2:244c])
        by smtp.gmail.com with ESMTPSA id o189sm5150873qkf.34.2020.11.12.06.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 06:51:14 -0800 (PST)
Date:   Thu, 12 Nov 2020 09:51:12 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] csum-file: add hashwrite_be64()
Message-ID: <X61L4Ebd5PBpYDel@nand.local>
References: <16932ced-8bcd-89bd-b927-cae1bce0365a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16932ced-8bcd-89bd-b927-cae1bce0365a@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 01:20:19PM +0100, René Scharfe wrote:
> Add a helper function for hashing and writing 64-bit integers in network
> byte order.  It returns the number of written bytes.  This simplifies
> callers that keep track of the file offset, even though this number is a
> constant.
>
> Suggested-by: Derrick Stolee <dstolee@microsoft.com>
> Original-patch-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  csum-file.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/csum-file.h b/csum-file.h
> index f9cbd317fb..e54d53d1d0 100644
> --- a/csum-file.h
> +++ b/csum-file.h
> @@ -62,4 +62,11 @@ static inline void hashwrite_be32(struct hashfile *f, uint32_t data)
>  	hashwrite(f, &data, sizeof(data));
>  }
>
> +static inline size_t hashwrite_be64(struct hashfile *f, uint64_t data)
> +{
> +	data = htonll(data);

Great. This is new from my patch (which wrote the high- and low four
bytes with two separate hashwrite_be32()'s), but I think it's a clear
improvement.

In addition to being more readable, we can use the bswap instruction
once instead of twice if it exists.

Please feel free to add my:

  Signed-off-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
