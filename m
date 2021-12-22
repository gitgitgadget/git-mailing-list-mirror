Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E236BC433FE
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbhLVEHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238941AbhLVEHK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:07:10 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77342C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:09 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v11so2048316wrw.10
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pYZvUYaIWBl1OZuu88+S4N83yF9rzsKl5y7+si06Wi4=;
        b=mICOZrlMoxIiBK8PT5b4Ca6QYP7hpZSLlEwQA99YT/yPeSCbg8LwLhy6MWr8MvpWYc
         3uZdZn6Eo3/snsVJZYlgpWdA+MoLQCa//O+pTR+PgHnkvi/Nctn7vWPDSiDD8RlSOCQV
         aqHcRx09TFB2Bwhm8monT2YBT+yvCjFDt3Rw13bR133MFcYjbm1UKTkDPPay3V3dRd3M
         HePlqkafAVBGo37QeZRVjkIiXfwP2ZddORc8PG+dNnridQiQwd40+OVC59U4AOA3Tmug
         ZXMIzzZ7GkbN2vH2lLYSzgNB9FhaHDkoZIHoxsmfCqsSn7Jvk2nGTRNMMA45o2mwynHk
         ptAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pYZvUYaIWBl1OZuu88+S4N83yF9rzsKl5y7+si06Wi4=;
        b=un2PCtuWDMY1q9UB80eLwo/LENoYRoLRN8L7lRjCS6hZsiikdghHtpGAjexGHe8MLq
         AdyuHkvCxdFL5BONVYrd+HHfQFWgzvKU5yVik1NRSf68npl/xCHrAfdMAQWSVZiisTpE
         rX49Qd/GYXsiXnqxBouwBNTu1FgwsXhtl/4eT0ogwGfJmxvCWcJCxlYbPknoF37Ejm2o
         bKPEvf58HQI4fLxN9mFMjRhV5rvlEC/5z3g//JLfk7DLlcD+Xm0YDIRYWj/NPS4GXrz3
         jEeGbCcl5ebX/SW/Yto9z1q8J7rJyl/qFdL+kq655LJip1keshpqmO8xXFaYxl8Gk6kp
         g6hA==
X-Gm-Message-State: AOAM5324TJH5GBqJ6mJr9IdHD33+Ttf+PNSgfSn16rH9oPTZlYa2Si/1
        AmVrr6sGmRRnPjoEYFhZN7Ej5DSL+jWSOw==
X-Google-Smtp-Source: ABdhPJxs0sml/Q3B/cJdgNKRgC0VSuQF4TTtyfN8vfgpORaqfXh6HkJxLNqvzT7CrMstWW3+SG64kg==
X-Received: by 2002:a05:6000:1543:: with SMTP id 3mr756226wry.140.1640146027873;
        Tue, 21 Dec 2021 20:07:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z5sm710484wru.87.2021.12.21.20.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:07:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/9] reflog expire: use "switch" over enum values
Date:   Wed, 22 Dec 2021 05:06:43 +0100
Message-Id: <patch-v3-4.9-74447de0413-20211222T040557Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code added in 03cb91b18cc (reflog --expire-unreachable: special
case entries in "HEAD" reflog, 2010-04-09) to use a "switch" statement
with an exhaustive list of "case" statements instead of doing numeric
comparisons against the enum labels.

Now we won't assume that "x != UE_ALWAYS" means "(x == UE_HEAD || x ||
UE_NORMAL)". That assumption is true now, but we'd introduce subtle
bugs here if that were to change, now the compiler will notice and
error out on such errors.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 57 ++++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 27851c6efb7..8d05660e644 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -303,10 +303,15 @@ static int should_expire_reflog_ent(struct object_id *ooid, struct object_id *no
 		return 1;
 
 	if (timestamp < cb->cmd.expire_unreachable) {
-		if (cb->unreachable_expire_kind == UE_ALWAYS)
-			return 1;
-		if (unreachable(cb, old_commit, ooid) || unreachable(cb, new_commit, noid))
+		switch (cb->unreachable_expire_kind) {
+		case UE_ALWAYS:
 			return 1;
+		case UE_NORMAL:
+		case UE_HEAD:
+			if (unreachable(cb, old_commit, ooid) || unreachable(cb, new_commit, noid))
+				return 1;
+			break;
+		}
 	}
 
 	if (cb->cmd.recno && --(cb->cmd.recno) == 0)
@@ -348,6 +353,7 @@ static void reflog_expiry_prepare(const char *refname,
 				  void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
+	struct commit_list *elem;
 
 	if (!cb->cmd.expire_unreachable || is_head(refname)) {
 		cb->unreachable_expire_kind = UE_HEAD;
@@ -363,34 +369,37 @@ static void reflog_expiry_prepare(const char *refname,
 	if (cb->cmd.expire_unreachable <= cb->cmd.expire_total)
 		cb->unreachable_expire_kind = UE_ALWAYS;
 
-	if (cb->unreachable_expire_kind != UE_ALWAYS) {
-		if (cb->unreachable_expire_kind == UE_HEAD) {
-			struct commit_list *elem;
-
-			for_each_ref(push_tip_to_list, &cb->tips);
-			for (elem = cb->tips; elem; elem = elem->next)
-				commit_list_insert(elem->item, &cb->mark_list);
-		} else {
-			commit_list_insert(cb->tip_commit, &cb->mark_list);
-		}
-		cb->mark_limit = cb->cmd.expire_total;
-		mark_reachable(cb);
+	switch (cb->unreachable_expire_kind) {
+	case UE_ALWAYS:
+		return;
+	case UE_HEAD:
+		for_each_ref(push_tip_to_list, &cb->tips);
+		for (elem = cb->tips; elem; elem = elem->next)
+			commit_list_insert(elem->item, &cb->mark_list);
+		break;
+	case UE_NORMAL:
+		commit_list_insert(cb->tip_commit, &cb->mark_list);
 	}
+	cb->mark_limit = cb->cmd.expire_total;
+	mark_reachable(cb);
 }
 
 static void reflog_expiry_cleanup(void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
+	struct commit_list *elem;
 
-	if (cb->unreachable_expire_kind != UE_ALWAYS) {
-		if (cb->unreachable_expire_kind == UE_HEAD) {
-			struct commit_list *elem;
-			for (elem = cb->tips; elem; elem = elem->next)
-				clear_commit_marks(elem->item, REACHABLE);
-			free_commit_list(cb->tips);
-		} else {
-			clear_commit_marks(cb->tip_commit, REACHABLE);
-		}
+	switch (cb->unreachable_expire_kind) {
+	case UE_ALWAYS:
+		return;
+	case UE_HEAD:
+		for (elem = cb->tips; elem; elem = elem->next)
+			clear_commit_marks(elem->item, REACHABLE);
+		free_commit_list(cb->tips);
+		break;
+	case UE_NORMAL:
+		clear_commit_marks(cb->tip_commit, REACHABLE);
+		break;
 	}
 }
 
-- 
2.34.1.1146.gb52885e7c44

