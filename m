Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D96FC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 13:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhLQNaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 08:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhLQNa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 08:30:29 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC3FC061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 05:30:28 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o13so4018354wrs.12
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 05:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rqXWBzhCHQ0dUYwI/TJVAU4PLjuFJwEsubhT9lDlkRs=;
        b=OyxOVH/E2Bs7rxOoY8SyyP8w+rEh7+wu1H0lMZ+oACLOJjc6hOj5IRWIZOa46qjSH+
         mXGLa9o8jbjlMRqp1rf6HSJctlATr2q3kSRo48kKU60SOBbcD01N/l2nqxBil0f8RYP+
         kW7IQvo5rg5UOf8xz5RWpPh+0Nl5oW4J53LnEmimL/eRi3K4XgItN9uJmzyqEG0LEocK
         CahR1x4CALRxdUwVl6tjXqUgI26h5CZH5OBkjFbL1YaCbpmMCCg2Ycbs7jGZtr3oUwp4
         7iK9hiUmvYGIU5pRF4S3znWAmz7dbSlv7alUQIZqx2QnLth8LK7wN6fQSRPMvdk1h+nR
         exGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rqXWBzhCHQ0dUYwI/TJVAU4PLjuFJwEsubhT9lDlkRs=;
        b=luJ+AGcX0FNFFxWbZp+aOpTao6hsm1d2Xb2+FrHtBadrP7BrxvgYObzHPHeDvTYxPI
         RneW4W3SrV2q/BKQbsCGJrweBXotZf4yog4yAH+doSA1msmxsxJYTTzsp4imgJLMiMTs
         DqNiaIPquRpxEDiBPjKxn+IGju3uTxfCaMUuelA8n+p2I71ttVJTVY2ucO2CUWx00M/L
         bTu8UFwy9A2JHAejbskc/3oPknXhgfVXxiw33955pNVWt2TL2VxSbf+nkpM5e04ZsKt7
         IfSuNQEXQz6YWxpZMl9hcV9gwAF1t2AajHEFPCzN4o0l3wIsDyGwY3llzXSYbV8BZDaZ
         gJFQ==
X-Gm-Message-State: AOAM533BncaEZbc/50EM/OTS8gYXdHqbk8pc4copVKLTahc11yZbBqwb
        ggYboJjW0fKVgXt/WAFvlE3PhZIyMyvbZw==
X-Google-Smtp-Source: ABdhPJzRFmh5ZgRnyOiTyBGv8CnD6GNwt2vwe1jACcnBSLEEza36NMVrWXrzeWomanYhJCPya5AZBw==
X-Received: by 2002:adf:dcd2:: with SMTP id x18mr2566495wrm.173.1639747826928;
        Fri, 17 Dec 2021 05:30:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b19sm11953993wmb.38.2021.12.17.05.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 05:30:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 1/7] ls-tree: remove commented-out code
Date:   Fri, 17 Dec 2021 14:30:17 +0100
Message-Id: <RFC-patch-1.7-a4778c87c74-20211217T131635Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <RFC-cover-0.7-00000000000-20211217T131635Z-avarab@gmail.com>
References: <cover.1639721750.git.dyroneteng@gmail.com> <RFC-cover-0.7-00000000000-20211217T131635Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove code added in f35a6d3bce7 (Teach core object handling functions
about gitlinks, 2007-04-09), later patched in 7d0b18a4da1 (Add output
flushing before fork(), 2008-08-04), and then finally ending up in its
current form in d3bee161fef (tree.c: allow read_tree_recursive() to
traverse gitlink entries, 2009-01-25). All while being commented-out!

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3a442631c71..5f7c84950ce 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -69,15 +69,6 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	const char *type = blob_type;
 
 	if (S_ISGITLINK(mode)) {
-		/*
-		 * Maybe we want to have some recursive version here?
-		 *
-		 * Something similar to this incomplete example:
-		 *
-		if (show_subprojects(base, baselen, pathname))
-			retval = READ_TREE_RECURSIVE;
-		 *
-		 */
 		type = commit_type;
 	} else if (S_ISDIR(mode)) {
 		if (show_recursive(base->buf, base->len, pathname)) {
-- 
2.34.1.1119.g7a3fc8778ee

