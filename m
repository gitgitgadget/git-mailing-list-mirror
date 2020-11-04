Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A10C4742C
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 15:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30212074B
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 15:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmsnTF5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbgKDP3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730381AbgKDP3s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 10:29:48 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64916C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 07:29:48 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 33so11691244wrl.7
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 07:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ehdXjR7D2CjFEqsLmND7I0tV/HMIGU+V+ilDD5COgc8=;
        b=nmsnTF5NVNCY3R0c4C1ewe78AcqiH5IcjHpkGQHQ1NEWXrMv9Zd4xHjwKMS5SUPTAe
         4lDs/RDFNdI1c/TIbkccjefotroCxlZFUDVyJCWDzYAYHlaJZdPmuRgdFpuQc9yUWkyh
         LbfGbX03cN/bbICai8oajNhGUEnJWb86eBzf9ubBAbzgnKpH3r9wu1yDuk/wo/vvT93O
         p9ltULn9gPPD1sYI4aB91xtqTrUtPM5djwrekIY3JGiwPMbofw1Spx0JcZpdSpreHGrb
         Dvyy4vwoII4C/dzSLAcX0CNuyjwJ7F3ZkYbN6X2m6REgHTzrWi51/75SgUE1eu8Y1uap
         RXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ehdXjR7D2CjFEqsLmND7I0tV/HMIGU+V+ilDD5COgc8=;
        b=IOIxpQWqY+TdrJ1PfS3jWv65FRi7IVIev6sWiCD/P32QjXb5C4tlzqofrxFBhwPvEw
         a2crEHWKNv/oDmwIebPrp0PBizfvNsLDpe3tf4Vn8HxD2L1+J3cXWf4P9+L9LT/vLF4W
         bmzB4yp0UN+71Z0poMbrd8LtmFYvPVUdBIwBBK+ayjTBUOsFyvOy5cOhu80TMQAR0d5U
         Bj6h6oEWAM8+/jX7h6Ujd1SObAJ9SRBgBd3NlkWL0sFMzQ/Vd2A7yLX0jlF0ugXHyofw
         /nMU4L6T1m9kep9JM2H4OTSL+ynYBo612rDDuYTAJDUhDF2mDaHWJrxZZrMSJeXtE1EX
         zS5A==
X-Gm-Message-State: AOAM531zZXC4N5Ld134Cf7eLfJWWGG9ekvXkg5QXP66niHhQV6HsTRM9
        nW+Etd2prlbxgSVEVh/FkJQsq61/51E=
X-Google-Smtp-Source: ABdhPJwdIkkNFfKLIViKn6IPSfQnMAGrwSHKD/9g6yvjomMwAnG0VmvSqx9ILhQMfzNj4sTigFFaHg==
X-Received: by 2002:a5d:4103:: with SMTP id l3mr32815826wrp.260.1604503786927;
        Wed, 04 Nov 2020 07:29:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm2939007wrt.88.2020.11.04.07.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 07:29:46 -0800 (PST)
Message-Id: <faae3ccff53b83aac3b8998fc5259f319fd80fc4.1604503780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.773.v2.git.1604503780.gitgitgadget@gmail.com>
References: <pull.773.git.1603807337.gitgitgadget@gmail.com>
        <pull.773.v2.git.1604503780.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Nov 2020 15:29:40 +0000
Subject: [PATCH v2 4/4] rebase -i: simplify get_revision_ranges()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Now that all the external users of head_hash have been converted to
use a opts->orig_head instead we can stop returning head_hash from
get_revision_ranges().

Because we want to pass the full object names back to the caller in
`revisions` the find_unique_abbrev_r() call that was used to initialize
`head_hash` is replaced with oid_to_hex().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 28e7b7f5ce..17450e9d9e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -270,15 +270,14 @@ static int edit_todo_file(unsigned flags)
 }
 
 static int get_revision_ranges(struct commit *upstream, struct commit *onto,
-			       struct object_id *orig_head, char *head_hash,
-			       char **revisions, char **shortrevisions)
+			       struct object_id *orig_head, char **revisions,
+			       char **shortrevisions)
 {
 	struct commit *base_rev = upstream ? upstream : onto;
 	const char *shorthead;
 
-	find_unique_abbrev_r(head_hash, orig_head, GIT_MAX_HEXSZ);
 	*revisions = xstrfmt("%s...%s", oid_to_hex(&base_rev->object.oid),
-						   head_hash);
+			     oid_to_hex(orig_head));
 
 	shorthead = find_unique_abbrev(orig_head, DEFAULT_ABBREV);
 
@@ -328,7 +327,6 @@ static void split_exec_commands(const char *cmd, struct string_list *commands)
 static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 {
 	int ret;
-	char head_hash[GIT_MAX_HEXSZ];
 	char *revisions = NULL, *shortrevisions = NULL;
 	struct strvec make_script_args = STRVEC_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -336,7 +334,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	struct string_list commands = STRING_LIST_INIT_DUP;
 
 	if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head,
-				head_hash, &revisions, &shortrevisions))
+				&revisions, &shortrevisions))
 		return -1;
 
 	if (init_basic_state(&replay,
-- 
gitgitgadget
