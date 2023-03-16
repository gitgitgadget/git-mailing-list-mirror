Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776C5C74A5B
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 21:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCPVS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 17:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCPVSY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 17:18:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FA6CC317
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 14:18:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j125-20020a25d283000000b008f257b16d71so3117072ybg.15
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 14:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679001503;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AEzfyJ9sd7GArzwLRnr8SzhPk12n19V2nj0lKjHpNTw=;
        b=r1gugM8zGAgJcdvH61bkIS+sVDAwxI/MQS8Am1w31Fe14UCwTokQsayJeJjBzQw7Qy
         olaPeee5zaxKIzOOkndsxYIUQ9yI6HqlAOb6SQnCyKiPksitDSDV/EfE670aNnnIGIoF
         7tLAaFbOAwleEBi1eYuWbcxM1HW953iv+4S/vpiYLcyg6wXX6TD9Jog/ZM5W2ZIngg6l
         3f9j7uLF65Lr6Y0n69JzLrmla2LQgM3nCv5a8v+1EJAQMaAqE1jzthk2MX7rWJv15Lw9
         lqEEV88bobo7C/OcHHlc5wPjujLH6MnjuS5pKPLwOLbG85y2UK8XwzhGv+Q2KhtBTqMF
         h1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679001503;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEzfyJ9sd7GArzwLRnr8SzhPk12n19V2nj0lKjHpNTw=;
        b=yqbowvXd1mILAr1DkuXJMJwltW9Em00NZZui4CjRfP8Ux0Xd7zd+qW+W0pCEVNrLBZ
         h5Q9nHgVPSzJNlvrg+Avmf+Gtzeel68tt8Z8/Snj3Yk5KnSoJueL2ojeyLMnBjTCUCD3
         zkSHktb6ktf8H9uAbHZSDQaxFLvBC4eiKWUs1WudYuNrVp3xqqMHvvClIHYLX4iaHy2p
         tSyUYma/k8S1w3lyQ7sClHlB5o7XpS4PGoeOtYJ4Us+I+ixhx3iGo/vO7suqKmjDGLq2
         IGOtpriOmmaH/e4Y6uOBgMmN1jk1mPR2/GEUBnel9xU29PxOR0malhohHIuee8DtzpjU
         G6ng==
X-Gm-Message-State: AO0yUKVwcHoSgzLYIBMINdUF3NzOgY+r+zskq+FCd12iMzrr2jytpCr8
        u8k6H3x/D/CYrDadOMElOojdHsCTdzbcWXk9a55s
X-Google-Smtp-Source: AK7set9UGy0tNGDQXpRo18jFFXubqfB6YPHodwRjONpftuPF4Jrb9pvg5b92P14Jx5CsNn9KrhhjNYGH02x7ORim1NHm
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:9170:84f8:2856:fe19])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:1101:b0:b26:d140:5f74 with
 SMTP id o1-20020a056902110100b00b26d1405f74mr885449ybu.1.1679001503104; Thu,
 16 Mar 2023 14:18:23 -0700 (PDT)
Date:   Thu, 16 Mar 2023 14:18:21 -0700
In-Reply-To: <7555da0b0e012a5fd28ca1a70a4a0897514cd607.1678925506.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230316211821.313426-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 2/8] config.c: don't assign to "cf_global" directly
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
> +static inline void config_reader_push_source(struct config_source *top)
> +{
> +	if (cf_global)
> +		top->prev = cf_global;

Don't we want to set prev unconditionally here (i.e. set it to NULL if
cf_global was NULL)?

> +	cf_global = top;
> +}
> +
> +static inline struct config_source *config_reader_pop_source()
> +{
> +	struct config_source *ret;
> +	if (!cf_global)
> +		BUG("tried to pop config source, but we weren't reading config");
> +	ret = cf_global;
> +	cf_global = cf_global->prev;
> +	return ret;
> +}

...since we use it unconditionally here.

The rest looks good.
