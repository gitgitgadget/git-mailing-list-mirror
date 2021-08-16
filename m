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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578BAC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 01:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40E3B613A7
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 01:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhHPBQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 21:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbhHPBQd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 21:16:33 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D878C0617AD
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 18:16:03 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id l24so13110039qtj.4
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 18:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KCgP66I7TGBioq06AhKLcEVjd86qBjTSffPKP4B81LU=;
        b=p6IiuFJR5nmO9OpZMfqv6WTBEhUWerc6ZzftF53I+BxsKwRxhOPPEGaoJhoBDBnGS0
         yUJZGap8K58iis4Klqkyjlttkuh10bdEYFoxJPWF/HudKB/wCtwvoimzwTxsaCfl46iQ
         4OW8lmIZQOiE0Lot4gG5dGyzDrw+pEgJf/Zvz1qGzTjlBR5w3eQruqJG1rVO63gd+MMw
         g+xVesxK+RS+fDhGY0DpDj+FbCXGDGIOEDiMxSkkashcmpyMVJ9XXcAcSosr6L9YG1et
         OV2jbMPfunsUE6ePGOh+4he08fgx/KWJdUiu67Utjq/tLzIs4cC1V/2mJbSWf1qAwodM
         b+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KCgP66I7TGBioq06AhKLcEVjd86qBjTSffPKP4B81LU=;
        b=o+SmT2a4L4v5NabBJ6s3ZbRuPGONDGRJMEB7ti8OMLFM7oKXLnyA5/PI7NTJeIqko5
         gGHWgRawgeHpBRtkRgKf3wOh2keJLUxLeYGEaQCtsqRrdlKWMTsraRQMzvr/XHbREaqr
         b4VU3U+F21ekovDhwsbo5Fd4BBCVIyg+SEljrzORcc5vaFetBeXZWj75gR2kQ9TsPEkZ
         LeYKVn4ghbrt3FAKS8+22ii72ARS7yH3YAf1sX25YsJIzEFiwxzThX2LVOfY/ldF6mlf
         cyQTlWBdTeR6pxqwEJ6crlIMZPm+xKs2gvRU0i0zWGXVTVQNlzQNuF9au40gMAkF8smp
         02DA==
X-Gm-Message-State: AOAM531H3UmhhOiaJPPCwt//a3jzy+bBsblzz9zhT/SJpJGf7Tps6KnO
        nmA6kgv9T/5o59Iln7U8ra8fK10zYh8=
X-Google-Smtp-Source: ABdhPJyJx+iOU0xDAY6gaPyF7lU+Sn5IhjGCHCWlRqFWL3PUfI8s/p8j9Nd/nngJ5jyrZBuBYLXJmQ==
X-Received: by 2002:ac8:1498:: with SMTP id l24mr11680792qtj.169.1629076562170;
        Sun, 15 Aug 2021 18:16:02 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id f2sm4121181qth.11.2021.08.15.18.16.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Aug 2021 18:16:01 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 7/7] fixup! reftable: (de)serialization for the polymorphic record type
Date:   Sun, 15 Aug 2021 18:15:38 -0700
Message-Id: <20210816011538.34199-8-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc2.476.g1b09a32a73
In-Reply-To: <20210816011538.34199-1-carenas@gmail.com>
References: <20210802190054.58282-1-carenas@gmail.com>
 <20210816011538.34199-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 reftable/record_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/reftable/record_test.c b/reftable/record_test.c
index bf5d072b20..519c0bbf18 100644
--- a/reftable/record_test.c
+++ b/reftable/record_test.c
@@ -207,9 +207,11 @@ static void test_reftable_log_record_roundtrip(void)
 			.value_type = REFTABLE_LOG_DELETION,
 		}
 	};
+	int i;
+
 	set_test_hash(in[0].update.new_hash, 1);
 	set_test_hash(in[0].update.old_hash, 2);
-	for (int i = 0; i < ARRAY_SIZE(in); i++) {
+	for (i = 0; i < ARRAY_SIZE(in); i++) {
 		struct reftable_record rec = { NULL };
 		struct strbuf key = STRBUF_INIT;
 		uint8_t buffer[1024] = { 0 };
-- 
2.33.0.rc2.476.g1b09a32a73

