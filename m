Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79ADC4167B
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiL1SBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbiL1SAt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:49 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAC4186B5
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:38 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d4so7536943wrw.6
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7cSFu4wamPHRmI3bGL0Hkg3f3NMwKBCd3DUSSku+Ys=;
        b=eG4pDaLYipaEzTJ7q9Pbtht69sOhB/FVlCP36IcheBvy/zdgTuqaQv+cA+foYDz10+
         m3JhBXdEA8fad6Y3NPhGWtmDTRoJXwb1oyuI82YDBw3omWQPttlAWnZC5oLeALGoTpbn
         5mW+WQHM67nP/06qQA6aNHB383kwpa0/XmtNAycN3wFdgzxHqkvwwrFC6T6RBt++d5SC
         M1Mv0Rtgyu2LzWXJyM1OytSSQPFmkoC30Qafymga6HGREX4fk2F2UjVJ21jCfhVj02eG
         Ab7Pp4OGc+5o0BQpjS24MmhKa+Rwym06FZewVkuDw5Valn0MpSwIRv23R7zh6fJLG9ir
         LSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7cSFu4wamPHRmI3bGL0Hkg3f3NMwKBCd3DUSSku+Ys=;
        b=uWbtZtLXoasy36ivlEHfTs60WJ0EIu51zXVy92f8T1R5Pt1BpoEP3iCWvVcXObNHf/
         W5eFJSB6yAa3sVLZ8FjcwDXoaXu3M5yUsCBU4teZG9pjd35iOOsUMHo5WaLLhRZP3qQ9
         H3sTNracS1B9GT18r9vBy0d2iox5bTcNUZ6O8Q4QjKZv/69mgHNc9+9TIAbeanL9hV6/
         ejFlP9ylR4qsq5660JzS2Do4fijHGD3uAKKMX9JCAP0Z991KxJ5XnSk1GC8rAo9OLVAc
         bmk0ZpHXvNYcqI2YajtEGvO88jh+gT04ZlR+Me3DtER3eAgPCw8F7prHqjuhoXZ2aRW2
         rKHg==
X-Gm-Message-State: AFqh2kp0rlq7++Ldp24midUtMu+2UGHbnFOompsOtvqMUwa/JkY2R8Va
        fOvJndHjOVMvuAXPsCRUwadcq3XIP/8jWw==
X-Google-Smtp-Source: AMrXdXvaDUXtSxIc6egahxWoKQQ6/PPwyd2dm5SpV+bOr41Q0ilH4XKrSlDXE0daKbhd58FU4MKPKQ==
X-Received: by 2002:a5d:550e:0:b0:274:c846:4201 with SMTP id b14-20020a5d550e000000b00274c8464201mr10538618wrv.68.1672250437755;
        Wed, 28 Dec 2022 10:00:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/20] http-backend.c: fix cmd_main() memory leak, refactor reg{exec,free}()
Date:   Wed, 28 Dec 2022 19:00:12 +0100
Message-Id: <patch-12.20-9be5b0c7836-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us ever since
2f4038ab337 (Git-aware CGI to provide dumb HTTP transport,
2009-10-30). In this case we're not calling regerror() after a failed
regexec(), and don't otherwise use "re" afterwards.

We can therefore simplify this code by calling regfree() right after
the regexec(). An alternative fix would be to add a regfree() to both
the "return" and "break" path in this for-loop.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http-backend.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 6eb3b2fe51c..9bb63c458b1 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -759,10 +759,14 @@ int cmd_main(int argc, const char **argv)
 		struct service_cmd *c = &services[i];
 		regex_t re;
 		regmatch_t out[1];
+		int ret;
 
 		if (regcomp(&re, c->pattern, REG_EXTENDED))
 			die("Bogus regex in service table: %s", c->pattern);
-		if (!regexec(&re, dir, 1, out, 0)) {
+		ret = regexec(&re, dir, 1, out, 0);
+		regfree(&re);
+
+		if (!ret) {
 			size_t n;
 
 			if (strcmp(method, c->method))
@@ -774,7 +778,6 @@ int cmd_main(int argc, const char **argv)
 			dir[out[0].rm_so] = 0;
 			break;
 		}
-		regfree(&re);
 	}
 
 	if (!cmd)
-- 
2.39.0.1153.gb0033028ca9

