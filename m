Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AE2C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 16:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386388AbhLFQOK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388644AbhLFQNj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:13:39 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D093DC00FDF8
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 07:56:05 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso10765213wml.1
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 07:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4Zmi/zzQ7Z2fnIcb8ViOTaN12hJk+N9kU0ajrJ/wfXc=;
        b=pm7fAAXnIeKBbA0/lH9x8TMkupg40P4JHBzpNHH+1pLXciuen0bfRuJLbpnA4AuS2g
         dI9YLjlEfvbsQmusIRlxXtAQ3/ez93UGjK+lxox0e4yRmCTsI32m7xebmL0I+P/I7Cn5
         kvWnt/f5nOKWibFpRaEIH1VYQZsnrhvY0U34xXZLVje5VA23fqNLOWLtrA20emXEo8rj
         Qaqoz1mQ++bHY0qFGwOpt/C6pNNxRPo1a3Lt7kt73Ai3vI3BMf6rnV4WWMyo2jZeOqG1
         etWfzVieqqQebzXrzME/313+bq2IoimiAtdBWTYDavCnyn/9WO9BI/c35TLH4LxhGYI8
         LVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4Zmi/zzQ7Z2fnIcb8ViOTaN12hJk+N9kU0ajrJ/wfXc=;
        b=7Ft03odIYtxVmwUSockJ7k5/yqkT29eleEMjf4EM0iHGPDbLL3eVFk/23oB7mQuyeb
         IXJLZ75M9VYnkcCYyxf6+HjPEGEZIJnON6B4HvKQRaC/W7iBgvrWsKdUT6WCn2XdGJ7R
         bpHATRy+keGpc9CTEKdNf0qQZmx/lbfgoA4ANRtBi2NIWVj54eYAWFVe73+PhPiApQaI
         5J7lf1gdfd+WrCCVgTlbctrCVwJrIspJsL9Nxj774/CZSS9e00mRZrHlawLEGjIrQ34E
         zi2qw0JDpRRjmDJHF7az7Bi9F0TMa5Y0kc99xbXoxchYiFO8+5ICT/JpYyRkUHZenEUl
         AovA==
X-Gm-Message-State: AOAM531sXHfJn4u9FyektC0KEMssEQWXi8A8cnGW+uVurivHthQWS10P
        XHvwixv4MYCnrpYTTixuB5B8gimyvoc=
X-Google-Smtp-Source: ABdhPJxZc+2Fu209qOzh4PnilcGaxOZsXO18TbBad9tyQsGmZ3ZHv17mXeX1tSru6GMc5WOOC7EPqg==
X-Received: by 2002:a05:600c:3584:: with SMTP id p4mr39629944wmq.109.1638806164278;
        Mon, 06 Dec 2021 07:56:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r8sm14452472wrz.43.2021.12.06.07.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:56:03 -0800 (PST)
Message-Id: <f676f03ccb024b9011eff999b342f96cfb76b892.1638806161.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v6.git.1638806161.gitgitgadget@gmail.com>
References: <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
        <pull.1050.v6.git.1638806161.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 15:55:56 +0000
Subject: [PATCH v6 2/7] commit-graph: return if there is no git directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Return early if git directory does not exist. This will protect against
test failures in the upcoming change to BUG in prepare_repo_settings if no
git directory exists.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
---
 commit-graph.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 2706683acfe..265c010122e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -632,10 +632,13 @@ static int prepare_commit_graph(struct repository *r)
 	struct object_directory *odb;
 
 	/*
+	 * Early return if there is no git dir or if the commit graph is
+	 * disabled.
+	 *
 	 * This must come before the "already attempted?" check below, because
 	 * we want to disable even an already-loaded graph file.
 	 */
-	if (r->commit_graph_disabled)
+	if (!r->gitdir || r->commit_graph_disabled)
 		return 0;
 
 	if (r->objects->commit_graph_attempted)
-- 
gitgitgadget

