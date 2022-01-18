Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7C8C433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 15:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346140AbiARPzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 10:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346116AbiARPzh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 10:55:37 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7162CC06173E
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:55:37 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v123so28680446wme.2
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iYF24mQ3Zuf4xjpcAzIMtBSOaXVlviXkRAbi/lKmP6Q=;
        b=S5xkfD5v/C92QWj0X1jk977t5BQLmR+XI1CCEx6GUfPc5QIDAQQi7uchH8npTXz3vi
         2/iz0di3JIhfe6/r/8fGjRjEi/gjgYEZd0zA+EeRNjnMGniXc8DuJzxz9+KvUKbDc0Y0
         qGKSC1BbnJiw7FVij7wi6awUnV5zbZfFjLMqjuo6w/IF5gLQ5W5pdVWj40SAHY7TKRzv
         /tRfkroDbrTzwTDaaWLHYwRtz2i/3nzyaOWDB8LhdwIHHm98999TKErlCVTm3eytGGRl
         iGomUjDRRSUjpvh/WwZzSt5Zvwwuolc4v6MqFm6CKTcwfbkgf5Yqo++D5nTBMe339urE
         LVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iYF24mQ3Zuf4xjpcAzIMtBSOaXVlviXkRAbi/lKmP6Q=;
        b=y4usdBHJYx2EP1QEj0gKcovKaDCYXLmg2EpgL1xSDhDj9tCTusiyEShTYIO2tg5uMI
         eVFvhJlS9WnuK3rtLHU4mNtWRKiWoEU8KHMe2JP5JFeB4z8an9ukBGC3kL2tsbFp4/qK
         DN/rSdeAgi6lxZyRpTCUnyZ+t4akEf6HisXoqYQTtCYi4gznSlGkNa3Wc7N3BZYZpqk+
         sK5U7pv1B1tgsluHxX5OuVOV2/3ZT9qgPhVSygQjV5JJpNAdmRfiUaNmqL9eAxgnkHGq
         QEDMbdhUw8QtkAcPF3nrJTFdCgaJl6/UAFKhvvV3Bz3rpbf9ZXkGw5OWm8O32bCV/2OQ
         97Ig==
X-Gm-Message-State: AOAM532Aie5HeFJ9aINOyfbJonLmNlGv0LGy3D0f1d+oeYyZRevhV+sa
        Ag557bI659H7vSw/Zy3vH0JXXPEkQlSCEQ==
X-Google-Smtp-Source: ABdhPJxDl7WaTk8ywmazI8jNRlwYTB2FBkfxOcv+5xpt3ZBaQbRUNQfxYET7YdT4Yo9Tdv0N8MqN/w==
X-Received: by 2002:a5d:6848:: with SMTP id o8mr25222956wrw.2.1642521335886;
        Tue, 18 Jan 2022 07:55:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f15sm1220522wrd.45.2022.01.18.07.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 07:55:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 07/10] grep.h: make "grep_opt.pattern_type_option" use its enum
Date:   Tue, 18 Jan 2022 16:55:19 +0100
Message-Id: <patch-v8-07.10-daf873899c1-20220118T155211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc1.864.g57621b115b6
In-Reply-To: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
References: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com> <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "pattern_type_option" member of "struct grep_opt" to use
the enum type we use for it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.h b/grep.h
index 3112d1c2a38..89a2ce51130 100644
--- a/grep.h
+++ b/grep.h
@@ -164,7 +164,7 @@ struct grep_opt {
 	int funcname;
 	int funcbody;
 	int extended_regexp_option;
-	int pattern_type_option;
+	enum grep_pattern_type pattern_type_option;
 	int ignore_locale;
 	char colors[NR_GREP_COLORS][COLOR_MAXLEN];
 	unsigned pre_context;
-- 
2.35.0.rc1.864.g57621b115b6

