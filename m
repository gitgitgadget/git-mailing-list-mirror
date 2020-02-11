Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466E8C352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD0124672
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9o3Vb6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgBKREQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:04:16 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46707 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbgBKREQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 12:04:16 -0500
Received: by mail-pl1-f196.google.com with SMTP id y8so4482688pll.13
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 09:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8khMHwW0qGf038t5of7w9n+7CsttWrnssxWUklRBUGk=;
        b=Y9o3Vb6DHEuvISTTONM0gb7OhN8Bx/5+oo4E3iL9EOma9yHfGNpQrT/6LmtFceXv6D
         PZbbmU1bI22WGcZlVui/7KgoCASD+sOyO+lvlrBo90B28NUskcMUoMSbqnC8ZUC212E1
         QVbfrPcaCrT00PAi+E1ybQF4c1rd02lINmE2TpNu6GpUpQkxcQu+Kjuo7Bgvmrc7V2fA
         tmE4aHQTtgObKgZV7l8Rxts4+fAVmJ3UX2UwArOk5En4J7hg/XadB3f2Z8FmRLzPAspZ
         wSkjMr/1CeBASURLmNfnCmHl9I4FIN85jLb+xKYQ1KQ92APAvEQZ74TL4dgbj6HZXFtP
         c2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8khMHwW0qGf038t5of7w9n+7CsttWrnssxWUklRBUGk=;
        b=XAT7YSyfZd0/rbRjLKni8fzUcZxUHMuNShIOD5yAeOsn/SiwkreNl2YYm/GuVTzN59
         YOVDZl9W6HVqXn0BAMbR9XKC8DNrNOpp1mf/QXSlJGQxSAJOcl9wMkK/KW5um3scssMv
         X7Vkoaxur7dYfQGefkG0kSHAIdVS5cAKjSOE93p+Hzmqn5BzwimQlNDqePD/FDtDMIV/
         7FYYaGA4R7KOTGCau5Jk/Lqj87S/F3/1TsF3HxboxnK33Y4us7OdV3xo6EZbip6hTLpJ
         q9LpQ6cbrbL324tiK8lZsBhBCmYhtHGx0YMiqqMLJq5RUs6RSIXD1ts0EzkL/X0QowFt
         P++w==
X-Gm-Message-State: APjAAAWsQtYuSuBdR3aagQfZOi80yIySjDnH+pisqIeZCjVf4ND0MpHZ
        cGVEcTGZVc+Qy2FHxOb+K6cZknmNRDRdHA==
X-Google-Smtp-Source: APXvYqxZHTZXhDjulyHhyFjhOGJL0T5ALoTiqqfs0g/pT++tBNZ7HIMYV5x6OkibUjg9iHLmEyiQKA==
X-Received: by 2002:a17:902:9687:: with SMTP id n7mr4042849plp.33.1581440653352;
        Tue, 11 Feb 2020 09:04:13 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.172])
        by smtp.gmail.com with ESMTPSA id g2sm4737462pgn.59.2020.02.11.09.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 09:04:12 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        peff@peff.net, chriscool@tuxfamily.org
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 1/1][RFC][GSoC] submodule: using 'is_writing_gitmodules_ok()' for a stricter check
Date:   Tue, 11 Feb 2020 22:33:59 +0530
Message-Id: <20200211170359.31835-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200211170359.31835-1-shouryashukla.oo@gmail.com>
References: <20200211170359.31835-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The if conditions of the functions 'update_path_in_gitmodules()'
and 'remove_path_from_gitmodules()' are not catering to every
condition encountered by the function. On detailed observation,
one can notice that .gitmodules cannot be changed (i.e. removal
of a path or updation of a path) until these conditions are satisfied:

    1. The file exists
    2. The file, if it does not exist, should be absent from
       the index and other branches as well.
    3. There should not be any unmerged changes in the file.
    4. The submodules do not exist or if the submodule name
       does not match.

Only the conditions 1, 3 and 4 were being satisfied earlier. Now
on changing the if statement in one of the places, the condition
2 is satisfied as well.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 submodule.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 3a184b66ab..f7836a6851 100644
--- a/submodule.c
+++ b/submodule.c
@@ -107,7 +107,13 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	const struct submodule *submodule;
 	int ret;
 
-	if (!file_exists(GITMODULES_FILE)) /* Do nothing without .gitmodules */
+	/* If .gitmodules file is not safe to write(update a path) i.e.
+	 * if it does not exist or if it is not present in the working tree
+	 * but lies in the index or in the current branch.
+	 * The function 'is_writing_gitmodules_ok()' checks for the same.
+	 * and exits with failure if above conditions are not satisfied
+	*/
+	if (is_writing_gitmodules_ok())
 		return -1;
 
 	if (is_gitmodules_unmerged(the_repository->index))
@@ -136,7 +142,13 @@ int remove_path_from_gitmodules(const char *path)
 	struct strbuf sect = STRBUF_INIT;
 	const struct submodule *submodule;
 
-	if (!file_exists(GITMODULES_FILE)) /* Do nothing without .gitmodules */
+	/* If .gitmodules file is not safe to write(remove a path) i.e.
+	 * if it does not exist or if it is not present in the working tree
+	 * but lies in the index or in the current branch.
+	 * The function 'is_writing_gitmodules_ok()' checks for the same.
+	 * and exits with failure if above conditions are not satisfied
+	*/
+	if (is_writing_gitmodules_ok())
 		return -1;
 
 	if (is_gitmodules_unmerged(the_repository->index))
-- 
2.20.1

