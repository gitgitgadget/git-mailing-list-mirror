Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B29061F453
	for <e@80x24.org>; Thu, 21 Feb 2019 22:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfBUWiT (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 17:38:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40981 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfBUWiT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 17:38:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id n2so237292wrw.8
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 14:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGF9H7idxPzNGu1VGRxpMKWjfCTzEaTdtUOjW64nZ6M=;
        b=ZxAsjzDhR0T7x+uk2cm4J0aDEYyker+jFiE9Ki80a6lVZ6fQGyOtpvDhDqeU4myPU8
         2d0ktn47FSnO3sVQZ3UkV0kFAmrxVaoC7+3TrOZeNlKBad/OCePW9J7y3VK/7p+B2qCv
         cqTom4sjFQaIYLdhHcGAAKNBPH6msT3UIFpPTk4yx4uHSZh7nKKAYL2t4c7g7yKb63jo
         Ojd563ua2zzheHwPA3reqfLkI4fDiv/cNznqaOQtgLhbS/3tTYzRTE/pvCwAKCh0Y55c
         FadHtYOJ5bxYSZQ2OXY76hvTGws6OqXRs9CttzbPiNSFJQLVw/RghCXa8XTYrFg/Xt5w
         S34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGF9H7idxPzNGu1VGRxpMKWjfCTzEaTdtUOjW64nZ6M=;
        b=sMzVyELqWQ2sNXAumk2llxybz7Z9yt/PWXwalT6HFW14h/6eX8hk6gQyp75iLuKMkA
         0Eipy5ajHcsJoOJhPgdKZSAp41sLxE+itWmtcxn5iXDZ+WO2NuEpXT3dQPsDyJL/kFqQ
         Suvx3CHisIDyLEylJTK6yQqfGuXO+2D4o9pf8k6mgTbWzZ3plh0HYMiTQFXl0qc7CKqZ
         f0wASKHsBdYpmvGXRfbwxSolPk5fBmXW0m2PUvu+6XccHpVbKyZ+5uXrFy9sBePnFtGc
         l2o/VV0R5dy0+scJTpKgy8aAK6GuV9iQsk73Ga1iHTlffMij63ihtbaX+PtPHKofhrde
         t+XA==
X-Gm-Message-State: AHQUAuZ5V2xggAwAjYgxMIhT1YRUkIvVt5edJRxpFUZD5MuGeNezRaTW
        FwuyPBwDVrP5gBlwmHRNug/zWPyGwCw=
X-Google-Smtp-Source: AHgI3IYhWOqEXIAG3zOTLMHNkOzsxf432PI5un021gZVS79DwZpGveZtTIHmkEtp+Buv4pxB4AtI4A==
X-Received: by 2002:a5d:5681:: with SMTP id f1mr546574wrv.95.1550788696908;
        Thu, 21 Feb 2019 14:38:16 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v196sm110803wmf.15.2019.02.21.14.38.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Feb 2019 14:38:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/8] commit-graph verify: detect inability to read the graph
Date:   Thu, 21 Feb 2019 23:37:51 +0100
Message-Id: <20190221223753.20070-7-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190221223753.20070-1-avarab@gmail.com>
References: <20190221223753.20070-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change "commit-graph verify" to error on open() failures other than
ENOENT. As noted in the third paragraph of 283e68c72f ("commit-graph:
add 'verify' subcommand", 2018-06-27) and the test it added it's
intentional that "commit-graph verify" doesn't error out when the file
doesn't exist.

But let's not be overly promiscuous in what we accept. If we can't
read the file for other reasons, e.g. permission errors, bad file
descriptor etc. we'd like to report an error to the user.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c  |  4 +++-
 t/t5318-commit-graph.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 8196fdbe9c..537fdfd0f0 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -62,8 +62,10 @@ static int graph_verify(int argc, const char **argv)
 
 	graph_name = get_commit_graph_filename(opts.obj_dir);
 	open_ok = open_commit_graph(graph_name, &fd, &st);
-	if (!open_ok)
+	if (!open_ok && errno == ENOENT)
 		return 0;
+	if (!open_ok)
+		die_errno(_("Could not open commit-graph '%s'"), graph_name);
 	graph = load_commit_graph_one_fd_st(fd, &st);
 	FREE_AND_NULL(graph_name);
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 0d012f55e5..1ee00fa333 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -400,6 +400,18 @@ corrupt_graph_and_verify() {
 
 }
 
+test_expect_success 'detect permission problem' '
+	corrupt_graph_setup &&
+	chmod 000 $objdir/info/commit-graph &&
+
+	# Skip as root, or in other cases (odd fs or OS) where a
+	# "chmod 000 file" does not yield EACCES on e.g. "cat file"
+	if ! test -r $objdir/info/commit-graph
+	then
+		corrupt_graph_verify "Could not open"
+	fi
+'
+
 test_expect_success 'detect too small' '
 	corrupt_graph_setup &&
 	echo "a small graph" >$objdir/info/commit-graph &&
-- 
2.21.0.rc0.258.g878e2cd30e

