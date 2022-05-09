Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D12BC433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 15:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbiEIPrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 11:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiEIPrj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 11:47:39 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ABD1B7760
        for <git@vger.kernel.org>; Mon,  9 May 2022 08:43:41 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 126so11108433qkm.4
        for <git@vger.kernel.org>; Mon, 09 May 2022 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mPW0dEIcwa9pXsO8tcctkhWaCXYQNyMPgPkvXcJs4ZA=;
        b=nyeoQ1qkCi8U2VzuXfEG0PzSZfHolzfhDxFBaZG7xKz+W2QCrAw/qoY98EdjGp/1WS
         bM0Pgas4TqmWVf37AfyinEwLbtaHHS3d6TR8rgtFehmFooXdykogPA8iex2oFazjpg6A
         ZoY/lLDU0bcVAUkC8WJH1lk3AO3LwJRj3evGJe75osvxYr/qfLVmQGvl38rgBgnq8XOs
         DYpcoe6q5syGt6hM/BwUhXKcMZdX9ydi/Y5ng3+fgX3ZGAqpTHWrJJDhcN/C+aVDzXX9
         gG1RxLYwNg3JHPSJ5cfpojhwPYgVQ/f+3X+uqQCLtKOfpJySk1+S8XVcmRqE02BrRJdS
         Xmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mPW0dEIcwa9pXsO8tcctkhWaCXYQNyMPgPkvXcJs4ZA=;
        b=rGXj6UfoiAAaOi+wH0sPDRvt5A4L+XZpO2hFB7JmJwLSKDRroiLtAC/ToW+nAXi6n4
         nxNVt1DSSLUyHkOdgDZtwg5sfL+PGxvS6Rgmlr6SLBRrRfJi537UJxnL8Imv4VUBdoD9
         HE9uFcVMNLAxQlgXuOJRNU5LWk2EtD/RBEol6fODFSmrz6Rfzk5tHJlnzhifaUIfq3N0
         P23i+Ym6usamufEkuG8iVZCS1XcLZSP8MC19lWC8Sn5eLTXXRSpMuROVrsMTmYnSb+/L
         h2FVXctunBtvVlhkXEgi2qTVJ0IBp58GQvI8aAG8LA5zaQQqKycMUEynyurOL0KGn2NE
         847Q==
X-Gm-Message-State: AOAM530wBU0WuwXNHFK2cYgym6Yp6D+hUOAKgOhoH8TvflG2ZvHITDHA
        1PM3wJOyLLc3WWwpheNhRPVhfg==
X-Google-Smtp-Source: ABdhPJwBEYjtEFzQN/f378vKKaV5MpqqMxvkwEzRjwLUseeUFWu+ayx0R4S3Ni4OrOToM0M5x0U2wQ==
X-Received: by 2002:a05:620a:3ca:b0:69e:88ef:5c75 with SMTP id r10-20020a05620a03ca00b0069e88ef5c75mr12125416qkm.255.1652111020783;
        Mon, 09 May 2022 08:43:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j10-20020ac85c4a000000b002f3d7c13a24sm3181448qtj.4.2022.05.09.08.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:43:40 -0700 (PDT)
Date:   Mon, 9 May 2022 11:43:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Chris Down <chris@chrisdown.name>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] bisect: output bisect setup status in bisect log
Message-ID: <Ynk2q1XVGsLPvALn@nand.local>
References: <cover.1651796862.git.chris@chrisdown.name>
 <acab8859d02c95750fdbc691ac672c17d5be0291.1651796862.git.chris@chrisdown.name>
 <xmqqh762le32.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh762le32.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 06, 2022 at 11:18:25AM -0700, Junio C Hamano wrote:
> Chris Down <chris@chrisdown.name> writes:
>
> > +__attribute__((format (printf, 1, 2)))
> > +static void bisect_log_printf(const char *fmt, ...)
> > +{
> > +	va_list ap;
> > +	char buf[1024];
> > +
> > +	va_start(ap, fmt);
> > +	if (vsnprintf(buf, sizeof(buf), fmt, ap) < 0)
> > +		*buf = '\0';
> > +	va_end(ap);
>
> We should just do
>
> 	struct strbuf buf = STRBUF_INIT;
>
> 	va_start(ap, fmt);
> 	strbuf_vaddf(&buf, fmt, ap);
> 	va_end(ap);
>
> > +	printf("%s", buf);
> > +	append_to_file(git_path_bisect_log(), "# %s", buf);
>
> and free the resource with
>
> 	strbuf_release(&buf);
>
> I think.

I don't think so. bisect_log_printf() has only one caller, which is
bisect_print_status(). Couldn't the latter manage its own strbuf without
the need to introduce a new varargs function?

Thanks,
Taylor
