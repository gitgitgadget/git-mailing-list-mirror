Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFF4C433F5
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 13:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiAANvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 08:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiAANvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 08:51:16 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABBCC06175D
        for <git@vger.kernel.org>; Sat,  1 Jan 2022 05:51:15 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso19918129pje.0
        for <git@vger.kernel.org>; Sat, 01 Jan 2022 05:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Jkle+8PPnnCZO2+XSpU2oCcYHIXVfKN6K1rnLZUPTA=;
        b=gZnc5FYn22AUKKGT9eJn5mWoueGS7qjElmmlkUVRAWxFDLvBx/VnBLJTUd/A1VIeT2
         QTwo+Wqgn507y09vBLCKCddYitd5q5opPeATau9CIpeYJWx3EFoEm9QPAOoDTo3u5dx9
         0Ec7gW7awsqDCy57x8vS3aMpgacF5mwbv09W7LwW5UCgbS7lzTAmWjCbTSoeJuVQRDkQ
         ii9E4QS3EZKIn1g9nLVMjSF/2OOKXUICHyX/yxlkIcNDxIN74oIYBCn6aWy8GpaOv2t3
         jA9ndAUS40KFPDwF7r+I8KrSh5KEdSlyUHMZnnq1WzQ7WX3kAsAb+A3bvBX1BeyCMp7y
         Y1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Jkle+8PPnnCZO2+XSpU2oCcYHIXVfKN6K1rnLZUPTA=;
        b=dHXi64iXZT+iVcYJcn3BLyE9t5bphx3mY1xexZToO3nS8sxyjae+Bq5Js8PMLmTUxh
         3rpz3hBlTQVQYqNZIoasDpACvcMJcnkSlJoCHH+sCRpk/X5cPooEbvHnK0lYwa+/H7nC
         +vCISDk5O7VibrUjjUnfurbRdZ5+kUGBLuT7Xx7pMfG+WXap3GXY9y35hoAiLMwBgsqr
         pqsF6gxXAOU8KmD9T6D52DWvukJVZhUIsCHYOKeYuvCSmyrswwkFciQ1+qPf68weRK5R
         1povrJIUoNDwHBnHYuK2iSWu2llcX71WHr6JHWPvU91ORIy0q5khH76qpnoMKex1XUXX
         XrLw==
X-Gm-Message-State: AOAM530LhWWxxYe2f4jS0LEZvv4PPCcpWT5QIcfgH5BXJiOleiP9seNr
        D7srOyHrojg3rThkJb0Fj89XZ7MUVMva9/IyDCM=
X-Google-Smtp-Source: ABdhPJxe/+lBXgrFPiwiAvU8CidlxucWRMYidT1EA692obBfPYzlUN0oRtEc3vpkDta1YqgaE007VQ==
X-Received: by 2002:a17:90b:1bc7:: with SMTP id oa7mr47188214pjb.200.1641045075087;
        Sat, 01 Jan 2022 05:51:15 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.41])
        by smtp.gmail.com with ESMTPSA id o11sm34022039pfu.150.2022.01.01.05.51.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jan 2022 05:51:14 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v8 5/8] ls-tree: split up the "init" part of show_tree()
Date:   Sat,  1 Jan 2022 21:50:28 +0800
Message-Id: <d77c895a4b9d5cb86443279c0156196254895ef4.1641043500.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.1802.gbb1c3936fb.dirty
In-Reply-To: <cover.1641043500.git.dyroneteng@gmail.com>
References: <cover.1641043500.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Split up the "init" part of the show_tree() function where we decide
what the "type" is, and whether we'll return early. This makes things
a bit less readable for now, but we'll soon re-use this in a sibling
function, and avoiding the duplication will be worth it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index eecc7482d5..df8312408d 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -61,25 +61,33 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 	return 0;
 }
 
-static int show_tree(const struct object_id *oid, struct strbuf *base,
-		const char *pathname, unsigned mode, void *context)
+static int show_tree_init(enum object_type *type, struct strbuf *base,
+			  const char *pathname, unsigned mode, int *retval)
 {
-	int retval = 0;
-	size_t baselen;
-	enum object_type type = OBJ_BLOB;
-
 	if (S_ISGITLINK(mode)) {
-		type = OBJ_COMMIT;
+		*type = OBJ_COMMIT;
 	} else if (S_ISDIR(mode)) {
 		if (show_recursive(base->buf, base->len, pathname)) {
-			retval = READ_TREE_RECURSIVE;
+			*retval = READ_TREE_RECURSIVE;
 			if (!(ls_options & LS_SHOW_TREES))
-				return retval;
+				return 1;
 		}
-		type = OBJ_TREE;
+		*type = OBJ_TREE;
 	}
 	else if (ls_options & LS_TREE_ONLY)
-		return 0;
+		return 1;
+	return 0;
+}
+
+static int show_tree(const struct object_id *oid, struct strbuf *base,
+		const char *pathname, unsigned mode, void *context)
+{
+	int retval = 0;
+	size_t baselen;
+	enum object_type type = OBJ_BLOB;
+
+	if (show_tree_init(&type, base, pathname, mode, &retval))
+		return retval;
 
 	if (!(ls_options & LS_NAME_ONLY)) {
 		if (ls_options & LS_SHOW_SIZE) {
-- 
2.33.0.rc1.1802.gbb1c3936fb.dirty

