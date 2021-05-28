Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDE2C2B9F7
	for <git@archiver.kernel.org>; Fri, 28 May 2021 16:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68299613DA
	for <git@archiver.kernel.org>; Fri, 28 May 2021 16:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhE1QMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 12:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhE1QMU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 12:12:20 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7200DC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 09:10:44 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id o66-20020a4a44450000b029020d44dea886so1049798ooa.5
        for <git@vger.kernel.org>; Fri, 28 May 2021 09:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=PSjAkfElX5t1lowtKxG7G1jSKChGum+T84qqsYHtYYQ=;
        b=GBOSMSE3HCB9GSPdDtpucNGWi7UJjFV5hQcm8DX1pIK9Bmz0d/NDId9wOnzXDaDB7Y
         mp0HRAO1fKtOyQOb/czinDtF+zNVCZLeF/f5dAvB4io/CKYGS5YupnlyPa6gFeNMNI53
         ORLQR9ROEImutCslOd8dqQyxmKRjx96U82TQT586d4NPfUTtMvtSMzWmKykPjt889ulP
         3KGx/zb71s2vbQVO2/5dWlHrnA6+X3MyASynEZSqKPUcBIYQhS9cURY93qIF1pJnzqmU
         GBl6b8BgSAF456MwCm9A087JZiMMU7z4v2SyxaOb9QOiXHs8Y6w7yznJURIe41G6kIcq
         kIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=PSjAkfElX5t1lowtKxG7G1jSKChGum+T84qqsYHtYYQ=;
        b=q37EblJuacdt1n+APWSH9cOuOHypO8suD56IV/t6wAdH+ITFuLttP7SHxwWanRhbNj
         +z6W5XNJlX2zkuC5HjOj96Msd+a/q2+KvA2qY3L1WgtNLr0+sFcnKW5cPioNAU6JSNIs
         GWjUicjORObh0iHhiI+s7vTm4IWfNCTnKgXfKcZ/Xj/Q9yZteuekpWofUi9z9K5J85kI
         scr4AM95XhQaC7fr7ABoMC4M2pMntN4GhEJGgP5LjDXt3myn98fYYOTVeqjH3dlHt3PT
         Vv/Reqwm4mwbOLRmQ26m9a56KvBc+KUGxH97zl7c+GKIOqJyMMYA8JPoee8oCaI78zON
         yATw==
X-Gm-Message-State: AOAM532y0PPv0NO0ehzW7cxIGKTqrj1Dq9cKD0ft8rMlQ2dE6wObp3uj
        5z8HAmG4S1rK4AEKyWX7K7k=
X-Google-Smtp-Source: ABdhPJwCAALvWa87idCeTWIbLGUrWIggPzQEdvG26iF8g5dMWSdOCLoyaaTYz90bq0+QXWUzbe/9eg==
X-Received: by 2002:a4a:e1d7:: with SMTP id n23mr7706143oot.86.1622218243421;
        Fri, 28 May 2021 09:10:43 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id o14sm1213243oik.29.2021.05.28.09.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 09:10:42 -0700 (PDT)
Date:   Fri, 28 May 2021 11:10:41 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60b116015b98a_4b03220857@natae.notmuch>
In-Reply-To: <patch-08.13-f1a879a8ae9-20210528T092228Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
 <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
 <patch-08.13-f1a879a8ae9-20210528T092228Z-avarab@gmail.com>
Subject: RE: [PATCH v5 08/13] send-email: use function syntax instead of
 barewords
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Change calls like "__ 'foo'" to "__('foo')" so the Perl compiler
> doesn't have to guess that "__" is a function. This makes the code
> more readable.

Agreed. Ruby has something similar:

  foo arg1, arg2
  foo(arg1, arg2)

As a C programmer I find the former a quirk of the language, and much
harder to read.

If it's a function call, present it as such.

-- =

Felipe Contreras=
