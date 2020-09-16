Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC9BC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF7421941
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgIPUxo convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 16 Sep 2020 16:53:44 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:40463 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgIPQyI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 12:54:08 -0400
Received: by mail-ej1-f68.google.com with SMTP id z22so11328815ejl.7
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 09:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yYQrc0FzM4U5z6R+TFdX6W0QMjVSp01WMU+rviyAZVw=;
        b=QsiB73gSQvaLknoYxlTRymkJsuBmeTLFdxxukjkaWYE5x2/6DssVt0BkZ6vn6dX+C4
         8Z4mOixQV8w/rabNmI+oL+dgW4Z/UJ8iNa3uY2/qOEWSkrxbys4yAbCq2dNLltdKGQ/h
         3MzYO6TkxlX3vCRKY0osnetJuID2jwwdIs/tEYJyONO1gYqeIOCK0jF4DH4yg6DWxPpr
         tGDFtRCH6T6LFCnH3Bkk+styWgtKevXlDA2R6J/xoKecwGVwBhW4fvAQrDBm8Gk2R7pN
         2BMo4fqUNQr7enGWL1Sk1qmsrxQSB2xlqXxu1wjc/ITesrysVSDh1t6p1WVXWezIzJer
         1tyQ==
X-Gm-Message-State: AOAM530L5zHP1NqJ+HuSA0g9fn3ttR/MkefSNKVYmVfXjB4sanJPua9M
        rr1wHxBjLpoUSSSuHdJxIvPtIKb5GMHr4a0lZ7lvPDQao/c=
X-Google-Smtp-Source: ABdhPJzFWe4tzmMxDEAG/Ew/nDRSYUI0SL6JN2GKzP5G5sBnf5lkhzLhqLuy3zsXb0X3MHTYr1sPoC9YRQeBcWmNOgc=
X-Received: by 2002:a17:906:250a:: with SMTP id i10mr25915036ejb.202.1600275231725;
 Wed, 16 Sep 2020 09:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200916102918.29805-1-avarab@gmail.com> <20200916102918.29805-8-avarab@gmail.com>
In-Reply-To: <20200916102918.29805-8-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 16 Sep 2020 12:53:40 -0400
Message-ID: <CAPig+cRg2tuOiQH_CQoHMjkX2gbRPJoV8NPJZnu3=bfo4wk-cQ@mail.gmail.com>
Subject: Re: [PATCH 07/15] remote-mediawiki tests: guard test_cmp with test_path_is_file
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 16, 2020 at 8:17 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Change a test that used a plain test_cmp to first check the file(s)
> using test_path_is_file. If some of these file(s) don't exist (as
> happened to me during debugging), test_cmp will emit a way less useful
> message about the failure.

An alternative would be to update test_cmp() to present a more helpful
error message so that all test scripts can benefit rather than just
this script. By the way, were you testing with a reasonably recent
version of Git? I ask because test_cmp() was updated not long ago to
provide better diagnostics when one of the files is missing.

[1]: d572f52a64 (test_cmp: diagnose incorrect arguments, 2020-08-09)
