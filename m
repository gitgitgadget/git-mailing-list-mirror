Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEACC433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 01:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE8120725
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 01:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFVFSGOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGJBm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 21:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgGJBm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 21:42:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDF8C08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 18:42:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d202so5219017ybh.12
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 18:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l00D2au9AWaFDLzFh3ZmluXyE56PEX52Fo0+P0rfrd4=;
        b=BFVFSGOqjmya5E0sdal2UP82VZfQVKV/5CZNBbAJ2cXg+TNA2ibZjj+AoSk5M79Cxz
         +6D4DKA+MXRs0Uj1NMSOm3abmuRxij9MVIkPjy5HztHp+idLwpybD/medGPwIyv8UnFj
         Vp0KO/XuIZDv1jKlIYYZ8TjYEL68txi91vgDjt475HWLX7ruvWPM3xT+M89Aky2vDU/f
         J+0Kmif+ehBJLlTpU1RjO04izCs94ug+teIiB9Ct/if2Est2SeMs/8JL2D1XwwAOQggz
         WJp498POqxBRtR8Uf70sFAFX5wZg88QdsB/OBbHAvPcpyDtOv1ON7bJqHB5SLa9e6WkZ
         UxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l00D2au9AWaFDLzFh3ZmluXyE56PEX52Fo0+P0rfrd4=;
        b=VXlu5zM54pU2+tToyvuyzfD1hy+1Fqmss9OQtfwcCaupFPhiVme/MteoUddwhQ87zD
         M9IT8Qq+vH3ywJric7yxwZzxKQy1Wn2mQtJf3cYYctqPp0Rzh5CnBc2cBMqKPLH7m4x4
         htsLYXe2ZEZkjzfj8lA8K+JmvIaM/mOzB0IgQFjZPncEogCDvVwuQ38mV4mmSYwwMPK8
         CXbYAdIwGr9sDyOv5LAtqiBZFu4luF7+WfxSYdLEdMR3bQyF8XRrSfvZAE0oJlpyBCdq
         5CBg1BWnaWWY7VepagLVPYnlAB4nzjSgal1kRQJPgWUbsGmoPDFczz6rNHdJFqwky2DM
         10Kw==
X-Gm-Message-State: AOAM531n/1pFCRbzTfaDaHSvMXggFxyJiNVEaC1jV0cF/hhzV6FhB9y8
        OKfpB3isLScmhlQAA7bYBJdrgWEn+A7XD0au3tOUc/jXwBwhDojqJRZyuhrQDel5skSCDJ94HvR
        JK77cJkYnDWQyFxsS6mawV6JAT6b8fni0xXRtqTSF4Awoc99I/16bNzpvghcLp/DnZXqgttV84Q
        ==
X-Google-Smtp-Source: ABdhPJxTpa2z9UDSuKfDaiqJeTrnyDa0E926ntSNzhbcySuKAtA7D75T0vsVP5sd+ZPn1iJ8BbHlQnKvX+ttHA9UoK4=
X-Received: by 2002:a25:38c5:: with SMTP id f188mr110651094yba.332.1594345375093;
 Thu, 09 Jul 2020 18:42:55 -0700 (PDT)
Date:   Thu,  9 Jul 2020 18:42:42 -0700
In-Reply-To: <20200710014242.1088216-1-emilyshaffer@google.com>
Message-Id: <20200710014242.1088216-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200710014242.1088216-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH 2/2] progress: remove redundant null-checking
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

display_progress() and stop_progress() are tolerant to NULL inputs.
Remove some places where redundant checks are performed before these
NULL-tolerant functions are called.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/commit-graph.c | 3 +--
 commit-graph.c         | 3 +--
 read-cache.c           | 9 +++------
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index ae4dc2dfcd..7964de3126 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -263,8 +263,7 @@ static int graph_write(int argc, const char **argv)
 cleanup:
 	string_list_clear(&pack_indexes, 0);
 	strbuf_release(&buf);
-	if (progress)
-		stop_progress(&progress);
+	stop_progress(&progress);
 	return result;
 }
 
diff --git a/commit-graph.c b/commit-graph.c
index b9a784fece..30d9a75932 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1424,8 +1424,7 @@ int write_commit_graph_reachable(struct object_directory *odb,
 				    flags, split_opts);
 
 	oidset_clear(&commits);
-	if (data.progress)
-		stop_progress(&data.progress);
+	stop_progress(&data.progress);
 	return result;
 }
 
diff --git a/read-cache.c b/read-cache.c
index 2ddc422dbd..feb7abe37a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1581,8 +1581,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		new_entry = refresh_cache_ent(istate, ce, options, &cache_errno, &changed);
 		if (new_entry == ce)
 			continue;
-		if (progress)
-			display_progress(progress, i);
+		display_progress(progress, i);
 		if (!new_entry) {
 			const char *fmt;
 
@@ -1614,10 +1613,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 
 		replace_index_entry(istate, i, new_entry);
 	}
-	if (progress) {
-		display_progress(progress, istate->cache_nr);
-		stop_progress(&progress);
-	}
+	display_progress(progress, istate->cache_nr);
+	stop_progress(&progress);
 	trace_performance_leave("refresh index");
 	return has_errors;
 }
-- 
2.27.0.383.g050319c2ae-goog

