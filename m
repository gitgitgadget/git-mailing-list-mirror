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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA90C2D0CD
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E12821582
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNofeJ3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfLRL0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:26:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46341 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfLRL0L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 06:26:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so1835224wrl.13
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 03:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AAeYwn5IvUi1KRAkbfxvOQoJ/vX9+46kRwTaoV5Nr/U=;
        b=tNofeJ3V7YLQm3LrGbxVCE7XuNQ9KNi9kC4JiP7iC9F7PZUw9xil4ozKYa8s+F2Yxl
         Ew4iwVwXs4K14g0jGrFZjw+KGs4VmOTDdCA+E6zXLRQIkk4I45PKRPj2mx2kwdWEoHR+
         +HvCfFfehefLGdw0o0RfxVy67mhvFQXrIFlCUW6AwgmwDgcyx3qZ+t1tw2TlMUX482uj
         rgw5tJT5cA7lPTlV9uHqrApPYKkqIYWx8BsNcqu31li8ZvhGHzvU6nysWFqXdEWORDQZ
         XIL4ucda4s67xJyGsqotZ9OEML00QAhoTHeLivwKHOOOwka1JRGHiYWQ+w/tnSOswLqt
         njuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAeYwn5IvUi1KRAkbfxvOQoJ/vX9+46kRwTaoV5Nr/U=;
        b=nPpHRTEpJ7B15C2SMbog19Z/a5yVnNsxnhjjg01+bd22GjSnPB4YYLIwJK2ufL971q
         pUSiRPwhF0y+AONK3xmd5ejT1z0YYpZF9J47T2Y/lN0lF93rSQqxQG+qLL9+MECSVbyj
         f+j7vCwtByuWn9Uu+6O6AfDlWAyJsaijNChqi5MrjTzlN0ijVK5ZvtO+LnRfv+TMivfl
         DTJRF1pwcf118sKo49H5P06aZ+awNQ149qZEx1ciz6dVcI/MPy5QrTjjay4+5ypZgz78
         lbFy1cVkuNs0gIr3XHB4CxicDf3LNZbunpWw0XQMqTsf8PsOpmfhEfzLAmFIP+DQbcp4
         m3+A==
X-Gm-Message-State: APjAAAU6pzbTJ2NE9z/Y+qbcrWpi6ehyvakWFclwvI6nmZlhMtXLKP+A
        EVwCOK6Gj1WPK2gvHc/qXk8qbOpI
X-Google-Smtp-Source: APXvYqxsGEnm6M2V2yj20rrbGf9jnveRvxWKI2XD7Q9x3yD2WiOoEzLR77rnDfyxw8vWgciRD1XXAw==
X-Received: by 2002:adf:f850:: with SMTP id d16mr2283996wrq.161.1576668368573;
        Wed, 18 Dec 2019 03:26:08 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:116b:f417:15eb:66f2:c98d:a463])
        by smtp.gmail.com with ESMTPSA id f127sm1204647wma.4.2019.12.18.03.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:26:08 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v4 02/12] packfile: expose get_delta_base()
Date:   Wed, 18 Dec 2019 12:25:37 +0100
Message-Id: <20191218112547.4974-3-chriscool@tuxfamily.org>
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

In a following commit get_delta_base() will be used outside
packfile.c, so let's make it non static and declare it in
packfile.h.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 packfile.c | 10 +++++-----
 packfile.h |  3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index 355066de17..81e66847bf 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1173,11 +1173,11 @@ const struct packed_git *has_packed_and_bad(struct repository *r,
 	return NULL;
 }
 
-static off_t get_delta_base(struct packed_git *p,
-				    struct pack_window **w_curs,
-				    off_t *curpos,
-				    enum object_type type,
-				    off_t delta_obj_offset)
+off_t get_delta_base(struct packed_git *p,
+		     struct pack_window **w_curs,
+		     off_t *curpos,
+		     enum object_type type,
+		     off_t delta_obj_offset)
 {
 	unsigned char *base_info = use_pack(p, w_curs, *curpos, NULL);
 	off_t base_offset;
diff --git a/packfile.h b/packfile.h
index fc7904ec81..ec536a4ae5 100644
--- a/packfile.h
+++ b/packfile.h
@@ -151,6 +151,9 @@ void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object
 unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
+off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
+		     off_t *curpos, enum object_type type,
+		     off_t delta_obj_offset);
 
 void release_pack_memory(size_t);
 
-- 
2.24.1.498.g561400140f

