Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FD9C4332B
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D8365023
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhCFLFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhCFLFA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:05:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C04C06175F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:04:59 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a18so5195512wrc.13
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uQ8XMDTPGyf0XB7lifCi9qup800vgNH1UMxqJFcjFzk=;
        b=hJ1vsaNwSPHwIsyFxfBmgGfAsMTmfkgz1xAoYJiPpt/X5PZI/85BNL1o+7jB/ICh2H
         Otmfu58Sl04ESc4qJMC4i8EixD15S2kbwFZy6t0gQefNXoExa10LB4WlzBv8KD+PLD7p
         I5S6xU8JG3kfXPyRargf2GwvStUoUBqLVwWmO0tjJ/NkOsViKnnrOqZVKTppTmmsuDKI
         WwklMtkWexZxHh711BKA7TuHZLysmxsXczim5BcuEsTj0nGoC6TgATi7ebAfcZThFyFb
         YC3LoIXoJ+ackd6TSeYQ3LUzu/d/YoalRGIjGgnDN4JJcimyI70DNse8tRXQbfjKSWOG
         A26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uQ8XMDTPGyf0XB7lifCi9qup800vgNH1UMxqJFcjFzk=;
        b=RGLw4bx2BtLWoimJHTIqMjo27cxX6GOD6i9gvg1FuTjGdJIS6NUlHsabGZs50QaM2H
         Bz1j1jbJFJ3irRapl1hCQBQpdT3BnfdP4aqqGpeO+JAnsmr9D0ciRyOhbkkqVIftwi5C
         Naznd8rs1m3n/hejQoahF+5Bf2Zu9ie5YgqpGiJfS78EgxjPLMVgiNe8o4Ercr3LsuOm
         jYfZCuRci7EHC7yLZwRIv/CGBsFYme1Yf+GJNWV7ByEPSdtLgrckFjFznf13c0e9413q
         qh82T+0Hvp6txNK5tuV7F0Zs5Vjr+UWlp2YJV3ejwwXEuFd/+cC0hg0fbT5C8q3HTbOP
         TnWw==
X-Gm-Message-State: AOAM530njO+DUM/+khLsuz/67j7a/a8eNxxdcXPRaREgoVdFCxxAh8M/
        pfrHVgyYowCN8BW1UIIEUbQrU63fGVZHfg==
X-Google-Smtp-Source: ABdhPJwIIV8lkxPrbjFAVhcdxMNMD7osd1JqECMxVX+6aIoXWicEbHkaW5gXC7lFXcwrlL2BCG/Bzg==
X-Received: by 2002:a5d:6304:: with SMTP id i4mr13401956wru.155.1615028698345;
        Sat, 06 Mar 2021 03:04:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:04:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/22] fsck.c: move definition of msg_id into append_msg_id()
Date:   Sat,  6 Mar 2021 12:04:25 +0100
Message-Id: <20210306110439.27694-9-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor code added in 71ab8fa840f (fsck: report the ID of the
error/warning, 2015-06-22) to resolve the msg_id to a string in the
function that wants it, instead of doing it in report().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 0a9ac9ca070..b977493f57a 100644
--- a/fsck.c
+++ b/fsck.c
@@ -264,8 +264,9 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 	free(to_free);
 }
 
-static void append_msg_id(struct strbuf *sb, const char *msg_id)
+static void append_msg_id(struct strbuf *sb, enum fsck_msg_id id)
 {
+	const char *msg_id = msg_id_info[id].id_string;
 	for (;;) {
 		char c = *(msg_id)++;
 
@@ -308,7 +309,7 @@ static int report(struct fsck_options *options,
 	else if (msg_type == FSCK_INFO)
 		msg_type = FSCK_WARN;
 
-	append_msg_id(&sb, msg_id_info[id].id_string);
+	append_msg_id(&sb, id);
 
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
-- 
2.31.0.rc0.126.g04f22c5b82

