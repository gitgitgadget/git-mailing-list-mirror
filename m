Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27909C74A5B
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 21:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCPVWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 17:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjCPVWj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 17:22:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A956DC0BD
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 14:22:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-544b71b3114so16819367b3.13
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 14:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679001753;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+mDuDkRw1wGcNcAlnEQkDp35MvhlD0/A54sohUr7I8c=;
        b=oVjW+Lk3uthXc5KkIXSxjq3Wc8+vNlVJGMXSS/sU1hIG/hpT3gXFB5gC0xaju6oyFE
         mIl3TeuAY0o24FgeJlgM+3HYdpSZjzN4Sck5ePtfyNQ3rpVutXNuTFWysbZV+cJVOtRT
         sHcEbcfwLtDIs7OyTb2kSajzZVqw0op3s6ZgL/ExWs7UVImATQALooqTUxSW/g/vhTna
         bub80Fj03H1nUTq3nYbDnuH6GwbWzJrDkXiZAGBeyCliM343ao94AqX0lO74VxORmpGD
         vH+SPTIY5VxcKOawNpJ7e8ykSNm5DhWVfXnLlD4R5mUJat9gA3fGRsCwGaPwzANHN/Ck
         Ls0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679001753;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mDuDkRw1wGcNcAlnEQkDp35MvhlD0/A54sohUr7I8c=;
        b=6rH2aOoqFXfigybzRvHL3y5wVXLJhiwFr/qqQQyZIDUNAMem+wIwUb2MBrEnnF4T6L
         laVX/sx6WNpbBmKdTsn24Ck9y2MGFV4u93h1seW71Vz/C56JeHBZgxj1HWi37t/4b8GG
         5lI9vHRTS+xSpBv/vQa141HAnB7fyDbAz5ET9fAJks3yz1EjCu2yFsbtGjr4H2Dw0kBx
         wTwF6Op32lwuW70IphnDbHCkCb+SEkectV3JI/qhOu+KxfOrUT7SNO2A+2Vh+MxUUYhV
         8XRqFJ9M1tZyVBqfOj/wZcabLDrkVWTMLhtRAv4oSRAbNTLjCwOuYMDWfDiyLn9rU/rT
         SUEw==
X-Gm-Message-State: AO0yUKWjLlIvp3nNCAsSLFMFd3GZKTOeJkGIFLivA/TVF5DqN8l3RZNH
        qyap4OabznGd2Y39pcpxg8TDPEUmRSZpCyr19z/i
X-Google-Smtp-Source: AK7set8f6FfDie/0tHqFdWpjdVy6+kEtapP9cVnVZzHPRW6tq3F9XjggNzkpPumFhwGhGZUegJo7ReIgVzUJyxJWvn1f
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:9170:84f8:2856:fe19])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:102c:b0:b4a:e062:3576 with
 SMTP id x12-20020a056902102c00b00b4ae0623576mr5626579ybt.13.1679001753627;
 Thu, 16 Mar 2023 14:22:33 -0700 (PDT)
Date:   Thu, 16 Mar 2023 14:22:31 -0700
In-Reply-To: <4347896f0a4896efe5b1410b72f5b583ad6bd9e0.1678925506.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230316212231.314236-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 3/8] config.c: create config_reader and the_reader
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> -static inline struct config_source *config_reader_pop_source()
> +static inline struct config_source *config_reader_pop_source(struct config_reader *reader)
>  {
>  	struct config_source *ret;
> -	if (!cf_global)
> +	if (!reader->source)
>  		BUG("tried to pop config source, but we weren't reading config");
> -	ret = cf_global;
> -	cf_global = cf_global->prev;
> +	ret = reader->source;
> +	reader->source = reader->source->prev;
> +	/* FIXME remove this when cf is removed. */
> +	cf_global = reader->source;
>  	return ret;
>  }

In the FIXME, it's cf_global not cf.

Everything else looks good.
