Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46233C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025CF64E4A
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbhBQToQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhBQTns (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:43:48 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146B7C061788
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:08 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bl23so24343531ejb.5
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8hQioYq2SUFWVMt390/hFdBWnZ+TltgMRh5ZIojhMRg=;
        b=hA+kDS7ns2bUaZialC4fZk/UbLi0Hn0NVwbPcuXNlddjla5OmtqAtqS+y59YnhxGIU
         aFFnublSbZAJS6e7OJC8npmaSC+M9/o4bcY7ybB2KTKmuVbhM68VmnGJYaHL9On51VPF
         VTKaSQTJ/xjGGf6xI/4x6hOOoavg3BuC2LSTYmA9NfbNFDTt/V/0a71/vv0Ukscc2Yuu
         GMpUg4kqJrg8blJYjrLuRDs7w0uUYVzuKf8LVytozaCa+Ng/9w5OYS6PeuRAQNviy/mt
         EgkMmh7A7rQtIr1UbUnODOy3j2nFIu89c9WT4e8g42fIT11Q3OfORD9d1+0gy2sxc8F1
         YO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8hQioYq2SUFWVMt390/hFdBWnZ+TltgMRh5ZIojhMRg=;
        b=Z4X83nXMy7qBe9WL0XAshR9RnNbMIOK1YqZqzENh8p3ga3ue+yPMQOEb360mkC/ATI
         8U+Jewe2R+RIigJqIUQaV7ox06v+BjOpD4Zgj0id8JE+7MswOGlqIenRacOuqp5zZog8
         3elcQMbtD4miFEdhBs8Mf0zinukbIJuie8AgLae+kNlJK3C6af/xxwlg9VQQZBzhyTAW
         yZ7fUC4ifbRSl6OvZMdQPx9nSffzbB0vSy6WvHnlD9OJ/qS6JmXi81oQuOXWNtngMvg7
         KKfgJSK16QpFEEfrsOxVOM0zShpqiU89tj0erXd+ad8KT8qf+hU1qN2Equ5O0iemJXW5
         JMzg==
X-Gm-Message-State: AOAM532TT0bzgUcUYS03+AgsbvMEDDfEb3L0lj+j7NpznFcyueMj3TFj
        GP89Nj04zH4lz5fir+7073go69DtrB7BLw==
X-Google-Smtp-Source: ABdhPJwcFP2cr6iE2HlEHHKjDbO9tPFpUXmGrUrcShtKtN2QS+08KoKFa8YHCh4Ol+5WiGr2ObPuDg==
X-Received: by 2002:a17:906:9bf8:: with SMTP id de56mr480863ejc.425.1613590986489;
        Wed, 17 Feb 2021 11:43:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm1479706eju.89.2021.02.17.11.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:43:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/14] fsck.c: move definition of msg_id into append_msg_id()
Date:   Wed, 17 Feb 2021 20:42:36 +0100
Message-Id: <20210217194246.25342-5-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87blcja2ha.fsf@evledraar.gmail.com>
References: <87blcja2ha.fsf@evledraar.gmail.com>
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
index acccad243ec..1070071ffec 100644
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
2.30.0.284.gd98b1dd5eaa7

