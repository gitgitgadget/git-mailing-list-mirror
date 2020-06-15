Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CFAC433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9622076A
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koZTCw3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgFOMdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgFOMdB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 08:33:01 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1C9C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:33:00 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z63so6835041pfb.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=v+2D6FPNC6oBfc8bPrMzCrbMNVO8Kdm6GZYEXroCb50=;
        b=koZTCw3KBs98OcmJ/DP3+DMwV9FHeiTjKVa++1KMf23A4Kn8MnEZ2woJTqz0obqPOp
         vOi33RAC0HBsBf1JFfnmxIwQW+v1oz/E5oTgYHjK4WytdqmY5TzKOlouwPprpIYmyrKB
         syl9HfI7xvzagtKpVyg4PQFgzgNsTIdrjbz7WT1UQbve0KhTAs1sFb6QizQkunsmd26P
         XXqXHS9k4JWtWNpv3/H+/GcN6gzZS8ov9z287CeJ2mso9fEtZsPaRXmEi2+rCxBVeJfd
         Z6SRHNJnovVAou4R4qzYc7l8U0tWYfO//68AzNXkJVKLOQQC6w/TIaC3sooK+cIyUtYg
         C4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=v+2D6FPNC6oBfc8bPrMzCrbMNVO8Kdm6GZYEXroCb50=;
        b=HDS6/l8HUQ5iECvDzTF72pTi4YHPziK95JlEkv3uQyGxF76J6TZTW8w8wTGIdveoIs
         iQzBBhQL2dSF1D8tcW9kfMr7FqxGHR7dSYJmV8ig2Zs49LZTFXO7+7kApGBd5S+x1PkC
         5rBT3kZOR668fIYZCA/BadkocRjZeXuFkw18IbONgYyVNdZvAAIP2FaJ+/7yInQAeYNJ
         2o6fpA2nOALWD7eu+i/OPJEojeXW0PZcfDgL4CvZAYQHwTbuNU2+eh7GyioUtDb8E7Lw
         vuKaYYEZum3bzznsIVUhcR6fWrETFYZ6v6vhHhQ0cLhovM/5gj7NRwRyazD9fQmutrnm
         d/qQ==
X-Gm-Message-State: AOAM530yPbLCPqLeSibL0Uf28eaEGKBlKtZzp/pPOSib5KKhJ5GSoMJ5
        7kUZXGogq9dOh0Ev1nf3cA0=
X-Google-Smtp-Source: ABdhPJzWHWJdm7YX4IFb4I0GPC3m0clIAAibA2YduJYFOgjcV1o4ejolptyIEo/sDRTYB4fewm6ySw==
X-Received: by 2002:a62:2ad2:: with SMTP id q201mr22924326pfq.323.1592224380013;
        Mon, 15 Jun 2020 05:33:00 -0700 (PDT)
Received: from localhost ([2402:800:6374:3bd0:871b:497e:ae48:68fa])
        by smtp.gmail.com with ESMTPSA id i19sm12959667pjz.4.2020.06.15.05.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:32:59 -0700 (PDT)
Date:   Mon, 15 Jun 2020 19:32:57 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] pkt-line: use string versions of functions
Message-ID: <20200615123257.GA20389@danh.dev>
References: <20200614083131.GD3405@danh.dev>
 <da9ba5fb2d0fb9481f81ce525cbabaedd722858d.1592125442.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da9ba5fb2d0fb9481f81ce525cbabaedd722858d.1592125442.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-06-14 05:07:54-0400, Denton Liu <liu.denton@gmail.com> wrote:
> Hi Đoàn,

Sorry for this late reply, I have another stuff to work on.

> Perhaps something like this?

This looks better, but ...

> 
>  pkt-line.c | 48 ++++++++++++++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/pkt-line.c b/pkt-line.c
> index 8f9bc68ee2..022376f00f 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -81,49 +81,61 @@ static void packet_trace(const char *buf, unsigned int len, int write)
>  	strbuf_release(&out);
>  }
>  
> +static inline void packet_trace_str(const char *buf, int write)
> +{
> +	packet_trace(buf, strlen(buf), write);
> +}
> +
> +#define control_packet_write(fd, s, errstr) \
> +	do { \
> +		(void)s"is a string constant"; \

If we are going to not wrap s inside () here,

> +		packet_trace_str((s), 1); \

I see no point in wrapping it here.
And wrapping around "string" is not standard C,
some (or most) compilers support it as an extension.

See USE_PARENS_AROUND_GETTEXT_N

Can we just put it straight?

	packet_trace(s, strlen(s), 1);

> +		if (write_str_in_full((fd), (s)) < 0) \
> +			die_errno((errstr)); \
> +	} while (0)
> +

-- 
Danh
