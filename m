Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AC0C433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE0420578
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="oU7a6l9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgHXTRU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgHXTRG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 15:17:06 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FCBC061755
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 12:17:06 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id e4so5869586pgv.7
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 12:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ufnWFZa22ChaMp9UKYB6rbhUs5hDnYxD2Y+b8FqCxZs=;
        b=oU7a6l9s6BQVKz75bx1QxUFt5l0/qdfC5Xc65poEeHFBujHZBMzW1gH9eAucgyIugs
         6uGaGAZLwFsZUpia7qN3HXYq9LvlIim39Sm1Bv9d9Wi6hmO6Io4pyG/bIN+I3JAhDqAj
         QjfIinBoLChg8mlPEBMJMQVVClTJH39y3U3ucvZqOUAY9pC+mmnUKss94nh7gYazAquR
         JivxCEonvdZfYMRGpf8AXNy3pUuAl2rqCbGBuH/LLrviQv1HxqRPbgveGNk0EHRBWJXD
         B4n9BphuRryfebCaCyOPCv8GNJ5Tcs+huVX/MTDQcLPUL2RT3HKOsifgx/uooN8WBRpn
         GCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ufnWFZa22ChaMp9UKYB6rbhUs5hDnYxD2Y+b8FqCxZs=;
        b=Ym4XDe0IDu8lclsiX8aipHz4UjKEgUPxKnBsLkkneYllLcgiixCc+2yaEcF8ZzJUvw
         ks3xArFn2Y1GzWHupJEobr0eznj9FKN8wbeAsNr5qNwjhHEZmqJzHv2Mmez9pBB1vQFu
         C8Qk91/arsuS0ZHqjtcFzZKtaCrTzg0UNPVCfiM7NyQX5SfEEtdQCVAMfaqo5GrxODcH
         fMacxI4KE7zBJddbjPqkHCQB/t7jIc8XMNEiRtMvWhPnaXtkqemRKrN3kvwlEnw3oOpt
         cjV9vj8p4CMpcEEGJvkHE3OlUj6oexYCQYSdndL0MpSK0TG2dy54pERs1XcnvzToB05K
         94zw==
X-Gm-Message-State: AOAM531UxBRUTJyDfMXpIs9ZueYklYmlizsqMocUSOSJKhHFPMH15/kq
        t08Eu4Q6yfZN/eWtEnP+ITCTlXqQ8B1WEhyxPBX4V0NX/OXt+iGKIxRjCaaYyVbJggbtotD0roF
        CYCfT9xJsj2KjGbNF2Ae7SVYCoEiEhZUjkVVeJ/B992P5GnITlFknPc+yX4d0ko9Fzsuo6zVIKv
        sc
X-Google-Smtp-Source: ABdhPJxu/3UAT3l4wkx1x6dxZIgPv6vQ6ftPq4VUpdHXZXE0IZfl3uYzbGduqEL6csD1iSs1rRJZrATnCeOPvbOS6XuR
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a63:7b16:: with SMTP id
 w22mr3774533pgc.17.1598296625632; Mon, 24 Aug 2020 12:17:05 -0700 (PDT)
Date:   Mon, 24 Aug 2020 12:16:37 -0700
In-Reply-To: <cover.1598296530.git.jonathantanmy@google.com>
Message-Id: <080e3b06d36e6abe660489765e7d424fc1bab62d.1598296530.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1598296530.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 6/7] index-pack: make resolve_delta() assume base data
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent commit will make the quantum of work smaller, necessitating
more locking. This commit allows resolve_delta() to be called outside
the lock.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index e98b11ab37..c6d2acc13a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -927,7 +927,7 @@ static struct base_data *make_base(struct object_entry *obj,
 static struct base_data *resolve_delta(struct object_entry *delta_obj,
 				       struct base_data *base)
 {
-	void *base_data, *delta_data, *result_data;
+	void *delta_data, *result_data;
 	struct base_data *result;
 	unsigned long result_size;
 
@@ -942,8 +942,8 @@ static struct base_data *resolve_delta(struct object_entry *delta_obj,
 		obj_stat[i].base_object_no = j;
 	}
 	delta_data = get_data_from_pack(delta_obj);
-	base_data = get_base_data(base);
-	result_data = patch_delta(base_data, base->size,
+	assert(base->data);
+	result_data = patch_delta(base->data, base->size,
 				  delta_data, delta_obj->size, &result_size);
 	free(delta_data);
 	if (!result_data)
@@ -1003,6 +1003,7 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 			    (uintmax_t)child->idx.offset,
 			    oid_to_hex(&base->obj->idx.oid));
 
+		get_base_data(base);
 		result = resolve_delta(child, base);
 		if (base->ref_first == base->ref_last && base->ofs_last == -1)
 			free_base_data(base);
@@ -1017,6 +1018,7 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 
 		assert(child->real_type == OBJ_OFS_DELTA);
 		child->real_type = base->obj->real_type;
+		get_base_data(base);
 		result = resolve_delta(child, base);
 		if (base->ofs_first == base->ofs_last)
 			free_base_data(base);
-- 
2.28.0.297.g1956fa8f8d-goog

