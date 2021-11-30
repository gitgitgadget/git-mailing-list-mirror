Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B36C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbhK3Vly (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344191AbhK3Vln (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:41:43 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EF6C061746
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:23 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so20618067wmj.5
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XtJJ+mNRQ+CWcj74FI+teeMSeJhiyOGNqS08VhRLjnw=;
        b=oJT9CUH6iW2X04l3vWgE28PSRXipO6TjAK743Iz/mObTuBaAoFvb+xMUt6B/g5sxZJ
         JabN49LJ6MkP7MJDY5se8zKD1L9GXnK/OvRr6I0Nmr0GU2KPMJqfTWTJ+q9sIZto3ob7
         +zzG1AA6HQa1FGaYS+1oSJXavgyC2qmDapjQYyXkK5kHMLkvgkY6z2vUXrqt4QZfiQNl
         J+xLfiCCHKjPetBboAq6yQCe1XYFTsbjw1sYNcCbo2NtqvQPzT7FeMqxlgsdF9h5ULeN
         6ofcxZBTiVw7JBiybwgVQhaLnW9VWcv0bQlnEnyhMQIc7k0N11940R3ClOWC7Ino5Vbh
         M5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XtJJ+mNRQ+CWcj74FI+teeMSeJhiyOGNqS08VhRLjnw=;
        b=aiZJRrdD257Jyq+wHZFtml8cafe6A8jkf1tEqXTXmL5YDWJ8mYfQ+oiDqc1vFzkdVW
         NLz4pwxQGYNtFaECp0rX09Mbd/SKuLMLrNKzf4EEBKOILfj0dN4IJJkBKIcKyrayx2ws
         oy3uKV7IqlWdxcVPoSxaRiANWXyRZ+jwpBamqBcGajz5km8ngLGT9x61psufmcKY97ES
         15w7g629wOUp6Eonf67ty078DUwZJbKawnCALIFSJJft11fU0/Ib9o5wvXH7fTsu+4Gf
         DgP6LChH1yqeqCJKTiY1RkdjHodO0/0wJ8z8YsyaZr/Pq3cPDBz+PQ97MGkwz449dzuI
         s45w==
X-Gm-Message-State: AOAM53359fLQVD+upNy07AwZMRakQD/v/TjBPrH8PKJnqaHXhGgfZ9DL
        I4YzUjRM1Kot5YR5QYSPZ/YXBRmo144rVw==
X-Google-Smtp-Source: ABdhPJy7O/QL283YBJLZBOpbbhmjAxbzMyy3r262jrsgDnGf2+eowlhtlRc/Tg15tczk22+5Vnpgdg==
X-Received: by 2002:a05:600c:294c:: with SMTP id n12mr1578481wmd.71.1638308302363;
        Tue, 30 Nov 2021 13:38:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v8sm17006914wrd.84.2021.11.30.13.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:38:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/12] reflog expire: refactor & use "tip_commit" only for UE_NORMAL
Date:   Tue, 30 Nov 2021 22:38:07 +0100
Message-Id: <patch-05.12-de162a476c1-20211130T213319Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.877.g7d5b0a3b8a6
In-Reply-To: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an intermediate variable for "tip_commit" in
reflog_expiry_prepare(), and only add it to the struct if we're
handling the UE_NORMAL case.

The code behaves the same way as before, but this makes the control
flow clearer, and the shorter name allows us to fold a 4-line i/else
int a one-line terany instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index f8a24f1aa26..ec0c6051135 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -354,16 +354,14 @@ static void reflog_expiry_prepare(const char *refname,
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
 	struct commit_list *elem;
+	struct commit *commit = NULL;
 
 	if (!cb->cmd.expire_unreachable || is_head(refname)) {
 		cb->unreachable_expire_kind = UE_HEAD;
 	} else {
-		cb->tip_commit = lookup_commit_reference_gently(the_repository,
-								oid, 1);
-		if (!cb->tip_commit)
-			cb->unreachable_expire_kind = UE_ALWAYS;
-		else
-			cb->unreachable_expire_kind = UE_NORMAL;
+		commit = lookup_commit_reference_gently(the_repository,
+							oid, 1);
+		cb->unreachable_expire_kind = commit ? UE_NORMAL : UE_ALWAYS;
 	}
 
 	if (cb->cmd.expire_unreachable <= cb->cmd.expire_total)
@@ -378,7 +376,9 @@ static void reflog_expiry_prepare(const char *refname,
 			commit_list_insert(elem->item, &cb->mark_list);
 		break;
 	case UE_NORMAL:
-		commit_list_insert(cb->tip_commit, &cb->mark_list);
+		commit_list_insert(commit, &cb->mark_list);
+		/* For reflog_expiry_cleanup() below */
+		cb->tip_commit = commit;
 	}
 	cb->mark_limit = cb->cmd.expire_total;
 	mark_reachable(cb);
-- 
2.34.1.877.g7d5b0a3b8a6

