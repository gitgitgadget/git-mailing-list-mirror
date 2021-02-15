Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328D9C433E9
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025C664DFF
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhBOSZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 13:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhBOSZG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 13:25:06 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D5BC0613D6
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:24:25 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id v206so7233935qkb.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JVV7qM3fU1nF9mfuasDDO2vc9sskcC4PjPUd+EVxGjg=;
        b=lo50VovLSqQNJahbl53Q8CUmNE1kkghMaPOJ3aQH3zrxWqF19oubxYiN9iqPRpE9Pz
         3aXcUZB55LsbIUo9IwvBnVGk6EIZGg4Dk9PJYZ+7FCNZBZHJQ2Yk0KvAVTIw3z0eLOBk
         QAJGxwX7quWv6p+2Oj5uiU0CBqm7tIkWURQc8kIU14YIcyeUiMa67aokgMY9lYRswSf4
         crnFGrUVKeFxudad8+y56XZtjIZFh8OskyD24K01ljmmiV8RC2o+pyJj1oyhfgCH0/vZ
         ynCf7wLShT1PObxeF1lNWTKcRDon66PU6WR+qHPMLFLoqZGeC9HRbBLy108JF3gh9rBp
         IE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JVV7qM3fU1nF9mfuasDDO2vc9sskcC4PjPUd+EVxGjg=;
        b=G96vGPhkIX/AOpTP+086+dBPV9FKwCIdyMd5HsqXE+EDbaKkGDsQv43v14Xe9BB/wx
         smod87bWETCgTF6cZrkFIl+B3pbKyBV72AcQwZqWAATPOVmemt+GKjUxw9i33CTGZS+V
         SKfQBiDQM6Z2KZ/WFT32SvF1G17o3F6bgTtxkMfwGbw8//J8QcbBrhCStSdsXb/iwIsR
         4m7NtxYKXIifF5cvz6HzlOTAgnjbnUNIUpuv0DPHfeKdzn/OJpwbqS6S9W7drJeafFeQ
         7Szb00LEhKyaGWR02J/h1lnQ3hx8BITvfi3jnShDeDuIF7Fl2PNJo0uqrruwugM//18l
         QZ5g==
X-Gm-Message-State: AOAM533N1GCaR/EyxRhySDW+c9yvzUQuK2pJDc9V/T5eSpWlMFrjIPeO
        rkwBlJMNyA57BO1wn2AObb8Y7x6JqdosMw==
X-Google-Smtp-Source: ABdhPJydKT0Nd0+InAdzU5iAk6idFw+Ak5LCa59VXG44Jw63Syo5EcfXGGNbyJzPkOQTWVau6I1eIA==
X-Received: by 2002:a37:d247:: with SMTP id f68mr5569695qkj.187.1613413464772;
        Mon, 15 Feb 2021 10:24:24 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id o5sm12305716qkh.59.2021.02.15.10.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 10:24:24 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2 2/2] checkout-index: omit entries with no tempname from --temp output
Date:   Mon, 15 Feb 2021 15:24:13 -0300
Message-Id: <6ece1947c1781ee24a3a72f89a1cba39a5ebec37.1613411136.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1613411136.git.matheus.bernardino@usp.br>
References: <cover.1613411136.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With --temp (or --stage=all, which implies --temp), checkout-index
writes a list to stdout associating temporary file names to the entries'
names. But if it fails to write an entry, and the failure happens before
even assigning a temporary filename to that entry, we get an odd output
line. This can be seen when trying to check out a symlink whose blob is
missing:

$ missing_blob=$(git hash-object --stdin </dev/null)
$ git update-index --add --cacheinfo 120000,$missing_blob,foo
$ git checkout-index --temp foo
error: unable to read sha1 file of foo (e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
        foo

The 'TAB foo' line is not much useful and it might break scripts that
expect the 'tempname TAB foo' output. So let's omit such entries from
the stdout list (but leaving the error message on stderr).

We could also consider omitting _all_ failed entries from the output
list, but that's probably not a good idea as the associated tempfiles
may have been created even when checkout failed, so scripts may want to
use the output list for cleanup.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/checkout-index.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 4bbfc92dce..023e49e271 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -23,22 +23,35 @@ static struct checkout state = CHECKOUT_INIT;
 static void write_tempfile_record(const char *name, const char *prefix)
 {
 	int i;
+	int have_tempname = 0;
 
 	if (CHECKOUT_ALL == checkout_stage) {
-		for (i = 1; i < 4; i++) {
-			if (i > 1)
-				putchar(' ');
-			if (topath[i][0])
-				fputs(topath[i], stdout);
-			else
-				putchar('.');
+		for (i = 1; i < 4; i++)
+			if (topath[i][0]) {
+				have_tempname = 1;
+				break;
+			}
+
+		if (have_tempname) {
+			for (i = 1; i < 4; i++) {
+				if (i > 1)
+					putchar(' ');
+				if (topath[i][0])
+					fputs(topath[i], stdout);
+				else
+					putchar('.');
+			}
 		}
-	} else
+	} else if (topath[checkout_stage][0]) {
+		have_tempname = 1;
 		fputs(topath[checkout_stage], stdout);
+	}
 
-	putchar('\t');
-	write_name_quoted_relative(name, prefix, stdout,
-				   nul_term_line ? '\0' : '\n');
+	if (have_tempname) {
+		putchar('\t');
+		write_name_quoted_relative(name, prefix, stdout,
+					   nul_term_line ? '\0' : '\n');
+	}
 
 	for (i = 0; i < 4; i++) {
 		topath[i][0] = 0;
-- 
2.29.2

