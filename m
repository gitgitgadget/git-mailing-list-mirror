Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A923BC433FE
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344234AbhK3Vln (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344191AbhK3Vlk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:41:40 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2621BC06174A
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:20 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so15785436wmd.1
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1FHFqGRrLhQUZc7KZwrka720Uzz4l3XACZCj2Ti0sHk=;
        b=DhVNlnK1APM7w86rYUDn8tINABvvQ8T6Gjbqrr5vYtkEyxmycYTxKTYG7m3UDewuho
         q42pMWzRkfNfAdVVt2SlViYIOP8uII1KQmEf+r1s2VhoYfKcyLTh5oT8w/LTiumLb7yT
         r5e8ST//aDCbZHk+CUHOK/sax3oOGNhLAr/wi6vVywMezh/XdkXjciGjBuK+/92jLZET
         018SLalGQqS9+e1jrNnYlNh7rPUUj9MQkEo0K7a/CtZ0HtsbNtk/7uTzIvavko+fkBT6
         tFjE+TtRIj8rPS/VGjOZ4waHy3z3CrqbEBMbJ7csD+dKDRX8FfwgnKHTl+zLo/8zv53I
         bAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1FHFqGRrLhQUZc7KZwrka720Uzz4l3XACZCj2Ti0sHk=;
        b=UlDHa5qAu3Czyqbi7n9YOGxWnFdyT6MUeSbzXdWJYERpfJiDf9SMWVupSXwt+i+TUX
         u/PhOfTZz3VIVgnD6uj60au+dRgOydkQ8KYJ9cEiKRdXq/OSp53TqtY9jikpGNRMUxhp
         LwVTPwhWBMzcj1qn1AzjIjhmM8wwjO3NCRqiBAGzxDj5MP3NRz6WNgETmqYeqOoax3nC
         2oh3K0X0jw4hhV7AOARhZE8ETSzjQv5Ox8sK7UShdbJsG5DQMbfNL/1VYw+z7AmLDqmI
         TouztnIzZ0+KaQ/8H5hNE0Uq/u4rguJ4EGDCMIjybBHq55fTOb/qAsHj7XeyOQKoxdAm
         F3/g==
X-Gm-Message-State: AOAM533uzpYI7ligQXaI4md8aXreyWyVTV261RRTZg5r18m0Guknu56n
        picqM/2beHmSiXtY9qNlJ3rhmGqoofY=
X-Google-Smtp-Source: ABdhPJwYiy3weeWhEuhs6iFkAi4T98AyvTBvZn8lrggbl6cSnqn0pO6ZpSZW/lKctUisN2DoC1Ojxw==
X-Received: by 2002:a05:600c:4f03:: with SMTP id l3mr1628588wmq.47.1638308298460;
        Tue, 30 Nov 2021 13:38:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v8sm17006914wrd.84.2021.11.30.13.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:38:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/12] reflog delete: narrow scope of "cmd" passed to count_reflog_ent()
Date:   Tue, 30 Nov 2021 22:38:03 +0100
Message-Id: <patch-01.12-99e8a639163-20211130T213319Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.877.g7d5b0a3b8a6
In-Reply-To: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "cb_data" we pass to the count_reflog_ent() to be the
&cb.cmd itself, instead of passing &cb and having the callback lookup
cb->cmd.

This makes it clear that the "cb" itself is the same memzero'd
structure on each iteration of the for-loop that uses &cb, except for
the "cmd" member.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 175c83e7cc2..4c15d71f3e9 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -662,20 +662,18 @@ static int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
 		const char *email, timestamp_t timestamp, int tz,
 		const char *message, void *cb_data)
 {
-	struct expire_reflog_policy_cb *cb = cb_data;
-	if (!cb->cmd.expire_total || timestamp < cb->cmd.expire_total)
-		cb->cmd.recno++;
+	struct cmd_reflog_expire_cb *cb = cb_data;
+	if (!cb->expire_total || timestamp < cb->expire_total)
+		cb->recno++;
 	return 0;
 }
 
 static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 {
-	struct expire_reflog_policy_cb cb;
+	struct cmd_reflog_expire_cb cmd = { 0 };
 	int i, status = 0;
 	unsigned int flags = 0;
 
-	memset(&cb, 0, sizeof(cb));
-
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
@@ -703,6 +701,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 		const char *spec = strstr(argv[i], "@{");
 		char *ep, *ref;
 		int recno;
+		struct expire_reflog_policy_cb cb = { 0 };
 
 		if (!spec) {
 			status |= error(_("not a reflog: %s"), argv[i]);
@@ -716,14 +715,15 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 
 		recno = strtoul(spec + 2, &ep, 10);
 		if (*ep == '}') {
-			cb.cmd.recno = -recno;
-			for_each_reflog_ent(ref, count_reflog_ent, &cb);
+			cmd.recno = -recno;
+			for_each_reflog_ent(ref, count_reflog_ent, &cmd);
 		} else {
-			cb.cmd.expire_total = approxidate(spec + 2);
-			for_each_reflog_ent(ref, count_reflog_ent, &cb);
-			cb.cmd.expire_total = 0;
+			cmd.expire_total = approxidate(spec + 2);
+			for_each_reflog_ent(ref, count_reflog_ent, &cmd);
+			cmd.expire_total = 0;
 		}
 
+		cb.cmd = cmd;
 		status |= reflog_expire(ref, flags,
 					reflog_expiry_prepare,
 					should_expire_reflog_ent,
-- 
2.34.1.877.g7d5b0a3b8a6

