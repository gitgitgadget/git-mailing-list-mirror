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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4824AC2D0CD
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC1121582
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m10ixN2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfLRL0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:26:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36539 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfLRL0U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 06:26:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so1893667wru.3
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 03:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZU0Fq2ekjvI6QJ11VjQCePiqYvjvOa6DerBBZH6+aEc=;
        b=m10ixN2vBc60PDGF0bgaSjxbFuPz/YJ2P/J/vFX0F6yDN34gBLrUXi3KqJua9QIVSi
         LKg9y1WuyjdvDrvRJ+J4I4cyVCAY+7f74HlwdDRNTQoo6RKk9ain2VPVfmAsPVO50v0H
         C1bJCo5TWmLG9LsObOXrMD5b2+94aJIaapfvcTUkcVQRKEadUteCx8u/6OPkPdoSTNUB
         tinc1XUZQNMATtHWnqLFvISjyF+aZe4ELKZPM4yT0CXXBv9hLsCcHDLarKRd5aamMgBf
         +4XnPmS9H8wNF/V+9YJPg1s0XeaaOy0lOSrwUVqL7RNphjgoq/3llbCV7E2k5UtTh29O
         4ngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZU0Fq2ekjvI6QJ11VjQCePiqYvjvOa6DerBBZH6+aEc=;
        b=cNlKt69XdmdINBmwT70mZAjw19+yewxak0z5TG01RAqIP6ULXCGwtAOuc5Vjlj9PQB
         I+olrRB4KtVokyAf+eU0v6WMoL931aiAN5dzodid3jkOfxXl9cK9RY4JldF5IQm6Aos8
         pBGkdva2bBf87FdrF9rTHdGnx4R8rEhv8aOKJ03t110CUeLK3LvIuokwB8YY5uPYnrlA
         xkfDj/AC++yJHpN9uOnD2+qwRqeMUJ/LVsGUE+n36D5vZcPV8Jsn7oqxdozIswU+cklv
         nzFNwfFJRrcjzLGR0NLar5zBR8PbG21WCIg6m24E8SuCrBYD4Cp0lsT5VtaB6oAcqwu2
         RQ8g==
X-Gm-Message-State: APjAAAXI7SmnFZRmA+JaUcLh2uDqhsoPuPWrCPo1dHzWT3v7I2ZvM1e+
        l/31vTh9rWudq3XrRS+72KdOhKUa
X-Google-Smtp-Source: APXvYqwqTtno13MiyDnuhYed+nwRcYOn/hcEqwuEHduPbhLsZvbvP92h2eFvYKXVt/Xif//1djqQLw==
X-Received: by 2002:a5d:4a8c:: with SMTP id o12mr2244413wrq.43.1576668378540;
        Wed, 18 Dec 2019 03:26:18 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:116b:f417:15eb:66f2:c98d:a463])
        by smtp.gmail.com with ESMTPSA id f127sm1204647wma.4.2019.12.18.03.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:26:17 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v4 11/12] pack-objects: add checks for duplicate objects
Date:   Wed, 18 Dec 2019 12:25:46 +0100
Message-Id: <20191218112547.4974-12-chriscool@tuxfamily.org>
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

Additional checks are added in have_duplicate_entry() and
obj_is_packed() to avoid duplicate objects in the reuse
bitmap. It was probably buggy to not have such a check
before.

Git as a client would never both asks for a tag by sha1 and
specify "include-tag", but libgit2 will, so a libgit2 client
cloning from a Git server would trigger the bug.

If a client both asks for a tag by sha1 and specifies
"include-tag", we may end up including the tag in the reuse
bitmap (due to the first thing), and then later adding it to
the packlist (due to the second). This results in duplicate
objects in the pack, which git chokes on. We should notice
that we are already including it when doing the include-tag
portion, and avoid adding it to the packlist.

The simplest place to fix this is right in add_ref_tag(),
where we could avoid peeling the tag at all if we know that
we are already including it. However, this pushes the check
instead into have_duplicate_entry(). This fixes not only
this case, but also means that we cannot have any similar
problems lurking in other code.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c80c1fac94..b1998202fb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1127,6 +1127,10 @@ static int have_duplicate_entry(const struct object_id *oid,
 {
 	struct object_entry *entry;
 
+	if (reuse_packfile_bitmap &&
+	    bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid))
+		return 1;
+
 	entry = packlist_find(&to_pack, oid);
 	if (!entry)
 		return 0;
@@ -2681,7 +2685,9 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 
 static int obj_is_packed(const struct object_id *oid)
 {
-	return !!packlist_find(&to_pack, oid);
+	return packlist_find(&to_pack, oid) ||
+		(reuse_packfile_bitmap &&
+		 bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid));
 }
 
 static void add_tag_chain(const struct object_id *oid)
-- 
2.24.1.498.g561400140f

