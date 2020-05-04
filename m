Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD979C47259
	for <git@archiver.kernel.org>; Mon,  4 May 2020 13:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D6CB2075B
	for <git@archiver.kernel.org>; Mon,  4 May 2020 13:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9cAogDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgEDNbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 09:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728417AbgEDNbb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 09:31:31 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE43C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 06:31:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k12so8422196wmj.3
        for <git@vger.kernel.org>; Mon, 04 May 2020 06:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gl+40ObxAzQ9BUWefXcL7ADB/tskWkmkHMV3sgw61DY=;
        b=t9cAogDPEj2LnW/RhkYeChf2XqHPMfx7Cbns4/ieijxADrab/T0NGph4dmOSWQc07b
         cg5CXm0ElIh0Lx76pNoPDFldk6sVDZ9g2pKlQAHJrrgnchMb5uGfuwZvUT/sTnuieU+q
         K050fzsvQHn5axrhkjBzbKNQKcB+lD5Y67NVA9qDjQMAc8oofiy87w3WPrlxwqUDfIkL
         XCIgzmij9ivMNxqniWXb6+hIGGR7lMhZ4jvg15/7E1XYGJ3/oPT962NO/fO4NH4+r8k4
         ZAETIr3+yhN/blsENVGse5wCGIBq9pXArWml4vEJcNycczqFPQAE9SFzLlViohOODl7M
         Q3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gl+40ObxAzQ9BUWefXcL7ADB/tskWkmkHMV3sgw61DY=;
        b=Jtu26wLDShKKUwp/wwXrr8EVG8gEJ8647+jLRomT/ASK+1c3VSkPj+SGYlWtC9kDmJ
         hQwSGKPiOXDgz1vKidEaQ9X5N7DzrU3e6cRVwsz1MpZAhtptn3yQbXi4iVjbb4OwAVOY
         yjtfrpbior+r/zQ3tQpUmlPUh4JHwYJPLjOsP0kvlYjg0exXiSsRDHskULVs0qV3Jo36
         uLmIWHhsLDPgFVgCzi/smCfpoYHG1JrwZxdSLCqJ6XbUkYn8NJCHJHqad9UTGms8x488
         8oYAU5cFtSsfYFMlKdTq8krXxo72F0CJqeJbeU1thWoaDX7Q/5jJlws9bzXv0V2o3ev6
         iVWA==
X-Gm-Message-State: AGi0PuZMRkbNb1z9JgH9W6aBugaThAQciXYUcXsSxsFd2k7HT3d25OyB
        uu3/GT42Q96wsrBhsYgofebuc5No
X-Google-Smtp-Source: APiQypLj6GbwKsSQJIpIxbndv7VTbGR+TgEuadZvoNlrLAmtyY+coiyKwJlBCxK50vb3cKwRm8yXtA==
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr14774950wmc.69.1588599089517;
        Mon, 04 May 2020 06:31:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7sm14985610wmg.41.2020.05.04.06.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 06:31:29 -0700 (PDT)
Message-Id: <6f1868a2fe21e59d80a81b837810b09aa86a6838.1588599086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.623.git.1588599086.gitgitgadget@gmail.com>
References: <pull.623.git.1588599086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 13:31:23 +0000
Subject: [PATCH 3/6] fixup! Add reftable library
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A `void` function cannot return a value.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reftable/record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/record.c b/reftable/record.c
index b0f18f26c55..5f48be1639e 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1005,7 +1005,7 @@ int record_decode(struct record rec, struct slice key, byte extra,
 
 void record_clear(struct record rec)
 {
-	return rec.ops->clear(rec.data);
+	rec.ops->clear(rec.data);
 }
 
 bool record_is_deletion(struct record rec)
-- 
gitgitgadget

