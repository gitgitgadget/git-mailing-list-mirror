Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C1FC4345B
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 23:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C904721473
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 23:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WFgg0YAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgGPXJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgGPXJV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 19:09:21 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF78AC08C5FA
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 15:57:30 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id x184so6538898pgb.7
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 15:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Fs1c5WQB4p6RwJfVn/AIkLelkurUnuytZ+pXECXTTUE=;
        b=WFgg0YAjVM+hoyOKRAGq/iZg1ssYtDGSy4t1EMvMDATDTtk17QLixG2lSKck6p/iLh
         vB1ofZ7pXV2cKEUDT8Ij2RjVR12okpkf/vDmaLV9f3h4Jw9qL06beZiCe2+zPCWxrNGt
         qi5S0Y5fA0QYspcml+4CQrsOQ1O/AuwWvmeo9+WK9v2H4VSp+5kGR7MrCYg8YQLTQ/hz
         wuNgYXwsndrHzcgmzj3H8X0ujiEXOuS+YcKsYMa6jmXTduSexvWIJyIsKiG/57c/yopQ
         CvD1gCx06ZZSFUR37cDWn/aGfURPr1+48BJmNCqulniW4ScS/AEuDK/ix7KD+DObfX+l
         TxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Fs1c5WQB4p6RwJfVn/AIkLelkurUnuytZ+pXECXTTUE=;
        b=q+kFravzfCR893GI/QFE1FJWl5q6gUZpXh5Y/XEtClDg2UWNKkcPuBBQDm+Hc5spzB
         KpQaK1fDgg5pxgTF7kAdz5Vw0EOuOodPeAObavcN/sIpqgM1Mqbku7hbCjD7cPqyDqQ5
         pQkDKso0kJaV06fgaVsztHaZX11ztZsMYQw3vxfT0tae26ab4C7PDBUPmHrUokEvxY8/
         d5jxnj5kNyAoxcEW2m/Em/0+AEfDp+tie6SbLe2Jku1mo7f1OQkQpcFrmtsW5WfgKvhE
         iyaw8tYs2KAWlMl2Zrj/Ln3bTXDnCKjb+DmQ5uySXoTv2cU4HfFXqhxx6Q0jpJpmo3zk
         GOgw==
X-Gm-Message-State: AOAM533xxhTuTFtfqBgxeY0pr1MPaB0nIU90g5IgX/NyLVlaF3cOx4Eu
        BdmRN+RAfgpHJTBhqJup3uOKF1LQMwQtl+K/z2AV+XWySgBTiiwYgQWgTq6C90h0KZzGAAeY4MP
        zO3I+whtPa5q/Mrfu2+7Dvc98ppAt6E4ywKOekiPuwhurdutDYEBL9/rUVnQyLD1mIQbXJggrlP
        n/
X-Google-Smtp-Source: ABdhPJyVrW9B8qWgOk1B+ttgnUYmrdudcSPweonn6b5Rh+mezbRrWBsKu8uihvzXTVNSuBHF4KvClJpFBUSfxIKOMCvl
X-Received: by 2002:a17:90a:ff09:: with SMTP id ce9mr6602948pjb.149.1594940249678;
 Thu, 16 Jul 2020 15:57:29 -0700 (PDT)
Date:   Thu, 16 Jul 2020 15:57:25 -0700
In-Reply-To: <92b218ca-f2b4-db9d-9f9c-1d071ea4fa97@gmail.com>
Message-Id: <20200716225725.4143039-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <92b218ca-f2b4-db9d-9f9c-1d071ea4fa97@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [FYI] commit-graph: trace expiry of commit graph links
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an obsolete link in the commit graph chain is deleted, and trace2
is enabled, trace a message that it is deleted, along with the list of
links before and after the current chain refresh.

The messages are emitted using trace2_data_string() and not
trace2_printf() because the latter is not implemented for some trace
targets.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This patch is just for informational purposes for people who have the
same problem and/or want to help diagnose.

I've tested that this produces the expected trace2 messages using:

  git commit-graph write --reachable --split=replace

> It is _possible_ that something like a case switch or a symlink
> could be causing a problem here. That's where I would look on
> the affected systems.

Indeed a symlink is present - the affected repositories are using the
git-repo [1] local mirror feature, which causes .git/objects (among
other things) to be a symlink - but I couldn't figure out how this
symlink would cause problems. In particular, looking at the code, all
relevant filenames seem to be constructed from ctx->odb->path, so no
matter which names were used to get to the object directory, all names
are built from those names, and this seems to be true in practice as
well.

So I've added some trace2 messages (in this patch), and let's see if I
can figure out what's going on. I'll write back if I find something.

[1] https://gerrit.googlesource.com/git-repo
---
 commit-graph.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 328ab06fd4..b5bd2ac6de 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2009,6 +2009,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	struct dirent *de;
 	size_t dirnamelen;
 	timestamp_t expire_time = time(NULL);
+	int commit_graph_deleted = 0;
 
 	if (ctx->split_opts && ctx->split_opts->expire_time)
 		expire_time = ctx->split_opts->expire_time;
@@ -2050,8 +2051,38 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 			}
 		}
 
-		if (!found)
+		if (!found) {
+			if (trace2_is_enabled()) {
+				struct strbuf message = STRBUF_INIT;
+
+				strbuf_addf(&message, "Deleting '%s' because it is not in [", path.buf);
+				for (i = 0; i < ctx->num_commit_graphs_after; i++) {
+					if (i != 0)
+						strbuf_addstr(&message, ", ");
+					strbuf_addf(&message, "'%s'", ctx->commit_graph_filenames_after[i]);
+				}
+				strbuf_addstr(&message, "]");
+				trace2_data_string("commit-graph", the_repository, "graph-deletion", message.buf);
+				strbuf_release(&message);
+				commit_graph_deleted = 1;
+			}
 			unlink(path.buf);
+		}
+	}
+
+	if (commit_graph_deleted) {
+		struct strbuf message = STRBUF_INIT;
+		uint32_t i;
+
+		strbuf_addstr(&message, "The commit graphs before were [");
+		for (i = 0; i < ctx->num_commit_graphs_before; i++) {
+			if (i != 0)
+				strbuf_addstr(&message, ", ");
+			strbuf_addf(&message, "'%s'", ctx->commit_graph_filenames_before[i]);
+		}
+		strbuf_addstr(&message, "]");
+		trace2_data_string("commit-graph", the_repository, "graph-before", message.buf);
+		strbuf_release(&message);
 	}
 
 out:
-- 
2.28.0.rc0.105.gf9edc3c819-goog

