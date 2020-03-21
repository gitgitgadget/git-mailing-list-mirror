Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D10C4332D
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7F120663
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvB0aVcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgCUSAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:00:35 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:41644 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgCUSAW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:00:22 -0400
Received: by mail-ed1-f45.google.com with SMTP id v6so11122653edw.8
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dSPTGkAGt7ySWgJXbc5cd5JZ9k/UQGMAyXV0NOU70Y0=;
        b=CvB0aVcZGMih+xQCg6Qa2zc2tDQiBSS9dZ6IzI9Fqs7R74eDQY2gkNadt01eKn17dS
         lJXEeaXofblvRYS8JTiFt0EvFkRbrWaV/NcFfcFYoBoD31edmKbt+UthCV2UFNunyoX8
         /oguBUHSLt86yYEL5cSs9gCZ6WNEB1ie/cfhJmvyTplfT3XTEe2+ubTb89Ct7RtWXTh5
         ewWv9MlATQda1oTy7gdk/pcNiMqoCdfGwzrCvlUzF5t0Sa3ZBwoflyYvRZprFDTggPEi
         NFnLbg37QG4jemHzYSJU9junT8AgUcVjAOJ66Gma3uve5iBgn0x3DWNmHuyJ5cbd0iCM
         21qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dSPTGkAGt7ySWgJXbc5cd5JZ9k/UQGMAyXV0NOU70Y0=;
        b=TrYeDWSvVogIdHAAmn5g+8E6+8uearMANUYSgi/0fAJq6pqgZe8NaXIpZ/5d4FO5Sq
         lSmuUWQ/D+1ociDSR4qPYvJyRGIPAzOz8sWZmg0qNpqGV7/H/n2VLKH5MuCeGLMu898l
         QqyANij4ByfpwDvRPPJmOhQBcO5gsKfK/FaX0ePDLG1lxgx8VX9v0OHA2u+xM7B4FX57
         lEdj5sFQwnAV8EvLD4T8XQSutbhqxZszyqZ8JXogN6JqlYmFrZ1qEBRssoFmnB5fmeea
         qsdE+z62zIlB+9R3Pbe+vesitLiSl5u/rFLoC2nKpLIqxI9PT5KLgmds8x1T3vhANYgX
         toAQ==
X-Gm-Message-State: ANhLgQ3p03wuw4IX9PhqkR8Bn0/a6HMCiL0xz/5pVXDDRvlKjDxZrkUa
        XQnJYd4j1D1Um4koMVFO1Vqqj2I7
X-Google-Smtp-Source: ADFU+vvrFcK6UN18M/TZ8yx3D1op0ifF2uCqAMxSeRl9rQE/QBO2X2B7b0ysgEXmXmQNcQFjp91LPQ==
X-Received: by 2002:a05:6402:1c0c:: with SMTP id ck12mr14187278edb.145.1584813619209;
        Sat, 21 Mar 2020 11:00:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x6sm590658ejw.19.2020.03.21.11.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:00:18 -0700 (PDT)
Message-Id: <2ba7bbdaee39fb9b8714fdc1918fa69a20d5d1e0.1584813609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
        <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Mar 2020 18:00:03 +0000
Subject: [PATCH v2 12/18] unpack-trees: move ERROR_WOULD_LOSE_SUBMODULE
 earlier
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

A minor change, but we want to convert the sparse messages to warnings
and this allows us to group warnings and errors.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 12 ++++++------
 unpack-trees.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 6abea555929..5c99d588dc3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -43,15 +43,14 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	/* ERROR_BIND_OVERLAP */
 	"Entry '%s' overlaps with '%s'.  Cannot bind.",
 
+	/* ERROR_WOULD_LOSE_SUBMODULE */
+	"Submodule '%s' cannot checkout new HEAD.",
+
 	/* ERROR_SPARSE_NOT_UPTODATE_FILE */
 	"Entry '%s' not uptodate. Cannot update sparse checkout.",
 
 	/* ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN */
 	"Working tree file '%s' would be overwritten by sparse checkout update.",
-
-
-	/* ERROR_WOULD_LOSE_SUBMODULE */
-	"Submodule '%s' cannot checkout new HEAD.",
 };
 
 #define ERRORMSG(o,type) \
@@ -166,12 +165,13 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	 */
 	msgs[ERROR_BIND_OVERLAP] = _("Entry '%s' overlaps with '%s'.  Cannot bind.");
 
+	msgs[ERROR_WOULD_LOSE_SUBMODULE] =
+		_("Cannot update submodule:\n%s");
+
 	msgs[ERROR_SPARSE_NOT_UPTODATE_FILE] =
 		_("Cannot update sparse checkout: the following entries are not up to date:\n%s");
 	msgs[ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN] =
 		_("The following working tree files would be overwritten by sparse checkout update:\n%s");
-	msgs[ERROR_WOULD_LOSE_SUBMODULE] =
-		_("Cannot update submodule:\n%s");
 
 	opts->show_all_errors = 1;
 	/* rejected paths may not have a static buffer */
diff --git a/unpack-trees.h b/unpack-trees.h
index 2c5d54cae9f..a656bbf810b 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -22,9 +22,9 @@ enum unpack_trees_error_types {
 	ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN,
 	ERROR_WOULD_LOSE_UNTRACKED_REMOVED,
 	ERROR_BIND_OVERLAP,
+	ERROR_WOULD_LOSE_SUBMODULE,
 	ERROR_SPARSE_NOT_UPTODATE_FILE,
 	ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN,
-	ERROR_WOULD_LOSE_SUBMODULE,
 	NB_UNPACK_TREES_ERROR_TYPES
 };
 
-- 
gitgitgadget

