Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7EF020C11
	for <e@80x24.org>; Sun,  3 Dec 2017 17:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbdLCREd (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 12:04:33 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33156 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbdLCREb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 12:04:31 -0500
Received: by mail-wr0-f194.google.com with SMTP id v22so14800602wrb.0
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 09:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bLXd/V4wf9q5ExsARVNzvw+FJaPd0U2Zr5Lkqw7I4Qk=;
        b=cOVZdEW4TLKO0yjg/py3vhEg5b/vTtjhjAfV2Z/J0zpRPiUexz1QfXfL4QercPYHbg
         WRBbPpsegXoZHt7Gc2joAovW7XqTiTAntFe+7HxfJQJDKADmWye6bCnvL6hsBThlYZPI
         31glrYfddcVn/QfPrViqhbZD5ZIcrChwnZcSvQrPW82TtjnInwkMexwKAgYuRFNqGain
         5tYql7IfFj9d4eIYlht9v9KLdfQ67cRO0UkHHqBjIWJhYkjQuKh9bB3Ss7IxFRMKNufr
         emaIFgFT6lQc6c8vabSydEIRCwEQHp/PCGJCBbMaYo4bp+zNosYcos4+TONaX6wC9pey
         eUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bLXd/V4wf9q5ExsARVNzvw+FJaPd0U2Zr5Lkqw7I4Qk=;
        b=M4j/WyanfjfSepnIn6GGlfpA4gmSNzIbhOIypMmjBGVOEZWRBqqaqB8XblUAkHQrVs
         JoOn/0Eu9zpK8OJdvK1qS0/1i5Tul+Nc3kcOXkTMBsKG5apz5D94ld62utkL8GAaglqN
         QHI85JBuMurXt7uwKcjr3y1n/D3hd/MdPbYNngSjp1CmxXb7kQQESi3OdGAySmyPXvsq
         83oK6j2M/Rrv43NrlcALX4BKJDo6SAbqqODJmBhdexZwqtRgUJ4hTdkvPHlHrOiLYXtD
         M1cjvOMxEP50Ai/1Oo1/heRL1ZcOIEpzD7m3aZI6DlMdfkxlaD5g7zBybcniY8PlsYbc
         RVDw==
X-Gm-Message-State: AJaThX7q4QdzR4m58sh3RW2g5yoLqqIZXvubkcbYE63WnxPT22x+smvU
        rx/QJfqkPDf7IvtbJtvi0No0WMcO
X-Google-Smtp-Source: AGs4zMbI7SrRv/fWqGOOBwb1IsrhdEYkr8Y7z4WBhjl738ehkbYJlTKinb8YVTtXyyH3xDCZfu09oQ==
X-Received: by 10.223.131.129 with SMTP id 1mr10776894wre.205.1512320669604;
        Sun, 03 Dec 2017 09:04:29 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id v192sm2340134wme.1.2017.12.03.09.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 09:04:29 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] index-pack: use skip_to_opt_val()
Date:   Sun,  3 Dec 2017 18:04:14 +0100
Message-Id: <20171203170415.15939-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.271.g1a4e40aa5d.dirty
In-Reply-To: <20171203170415.15939-1-chriscool@tuxfamily.org>
References: <20171203170415.15939-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Let's simplify index-pack option parsing using skip_to_opt_val().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/index-pack.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8ec459f522..5cf252c885 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1660,10 +1660,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				from_stdin = 1;
 			} else if (!strcmp(arg, "--fix-thin")) {
 				fix_thin_pack = 1;
-			} else if (!strcmp(arg, "--strict")) {
-				strict = 1;
-				do_fsck_object = 1;
-			} else if (skip_prefix(arg, "--strict=", &arg)) {
+			} else if (skip_to_opt_val(arg, "--strict", &arg)) {
 				strict = 1;
 				do_fsck_object = 1;
 				fsck_set_msg_types(&fsck_options, arg);
@@ -1679,10 +1676,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				verify = 1;
 				show_stat = 1;
 				stat_only = 1;
-			} else if (!strcmp(arg, "--keep")) {
-				keep_msg = "";
-			} else if (starts_with(arg, "--keep=")) {
-				keep_msg = arg + 7;
+			} else if (skip_to_opt_val(arg, "--keep", &keep_msg)) {
+				; /* nothing to do */
 			} else if (starts_with(arg, "--threads=")) {
 				char *end;
 				nr_threads = strtoul(arg+10, &end, 0);
-- 
2.15.1.271.g1a4e40aa5d.dirty

