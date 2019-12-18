Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479F5C2D0CD
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C53321582
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcA9KLAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfLRL0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:26:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43158 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfLRL0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 06:26:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so1856249wre.10
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 03:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JQQgqz1yIUMmNdx3lVEw8Zcw26jdsVnZB5A9Dhbx604=;
        b=dcA9KLAx7KZq4q2B/ClJRO8sr3Wcclzgdocnrh+FdjmH6XbsJJgOXQCJyJNNpkNyy7
         VTe2k52ImroWdlJ7Lj2AWSqWBZ96hPVPdGKNpiOddPgNj6hftLWJLAhv6OTVVAm/Ms4I
         ZxWgQiaWw9XohcIYORn4D75Ogp8+sUreSCveLKXHYAxKfXT/RHvrmFW6KmEj1bZdNERH
         ZPTSBUQsw4pfdtaliMprauGCu7deUpaIWQDnqcqSJ8lXd0fUKZ2KF/tq2s12yZfert/N
         5P3CWn5rvxYlmoc2u+xXT5KkV8oMH6lqIE8UxHoH00qgUnGcc1Z7ykzAlm3ZGEh3W9Eh
         ZfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQQgqz1yIUMmNdx3lVEw8Zcw26jdsVnZB5A9Dhbx604=;
        b=rcqLM66wiiE28YaQbnHsfvRXTQjD8+uPd/n4gpgTsvhIZRFkrNe3ZBUDgQr8Duvnzq
         9rRQaf3wWexPvmUGdbDOoniuLAJmBzf656DbIKEiFgh8inGVmuu8E+NHty31KZoZQM2z
         7+zAwLntA737DgdFl4eKUssgGLAFIJ8dbNxA9q3D0/UsOTp95iz844ri9iPORg7L4VFU
         I6MMTNIqBpEp/QlrH+ZgOPA4B3TrpLODYyL3vHN97SQZskHjsipmO75+inf8YGmyGwtH
         nE14ukrtyLETl1hkPIr86Cf9rsCe3bymfQeCPx1nFDv6ZrX3xLZPAoN+Nbeu7tfCxh4e
         HwbA==
X-Gm-Message-State: APjAAAXxO0fiJ5jUznojdIfg0ZXUaxZWNDH7qpAvs3dXlil0u1UySBwS
        xSkBhdkAKAEdeVF8pk7Dqk71eGi5
X-Google-Smtp-Source: APXvYqxD8vnvV10neS85Amw6reQQkHnljXYWYOKKZEkfRpDYYhITtBZKpdTxxEDqJjR61gpCFtQUuw==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr2296529wrr.226.1576668373989;
        Wed, 18 Dec 2019 03:26:13 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:116b:f417:15eb:66f2:c98d:a463])
        by smtp.gmail.com with ESMTPSA id f127sm1204647wma.4.2019.12.18.03.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:26:13 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v4 07/12] csum-file: introduce hashfile_total()
Date:   Wed, 18 Dec 2019 12:25:42 +0100
Message-Id: <20191218112547.4974-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.1.498.g561400140f
In-Reply-To: <20191218112547.4974-1-chriscool@tuxfamily.org>
References: <20191218112547.4974-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We will need this helper function in a following commit
to give us total number of bytes fed to the hashfile so far.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 csum-file.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/csum-file.h b/csum-file.h
index a98b1eee53..f9cbd317fb 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -42,6 +42,15 @@ void hashflush(struct hashfile *f);
 void crc32_begin(struct hashfile *);
 uint32_t crc32_end(struct hashfile *);
 
+/*
+ * Returns the total number of bytes fed to the hashfile so far (including ones
+ * that have not been written out to the descriptor yet).
+ */
+static inline off_t hashfile_total(struct hashfile *f)
+{
+	return f->total + f->offset;
+}
+
 static inline void hashwrite_u8(struct hashfile *f, uint8_t data)
 {
 	hashwrite(f, &data, sizeof(data));
-- 
2.24.1.498.g561400140f

