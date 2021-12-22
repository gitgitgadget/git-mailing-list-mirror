Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1274BC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbhLVEHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbhLVEHH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:07:07 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511B8C06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:07 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id a203-20020a1c7fd4000000b003457874263aso3029880wmd.2
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gys0B9hF3y44VKBdyD8Oj5C9v0DsC8E0n1XzVNM+ZhU=;
        b=YE3iBTFS8GoDHbFtcZiRiYWTF2fhquj9/tQ/ClfcSwAfvO7U2yoQRZhD5gUUJ8zovn
         6pnRhMBfWd0TXAu6ohCeQoE11aA8F2fLdJvUORib5BKMqpTC+Dd/w+BqNaVYCYlfllpx
         +gV1hXdcmifyxx72R22b8wet64kSqq5XBR+5virjv+lR4mIhgSKxo8PaZ5BaTdN6wGal
         xWOqW/b/BTBROPoXv1DmaD8knxrItHnrAePsZyoQrVI6QmI7Bwq+HYqaZh0e/SYYAg8a
         sMkyQ+vMvbM9dIa92o1YhHQkzUPof3Z8BIPnV87joZ36JaIkleNKJF1HN//Q4s1nD9br
         oQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gys0B9hF3y44VKBdyD8Oj5C9v0DsC8E0n1XzVNM+ZhU=;
        b=C4RDoiP4IigcAY9HFQjExbPHsVF/nK4KLvsdQBgotUClOWebX232NF1WP74cNrYoRb
         9Rs+PstOU/RY6MfYtkQhW056zOqXrraElmr850SOynOpqQcYe84mehBmLSStXNMXisxg
         vn9r1VxwFAdlYoDMdVdAmkLsbZJgI3npxPVDH9YWZDIWq7F4xWU2qs+/J1xjfzckLBO7
         cko4bCBAOc1OVw0psrcBgdxs5Xhhaw88BU0ULxbm9eOLCNglRYtUEIzlBEFRHsKAxhYa
         hXGF576Rwu7KABpTFuoQ2f22gogLozI3ORd9q85pboYPJpYNs6JQu9+Gw3z39hMLEz/7
         M5uw==
X-Gm-Message-State: AOAM532CxpcFrtzCj4/qxqD5L315FBfe2/A1+oeFMl6wvet37+FVTr7d
        WfB0DV7sRIJUDC4VZFk22IB9izrQ0lWe4Q==
X-Google-Smtp-Source: ABdhPJz09DRJbecfAsHyx1I13qcrdyQOPledpIPhIpbj6T+QIL+2WCLJdcOUFy5ntDNAwqFpszg1Iw==
X-Received: by 2002:a05:600c:3d10:: with SMTP id bh16mr783517wmb.111.1640146025694;
        Tue, 21 Dec 2021 20:07:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z5sm710484wru.87.2021.12.21.20.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:07:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/9] reflog delete: narrow scope of "cmd" passed to count_reflog_ent()
Date:   Wed, 22 Dec 2021 05:06:40 +0100
Message-Id: <patch-v3-1.9-7fac198f485-20211222T040557Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>
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
2.34.1.1146.gb52885e7c44

