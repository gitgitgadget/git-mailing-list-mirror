Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFE5C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7303E60F58
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhIKQaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 12:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhIKQaB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 12:30:01 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB43C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 09:28:48 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id a13so6400141iol.5
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 09:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ob+GqgjhRBnmGrgnTmOY+4PTBAWf8cEYnmZTRyg9SOk=;
        b=D4XCmo85kgm4kkn59yR3g1UcV6GHZ34HVlaT2fv/xZRrpEOxYFEheNm3ZykEDfTY8b
         01xIJonCyWxDwO+Liwh7txfNYKU9tSuXA5+g+F8biFoEkNQJkyucJ8F/UgkLU9PqaBZY
         MyPraygteh9TJJOcMVezugq71wJYjtT54X4jAyb3mMS6geuhtDlnXQb2QmTiB6VQuc2k
         1D3tdHxMCPAcBQJ3wnGhyErBJj/L5xSNQFKQyUrI1S7Y35E+VGx7U/g/IvuNC8bt8BWu
         J80Ae5cD8fm9xy7HLKJw9meBijMpprKizvbXII7GHMoATbJIGXhbH2JkmmVzcvdbP9m2
         z7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ob+GqgjhRBnmGrgnTmOY+4PTBAWf8cEYnmZTRyg9SOk=;
        b=YzJofhyzEcNUc98DHagqmElgFxVZBY1B0hlLnCXgrdtD7RPM+eAyDUwGBOkCDYaW1a
         Jrzkx2LVMKbbWKxArB0NFOW4mYPq9eHIp974c5Z42jC7RyJ+c0ElSg7QWUoFFz22SnFn
         MikrRMX7RmyY+LrHpRyaN7XMd+2LiRu6EVn01OdAwRLYeFabeT/UwQSatqJ7vLxaK4aH
         V/oRboVPTdR+LR1WC0EnoRZylYe1jpiLlFEgf9GDQ+LsMa1DjqUv+HkL48wrAsUiJGPV
         bxjOavWih7RMn5ZxLQQK8wJW/zPtpNcIrsx3sGgRpqREXjNvvigxUMLt/ERmBrd5N2Rc
         6jPw==
X-Gm-Message-State: AOAM531yEmcvhQfXHg1ykRoAUpRUzpqGENBr6LrqHs/WUOYPOXvuwxsf
        7nAzKyLtag19GAFcLFJwJn1g4g==
X-Google-Smtp-Source: ABdhPJyo/M686ohEiFDK0NkTr1QcV+657qLUn/IzNcShhX1q86OEBE8vLreGtkE7SQiGBQ/M6xldJQ==
X-Received: by 2002:a02:ca0b:: with SMTP id i11mr2697766jak.84.1631377727811;
        Sat, 11 Sep 2021 09:28:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f14sm1094730ile.82.2021.09.11.09.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 09:28:47 -0700 (PDT)
Date:   Sat, 11 Sep 2021 12:28:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 2/8] builtin/multi-pack-index.c: support --stdin-packs
 mode
Message-ID: <YTzZPti/asQwZC/D@nand.local>
References: <cover.1631331139.git.me@ttaylorr.com>
 <2a16f11790b79ab452233b6f28acac607c0abd28.1631331139.git.me@ttaylorr.com>
 <87ee9va0ie.fsf@evledraar.gmail.com>
 <YTzYYfBGqG87O5mN@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTzYYfBGqG87O5mN@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 12:25:05PM -0400, Taylor Blau wrote:
> Good catch. It's kind of gross, but the result is:
>
> --- 8< ---
>
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 77488b6b7b..e6cab975e3 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -64,7 +64,7 @@ static struct option *add_common_options(struct option *prev)
>
>  static void read_packs_from_stdin(struct string_list *to)
>  {
> -	struct strbuf buf = STRBUF_INIT;
> +	struct strbuf buf = STRBUF_INIT_NODUP;

Thanks,
Taylor
