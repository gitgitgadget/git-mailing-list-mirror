Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C204C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 19:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 621C861037
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 19:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243403AbhHZThk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 15:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhHZThj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 15:37:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0107AC061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 12:36:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q14so6786691wrp.3
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=cFgRd6LRdmH0zwMcdUkQM9tDs+7O7xj2NfvKjQDefik=;
        b=Y7SdPwkaCHphRKPuKi1gULk7IYU9d0KDnzNvSTXwukVAh2OIMoTT7W2BaAJVE462RZ
         QM2rFJKE2aCynLlFOFk4U0g0JmMWWXJ9R2I+OGv8ZcJTvDtAOXbjdwlQLfrdjjxqS9TY
         QwX8z2ik5qjol7IXDx5rdw/6qvuQOx+qleq/+2q2ui6SuM00341epxYfIa8EgQfpfU8K
         C6SWV50S8z3p7dPUOf8DFDjNznGz7PoGU27dHKTn1o/c+Ou4o53+yl6Z4zaAdfu+7ogQ
         sjiID7wFX/jwgdpAC5LeS7/A1/celW9EaPKTIW7AxD9865NDmY/rzQMRZM3h3ZMIBojm
         opWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=cFgRd6LRdmH0zwMcdUkQM9tDs+7O7xj2NfvKjQDefik=;
        b=fJu7QieuPdjw5j4DMklpncqKJnseYyVyD6tbTAhnRlezZlben566s3cQU/oVW2D8k9
         9Xv7zSsQmazPwBy//mZDZkY66aC0vWqQsYqCyZXF/TnjLCTlOsnuKIAYOyfKEwF9kiMF
         rSZHZteJwimk2cMXj3uOKH6+TBwp3mgJu7itKWVHmyjBzdvxNZZp10aJfjpTdHmX0b3R
         9UjMo2a4cb3qQjkKtmswSq1CFye+/1inXZSLhPA3iTbgDMw52E77R7EA5UD8hXskhIxu
         bnFnYDcC0T40rbZs9vu330C5dJArMC67Eq+bdzYYC2FujVQUoctwomR7NcnAoEEK6cVo
         zHpA==
X-Gm-Message-State: AOAM531pmheR40cOOoxrGO0MLnm0NVSkga33DsUyi53e3CNm2lragFya
        uqEp/jhAYKZ7Vc3qMnDvxMvzBCUXe595kQ==
X-Google-Smtp-Source: ABdhPJyTSbAvoKsWmRoBsOo7p3G587Xw6WEVcEUvsl35SLx5m0LqpmdVLv6BgYlQWMlelsciF0b4bQ==
X-Received: by 2002:adf:c40d:: with SMTP id v13mr3753054wrf.388.1630006610323;
        Thu, 26 Aug 2021 12:36:50 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v21sm4526903wra.92.2021.08.26.12.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 12:36:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        felipe.contreras@gmail.com,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] make: delete strip target
Date:   Thu, 26 Aug 2021 21:36:05 +0200
References: <20210826113824.50078-1-bagasdotme@gmail.com>
 <20210826113824.50078-3-bagasdotme@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210826113824.50078-3-bagasdotme@gmail.com>
Message-ID: <87bl5kyp4e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 26 2021, Bagas Sanjaya wrote:

> The target isn't needed anymore since stripping is done in install-strip
> target (in previous patch).
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Makefile | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index b8a3a64422..027b052a0c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2170,8 +2170,6 @@ please_set_SHELL_PATH_to_a_more_modern_shell:
>  
>  shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
>  
> -strip: $(PROGRAMS) git$X
> -	$(STRIP) $(STRIP_OPTS) $^
>  
>  ### Flags affecting all rules

This doesn't remove the phony "strip" target (nor does the first patch),
and in any case I think this would be more readable with the two patches
squashed together. Let's remove the old target & add the new one
atomically.
