Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DE7E200B9
	for <e@80x24.org>; Sun,  6 May 2018 14:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbeEFOLK (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 10:11:10 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39322 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeEFOLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 10:11:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id q3-v6so25373466wrj.6
        for <git@vger.kernel.org>; Sun, 06 May 2018 07:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8qcV5s1gp457u+NjnUWxdAqjGpqd6OIOp1VBlGln0EM=;
        b=GIvHD3Et5Qhm2Kljhfj8j34qdH3whcwp/wODfRe1tLfTBpdjulbT+FAG8FrJtSi9f7
         txc+vm0JKA1OCFUYk48GS9NaGoYU6+CS5XYw82FfB8Yo9n7vb6sV2yKtXhXWf/YR4z6D
         psb9X7rKvBZ1v0dHoTK0afJoN2AQ+6NBm/n/FFr4k07v2t7MVAAtfWjZcvB7fSlXw6vr
         9XZ8ujbAbsz1z3BlIjKnjkpWlqS/MmPrBq3uOAJS2IZdpCAzoimu5WnNNoJbZfTR60w+
         WnxrepUpEAfMttbreqzfOyO18LSJT29my3otIZ2AOma20arcgb98FANHTT9zve5iSY+Q
         MJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8qcV5s1gp457u+NjnUWxdAqjGpqd6OIOp1VBlGln0EM=;
        b=QVS+WZVu+xKvWxEfIDZbyvP7V6h2N4CmL3RfOkiPNk+mLY+kV0A+akEOmiaJqQm1dV
         0t3rsmnQkwxWQVjPGXCH3NuR10Uq6OzsG9xUbsNbNeGc/W4zHOVci95qDkiDQc/eP7Uo
         P+QjNetVL74sFfxAMv1yQezPtIBVY5MiN95x81wUMXsXxRLMXJHlSvtNzn+/Vfgns155
         CbgyoA1Zplhs+2gavjGhbCB046dqsVVchsuQEYCiMvlrT4NslfnakXJjnmU55Rt6AWfR
         Tj6yj53e3rQi7upWfIc7P9UXt3Wx/WTzsAR++3wo+kKjex2mLSzMgWJNsvwmZfFpIXKI
         aujA==
X-Gm-Message-State: ALQs6tAg5e3cJSaQy5+jrU2gnzklzjvkxDz3Vsr5c/IKM3Th2JTR80AE
        a9l7WN4er3jopOdSibACuyvKx1nh
X-Google-Smtp-Source: AB8JxZrREMT4PLJp7cm8l9Zujk1uIE4euZ5bAUaiLpAmC6I22wguoRxwrgg6acXwZ8Ay2BSE3O0Ccw==
X-Received: by 2002:adf:b18d:: with SMTP id q13-v6mr25277308wra.276.1525615867666;
        Sun, 06 May 2018 07:11:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id p17sm4914857wmc.17.2018.05.06.07.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 May 2018 07:11:06 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     David Turner <novalis@novalis.org>
Subject: [PATCH 2/5] refs.c: do not die if locking fails in `write_pseudoref()`
Date:   Sun,  6 May 2018 16:10:28 +0200
Message-Id: <20180506141031.30204-3-martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.411.g9fd64c8e46
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we could not take the lock, we add an error to the `strbuf err` and
return. However, this code is dead. The reason is that we take the lock
using `LOCK_DIE_ON_ERROR`. Drop the flag to allow our more gentle
error-handling to actually kick in.

We could instead just drop the dead code and die here. But everything is
prepared for gently propagating the error, so let's do that instead.

There is similar dead code in `delete_pseudoref()`, but let's save that
for the next patch.

While at it, make the lock non-static.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 refs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 8b7a77fe5e..8c50b8b139 100644
--- a/refs.c
+++ b/refs.c
@@ -644,7 +644,7 @@ static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
 {
 	const char *filename;
 	int fd;
-	static struct lock_file lock;
+	struct lock_file lock = LOCK_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	int ret = -1;
 
@@ -654,8 +654,7 @@ static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
 	strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
 
 	filename = git_path("%s", pseudoref);
-	fd = hold_lock_file_for_update_timeout(&lock, filename,
-					       LOCK_DIE_ON_ERROR,
+	fd = hold_lock_file_for_update_timeout(&lock, filename, 0,
 					       get_files_ref_lock_timeout_ms());
 	if (fd < 0) {
 		strbuf_addf(err, "could not open '%s' for writing: %s",
-- 
2.17.0.411.g9fd64c8e46

