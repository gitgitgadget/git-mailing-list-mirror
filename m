Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF6BC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 10:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbiCDKoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbiCDKoB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 05:44:01 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB05A1AC296
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 02:43:12 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id e2so7370945pls.10
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 02:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3KuLP5qP/VqlP1E8IR9y0kSFcaMZIji7j23ou89GJxw=;
        b=V8f7KoNZCTGQ4LT6/Y4Z6kTBaulbSpKgnTcnMUgkWvIn/25DOvkm63RcglcN04TElP
         UvLgh4ZVCbQUDcWSGZrXKTlGlueAYtqg4b71eMgNpiL2/NtrCrFT+LOkjVvnPMV7Icbe
         RH5zjnnWPZuCnvYmd9vQJTyZ3Yfpan0xVpSLKz61v+B79UOGUNYErfbbuXtvMM5H5ztt
         TeWn/OMylGpToQ5LTcQEiBp1BQPEQNZ/rgr5A6QSV6bK+0BSoxnhwfN+0SUo2NfQfbew
         vU+kJOYS427EJMrXKbSSuhxfeDjUoZRqTdpOmPDpk8S9TEL18yC/hN7aJWtgcB1QNtj/
         WUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3KuLP5qP/VqlP1E8IR9y0kSFcaMZIji7j23ou89GJxw=;
        b=SWb6dY4CHZ3yeZtepIY8HGwuTJXAL5FJIZJf5maONgOQkhkv4w7nSzXlTC86UUp3lH
         0vKTtXAknM/6OzhfL05oIHUi0xUR0Jn8NX/oE6S+fGyny8HIccSPU8oiXvugE9ck8jy3
         rdGAYSVidrpeOTRnaVLwxl2eCpHywu/UK8t3wn9LB7QUPyJOgaNqp9Lw3n+vf61uqdQt
         U0p/TJkF0gzJaDxpzQlaA8Nb8DHu6NCl0wiDqXqA8HXxbG528rfyKlZXEGfL/uvYlBzc
         U8Ju0Tnt/WB82geqKVrlZu2L/Nh1zGgrJSr6I8fOfRTlcyFNtsuVpRJb0wy4t5SL4CNA
         RmGw==
X-Gm-Message-State: AOAM531yu3PYP7jNVTBeF+8i3kigMaMfP5Ze44yfxvdP55lHNfCRl2XV
        wqLIcNszYuTYxKKRmhFd7K+pbwl5ZC8ogVLJ
X-Google-Smtp-Source: ABdhPJyUjhSmILgiJInNbzmeJ7SytsXNEWABbLZ7Qwm0Fe01+yNX7PugKbTeNVgSvQzLInKY2r35EA==
X-Received: by 2002:a17:90a:5505:b0:1b8:ebd4:d602 with SMTP id b5-20020a17090a550500b001b8ebd4d602mr9879559pji.147.1646390592161;
        Fri, 04 Mar 2022 02:43:12 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.53])
        by smtp.gmail.com with ESMTPSA id k7-20020a6555c7000000b0034e101ca75csm4236253pgs.6.2022.03.04.02.43.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Mar 2022 02:43:11 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v12 04/12] ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
Date:   Fri,  4 Mar 2022 18:42:30 +0800
Message-Id: <2637464fd8f6b8bae6c681f20c10c9fc76dc6d6c.1646390152.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.402.gef0f5bd184
In-Reply-To: <cover.1646390152.git.dyroneteng@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

The "struct strbuf"'s "len" member is a "size_t", not an "int", so
let's change our corresponding types accordingly. This also changes
the "len" and "speclen" variables, which are likewise used to store
the return value of strlen(), which returns "size_t", not "int".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3f0225b097..eecc7482d5 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -31,7 +31,7 @@ static const  char * const ls_tree_usage[] = {
 	NULL
 };
 
-static int show_recursive(const char *base, int baselen, const char *pathname)
+static int show_recursive(const char *base, size_t baselen, const char *pathname)
 {
 	int i;
 
@@ -43,7 +43,7 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 
 	for (i = 0; i < pathspec.nr; i++) {
 		const char *spec = pathspec.items[i].match;
-		int len, speclen;
+		size_t len, speclen;
 
 		if (strncmp(base, spec, baselen))
 			continue;
@@ -65,7 +65,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 		const char *pathname, unsigned mode, void *context)
 {
 	int retval = 0;
-	int baselen;
+	size_t baselen;
 	enum object_type type = OBJ_BLOB;
 
 	if (S_ISGITLINK(mode)) {
-- 
2.34.1.402.gef0f5bd184

