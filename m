Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69917C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 11:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4562F20707
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 11:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eo+0aFAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgFOLPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgFOLPU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 07:15:20 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5123EC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 04:15:19 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id di13so7502359qvb.12
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 04:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kzT435fDSRn0U0QRqGqbBu4GNpBa5CWR7ZEf3SCFrrc=;
        b=eo+0aFAlbLkD5u9Ap8pzb/dEJhMuKhhSiZUDOUWwyKia1JTAiSaX6LEJDoOAyT/WWa
         FUmCluWshU+jKJUxB0lMVNYlIl6z31oVhwDWyec+orc79e+Rp4p34V96pdkPV7GEXgmi
         LMWqd5TfIryX9k0JqEhKM1qll1ocPyZYVDzQyzqFuHeYtVEe3Xm36J9XwFxWcZnty0NQ
         GVu3aCbQh4vz947MYi2FKYF893Fw0hoZ3B6z0+t5MN9ZI2xKeFsWRTcmPdfpN0AuBDg9
         RPi/Mie2ifPidD6nuDRnI310ptlDzn54rKo2YgdNyIKtIU7SH7mHLN5XgaQntyp3W485
         ZVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kzT435fDSRn0U0QRqGqbBu4GNpBa5CWR7ZEf3SCFrrc=;
        b=bxk9Bh0xJ+qxRPwP8PJkfaVGtKgDsZSm9unYOsuOHQgnvc8BeAmNCZBAiBItVfxzvG
         jdI2TLSX/ft+y2404Zb1M6LjRtozpqUiLvX6t8iNXKtwhZfl8EnbwZPtMMQtRTGzsXOw
         t764xmk1nfPQCH+Y+viC0o2p8JF1JrwstaC0fZXUeMq2OpLTCxQJRODdaShI5OvHBT+0
         O8KipkZQVPRuvWpj7uoRgD7veCytO14Nvd2/LhJi8RODXCjjr/OuQmzPbfjEB4Q9p+4a
         c4hJurb3LOBhAI6ctKJ3BmZ5ZUmMh2Bb49MaDIuHnUoxe6DPBn6rco36YmsplRR6/6Az
         nkug==
X-Gm-Message-State: AOAM532RZZYxM+nVwFhHBuPA1R61VV576YdXCf1qH1Sr65xxFdEG4Fxo
        3wfWaN5SurMqmY6qHRPxb3aXwVfc2+M=
X-Google-Smtp-Source: ABdhPJwNGcsWWNo/jdJ5ZpRyOp9VjFGKku54SdDviGTJAk9N5y+hENNFOJuNEZO19axNXN4oW85RjQ==
X-Received: by 2002:ad4:4a6e:: with SMTP id cn14mr23254089qvb.79.1592219717758;
        Mon, 15 Jun 2020 04:15:17 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id h77sm11350788qke.37.2020.06.15.04.15.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 04:15:17 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] builtin/diff: fix incorrect comment
Date:   Mon, 15 Jun 2020 07:15:07 -0400
Message-Id: <a9aea5dbb821544eea636bc5de9fe8185bb603fb.1592219700.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A comment in cmd_diff() states that if one tree-ish and no blobs are
provided, it would provide a diff between the tree and the cache. This
is incorrect because a diff happens between the tree-ish and the working
tree. Remove the `--cached` in the comment so that the correct behavior
is shown.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 8537b17bd5..1ebab58c55 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -276,7 +276,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	 *	compare a blob with a working tree file.
 	 *
 	 * N=1, M=0:
-	 *      tree vs cache (diff-index --cached)
+	 *      tree vs files (diff-index)
 	 *
 	 * N=2, M=0:
 	 *      tree vs tree (diff-tree)
-- 
2.27.0.132.g321788e831

