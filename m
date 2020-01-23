Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD487C3F68F
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B515321D7E
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7BoO7+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgAWTlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:41:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36321 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbgAWTlX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 14:41:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so4489279wru.3
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 11:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TS3Ah3CuiEXq+4m5EAu3GCHE+T2RdzcLIMPLUJRoWRI=;
        b=d7BoO7+2mtUlLOl0JBBopAuQbNAI+waGfjblgfhnN9L3z7npxANCW3k6eWRFOkrAZs
         hkuVPqNmI98x5SIxSldH7eQ/1xKbk7R5fF0MmEOQy1pKfuU9kq+dOdQ5KQj6VxGtZxRS
         N2E75gc487mkMf+8zaW/KOGn33GBwGfi9hfOWltZ6WdQfklBMOqqtuhZIC8W59MsoaBH
         tNSRJMPCrABehgM1K5mr434AtfFo/ka0FRvlDhUF+e7rTmzprzSbHWFLxFNFbKcMPaoV
         k55feRXco1ESlZc4gJgQOCAzvtZ/dHYwU/BBk6n7ywSZx1XG4EB9PTisFwvQTZVNcN6s
         08QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TS3Ah3CuiEXq+4m5EAu3GCHE+T2RdzcLIMPLUJRoWRI=;
        b=hHzrHW7m6yeXlPDuASWinv2a+VH1c826hE8I98Bxrmvx/BjW5u/YKffzsyvGHUS6OS
         BG1K9wPd4xJ8J/XpJkrbsk78VpN7RVkVWwRKgjdSEcYwu7h35afU3QeVP7QQgoJ+RlFc
         DnXXg0DRYpwhnXIFxo0T9Hgl4HtSLJaEnw983uNr4ZUM6rY4Iatcx+dAcXecEBjqrb1k
         E4WXctruaCIOEVD4PoZzudsMiE2PO/s0a8bJXDwkPIzbuNFQxawNMj5PNvY4FvQDOOZP
         dDjVRB0bEwPAoM3XxPT8Ndr5af2R25truiogyBj2jon4PNtdPVAoZ1eDVySUFbXcIYCy
         lWcg==
X-Gm-Message-State: APjAAAXr5IxI7pRr2nzVfQfq4nT/vYbHoq5nHRXA1lkSzdWnO/XDGFed
        UnSKCtROGi4eTnXe36DfJbBUrRYE
X-Google-Smtp-Source: APXvYqz8YUQoUeJPXAdTAtZh/Hosa6qiEGg+NpL+G1YsGO946l0D4D9rdTx45iOwJHHY0UqzR00gew==
X-Received: by 2002:adf:f288:: with SMTP id k8mr20412613wro.301.1579808481586;
        Thu, 23 Jan 2020 11:41:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm4230657wrt.89.2020.01.23.11.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 11:41:21 -0800 (PST)
Message-Id: <fd2baf16282747707c6e1da402df7e0e669647d1.1579808479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.git.1579808479.gitgitgadget@gmail.com>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jan 2020 19:41:15 +0000
Subject: [PATCH 1/5] setup.c: enable repo detection for reftable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@xs4all.nl>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

* only check R_OK for .git/refs.

  In the reftable format, tables are stored under $GITDIR/reftable/ and
  the list of tables is managed in a file $GITDIR/refs. Generally, this
  file does not have the +x bit set

* allow missing HEAD if there is a reftable/

Change-Id: I5d22317a15a84c8529aa503ae357a4afba247fe9
Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 setup.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/setup.c b/setup.c
index e2a479a64f..e7c7dca701 100644
--- a/setup.c
+++ b/setup.c
@@ -304,22 +304,23 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
  *  - either an objects/ directory _or_ the proper
  *    GIT_OBJECT_DIRECTORY environment variable
  *  - a refs/ directory
- *  - either a HEAD symlink or a HEAD file that is formatted as
- *    a proper "ref:", or a regular file HEAD that has a properly
- *    formatted sha1 object name.
+ *  - a reftable/ director or, either a HEAD ref.
+ *    The HEAD ref should be a HEAD symlink or a HEAD file that is formatted as
+ *    a proper "ref:", or a regular file HEAD that has a properly formatted sha1
+ *    object name.
  */
 int is_git_directory(const char *suspect)
 {
 	struct strbuf path = STRBUF_INIT;
 	int ret = 0;
+        int have_head = 0;
 	size_t len;
 
 	/* Check worktree-related signatures */
 	strbuf_addstr(&path, suspect);
 	strbuf_complete(&path, '/');
 	strbuf_addstr(&path, "HEAD");
-	if (validate_headref(path.buf))
-		goto done;
+	have_head = !validate_headref(path.buf);
 
 	strbuf_reset(&path);
 	get_common_dir(&path, suspect);
@@ -339,9 +340,16 @@ int is_git_directory(const char *suspect)
 
 	strbuf_setlen(&path, len);
 	strbuf_addstr(&path, "/refs");
-	if (access(path.buf, X_OK))
+	if (access(path.buf, R_OK))
 		goto done;
 
+        if (!have_head) {
+                strbuf_setlen(&path, len);
+                strbuf_addstr(&path, "/reftable");
+                if (access(path.buf, X_OK))
+                        goto done;
+        }
+
 	ret = 1;
 done:
 	strbuf_release(&path);
-- 
gitgitgadget

