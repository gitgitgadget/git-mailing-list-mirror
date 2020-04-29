Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A64C83009
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B714520757
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="CP3NWIMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgD2Rgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2Rgq (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 13:36:46 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABBCC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 10:36:45 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r4so1347308pgg.4
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IBNnROhPpGuZCkZjhUSkzDnwnuE98m7A7rwPIhTf4UI=;
        b=CP3NWIMHnoEG+utDm2+QRFrIGzLvuxaQjvxRoWKVDyDNGMpQ5MGdNOrGjZpsAPGk2K
         L8j7H6Y3kpcWk9Prt+6Y0JYBuQNYhhNEvHtYm8bwk3eM7p0F7F8cOMHwlsb4jHXdr31e
         Zew3Ot2qK06RTKm5CH1CykbjQe9EsQxbe4N2FAMMJ6+id1gqP71CzT+RhMNqAckxeTyh
         czWtCQYYJfGW/9iMKmLIMJFS0J8t/J7ruXeATvxvCKZOK+mxs2xTC0g3dSNgjuwxA2nK
         qNcpi5XH6omG0oFALxxsdqnLo1/ePQ6lzslnL5JMdL3ko8ZF+Qf/nfnBn8TIMLMSg/Ak
         2RHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IBNnROhPpGuZCkZjhUSkzDnwnuE98m7A7rwPIhTf4UI=;
        b=ndKvTIjjWbnubCbpOxvQmHm/G9UYTEdwIgg7Fi0dMKX+bXv+VPgLv46NyQ1YGZiLii
         kaLhbfyF4ru2PE5RP3bzt3yUvNVx0YpLWHMbi3YBm/MRcoJvpj4WntQgkllBkrt6XAQO
         wyf7AT1eMvqwfOkZneUDSkaDbFcxWtfqQxI+YDlkpeuexyP98XVbVQ9mDuyjtvcNArpo
         eybfXEzsx16X+Nt4ALAs/U0dT9s1R7vUt1r0s2F/CCxAGKcjmmQIeZdYRXRMYFqusdxh
         gsVe+KR4i/x9XZKzvvy0JZKx5JXGlEz/y9m7cmuxBPzEGMsTW/W/yscuidez8eX+j1ML
         1lnw==
X-Gm-Message-State: AGi0Pubz7I1hjIw7foqoRibtebUiJNkKqNBjNNela8o2Itd3uwPuO4Mu
        B692IzgTu2G1nNxI/sji8aNeDv612tcoUQ==
X-Google-Smtp-Source: APiQypI/7gBVswQ+CjkWrcckeZkaUC6ZMvdCwJj17xrIkm+/kl2GGiTuYQeHc/0ljcwp/A0GeuJivQ==
X-Received: by 2002:a63:214a:: with SMTP id s10mr32300335pgm.98.1588181804391;
        Wed, 29 Apr 2020 10:36:44 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id x12sm1497505pfq.209.2020.04.29.10.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:36:43 -0700 (PDT)
Date:   Wed, 29 Apr 2020 11:36:42 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        mhagger@alum.mit.edu
Subject: [PATCH v3 4/5] commit-graph.c: ensure graph layers respect
 core.sharedRepository
Message-ID: <4b74e23af2ac9e65449e383161f7b7cdabf983ba.1588181626.git.me@ttaylorr.com>
References: <cover.1587422630.git.me@ttaylorr.com>
 <cover.1588181626.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588181626.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Non-layered commit-graphs use 'adjust_shared_perm' to make the
commit-graph file readable (or not) to a combination of the user, group,
and others.

Call 'adjust_shared_perm' for split-graph layers to make sure that these
also respect 'core.sharedRepository'. The 'commit-graph-chain' file
already respects this configuration since it uses
'hold_lock_file_for_update' (which calls 'adjust_shared_perm' eventually
in 'create_tempfile_mode').

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c                |  6 ++++++
 t/t5324-split-commit-graph.sh | 22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 5b5047a7dd..d05a55901d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1386,6 +1386,12 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			return -1;
 		}
 
+		if (adjust_shared_perm(ctx->graph_name)) {
+			error(_("unable to adjust shared permissions for '%s'"),
+			      ctx->graph_name);
+			return -1;
+		}
+
 		f = hashfd(fd, ctx->graph_name);
 	} else {
 		hold_lock_file_for_update_mode(&lk, ctx->graph_name,
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 53b2e6b455..699c23d077 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -36,6 +36,10 @@ graph_read_expect() {
 	test_cmp expect output
 }
 
+test_expect_success POSIXPERM 'tweak umask for modebit tests' '
+	umask 022
+'
+
 test_expect_success 'create commits and write commit-graph' '
 	for i in $(test_seq 3)
 	do
@@ -351,4 +355,22 @@ test_expect_success 'split across alternate where alternate is not split' '
 	test_cmp commit-graph .git/objects/info/commit-graph
 '
 
+while read mode modebits
+do
+	test_expect_success POSIXPERM "split commit-graph respects core.sharedrepository $mode" '
+		rm -rf $graphdir $infodir/commit-graph &&
+		git reset --hard commits/1 &&
+		test_config core.sharedrepository "$mode" &&
+		git commit-graph write --split --reachable &&
+		ls $graphdir/graph-*.graph >graph-files &&
+		test_line_count = 1 graph-files &&
+		echo "$modebits" >expect &&
+		test_modebits $graphdir/graph-*.graph >actual &&
+		test_cmp expect actual
+	'
+done <<\EOF
+0666 -r--r--r--
+0600 -r--------
+EOF
+
 test_done
-- 
2.26.0.113.ge9739cdccc

