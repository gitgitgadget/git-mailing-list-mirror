Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C34C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A0F20768
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nGbYiD3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgIHTs6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbgIHTss (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 15:48:48 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C34C0613ED
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 12:48:47 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id q5so202819pfl.16
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 12:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7JKY3sywb5PoF2eqzKuwTh+/TXzU8WfCj9zyzzvqg9g=;
        b=nGbYiD3JziNmZPVyJUdvX5cpx7iOmZLTS9Oqu7XtkY61vmrScnNttCRhM+pGWw+cdI
         1/Q46X4Morq7oSPl/sCc//MkRh//vaRtxQHKSnY/1NZtgEXMT/jzrcLp3BmiCPVYlmQ/
         YgDv9r2+7ISl88827treg5guwbrMM2P4yIo1u6erHXLxs0mYXklAPjghRYS0fKLopfsQ
         6ZxO8MahqjzVn4VSwQH4z1GjX+SXyQbL/t7baIMbHuSGHCz5uniysOyAPjXf5t/oaME8
         BfQ10qJVijooRivfiptxwXTEiUvd7tL8vAHvWVTn4dLXu7K3IA4T1tG+fL771vfRzxRa
         AKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7JKY3sywb5PoF2eqzKuwTh+/TXzU8WfCj9zyzzvqg9g=;
        b=sAF2EWsIHIZRl+4CXBsY0ADQJTlvd1fmgUoTBneFOHizsDSh6ykFCOpk7f5agNGU2N
         46axTbd63RAteYkvkksutedNPztjqeycUtvnbs4qZ7ls0EluRtJNbNmxNQoW+Z41PMdx
         ZN/Ouw7Dk+bhmTOrY7Pss+hI3Q43a/OAOTFHJ1Vurp8vwwEhSrWvqbRNK75oUuS9p6nd
         QYmi3JK6W38Ds00mVmgsY/G1w5PBuwo0/BC/4mQk41GB5HNFx2F7o0sMnoTqGMx5j1gA
         b5WMO6Y8FNC3FUVO06cOQUAdJlzk4jOjZh2kgbtYMUIKFLnajhiyczD0owGqUKKddudG
         rVoQ==
X-Gm-Message-State: AOAM531gBKRBa58EkrDhVuQSFdWazHt1hWiT5tTfilzD2GJoVqys3Cgm
        ejEoWB0ZozSjZn1DoiPHTjvbsdShqSJqDXpHqXID9uJeIRQh98qcy0B5Ba8X/i8UwT4Ssv7WdPd
        cSi2gMzpuMKQptmdz5nL/JPpgUlYqfzO0rnpcmdo3QUDcz/9l7bJAEVKJz+uFhaIneCsanbpcjL
        54
X-Google-Smtp-Source: ABdhPJx0tQbVLN37wvnTNrU4S5d5lHZKwLCj+2RFyfoySt22BrRfUIJwQMxO8xWGKiQjyWNkNi9PUmvvug7cWE2z7cEG
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a63:2fc7:: with SMTP id
 v190mr271529pgv.250.1599594527168; Tue, 08 Sep 2020 12:48:47 -0700 (PDT)
Date:   Tue,  8 Sep 2020 12:48:31 -0700
In-Reply-To: <cover.1599594441.git.jonathantanmy@google.com>
Message-Id: <dc9f0958d819f756a18f8eb7d4d1b8d618223e07.1599594441.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1598296530.git.jonathantanmy@google.com> <cover.1599594441.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 3/7] index-pack: unify threaded and unthreaded code
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/index-pack.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0e0889afc4..c7b4aef4e4 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1211,15 +1211,7 @@ static void resolve_deltas(void)
 		cleanup_thread();
 		return;
 	}
-
-	for (i = 0; i < nr_objects; i++) {
-		struct object_entry *obj = &objects[i];
-
-		if (is_delta_type(obj->type))
-			continue;
-		resolve_base(obj);
-		display_progress(progress, nr_resolved_deltas);
-	}
+	threaded_second_pass(&nothread_data);
 }
 
 /*
-- 
2.28.0.526.ge36021eeef-goog

