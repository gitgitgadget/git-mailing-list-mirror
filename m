Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31922C35254
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 19:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAD820842
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 19:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="VkHU2Y/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgBJTzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:55:11 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55954 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgBJTzL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 14:55:11 -0500
Received: by mail-pj1-f65.google.com with SMTP id d5so220839pjz.5
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 11:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7TtRqb4rqagGW86rPAOkLrz0mdNTq2SpNcuNNG3Webs=;
        b=VkHU2Y/zy2uzmEur9S4LV8AWQ93PrhkSSKGp8KDzFYxiRIxVo7RFHAskC1iS4JhDf0
         9t0Zk2WOPx48Pey7NNTcXsxm/ugtvnjnETakBnv2357G2FcuA7Qh27Zg4NkqT9LhDF/J
         WS5g5uLsXGL3TERgwQU5MVhZp3omfyVms7ZcONH6mSm7+LNnEGk68tftkodGqDN7kDdo
         0Z0bLvaun59ehOQhN/qaXcLkPuIVgi/eQ5GVHW2JqkgfeJtlcNvQKT7PaAS4ctiZLiYH
         75zWhkoDtBlv5jmZ/Y/Z47NBkOAQCt+QH05QmL2tXf79o3OyUuNi3nHEejPnUodD01di
         lqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7TtRqb4rqagGW86rPAOkLrz0mdNTq2SpNcuNNG3Webs=;
        b=NyenHga+LTqRSO8Svj2IRW1KUlHQ3Nf9vGRILlEj7aXO+aZK7ZPuGDzkYHyD/CEvOZ
         TaimOfwEe4N0BjbN4TLlgpHEOQ9JQONwo4kD8PhmQwo7MU/yFRYYEWniYqZsh0pRYqT8
         GxZ54VNPzUsRZgOzVE0QYmL97+HrjUvztOAelKBWprIoxr5NmXQwgIm95eYhBibM/fSF
         C3F/ZpF9p+7aukgK6/TxvjVn2HJN7Jv04qLbT3rKs/qEpd2BgGRErKVIn+umc/uIqtdl
         EPsN1rTVoHEC9Gnz0SFXxROvPIh2VcxKKxUsoVPhnL0RmWY1DaYvBGu3d5hNv2q/9epa
         l2nQ==
X-Gm-Message-State: APjAAAU7KXChc6fDvhz18fBD9McA6rkwpGXKTXWIeUbicdyex/KG2qTt
        zChguvtGOnn+R3YEJihGOgYWxQ==
X-Google-Smtp-Source: APXvYqy5JhRJ512hQuglWZMludZ9mEt2nowH3cnOZmt5NFmxvuFmAEOphf2HTBkpJKfq+HU6CkhiIg==
X-Received: by 2002:a17:90a:b381:: with SMTP id e1mr821701pjr.38.1581364509531;
        Mon, 10 Feb 2020 11:55:09 -0800 (PST)
Received: from localhost ([205.175.106.6])
        by smtp.gmail.com with ESMTPSA id z14sm909392pgj.43.2020.02.10.11.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:55:08 -0800 (PST)
Date:   Mon, 10 Feb 2020 11:55:08 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/1] mailinfo: don't insert header prefix for
 handle_content_type()
Message-ID: <20200210195508.GB46461@syl.local>
References: <019be197-e0aa-1234-e16f-6561d8340023@web.de>
 <b31c46a8-380b-3528-27a5-a2dddacaf837@web.de>
 <35ef5149-2da9-a147-fb5b-8f175ff617e7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35ef5149-2da9-a147-fb5b-8f175ff617e7@web.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René,

On Mon, Feb 10, 2020 at 08:15:19AM +0100, René Scharfe wrote:
> handle_content_type() only cares about the value after "Content-Type: ";
> there is no need to insert that string for it.
>
> Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  mailinfo.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/mailinfo.c b/mailinfo.c
> index 543962d40c..402ef04dd1 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -570,7 +570,6 @@ static int check_header(struct mailinfo *mi,
>  		len = strlen("Content-Type: ");
>  		strbuf_add(&sb, line->buf + len, line->len - len);
>  		decode_header(mi, &sb);
> -		strbuf_insertstr(&sb, 0, "Content-Type: ");

This looks quite good to me. When I first looked, I was wondering if we
should have used 'skip_prefix' and passed that result into
'strbuf_insertstr', but I think that's a bigger change than we need for
now.

This looks all right to me.

>  		handle_content_type(mi, &sb);
>  		ret = 1;
>  		goto check_header_out;
> --
> 2.25.0

Here is my:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
