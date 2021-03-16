Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A071C4321A
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A81665092
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238697AbhCPQTI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238562AbhCPQSO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:18:14 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A934C061762
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:13 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so4102346wma.0
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P3vXHWJ2/Ynpr02hktr7aopm6VP3FNrN5iPVrzOnnFE=;
        b=RQ0Cbi0ybGl0DpC0YZEBY4XGwOLmBw7qx9sqPn/Ay4arPVjjJ2tccfC2/csD2ahc/p
         kiqWZPbNRWCSt//thZWOTbYb0fv1tI3XDcREbitZ6gkQ/Vs9R9t+iISy/EyP9LnLbGGu
         e02TlSL9Rt3yhdilO3Yye4njVw7BZSUt1exwMSo1mtIxErdHYMXtgTQnNoCitL0vARpE
         1BdlLWbBxvxdYHIHk7qp1Tb5azhHguDRduakamysVj1lfTVtKmUlgGouvDcAIMesZt3y
         co6GmoenOsCsLMK4amOwl0h7+XDqlUbUeYEuLdt4cwbSf/Dsn8sFL3zaw59toEjV4ish
         TgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3vXHWJ2/Ynpr02hktr7aopm6VP3FNrN5iPVrzOnnFE=;
        b=jZ0D5V5u3GquOY3jOX+b9R8ZGphv7obgx/zbFg3i+K/J4kO5lfy6j+36ziR/ho6t03
         kQTrh4SQMDXzKVf93nz0dpIbF54V3m/Nc+U59mNPvt7xGKcZcXDBr/sPNPrAJfDqTnNe
         DI4vyOfXyfUhStRc/zYl961I2cWpo/2qrPBSVjBNIBORJciPprlKf6XIY/aU8mrjAIqm
         cAHdRxfMhNrlDMjXpt+7k7ST0UeDXyJAlUl+bTpSXQ3R185kpJj7QGOyClpeEVfMWxJd
         bxBL3UaIbn8eQUZJXUZn6m9SY20radQBdzVMsCYWeRFTf5+snCnHuIG/y2Ld0qa8pcm0
         OJyQ==
X-Gm-Message-State: AOAM532X33cb7RXtAm8JfUlH4YZFpSFaBA/hUPLJYCvkYvGJA7eOeyMq
        9pfm+CwxNyyn4ISCv+OSUttEYDE49I+BUw==
X-Google-Smtp-Source: ABdhPJz1OrObnH6fONaoyrEyTwyP8kD9iMegzc8VeHw4JdD0bQwJan6s/F01LRDoegd3/XB6gXpS3Q==
X-Received: by 2002:a1c:e4d4:: with SMTP id b203mr358562wmh.105.1615911491962;
        Tue, 16 Mar 2021 09:18:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:18:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 21/22] fetch-pack: use file-scope static struct for fsck_options
Date:   Tue, 16 Mar 2021 17:17:37 +0100
Message-Id: <20210316161738.30254-22-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code added in 5476e1efde (fetch-pack: print and use dangling
.gitmodules, 2021-02-22) so that we use a file-scoped "static struct
fsck_options" instead of defining one in the "fsck_gitmodules_oids()"
function.

We use this pattern in all of
builtin/{fsck,index-pack,mktag,unpack-objects}.c. It's odd to see
fetch-pack be the odd one out. One might think that we're using other
fsck_options structs in fetch-pack, or doing on fsck twice there, but
we're not.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 82c3c2c043..229fd8e2c2 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -38,6 +38,7 @@ static int server_supports_filtering;
 static int advertise_sid;
 static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
+static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
 static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 
@@ -991,15 +992,14 @@ static void fsck_gitmodules_oids(struct oidset *gitmodules_oids)
 {
 	struct oidset_iter iter;
 	const struct object_id *oid;
-	struct fsck_options fo = FSCK_OPTIONS_STRICT;
 
 	if (!oidset_size(gitmodules_oids))
 		return;
 
 	oidset_iter_init(gitmodules_oids, &iter);
 	while ((oid = oidset_iter_next(&iter)))
-		register_found_gitmodules(&fo, oid);
-	if (fsck_finish(&fo))
+		register_found_gitmodules(&fsck_options, oid);
+	if (fsck_finish(&fsck_options))
 		die("fsck failed");
 }
 
-- 
2.31.0.260.g719c683c1d

