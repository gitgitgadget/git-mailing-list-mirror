Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13FAC433E1
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E59206DA
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="oGX/BlEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgHJVfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgHJVfm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:35:42 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D05C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:42 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w9so7974630qts.6
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hh+MYb8IWJsn+O485kBva+2apDsvaqnZccKmIGFqA3A=;
        b=oGX/BlEP3D6YvTAlXXwWW+/UpSBYj2FVOytrfnEgrvBEmc40Rf7OQ0cagHqInshCIQ
         JCtPkJIx8p742Fjhgy2jpP9AuKZQQ4IfuhpSRaYTooFs5/3aKs4nX1OMoR4Eb4o5tZEc
         ZdsPDEJAMBpbTfdS08qdYzRSEVyYspzidQqv4sMbxiD8YYNLazDGJ6SB9lmc4yeAg9KN
         E3p31kdog1NWsJOy/3jUJE6Ayv4CGKRB0hTeufGnWycy6TO18PXbZ/I7mnwlvcMVmzq9
         D5MArRGf+5ryH6jBQMzpA69Hw1UYkLaniZdMEA+eR8vKeF6eSod4C7g+jeXxohup0Ely
         h7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hh+MYb8IWJsn+O485kBva+2apDsvaqnZccKmIGFqA3A=;
        b=LHQxEiRtjB4IHZbzM4/XkBlSHMdIzqTkjjzVB+AdmtiBC/e+H4hq+jKhM8b16TcAof
         w8e7gqsOKmd8SeIKfwjJQ+WzxZPsqJ6X28q9mASF0RkS2IClXoZUYv/N0Y79f0dDupVF
         z5oOLRENfFggopVKr9h93BApgUsZZdAIV0xU7gtO50a1rKh/NPSqXc+Wg/0AD0mqB5xf
         HPVXyesmAPVFxsgf5kp5gDM4J5X5PvmzsuTASoPIrPmZvOKx8bcQBxBUMI+pSBQt+FsO
         GnBJ0vM2L4YZN3/Bx4lpU3/bXjptHD5N8qRpGlAbCk8BzH9Lfj6/YDmssEqfPQWhhz+J
         uV2Q==
X-Gm-Message-State: AOAM5317qn1lhJjXQQeo5KACxAKWQkIk7l3TLF2W2Je+IKFNC6Hovasw
        iBaK4o1NC5LD3pFUo1RSoGWfhUsc7HI=
X-Google-Smtp-Source: ABdhPJyPmAiKGe28b/qz3B09nCYQ+rzXYSXdlJ+eCFoaUcaQnfsDbHJL1foPx1EPiWCpWEKKNX+9tw==
X-Received: by 2002:aed:2946:: with SMTP id s64mr29699832qtd.204.1597095340806;
        Mon, 10 Aug 2020 14:35:40 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:35:40 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 18/21] entry: use is_dir_sep() when checking leading dirs
Date:   Mon, 10 Aug 2020 18:33:26 -0300
Message-Id: <747e78a0a34c3044a3edf07ca038bd85e7c0afef.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test 'prevent git~1 squatting on Windows' in t7415, adds the file
'd./a/x' and the submodule 'd\a' to the index, with `git -c
core.protectNTFS=false update-index --add --cacheinfo`. Then it performs
a clone with `--recurse-submodules`. Since "d./" and "d\" represent the
same entry on NTFS, the operation is expected to fail, because the
submodule directory is not empty by the time "d\a" is cloned. With
parallel checkout, this condition is still valid: although we call
checkout_entry() for gitlinks before we write regular files (which are
delayed for later parallel write), the actual submodule cloning only
happens after unpack_trees() returns, in builtin/clone.c:checkout().

Note, however, that we do create the submodule directory (and leading
directories) in unpack_trees(). But the current code iterates through
path components only considering "/", not "\", which is also valid on
Windows. The reason we don't fail to create the leading dir "d" for the
gitlink "d\a" is because, by the time we call mkdir("d\a"), "d" was
already created for the regular file 'd./a/x'. Again, this is still true
for parallel checkout, since we create leading dirs sequentially, even
for entries that are delayed for later writing. But in a following patch,
we will allow checkout workers to create the leading directories in
parallel, for better performance. Therefore, when checkout_entry() is
called for the gitlink "d\a", "d" won't be present yet, and mkdir("d\a")
will fail with ENOENT. To solve this, in preparation for the said patch,
let's use is_dir_sep() when checking path components, so that
checkout_entry() can correctly create "d" for the gitlink "d\a".

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

I'm not sure if this is the right way to make t7415 work with
parallel-checkout; or if we should, perhaps, change the test to add the
submodule at 'a/d'. I'd love if someone more familiar with Windows could
review this one.


 entry.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/entry.c b/entry.c
index 6208df23df..19f2c1d132 100644
--- a/entry.c
+++ b/entry.c
@@ -19,7 +19,7 @@ static void create_directories(const char *path, int path_len,
 		do {
 			buf[len] = path[len];
 			len++;
-		} while (len < path_len && path[len] != '/');
+		} while (len < path_len && !is_dir_sep(path[len]));
 		if (len >= path_len)
 			break;
 		buf[len] = 0;
@@ -404,7 +404,7 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
 {
 	const char *slash = path + len;
 
-	while (path < slash && *slash != '/')
+	while (path < slash && !is_dir_sep(*slash))
 		slash--;
 	if (!has_dirs_only_path(path, slash - path, skiplen)) {
 		errno = ENOENT;
-- 
2.27.0

