Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2C6C2BB55
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 12:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80152206F7
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 12:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgiHnwXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgDGMIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:08:22 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36460 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgDGMIW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 08:08:22 -0400
Received: by mail-pj1-f67.google.com with SMTP id nu11so692187pjb.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 05:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k0TTErNib/oVDKYqMrFH1TE4YX/C72t6kSBmdz23lsc=;
        b=EgiHnwXnYOwaS3J9zlSmvvvoWcRDCpFIUrUIZ7FWpwHXtyBgc+JNn3ZrmwOzr5Ohpu
         frwafgrbe1p9Kbql4ogH6Fug9sCdRxnGTKTkbt8Pkz6QBo3GMAYuYm2t7COCJKp7GXeX
         UYZHI5dbhbeAxsByAXuriILQZBYeRNY8Hwf3bs2QsgKO1HJlruFqCw9cijSuULwBWfQ3
         UzN2Vh9wHp9w6leytV3RUrsKxfS1zRiuz3COfWl4RMOF7R6VI3ZAXGM24vu37r86tyVJ
         GwRzlka9k8pPeVtRqnJ8Ii5hvRaJ17AH1CFS42hZeN7B1Qm/KbsW0oAJLLlACKANNd64
         rgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0TTErNib/oVDKYqMrFH1TE4YX/C72t6kSBmdz23lsc=;
        b=q32ypRlhW4+5nyHS/YwdWUdrE0qd7R06qI2LeWpwUaoHuDmpA/xd9KzRsHFQiUyF2P
         Tuv2wamhYZ2aDdsU7gNkCq1anYqj5FKgEaEpUX3iAKBzYjTZbln4e5a7Z7G7kKA7d6iq
         X/tuD2+0Ie++zrm8wSPQq9kJu4yVgE85Gu+37eTnkVulCsQcPgIQHVoCsksoK2qqLKof
         EnpI6I5ZKYQU3wUc1w2g+YZ1rkKX5qB/+aAsdacSX6/s4pg0M3Ib/CKsoK4Jn1wAvYCa
         6dmjFZabHKIEwIBrj6w1H0g/NnLbRnp2D7Gpg6u9E3llv5VjJDqceLQ3T63f4LHBgKJN
         P6yQ==
X-Gm-Message-State: AGi0PuaH03voi7E0+PKYMSIbYfJ+xs46K1bsw1H5YaidTbTZBBB7GBW6
        QzJFfruunLe4t0DBMyaA71is9J68ENI=
X-Google-Smtp-Source: APiQypKVVvKrgFGVVTvqa2fQ+vmwwzR9rnZcTDCamKQp1aCl4Ywjvvba/1g9Ru0X8A+r4PS9NcQzOg==
X-Received: by 2002:a17:90a:358e:: with SMTP id r14mr2439503pjb.182.1586261301315;
        Tue, 07 Apr 2020 05:08:21 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id e26sm14061833pfj.61.2020.04.07.05.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 05:08:20 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v9 3/6] refs.c: refactor to reuse ref_is_hidden()
Date:   Tue,  7 Apr 2020 08:08:10 -0400
Message-Id: <20200407120813.25025-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200404134345.10655-1-worldhello.net@gmail.com>
References: <20200404134345.10655-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add new function `ref_is_matched()` to reuse `ref_is_hidden()`. Will use
this function for `receive-pack` to check commands with specific
prefixes.

Test case t5512 covered this change.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs.c | 11 ++++++++---
 refs.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 1ab0bb54d3..229159ea1a 100644
--- a/refs.c
+++ b/refs.c
@@ -1389,13 +1389,18 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 }
 
 int ref_is_hidden(const char *refname, const char *refname_full)
+{
+	return ref_is_matched(hide_refs, refname, refname_full);
+}
+
+int ref_is_matched(struct string_list *match_refs, const char *refname, const char *refname_full)
 {
 	int i;
 
-	if (!hide_refs)
+	if (!match_refs)
 		return 0;
-	for (i = hide_refs->nr - 1; i >= 0; i--) {
-		const char *match = hide_refs->items[i].string;
+	for (i = match_refs->nr - 1; i >= 0; i--) {
+		const char *match = match_refs->items[i].string;
 		const char *subject;
 		int neg = 0;
 		const char *p;
diff --git a/refs.h b/refs.h
index 545029c6d8..a2ea043f7f 100644
--- a/refs.h
+++ b/refs.h
@@ -739,6 +739,7 @@ int parse_hide_refs_config(const char *var, const char *value, const char *);
  * parameter always points to the full ref name.
  */
 int ref_is_hidden(const char *, const char *);
+int ref_is_matched(struct string_list *, const char *, const char *);
 
 enum ref_type {
 	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
-- 
2.24.1.15.g448c31058d.agit.4.5

