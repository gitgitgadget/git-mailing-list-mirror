Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FA3C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 10:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CBDD60F5A
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 10:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhHBKbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 06:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhHBKbs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 06:31:48 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D20C061796
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 03:31:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g21so4511370edb.4
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 03:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/Kr4X7GXu+2SDpNoexTX7rFZgixJ534e9gLdT4QOIJ4=;
        b=rpq1IdnK2GlyO5Wd86upAetFgVNCqmII3fLI38quV+zc3JBLSvDKZxgfFwOymR2PZw
         QLtPJPwAcoNMTSSA+Cl6VmA0gX17B0Pb5HmIGzX8ongq3BitWWwmt+zWrrvJsttahDr6
         eSj02tIVI0k2OWgIVZNIxsie1/i3EFqK4uXtIpSbc4g2xV24FKyFR7Bu0sZCnWtsh+1L
         o52RwLuBFVfTaA+7E2OElOvgRAEChp60p72WbsNUc253EMRjY+SVvBf5NjY/gD9qhqzV
         PAwodJWR470NVQyCWDnJhdpV3ur/PmNBKkLkjnbzpl8xXhweLYge0If7EG9zE5ACQVAC
         PKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/Kr4X7GXu+2SDpNoexTX7rFZgixJ534e9gLdT4QOIJ4=;
        b=N22NQifUZx0Denma7CjTE0QKYPdMi3L+oALqAueg/I2TcBVkf0XkqJdhK3tPgUocJL
         FWZHAIu4q1EeOHaK8jhWlHQPgmNHDQvq0dM6CydiRs3mdCqsdDos+McXK7O1guLRu45a
         /eI6YFym0yW5ISAZsGPKMlRhNcgnEN22HXUkOUgEBzXRLo8D203oIQ7QcECdSGsNynrg
         qOmuKU15O/VpFCUuzzET89iBX90CwArIxYQyZgXjClqSGi9+2lpZ/q8puCAXllFPMZ5/
         l9khbSqfbvhTnMLdAMi00s5ixIMB8DR9TVe/KWSRA3XfCh5DoWzT4ol2KLFfrVbOX5PU
         AZ/w==
X-Gm-Message-State: AOAM5312DZ3j811xQ6jQa9L4H4no+70DmMwx+qoXrC4DLzfwzPNMysHM
        KjWdFnGH7XA5HjXG/yoP0W8=
X-Google-Smtp-Source: ABdhPJzBxQP8xBxL6i2d0F1NVqGvqlzRbfNSxTd+mCOALmPayb9bllDXVI6AHoCHYEAWooOq497yPQ==
X-Received: by 2002:a05:6402:702:: with SMTP id w2mr18366637edx.149.1627900295895;
        Mon, 02 Aug 2021 03:31:35 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id jj19sm4355871ejc.85.2021.08.02.03.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 03:31:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 2/2] tr2: log parent process name
Date:   Mon, 02 Aug 2021 12:30:34 +0200
References: <20210722012707.205776-1-emilyshaffer@google.com>
 <20210722012707.205776-3-emilyshaffer@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210722012707.205776-3-emilyshaffer@google.com>
Message-ID: <87lf5kp27s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 21 2021, Emily Shaffer wrote:

>  compat/linux/procinfo.c                | 55 ++++++++++++++++++++++++++
> [...]
> +	/* NEEDSWORK: add non-procfs-linux implementations here */

We'd want non-Windows and non-Linux implementations of this, but that
NEEDSWORK comment should not be in compat/linux/procinfo.c, where we're
never going to add non-Linux code.
