Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86DE71F406
	for <e@80x24.org>; Wed, 17 Jan 2018 17:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754135AbeAQRzR (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 12:55:17 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34320 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753462AbeAQRzP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 12:55:15 -0500
Received: by mail-wr0-f195.google.com with SMTP id 36so19842514wrh.1
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 09:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m1Afdoamc7XPp+b05ceeAn2l5AjC4Xkyjlc1oHXNH/A=;
        b=kFi5WujmmWaPHPQST+uVXNZAkxBiLLFIctGOEgIdgtOprutwZCxZNrzOUo+QoNQFuO
         uVmSdR3oVoez9F6ZvzUl2dIqUwws6M3hyLKy7Oce4R4tWV4lQsv3reDS23E3CtBOULsi
         2m5d/bD56NbRcsV++X+qBdF+BmDcRtn12nnbf11x/L+mCxZ8eyE8pqnxv69TA5urFZhD
         TM2gnqFrq6Ue3NNVvdmpFoaXauQSTBxIRh/zYq5ArHrrgcM0FGaePrr/7pyOAuuMqvS5
         tbuqNWlWYtSyYQeUFQv1MkNcLcZfl/f5OaxxQ3lWOsFUngcSrWlgML2GUg//ki9pLD0l
         3nzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m1Afdoamc7XPp+b05ceeAn2l5AjC4Xkyjlc1oHXNH/A=;
        b=rBOcK8B71RbL7byHK4gMNqqc2IezeTbK7ciI18pdcov3oVHAKyrdNx0trAFqZqy4uQ
         ZTV25ed9amysm1rhX7Nyad4g5ovohsFy3LCwYAStAjxU/Skl31uXHGkx4DEKpjQZJ9+9
         jh7/o81AKOWphLeuxh5MuIpkibTlB3/WmnfwBkdyP+VPWMmBJH9/KTOPYRbOEl9wbUud
         ZDc6UOU0GSdV/FUBSGBJBis79+XusA5Csy8q8X/pjkJmsMC1l8mhspVO664vC4A0pnD2
         wsuWxm7WwjtadbnwG+VUqQBMoOfhzbZZRjeKoFWDkjqizFD0ES5yXvUkTlpOfJguBKb9
         p3bw==
X-Gm-Message-State: AKwxyteOjgkFimDAe+aR4sEaOtNfQozv6O5XleOQt3wCboXqtrq7u97s
        2arIvP+Y2LQA0yOE6LW1HZbrqJuC
X-Google-Smtp-Source: ACJfBovAXRVVyHQRcGnCqeCYRRUA6MArsHiri6GSsua7jwtJy+k+YcIyctzaDlK6ldK6bylABlBiwA==
X-Received: by 10.223.196.149 with SMTP id m21mr3251772wrf.256.1516211714166;
        Wed, 17 Jan 2018 09:55:14 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id o18sm3994704wrg.59.2018.01.17.09.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jan 2018 09:55:13 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>, Kevin Daudt <me@ikke.info>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/2] sha1_file: improve sha1_file_name() perfs
Date:   Wed, 17 Jan 2018 18:54:55 +0100
Message-Id: <20180117175455.9316-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc2.3.g254af8b974
In-Reply-To: <20180117175455.9316-1-chriscool@tuxfamily.org>
References: <20180117175455.9316-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As sha1_file_name() could be performance sensitive, let's
try to make it faster by seeding the initial buffer size
to avoid any need to realloc and by using strbuf_addstr()
and strbuf_addc() instead of strbuf_addf().

Helped-by: Derrick Stolee <stolee@gmail.com>
Helped-by: Jeff Hostetler <git@jeffhostetler.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 sha1_file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index f66c21b2da..1a94716962 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -323,8 +323,14 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 
 void sha1_file_name(struct strbuf *buf, const unsigned char *sha1)
 {
-	strbuf_addf(buf, "%s/", get_object_directory());
+	const char *obj_dir = get_object_directory();
+	size_t extra = strlen(obj_dir) + 1 + GIT_MAX_HEXSZ;
 
+	if (extra > strbuf_avail(buf))
+		strbuf_grow(buf, extra);
+
+	strbuf_addstr(buf, obj_dir);
+	strbuf_addch(buf, '/');
 	fill_sha1_path(buf, sha1);
 }
 
-- 
2.16.0.rc2.3.g254af8b974

