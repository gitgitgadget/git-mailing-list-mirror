Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF30EC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 14:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239009AbiGSOKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 10:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238854AbiGSOKM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 10:10:12 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A336A4D4DA
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 06:28:59 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id o18so13463741pgu.9
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 06:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dlNEvhIJLmX7y4XPjfnzdGR+FaGJHlapW3spqnQxAMk=;
        b=Lz5NDrrGXQlmuH+pRKzQcjHMM9lsHaOhw2gwVNysl8vel055vWHPhX1HUOgNzNDPsT
         0Y/QIdzOmCvENK9CYQvaJZkXkVMAsFKEqDXz/Q0ZzkfUgZD+MrqD6Kb0jPWLZicDuzk+
         ZEFiV0asKcel2rS4UIfaUN9r4qRnc2ktwGiGbrwZ3PkFwyLiI84y/PWaicB5ucymV+ZR
         NOWC160UDpC1E2dY2Unuadr/vYuZqmP47MtGp3nx/vvxk8eS6ardbN42OXh4C5+NQpdY
         GBznuaSLgVEwwV5+sdcZqpx1FBoUIcYgaa9laW4qVUggyUzZ9Fd72FlCFe1X/YHz0OyV
         LjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dlNEvhIJLmX7y4XPjfnzdGR+FaGJHlapW3spqnQxAMk=;
        b=4YyHsa8fqmWIBkkgagLHZQAPCAv9GTIOdjVytevQ0+OIBR4ILiCBaquJPA733i7zP+
         3/ieslLJ0196dgmjEXoQtl8h36L2+l8HrI3utpdAgmkYuH6Rhsj3wh0LYqZPWjcqpIWT
         YON1SWoojie98TilEWn7JCcyc20zNgd51J0Ng24UI6KU8AC+gzVFkOQcLskvxaHh+ZE6
         RMR8zpq/O1EJKYRRzKJ6o+Zwl+PjosMHjSAa4FxSyp5ki+YL91zVWw6Ud7GQXoiHWoOY
         uPeI7D+NT4t8m5naToVbJel7ICGWRfNUVspaazKzFT4cpVmfRnujsg/4VmY2wW9NSVNS
         b1nQ==
X-Gm-Message-State: AJIora94ZU5ze/uT9e88bMC1jayda4S/qHqpUtd6b50MNgY+h6f8A/2m
        SwzC/EKjaSK7OKMCDSAlG0qViOez2iObAafy
X-Google-Smtp-Source: AGRyM1u5YmOY2viCgnhxO8Al+g5lDSDLQXdqO9xHcR7MCj9Iv0PUUPy1iUhLSzh2sbx+7KtAfANaMQ==
X-Received: by 2002:a63:e252:0:b0:41a:4df2:13ed with SMTP id y18-20020a63e252000000b0041a4df213edmr2088196pgj.113.1658237338990;
        Tue, 19 Jul 2022 06:28:58 -0700 (PDT)
Received: from ffyuanda.localdomain ([101.206.227.243])
        by smtp.gmail.com with ESMTPSA id r9-20020a170902be0900b0016be834d544sm624424pls.237.2022.07.19.06.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 06:28:58 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v1 3/7] mv: free the *with_slash in check_dir_in_index()
Date:   Tue, 19 Jul 2022 21:28:05 +0800
Message-Id: <20220719132809.409247-4-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

*with_slash may be a malloc'd pointer, and when it is, free it.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index c8b9069db8..23a297d6b8 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -140,6 +140,7 @@ static int index_range_of_same_dir(const char *src, int length,
  */
 static int check_dir_in_index(const char *name)
 {
+	int ret = 1;
 	const char *with_slash = add_slash(name);
 	int length = strlen(with_slash);
 
@@ -149,14 +150,18 @@ static int check_dir_in_index(const char *name)
 	if (pos < 0) {
 		pos = -pos - 1;
 		if (pos >= the_index.cache_nr)
-			return 1;
+			goto free_return;
 		ce = active_cache[pos];
 		if (strncmp(with_slash, ce->name, length))
-			return 1;
+			goto free_return;
 		if (ce_skip_worktree(ce))
-			return 0;
+			ret = 0;
 	}
-	return 1;
+
+free_return:
+	if (with_slash != name)
+		free((char *)with_slash);
+	return ret;
 }
 
 int cmd_mv(int argc, const char **argv, const char *prefix)
-- 
2.37.0

