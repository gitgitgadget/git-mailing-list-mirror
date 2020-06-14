Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD06C433E1
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 08:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2DA206B7
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 08:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epVnmHij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgFNIbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 04:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNIbg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 04:31:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E305C03E969
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 01:31:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 23so6428428pfw.10
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 01:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P91jMj5vvUrmarkZNG7WrD+nIHwkSPKaBSUcOzh1KXw=;
        b=epVnmHij12AY5foATd4Obr4gqI8u6Ojtf4UV10+aDyY5wa6hTlTC0e/eFZWDh6jc5t
         5FHp59XJ49iDdgTuGrM4rR5me/4TaJ+znLmuuybiOB90r/f4uZcANFBXWWf2rTPUwdC8
         o5h0LFaFs/PxDnc/iZQo/e7C7qKA21F1l2qWpvhjhofnHaX3TXIgyqb99+q3+Iap/PP7
         QFna3YBm1o+MMaGZ35DOVk6+X9Sdsa6pGmdzasxyAZHgT89mbxbzUetOCGLnb1VotHSi
         oPj7lPB0GHs6lSqhJLcUpy0AYXMJ5JH7lTp6uVymsuV+DxcLYK7HyC6F2pwATxBscs6T
         wmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P91jMj5vvUrmarkZNG7WrD+nIHwkSPKaBSUcOzh1KXw=;
        b=HInJ/+s9Mtq4mVnFGQ4FnrQHHcuj11c7YsZbrnPggtVDHIcEPfpDPkAjVv14C46c1p
         6mbL95b+dTekM1tpyuO8obSA8JfvuZYMM5lAHkog2Ze0gAeQD+QYGzLsNEfwek1JoKbp
         qaw/PBNqM9PrUUEyJPfHGkfSoRVazmWr77lihqIr0G75ME3DVrdLgbhmIBPApFRc6Csr
         LVo8wHUUhjY9zG6Ol/vBxvlPplBE7gZUlDTWGgyL3/H5sEo8o9+ftfNgimVbtkUNA4qD
         fZxOByLlNwHBDXNLFkmmt8siRTCK/7oKnp+u3wALmgpO/flJd0saNCVggbaNaicORgqz
         KnmA==
X-Gm-Message-State: AOAM530BMblQ9zhvKakTc9zqQ5v+JXnaaqt8Rsz4UVi3L4BPKJrQR/Q5
        ZbmYuq9LLCipx/SanrlWCMo=
X-Google-Smtp-Source: ABdhPJzRSW9ZTIIUwSfR7LBTCz2HFGxDa3qLZXEZbc87+OmX89f0Nk2/WmOLYC2P+AAIoH37wrUuUw==
X-Received: by 2002:a62:194d:: with SMTP id 74mr19513800pfz.21.1592123494341;
        Sun, 14 Jun 2020 01:31:34 -0700 (PDT)
Received: from localhost ([2402:800:6374:3bd0:871b:497e:ae48:68fa])
        by smtp.gmail.com with ESMTPSA id q2sm2701509pgn.11.2020.06.14.01.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 01:31:33 -0700 (PDT)
Date:   Sun, 14 Jun 2020 15:31:31 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] pkt-line: use string versions of functions
Message-ID: <20200614083131.GD3405@danh.dev>
References: <7e803a2ba9458ce35c657e67323edfe4409205ec.1592055716.git.liu.denton@gmail.com>
 <cover.1592119902.git.liu.denton@gmail.com>
 <d1b79c7734f0609fcac5e523644c3093f538bccf.1592119902.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1b79c7734f0609fcac5e523644c3093f538bccf.1592119902.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-06-14 03:31:59-0400, Denton Liu <liu.denton@gmail.com> wrote:
> We have many cases where we are writing a control packet as a string
> constant out and we need to specify the length of the string. Currently,
> the length is specified as a magical `4` literal.
> 
> Change these instances to use a function that calls strlen() to
> determine the length of the string removing the need to specify the
> length at all. Since these functions are inline, the strlen()s should be
> replaced with constants at compile-time so this should not result in any
> performance penalty.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  pkt-line.c | 46 ++++++++++++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 18 deletions(-)
> 
> diff --git a/pkt-line.c b/pkt-line.c
> index 8f9bc68ee2..72c6c29e03 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -81,49 +81,59 @@ static void packet_trace(const char *buf, unsigned int len, int write)
>  	strbuf_release(&out);
>  }
>  
> +static inline void packet_trace_str(const char *buf, int write)
> +{
> +	packet_trace(buf, strlen(buf), write);
> +}
> +
> +static inline void control_packet_write(int fd, const char *s, const char *type)
> +{
> +	packet_trace_str(s, 1);
> +	if (write_str_in_full(fd, s) < 0)
> +		die_errno(_("unable to write %s packet"), type);

This will create i10n problems:
- Translators don't have enough context to know what does %s mean.
  In some languages, depend on value of %s, it will be translated to
  different phases by the order of words, word choices, gender.
- `type' won't be translated with this marker

I think it's better to pass full translated phase into this
function. Something like:

	static inline void control_packet_write(int fd, const char *s, const char *errstr)
	{
		...
		if (...)
			die_errno(errstr);
	}

and call the function with:

	control_packet_write(fd, "0000", _("unable to write flush packet"));

Other than that, I like the idea of using preprocessor to check
compile time constant string, but I'm not sure how to write it with
standard C

-- 
Danh
