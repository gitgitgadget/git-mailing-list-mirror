Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8595CC48BE8
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 738CB61464
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbhFNKks (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:40:48 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:51775 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbhFNKhV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:37:21 -0400
Received: by mail-wm1-f41.google.com with SMTP id l9so11842291wms.1
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ilzOW3GnKIopL42EeHdRGSokwhnkmREW+LSjof5wwa0=;
        b=lT7dk782ijuxrqOXBWjjkQ/dMKPOXEg7w547zLgt1POqufbiqJUbPezrOdGnJ0vpIm
         s/XEhNtRAwEH14DyGrar6GaQq/e9XCYuXlwuCAbCBw00ApREmsua8GG26ASlYOru11v3
         lpT9QdvzqTTjU9d+7o5CqZ8ry994R3noobrmtD2hzbVVlwQ+nRESD98Z8yeQWaDVZTiJ
         oZ5UWSbBabvaUSuix2kVYIUX2kZ8WZpoGt5IWFYkmVHGrC3NZsvNjznbNoEaPhMEvv8w
         N159G+cciiHJgWMwNthMCsh/HWBWjkY1adbNiTp3FjokzYy7wbUNbTk25GUHwvTaICnV
         27IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ilzOW3GnKIopL42EeHdRGSokwhnkmREW+LSjof5wwa0=;
        b=MGtq3kPOhnJkGNVV8vX1QTmnpKUIWXn0IDJZVDXeyF+qmv+PGoQSYLw+SWrWCP+2rh
         JoHjtiA5Kd19yyEvP77LwnX7CQFmCpEbCTXRU0QxnwPXZMwQz5y3XXhZaLwk3Udnm7rM
         eueSl+B52K9ALYwx/UKFNQq/iezJRGVfWFyh5wlS0pz1aYAwx0JrpOEp0AYpL68CLE3E
         vH8xr0vbY7eaWj9+JRLwCSUDznQPKwQgHkddpbpH7lIM5yVfCdPJA/09nVixVTAqzkgK
         5HrPfQmpOa43BOH9HheT30KQrl66h3n1CsPzpdlSkyRpb2+gExAc2qZJP64m1MU5q8UI
         aziA==
X-Gm-Message-State: AOAM530q/JxXXUp/JmDxA1IR9yjUORybfjDMFQOXkwtr703Fh4a0IUWH
        bDOiExPwIPvkLxRdaxh2rURRcKPoIVuF7g==
X-Google-Smtp-Source: ABdhPJxRdqQ6walbdS3wY/Ws+2UMmMQi11Mfrh6/8AAzN9i7FnFMcEyDxX4ki6WGVukyMOdcF3MnYQ==
X-Received: by 2002:a05:600c:204:: with SMTP id 4mr32046580wmi.95.1623666844216;
        Mon, 14 Jun 2021 03:34:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:34:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 23/30] reference-transaction: use hook.h to run hooks
Date:   Mon, 14 Jun 2021 12:33:12 +0200
Message-Id: <patch-23.30-6049b1cdc74-20210614T101920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com> <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/refs.c b/refs.c
index 59be29cf081..1149e7e7dcb 100644
--- a/refs.c
+++ b/refs.c
@@ -2062,47 +2062,35 @@ int ref_update_reject_duplicates(struct string_list *refnames,
 static int run_transaction_hook(struct ref_transaction *transaction,
 				const char *state)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
-	const char *hook;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct string_list to_stdin = STRING_LIST_INIT_DUP;
 	int ret = 0, i;
+	char o[GIT_MAX_HEXSZ + 1], n[GIT_MAX_HEXSZ + 1];
 
-	hook = find_hook("reference-transaction");
-	if (!hook)
+	if (!hook_exists("reference-transaction"))
 		return ret;
 
-	strvec_pushl(&proc.args, hook, state, NULL);
-	proc.in = -1;
-	proc.stdout_to_stderr = 1;
-	proc.trace2_hook_name = "reference-transaction";
-
-	ret = start_command(&proc);
-	if (ret)
-		return ret;
-
-	sigchain_push(SIGPIPE, SIG_IGN);
+	strvec_push(&opt.args, state);
 
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
+		oid_to_hex_r(o, &update->old_oid);
+		oid_to_hex_r(n, &update->new_oid);
 
 		strbuf_reset(&buf);
-		strbuf_addf(&buf, "%s %s %s\n",
-			    oid_to_hex(&update->old_oid),
-			    oid_to_hex(&update->new_oid),
-			    update->refname);
-
-		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
-			if (errno != EPIPE)
-				ret = -1;
-			break;
-		}
+		strbuf_addf(&buf, "%s %s %s", o, n, update->refname);
+		string_list_append(&to_stdin, buf.buf);
 	}
 
-	close(proc.in);
-	sigchain_pop(SIGPIPE);
+	opt.feed_pipe = pipe_from_string_list;
+	opt.feed_pipe_ctx = &to_stdin;
+
+	ret = run_hooks("reference-transaction", &opt);
+	run_hooks_opt_clear(&opt);
 	strbuf_release(&buf);
+	string_list_clear(&to_stdin, 0);
 
-	ret |= finish_command(&proc);
 	return ret;
 }
 
-- 
2.32.0.rc3.434.gd8aed1f08a7

