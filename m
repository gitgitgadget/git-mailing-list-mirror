Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB68C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 12:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiGUMBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 08:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbiGUMBP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 08:01:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CAC222A7
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 05:01:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h8so1954378wrw.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 05:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hC+B8onyWGpuMVHLjUAxC8r7NYU5leDLQCSLWOfMVGw=;
        b=F+Z9iY+zhxOCrIRdGbGPcitRnYpPWDsJxI2fH+EerFKwKgJV1XNl3bdNSZOlpew7x7
         DqTPCLD0fJfdQQOMrUXItR+oVj6BQ5ZMCEbBk8YUsXYHBr+kHpEKWWU85khcSaRIynsB
         fmzOGSRvIlJTPEpCVy+YGdjyuDN21lC21SPr4POkfiS70ExUBZlGTt847bJLNfUMDehf
         HdzLsMBx/iySB+sX5Whz4HU19nvcQQw7Fs2Wk0It42zZtsdmSfSU1sfO8IjxQSrrm3qQ
         PneIyfWGPcKe3CBiTdj8zknHq+MmZMAmvDanwQQD2LzvU73DdPAT1EXWP7eViOmF7GGk
         iZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hC+B8onyWGpuMVHLjUAxC8r7NYU5leDLQCSLWOfMVGw=;
        b=WfKyLGg/Gjw56hYyqLdG8pFk9W881+uOnIbD5QRr0AEi1c2oReOx6Q0V2hHkhlkFhV
         K2hIF97l8B/j0rtKVMc9xvttU8ANsx44hCowc+QlXN7wAcGfJ3qEkt9DC9o1jNG5w5AD
         XjRuunZhsctWLUJookPDHkIwLquALpONDjU1UcjeSJyi3nKFsRZfpkh3cYnoYz+0bxlh
         p8gPAVh0gpQlogCoCcvdLMC3WNQDv+MmcYwffFCbI7mAdrvJm6Qt984+Kv7ZOVBjPNKF
         z99ZvQUHvHrnuf8fMcwcwZbKRorvfweP2mhrmmwPGs4rxdGIzCHaiyhHY4bK13l2MtOh
         fbng==
X-Gm-Message-State: AJIora8SVaCB68+RCYDw1NjIzEFZVcl2Ca6iY3cXgzyZOyizTJI5DQan
        ZSeN6gCeciMU52HFZu0ff/TwOmBb7hQ49Q==
X-Google-Smtp-Source: AGRyM1tlvmP0ClMIO5jY28D9dV//k3qh5j9iSF7vOpfAUHWCzeFL+PZKV00MwGOLX1W/bgjEh9wEXg==
X-Received: by 2002:adf:fbc3:0:b0:21e:3c88:2aa1 with SMTP id d3-20020adffbc3000000b0021e3c882aa1mr10216882wrs.84.1658404872460;
        Thu, 21 Jul 2022 05:01:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c420300b003a3200bc788sm5226069wmh.33.2022.07.21.05.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 05:01:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/6] reflog-walk.c: use string_list_init_dup()
Date:   Thu, 21 Jul 2022 14:00:50 +0200
Message-Id: <patch-v2-3.6-62aab32ae77-20220721T111808Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-v2-0.6-00000000000-20220721T111808Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220721T063543Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20220721T111808Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change init_reflog_walk() to use the helper function added in
183113a5ca9 (string_list: Add STRING_LIST_INIT macro and make use of
it., 2010-07-04) rather than assuming that the "struct string_list"
part of "struct reflog_walk_info" can be memset() to 0, followed by
flipping ".strdup_strings = 1".

As explained in a preceding commit that can be assumed now if we peek
behind the guts of the "struct string_list", but there's no reason to
break the encapsulation here.

This does not match the newly added "struct string_list" rule for
changing CALLOC_ARRAY() followed by ".strdup_strings = 1" to
"ALLOC_ARRAY()" and "string_list_init_dup()" because here the
"CALLOC_ARRAY()" is allocating more than just the "struct
string_list".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 reflog-walk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 7aa6595a51f..2b17408f9a4 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -120,7 +120,7 @@ struct reflog_walk_info {
 void init_reflog_walk(struct reflog_walk_info **info)
 {
 	CALLOC_ARRAY(*info, 1);
-	(*info)->complete_reflogs.strdup_strings = 1;
+	string_list_init_dup(&((*info)->complete_reflogs));
 }
 
 void reflog_walk_info_release(struct reflog_walk_info *info)
-- 
2.37.1.1095.g64a1e8362fd

