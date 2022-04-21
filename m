Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928C0C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 20:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392269AbiDUURk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392258AbiDUURe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 16:17:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF27E3ED04
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:14:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so6599491wmb.4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1cj3i3A0VAQpHlvrWYX1jw1uy5JzgitcbZw9J8lE3LM=;
        b=BQlDlodP7mTqc0Sf4hgLOmczK7a9sqCn7gqRNf7mKgfIE8IaRqYHoz7rsUSCrgKt0u
         hvJBBXjIo5Gp0CP2d6dCHcA4BqYT7v7pTxEMA3C5H33BobQQz8FhGofOo94Fpy0JQCTi
         1H9yiVkdyD+xLbnidkq7XHN6v2tpfXKhsQT8pRDAF0gF2f2ImyvDXLLwi73kwCoUY/Gl
         G1G4EToujqhpTSBmFBuQwOrtIDmrRA87F7u3qtuQRAVwVt8PCW4/gF3rQIs7s0ml5AWC
         FXA3cm5WXk2QPa31aYyr0bpp4oT3RjpZk6crpxyOiqZ7zfYIfrvilp9eWge0zeBCcBqt
         0Uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1cj3i3A0VAQpHlvrWYX1jw1uy5JzgitcbZw9J8lE3LM=;
        b=6I5+vePDsKSg77aAHR0VZmwjQUQxJc9RfQtw5ZEGkhFtLJS1bLPwcg3RDg4/omA9Ex
         ffQZt5N1zxmyGU3ZP53fu8MlasNV1LfLGuf4pLYl6NIkI4y0TI5Yj4hOLps3w8KD7NXg
         14Ex/YV7uRuecFZGfsPoynSlSl25IS4GnttrCKJwKchCXg1Ou7V7TXwHK8zGFA5kNxPx
         nlP9JYi8ge6dEoLza9fxYkjG4M6Y4gwe3hnI0wtVf+6Vmdp3u0eoqjf4h8XVuCFZBrhp
         Qr70B/4hqELCVuMUOVUUbrN2a7773MwsxqrQsCsiPLbEr9yZGel+nIa6D7Bo3NtH3sXw
         6IRA==
X-Gm-Message-State: AOAM53256vpqiw7zpMscu7PyzWte9dokOlxjLGHHvB/Bm5klAis+yfUM
        nDp+P5qC8QNaVxxOhgswbMEIYKAPxs2CEA==
X-Google-Smtp-Source: ABdhPJyzTIvGBoUCwxw/2TRjEBkIaBc8cFoecQpyvVzFMVGPf/1tPhnAm215ZWwmXkJ3i7YFP4jmKw==
X-Received: by 2002:a05:600c:4e01:b0:392:ab42:48 with SMTP id b1-20020a05600c4e0100b00392ab420048mr899136wmq.169.1650572082278;
        Thu, 21 Apr 2022 13:14:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b0038eb8171fa5sm1309wme.1.2022.04.21.13.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 13:14:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/4] commit-graph.c: don't assume that stat() succeeds
Date:   Thu, 21 Apr 2022 22:14:36 +0200
Message-Id: <patch-3.4-fadaa08a3ff-20220421T200733Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.gd068ac2c328
In-Reply-To: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix code added in 8d84097f965 (commit-graph: expire commit-graph
files, 2019-06-18) to check the return value of the stat() system
call. Not doing so caused us to use uninitialized memory in the "Bloom
generation is limited by --max-new-filters" test in
t4216-log-bloom.sh:

	+ rm -f trace.event
	+ pwd
	+ GIT_TRACE2_EVENT=[...]/t/trash directory.t4216-log-bloom/limits/trace.event git commit-graph write --reachable --split=replace --changed-paths --max-new-filters=2
	==24835== Syscall param utimensat(times[0].tv_sec) points to uninitialised byte(s)
	==24835==    at 0x499E65A: __utimensat64_helper (utimensat.c:34)
	==24835==    by 0x4999142: utime (utime.c:36)
	==24835==    by 0x552BE0: mark_commit_graphs (commit-graph.c:2213)
	==24835==    by 0x550822: write_commit_graph (commit-graph.c:2424)
	==24835==    by 0x54E3A0: write_commit_graph_reachable (commit-graph.c:1681)
	==24835==    by 0x4374BB: graph_write (commit-graph.c:269)
	==24835==    by 0x436F7D: cmd_commit_graph (commit-graph.c:326)
	==24835==    by 0x407B9A: run_builtin (git.c:465)
	==24835==    by 0x406651: handle_builtin (git.c:719)
	==24835==    by 0x407575: run_argv (git.c:786)
	==24835==    by 0x406410: cmd_main (git.c:917)
	==24835==    by 0x511F09: main (common-main.c:56)
	==24835==  Address 0x1ffeffde70 is on thread 1's stack
	==24835==  in frame #1, created by utime (utime.c:25)
	==24835==  Uninitialised value was created by a stack allocation
	==24835==    at 0x552B50: mark_commit_graphs (commit-graph.c:2201)
	==24835==
	[...]
	error: last command exited with $?=126
	not ok 137 - Bloom generation is limited by --max-new-filters

This would happen as we stat'd the non-existing
".git/objects/info/commit-graph" file. Let's fix mark_commit_graphs()
to check the statu() return value, and while we're at it fix another
case added in the same commit to do the same.

The caller in expire_commit_graphs() would have been less likely to
run into this, as it's operating on files it just got from readdir(),
but it could still happen due to a race with e.g. a concurrent "rm
-rf" of the commit-graph files.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 441b36016ba..2b528187316 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2206,7 +2206,8 @@ static void mark_commit_graphs(struct write_commit_graph_context *ctx)
 		struct stat st;
 		struct utimbuf updated_time;
 
-		stat(ctx->commit_graph_filenames_before[i], &st);
+		if (stat(ctx->commit_graph_filenames_before[i], &st) < 0)
+			continue;
 
 		updated_time.actime = st.st_atime;
 		updated_time.modtime = now;
@@ -2247,7 +2248,8 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 		strbuf_setlen(&path, dirnamelen);
 		strbuf_addstr(&path, de->d_name);
 
-		stat(path.buf, &st);
+		if (stat(path.buf, &st) < 0)
+			continue;
 
 		if (st.st_mtime > expire_time)
 			continue;
-- 
2.36.0.879.gd068ac2c328

