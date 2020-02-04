Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A41C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D178C2082E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTwROtT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgBDU1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:27:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36961 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgBDU1o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 15:27:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so24835569wru.4
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 12:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=giU3mmZuFbs9NrfGW5HxhL7tyz75Z/Kk7Lvqh5GE5lo=;
        b=nTwROtT6O29eOQIJV+kRLDI1KHYUEsmtozY/l8/zpZOCykpfJpV9w8OG2nT83tFRoA
         tQW3ub95JLlnv6m88yT6e3DQkzY46iUHjU6qAKTrIuX8qOeksSaeXRKf06PsHyBz+Vk7
         Mj720FlOWyYFOZ3kj+2PrBWE0g2F4lhiZoQuwrySt+vYV7VLIkwpmiyYhdRPq64ZSlHN
         PWEoB4AA20uAg+Qz4KCSkFLhNOsx6/QY+Qb4EXyGyqSjoiKDQyTnSLWU8KyEsSZh42GA
         rh9JpQpqx2X7f72jrqD+6ekmmmIR5kYWIaXJIjJiekhbsgJlk3m/Ttk49y4+N7JB1uqL
         4VBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=giU3mmZuFbs9NrfGW5HxhL7tyz75Z/Kk7Lvqh5GE5lo=;
        b=BEk68BhCq94woRLdW+2luEWvxjzv5EHGzGvDWa8CUxl0xA0Cbg5JCW559PnFc2K2EV
         DFatqafXBvMaKdE63nuIdLeVoVVaea8a3En/wqIUTxzEZxxFDzdzbc3jr/7FEkBW+013
         GCx/yHPxO19HZWQm47uxjNTusfEsfuU/N2JLGBN2v+nSTxkP4ctnN7zxnfL49OvFY1kH
         8Dbf9BAcshEA8xwaX6ae2fye06xOhuqpt3okIgL0x0/N96N793qq6WwGS+gEJq5OHIJ5
         B0wkRLGpmPi0wz09OYPDQDgQkJlIMYSvlZfnUkM37zNb9L1cUfictXiPzl2CG+gCU3xm
         OinA==
X-Gm-Message-State: APjAAAVK8sb1x1a0DMbjxoT5lKQ2BlkIE2nW3x5YF/0bnLhD1XKLKaA6
        qFgDDqUPqEKtaFTMtqpHxbEVEFLh
X-Google-Smtp-Source: APXvYqwj/48ekucWfYCQSwFQJPhl/quQNEhAvuVUewUDbnA0z7iqkMZn2aPpQQU1LOLacWp9AktdhQ==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr23390776wrp.63.1580848062780;
        Tue, 04 Feb 2020 12:27:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm5205330wmm.15.2020.02.04.12.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 12:27:42 -0800 (PST)
Message-Id: <57c7342319900e955ff0c14eeaa54aad9e41aa9e.1580848060.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
References: <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
        <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Feb 2020 20:27:36 +0000
Subject: [PATCH v3 2/6] setup.c: enable repo detection for reftable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
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

