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
	by dcvr.yhbt.net (Postfix) with ESMTP id 451BC1F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfHQSmd (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35766 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfHQSmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id d85so4828298pfd.2
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MKv15GAGuh8hc1pF4Q7oRQu73NxUzPXT1Rb01TgMISg=;
        b=Ue+0AFLHNrHKWo5oGYmnsuv7FOnDy9BDk+nJ6P5nq4Gum6V3kuUF9DHiUb57OtOMEe
         KrZPgBstkoq5ePdnGpPWSOY+aKlSq/cFwRjFgiyoBVG4ZRfZJfweSqmKFmIni7L9OSiF
         UtMIiMI2Xuo98b8MAMfmMs95JmnRMW5yUn963xBDvJ6molB3jLlAsCOqa6UTCbtzBFZx
         nYbzIPdlYGp6sQLuVrO+Tj8rLFTZ7vxaGg80xx3YzeDTUKT1nhHvgY5SzFnzKqdy5t0X
         kPUD671bYtJs2FBTsac2w18fnvGZZ1wVKkMWwZWmqGIyyqkKzo2uXpe8CvZ7LE4ykEN5
         x2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MKv15GAGuh8hc1pF4Q7oRQu73NxUzPXT1Rb01TgMISg=;
        b=qjCK7QF83rLZJg+E7x6FyE6MdNarVHW50ERJaLKTZPCZga2VJpi2gg74F+8u5f4GwA
         sHA+0+hul4DR+iHggrDHEgmVl67hjjH5COh7eDJsa32Xev2ijiLjqUmwDXDNzPJ9hZCp
         qEVJDWiE9wfC/rkn4IN41BaH/m1mR8985VFggu+YMGmIN4PB94fGL5QoAOyG6VzykV0m
         IOeGuznUS8xAybKQ6hK9mBdpRGZ8j5vfIQWFsRnGgr4iRZElabGMAcfLB3yeMN+NHMVU
         tktWVeDg8fglqR+gaeOmb224zxt0YybMIaubUioD0Lw5TWBb3TgVtcWJ2QASY9aU+5wJ
         mX8A==
X-Gm-Message-State: APjAAAWwzJy39TG9yh5zLziUFm0GGVfwFpAHSxMxjTzmcOsr1zRUpEU1
        TNfEZ3ekjmJXX9Qkjs5zu1sA3vHd
X-Google-Smtp-Source: APXvYqzN12qWJkZEr12KCfaHRG5NM+0TMcl7XCam3hsfLNGrmEHc5JI2rnXKkXDQZyh8eG2FIrwHTA==
X-Received: by 2002:a17:90b:14c:: with SMTP id em12mr13524649pjb.28.1566067343999;
        Sat, 17 Aug 2019 11:42:23 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:23 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 23/24] merge-recursive: add sanity checks for relevant merge_options
Date:   Sat, 17 Aug 2019 11:41:43 -0700
Message-Id: <20190817184144.32179-24-newren@gmail.com>
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

There are lots of options that callers can set, yet most have a limited
range of valid values, some options are meant for output (e.g.
opt->obuf, which is expected to start empty), and callers are expected
to not set opt->priv.  Add several sanity checks to ensure callers
provide sane values.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index fa3f8eb0b2..0231d7b049 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3615,6 +3615,30 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 {
 	struct strbuf sb = STRBUF_INIT;
 
+	/* Sanity checks on opt */
+	assert(opt->repo);
+
+	assert(opt->branch1 && opt->branch2);
+
+	assert(opt->detect_renames >= -1 &&
+	       opt->detect_renames <= DIFF_DETECT_COPY);
+	assert(opt->detect_directory_renames >= MERGE_DIRECTORY_RENAMES_NONE &&
+	       opt->detect_directory_renames <= MERGE_DIRECTORY_RENAMES_TRUE);
+	assert(opt->rename_limit >= -1);
+	assert(opt->rename_score >= 0 && opt->rename_score <= MAX_SCORE);
+	assert(opt->show_rename_progress >= 0 && opt->show_rename_progress <= 1);
+
+	assert(opt->xdl_opts >= 0);
+	assert(opt->recursive_variant >= MERGE_VARIANT_NORMAL &&
+	       opt->recursive_variant <= MERGE_VARIANT_THEIRS);
+
+	assert(opt->verbosity >= 0 && opt->verbosity <= 5);
+	assert(opt->buffer_output <= 2);
+	assert(opt->obuf.len == 0);
+
+	assert(opt->priv == NULL);
+
+	/* Sanity check on repo state; index must match head */
 	if (repo_index_has_changes(opt->repo, head, &sb)) {
 		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
 		    sb.buf);
-- 
2.23.0.rc2.28.g5f89f15d7b.dirty

