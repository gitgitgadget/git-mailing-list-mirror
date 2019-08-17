Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 387F11F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfHQSmS (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40255 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfHQSmH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id w16so4812124pfn.7
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WzwAiJvrVxNndBuz9+KfGMQSYkmf1xJJYbzB7FpP28o=;
        b=C++iokm0DkDchkTd5D5SWervDjd+Ch2RjodHZKwx92YLvRUNsV2sfHZAh9G59nyZUf
         96WWRzab4cEGBKoiLBPwajKXG2XDlW5efkCrUVoKcHdHqPCg/fy2kqWwwNCAAMlcJwcF
         3Z3h1bWLUbsx0t4yt918ostBnX3Pm2/j92LVZsR4qsBKaFygMJV0qoBUf7XJApoNGSTg
         bwoUIIiFZY5JlOjX2K1GmIlKtORH3+hig3QCErFycSmzmOyBtSrUPJGuP21IaFHI7Vn1
         zmqSBAoCNzoFRogXn/dhqM/RV5ife3X7mqnHVSNHeKz4iKZL1riyBwQZGta41dIKiLkn
         unZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WzwAiJvrVxNndBuz9+KfGMQSYkmf1xJJYbzB7FpP28o=;
        b=UoL5xrvJcN/qr0R56uBF6RCD5PDJxTUbihKlvjuAADPQOj/LwYoROwtdvFikUJmyTP
         JP3lisuxENcTidckmbWk6M4pH/VHKs+TQTJtu5a3dr2Y4nRCwlrTLN35fynCRaNd/6Ns
         fPpXBTm6rr8D077ydv01drlKfU3KYpV5PmHacuPeO2b9W0Z/XS1zvD4v5DAwEyDX712j
         E8LhfM3yImsn9BWdlZdX2G1g7eF3kwirOUoozgF4/kf0fDV277vr9WkyG2qlNd8vqbQx
         1XzVw5AuiFMqjS3beOCoAYTZMCexPpGEmdHxeGYrJTIEii1qrvZwd5CV95eV5psMcdN/
         4EvQ==
X-Gm-Message-State: APjAAAWJPDn1lEKfFSxPBd3jvei+5BSmvgiZ71zbLKzYqHv2cdzCf8M7
        Vq628rm2pYLMLgDS4fc9E/AcAFGV
X-Google-Smtp-Source: APXvYqzO85GdaA0LN1uv95hlHb2zZFs0KtDh8aVUCxxENk09kJhG5yhvunL6Tkxb8IpgoA0iF8geNg==
X-Received: by 2002:a65:50c8:: with SMTP id s8mr12883658pgp.339.1566067326577;
        Sat, 17 Aug 2019 11:42:06 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:05 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 07/24] merge-recursive: remove another implicit dependency on the_repository
Date:   Sat, 17 Aug 2019 11:41:27 -0700
Message-Id: <20190817184144.32179-8-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit d7cf3a96e9a0 ("merge-recursive.c: remove implicit dependency on
the_repository", 2019-01-12) and follow-ups like commit 34e7771bc644
("Use the right 'struct repository' instead of the_repository",
2019-06-27), removed most implicit uses of the_repository.  Convert
calls to get_commit_tree() to instead use repo_get_commit_tree() to get
rid of another.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1d4df952e5..88a33e6e72 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3587,8 +3587,11 @@ int merge_recursive(struct merge_options *opt,
 		repo_read_index(opt->repo);
 
 	opt->ancestor = ancestor_name;
-	clean = merge_trees(opt, get_commit_tree(h1), get_commit_tree(h2),
-			    get_commit_tree(merged_common_ancestors),
+	clean = merge_trees(opt,
+			    repo_get_commit_tree(opt->repo, h1),
+			    repo_get_commit_tree(opt->repo, h2),
+			    repo_get_commit_tree(opt->repo,
+						 merged_common_ancestors),
 			    &mrtree);
 	strbuf_release(&merge_base_abbrev);
 	if (clean < 0) {
-- 
2.23.0.rc2.28.g5f89f15d7b.dirty

