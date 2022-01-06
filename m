Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B98C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 04:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbiAFEb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 23:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiAFEb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 23:31:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EC8C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 20:31:58 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id w7so1629366plp.13
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 20:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G9TfqrPPqvQ9Q5rPIxT2vhXl2paAUnRnTsrVrzzBQP0=;
        b=DNxefMmTnC0xGk78Zv0c6SVZ+HjdEkoxzDJDzQLVLHYsjEOI/2O30aY23Ba0gcGneo
         OHVgdSOkF9qROeUAUerF/8174yt6J1E2UGylrpKiwQPV0vk00E2ULbjH0UZQW85cZ7zO
         sgEUuHZFg+V7+nvHxK+PFo/bhgKHHbwmB6qxofwRVI5IIZoMGKiIB5EYIystwOUKKrw+
         bUyZvyXmPoONcFljU/vAQowm99PeD0yA5E8TS0kza9/zYY37l2QLoJsoR6Dr0iVFEVAI
         FAf8nWIlS7IxiUxsy7s1yhTVvMVFZVhLaLRRoRcfylJgjLYjtuplcIm1pv+yvndrwTlm
         jpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G9TfqrPPqvQ9Q5rPIxT2vhXl2paAUnRnTsrVrzzBQP0=;
        b=2cmxnDFj1reTaPqfjup3e2v5VqMAyKSQzqrohasEI7ZBO3A+h+Ol4j5ui9sTDd5iD6
         FaBkEo6J+z3FLm580MRgsSqBlBtb+38d/IdEMFnx1jugs+uVQ4sKi9AbS3nBnYJRjc2k
         cQZl+cMBUnnTWo9afvMpcvB1w9vXJbA5EsqJHeCa8yKIXGXV6WZXv/Ke6Aarc50JJKr7
         htXpeGKNkD5dA4e8rh3v6f1l7CWdSK2G3NyJ/YRVqbLjG2MTVQDCz5N3YopxPBQaVjcX
         Kh/bQnJ5a+LJJO4rZCy4JHCuh0nKxaoZVgGCmVSv2Idxm8XNLskWO/jczHj4Qi+dSJRI
         NYBw==
X-Gm-Message-State: AOAM533hxXPJHJTSu2peiy3cJtsFhNgKgLzHptRYuRc5GzI1iQ2DkjMH
        ggDa66Bkfjl1ECIr79i0yGc=
X-Google-Smtp-Source: ABdhPJxrJR9XdAfQq4bK9JgYBjHs5EhexZvL5UoMX8eJO4Aj2ABEQojRBkVADgAQajDDnu+T2g4Bow==
X-Received: by 2002:a17:903:2307:b0:149:ba56:ff83 with SMTP id d7-20020a170903230700b00149ba56ff83mr18485374plh.7.1641443518028;
        Wed, 05 Jan 2022 20:31:58 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.34])
        by smtp.gmail.com with ESMTPSA id 13sm636491pfm.161.2022.01.05.20.31.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jan 2022 20:31:57 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com,
        Johannes.Schindelin@gmx.de
Subject: [PATCH v9 3/9] ls-tree: use "enum object_type", not {blob,tree,commit}_type
Date:   Thu,  6 Jan 2022 12:31:26 +0800
Message-Id: <208654b5e2aebbe988b5a8f478869253a0166e9b.1641440700.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.1794.g2ae0a9cb82
In-Reply-To: <cover.1641440700.git.dyroneteng@gmail.com>
References: <cover.1641440700.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Change the ls-tree.c code to use type_name() on the enum instead of
using the string constants. This doesn't matter either way for
performance, but makes this a bit easier to read as we'll no longer
need a strcmp() here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 0a28f32ccb..3f0225b097 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -66,17 +66,17 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 {
 	int retval = 0;
 	int baselen;
-	const char *type = blob_type;
+	enum object_type type = OBJ_BLOB;
 
 	if (S_ISGITLINK(mode)) {
-		type = commit_type;
+		type = OBJ_COMMIT;
 	} else if (S_ISDIR(mode)) {
 		if (show_recursive(base->buf, base->len, pathname)) {
 			retval = READ_TREE_RECURSIVE;
 			if (!(ls_options & LS_SHOW_TREES))
 				return retval;
 		}
-		type = tree_type;
+		type = OBJ_TREE;
 	}
 	else if (ls_options & LS_TREE_ONLY)
 		return 0;
@@ -84,7 +84,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	if (!(ls_options & LS_NAME_ONLY)) {
 		if (ls_options & LS_SHOW_SIZE) {
 			char size_text[24];
-			if (!strcmp(type, blob_type)) {
+			if (type == OBJ_BLOB) {
 				unsigned long size;
 				if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
 					xsnprintf(size_text, sizeof(size_text),
@@ -95,11 +95,11 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 			} else {
 				xsnprintf(size_text, sizeof(size_text), "-");
 			}
-			printf("%06o %s %s %7s\t", mode, type,
+			printf("%06o %s %s %7s\t", mode, type_name(type),
 			       find_unique_abbrev(oid, abbrev),
 			       size_text);
 		} else {
-			printf("%06o %s %s\t", mode, type,
+			printf("%06o %s %s\t", mode, type_name(type),
 			       find_unique_abbrev(oid, abbrev));
 		}
 	}
-- 
2.33.0.rc1.1794.g2ae0a9cb82

