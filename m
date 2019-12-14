Return-Path: <SRS0=+pXB=2E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E16BC43603
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 08:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F5B24656
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 08:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tI0gB4kE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfLNIMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Dec 2019 03:12:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33554 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfLNIMf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Dec 2019 03:12:35 -0500
Received: by mail-wm1-f65.google.com with SMTP id d139so1015993wmd.0
        for <git@vger.kernel.org>; Sat, 14 Dec 2019 00:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uRDTz2zqBKgao+sQy/E1o6wA2MSBK/jlHECc9MkngWA=;
        b=tI0gB4kEwuDZmzCMw0QHoFEjIPrxI1SYdFNN3JQoqKYNBV5yZT4Q7KoTKol9Asjh45
         /XioxM+NM8aP+JKi21kfO4tDYi2cJnKuR5JxBczyy0cX97aWbxlHSOAX0E9gX0nq8CYF
         6VtudO+m8KCm4ZMLH4rjfue6jUPfrozLl8DffbR0WJdwgi81xqSg3Bd4PO2JVRp8mom1
         KUfI8QvLPRUtWAEZ2pyo7oBBIWWJ0zx9q6sWbjXH8i8JiOCJd1VOIcCcRZPtUg3Z7sQ+
         bVEv4hxTU5R3fFioHKWBVEWIrUCoZEVFaVcScHEOpYECTTqCoHa84JwMFHjhEEcyoWOv
         ik1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uRDTz2zqBKgao+sQy/E1o6wA2MSBK/jlHECc9MkngWA=;
        b=M51/0ZIQajx9v/8lVriE4CYXsK9Z9kkA5SM3aUKdZVi2/e0gR5a8aPONJ16ZjaLp8F
         3U8IAPg2LLpAVQF6oBwQcLuKVWVL5W+ylY2h+boUyfsFYvfA+Ifpb8N0HRoJE2/wWfbu
         slVpGNusC4fSemnAGtJ0CSVlCgDrS2WAJQ+mFCyurwv82jxgEdwi3n6jKVCHH6NuQEJk
         Y5hZVvoGH/GaAlZ4KVcQ7sfobioZ0TMkXdAltlGrqKeF6Z25ilQlP4HKvAMUmJibHE2w
         ayBo2bWF+PoYwTTj0R70M0VQuOz174CZIBGU7kdmBFhLIYUleZtFMCNL1oOR0gQ+ZeHy
         Xamg==
X-Gm-Message-State: APjAAAXJxYG8YYzvSIPwlt2wznB2zUEmX1cSa158n2kkZAfAVcHg4evK
        bNKsVqyx2nbJkCdYXgCwgBlKcJTc61c=
X-Google-Smtp-Source: APXvYqy/JggyYepFmbTXtVEmEFOsjXLhCuSw2mhUUQQFhxwbsbsZjxXIw84SYqTr5wut/OUX3/zeIQ==
X-Received: by 2002:a1c:145:: with SMTP id 66mr8795608wmb.11.1576311152648;
        Sat, 14 Dec 2019 00:12:32 -0800 (PST)
Received: from localhost.localdomain ([139.47.114.52])
        by smtp.gmail.com with ESMTPSA id w8sm13642767wmm.0.2019.12.14.00.12.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Dec 2019 00:12:32 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [Outreachy] [PATCH v2] bisect--helper: convert `*_warning` char pointers to char arrays.
Date:   Sat, 14 Dec 2019 09:11:24 +0100
Message-Id: <20191214081124.28851-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tanushree Tumane <tanushreetumane@gmail.com>

Instead of using a pointer that points at a constant string,
just give name directly to the constant string; this way, we
do not have to allocate a pointer variable in addition to
the string we want to use.

Let's convert `need_bad_and_good_revision_warning` and
`need_bisect_start_warning` char pointers to char arrays.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
This patch is a new version of:
https://public-inbox.org/git/cadc46442d5c960caa58227092289fa2f44fb96f.1551003074.git.gitgitgadget@gmail.com/
sent previously by Tanushree Tumane.

 builtin/bisect--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3055b2bb50..1718df7f09 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -282,11 +282,11 @@ static int mark_good(const char *refname, const struct object_id *oid,
 	return 1;
 }
 
-static const char *need_bad_and_good_revision_warning =
+static const char need_bad_and_good_revision_warning[] =
 	N_("You need to give me at least one %s and %s revision.\n"
 	   "You can use \"git bisect %s\" and \"git bisect %s\" for that.");
 
-static const char *need_bisect_start_warning =
+static const char need_bisect_start_warning[] =
 	N_("You need to start by \"git bisect start\".\n"
 	   "You then need to give me at least one %s and %s revision.\n"
 	   "You can use \"git bisect %s\" and \"git bisect %s\" for that.");
-- 
2.21.0 (Apple Git-122.2)

