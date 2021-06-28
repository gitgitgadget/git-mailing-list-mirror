Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC876C11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 18:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B273961C71
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 18:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhF1SOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 14:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbhF1SOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 14:14:16 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F3AC061760
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 11:11:50 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 128-20020a4a11860000b029024b19a4d98eso4983138ooc.5
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 11:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ikgUK+5J9Qhj1UPcjOykC8lAR+qeZoMV2chPW/3oQv0=;
        b=KZJvWSgC9ue9UTi1LYsE1qoGXmALjj7C1x2FrneAGqy9P6kJvOhaJFzEW/ZoPh/11h
         SVq7ac9rfiPj/lOaa+MIXsxsc0jMOums/qrEsCCc8k8nljR1Q+r6FbVhnI5RhbZwKlxV
         L6w2w+YSoupRJByqhqbXC5y37gjw72SR7L1c9ODWI7LO+NFEfLgKsgXjpHQso8qTl8Rr
         14CVEzdz29VX5Kc2F0p59YIINl/A3vTC1K/tsXSRF64jhTygu20KlpnOAg+wJse7w0Kv
         5XBsHU7JFvH2Vp0i8QJffwpQSwbYeWMpgGe+9YJJOOzzCmpGrSWGrMYsAi404Wu1XY6q
         k5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ikgUK+5J9Qhj1UPcjOykC8lAR+qeZoMV2chPW/3oQv0=;
        b=ZytDPVbNc+WBmX7JETJa6+WehpCy0ZEAv4cNqzEUM8c5Uiz7pbQGTPjRcmToGW7p1I
         RihJpFWGx2eFI36dZnrwL0SE4MTKP6z4P9Ur00HsvtCkHFB9wx05uobuSyuwZHcRB7f7
         3bWfui8KHMZBvR/10pNUeswDpIyKxunOZkfHP/a9lbWw5pz6mJBbfXsmZDqkVltWNLq5
         GtDbrr76V2yu8BjN4eaUGdbFWzAXTmt32hKhYOA4wruET9oLsx073f/mBmpYqTspFu4e
         ln5VpZJxU5de/Lc5QbKKp+NNHbzUpB5qLNGvVIFv5jS8msZxL5IXdDdLpOr2Eyci+fNU
         1l6g==
X-Gm-Message-State: AOAM531wa9hU2bcWNurJqVIL2djAvRmWowh2sJ7Br6yarbWWjUcALUL+
        HOVyoRQcoib5Guc0WLqDPDg=
X-Google-Smtp-Source: ABdhPJxqrauEKL2wXLAzLnWTmzhanrF1yJoN6k6V2gjX0Dd2JpYZe7bWD8BswYNtBXej8AQJWilGog==
X-Received: by 2002:a4a:e286:: with SMTP id k6mr588902oot.62.1624903909943;
        Mon, 28 Jun 2021 11:11:49 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id l11sm1211444oou.0.2021.06.28.11.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 11:11:49 -0700 (PDT)
Date:   Mon, 28 Jun 2021 13:11:43 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Message-ID: <60da10df509f0_1b95d2089c@natae.notmuch>
In-Reply-To: <60bfadc0aca09_1abb8f208fd@natae.notmuch>
References: <60bfadc0aca09_1abb8f208fd@natae.notmuch>
Subject: RE: How dow we educate our users to configure less?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> It has been suggested that we "educate our users" to configure less in
> the right way, instead of colorizing man pages ourselves [1].
> 
> The question is *how*? Nobody has answered that.
> 
> This is a continuation of the thread below.

> I am still waiting for an explanation.
> 
> How does the user properly colorize man pages for both man and git in a
> way that works in all distributions?

No response.

It's safe to say at this point that nobody knows what that configuration
would look like.

So we cannot "educate our users" to do something that doesn't exist.

-- 
Felipe Contreras
