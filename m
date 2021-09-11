Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A476C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 01:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E60B76120A
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 01:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhIKBg1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 21:36:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61435 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbhIKBgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 21:36:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C986C9504;
        Fri, 10 Sep 2021 21:35:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zakaiAuHbEL/awYKuncNETLEyt7v0pAT2/8cCA
        hpS80=; b=s9DjuaA7//uri8QOodD1p8rULd6P6V+lSOyK/4YuKr0UOGryUGrUrT
        W1hxk7JiacXD2aR3Y89gzlXn+3wLcVZqpUAMC/p9CrJ/kvVXtcxiDB8ENeCwK490
        R/FUJ+lltFVAKkCeXrJzzz73NRaT4vjrEhdaLPa9uQtauRiOcYnJQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D763C9502;
        Fri, 10 Sep 2021 21:35:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 649FEC9501;
        Fri, 10 Sep 2021 21:35:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 5/5] help / completion: make "git help" do the hard work
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
        <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
        <patch-v2-5.5-e995a42cb8d-20210910T112545Z-avarab@gmail.com>
Date:   Fri, 10 Sep 2021 18:35:02 -0700
In-Reply-To: <patch-v2-5.5-e995a42cb8d-20210910T112545Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 10 Sep
 2021 13:28:46
        +0200")
Message-ID: <xmqq7dfnopx5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C7DF9CA-12A0-11EC-9657-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This step does not seem to pass "make builtin/help.sp".

diff --git a/builtin/help.c b/builtin/help.c
index 9eb09d4804..4af4c62793 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -38,7 +38,7 @@ static const char *html_path;
 
 static int show_all = 0;
 static int show_guides = 0;
-enum show_config_type {
+static enum show_config_type {
 	SHOW_CONFIG_UNSET = 0,
 	SHOW_CONFIG_HUMAN,
 	SHOW_CONFIG_VARS,
-- 
2.33.0-549-g40c0868576

