Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9800520229
	for <e@80x24.org>; Mon, 24 Oct 2016 10:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757197AbcJXKmu (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 06:42:50 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36740 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754136AbcJXKmt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 06:42:49 -0400
Received: by mail-pf0-f194.google.com with SMTP id r16so16249332pfg.3
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 03:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iJDSEmbdqGjl7NnMJep1/lD14Zv+lmpkRaikHbXDqmI=;
        b=1HxS4mvsnjWuDbVO71Feu4ggCJ+klPVNbicnLEvm85A9tUbNUG6BnvA9V1Eu08Ug3p
         p1WnbfbsfirQrCd5+VxmQJhadtNWbQROfwYcR2L/BlHbIY/L8EWJ7X3kl+NzoZEVCyeB
         V5CvPuz76mrdlKz6fzUfLTYME0PJj1/YuhL6I6JWya95kqCUrB1CZJNg7TxWZcVRxUe4
         Cn0Qmi6pXy4MaTmg4CUS8quCtFEG95fhgZD5fWsv3zBx3MiGwZrU6bEgiJt+LW6oXOoy
         JTs3/MZn4LiT4Quk+mpSuCuljDDSmTGjqSNUjuNtc4z95eb4CDncP6pOrn9S0TzfvrOK
         R2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJDSEmbdqGjl7NnMJep1/lD14Zv+lmpkRaikHbXDqmI=;
        b=ck4xL/DTG7PoljP4CJV6Krc4dfxj5aTVW2SDqmgNNP2WwVCARBpJaO65cWgM46qePH
         ct1YladUQnIT1VSma68xkARTJ9YSz87HmtnC3bAI3A+1Egx6WLjWXOkP2VxTdhE3Nkmz
         w9kLTNHKj/SYtqkr7Z9fFESnjtxhjYxxlIZXzrCxZJCTgpW5XcNTojGywG4wZn9w8rLV
         8ESCd0X2MFQs5fqbtcMQiOf1XTAhhgn2vbJX3D4GTdUEU0G1DPeHpwDaNv5GeJ5fTx+s
         +FqKNNztwI2SCiVfmp9byO9cpRmedGKbdUmLWT1hV0X6oWlu6LQoWuRvYZbNmenkcL9A
         9R0Q==
X-Gm-Message-State: ABUngvd3LnCoxXXAR3rAUO8bbimWa7m/IpP8NcKbN0vL0FTGNtVRkCopkjczzeU8FUiK8g==
X-Received: by 10.99.115.65 with SMTP id d1mr22353684pgn.56.1477305763317;
        Mon, 24 Oct 2016 03:42:43 -0700 (PDT)
Received: from ash ([115.73.162.90])
        by smtp.gmail.com with ESMTPSA id 3sm24330650pfo.31.2016.10.24.03.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Oct 2016 03:42:42 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Oct 2016 17:42:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/4] commit: fix empty commit creation when there's no changes but ita entries
Date:   Mon, 24 Oct 2016 17:42:21 +0700
Message-Id: <20161024104222.31128-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161024104222.31128-1-pclouds@gmail.com>
References: <20160928114348.1470-1-pclouds@gmail.com>
 <20161024104222.31128-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If i-t-a entries are present and there is no change between the index
and HEAD i-t-a entries, index_differs_from() still returns "dirty, new
entries" (aka, the resulting commit is not empty), but cache-tree will
skip i-t-a entries and produce the exact same tree of current
commit.

index_differs_from() is supposed to catch this so we can abort
git-commit (unless --no-empty is specified). Update it to optionally
ignore i-t-a entries when doing a diff between the index and HEAD so
that it would return "no change" in this case and abort commit.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/commit.c      |  2 +-
 diff-lib.c            |  4 +++-
 diff.h                |  2 +-
 sequencer.c           |  4 ++--
 t/t2203-add-intent.sh | 11 +++++++++++
 5 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index bb9f79b..fe8694d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -910,7 +910,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			if (ignore_submodule_arg &&
 			    !strcmp(ignore_submodule_arg, "all"))
 				diff_flags |= DIFF_OPT_IGNORE_SUBMODULES;
-			commitable = index_differs_from(parent, diff_flags);
+			commitable = index_differs_from(parent, diff_flags, 1);
 		}
 	}
 	strbuf_release(&committer_ident);
diff --git a/diff-lib.c b/diff-lib.c
index 27f1228..5244746 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -535,7 +535,8 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 	return 0;
 }
 
-int index_differs_from(const char *def, int diff_flags)
+int index_differs_from(const char *def, int diff_flags,
+		       int ita_invisible_in_index)
 {
 	struct rev_info rev;
 	struct setup_revision_opt opt;
@@ -547,6 +548,7 @@ int index_differs_from(const char *def, int diff_flags)
 	DIFF_OPT_SET(&rev.diffopt, QUICK);
 	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
 	rev.diffopt.flags |= diff_flags;
+	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
 	run_diff_index(&rev, 1);
 	if (rev.pending.alloc)
 		free(rev.pending.objects);
diff --git a/diff.h b/diff.h
index 68a6618..b171172 100644
--- a/diff.h
+++ b/diff.h
@@ -356,7 +356,7 @@ extern int diff_result_code(struct diff_options *, int);
 
 extern void diff_no_index(struct rev_info *, int, const char **);
 
-extern int index_differs_from(const char *def, int diff_flags);
+extern int index_differs_from(const char *def, int diff_flags, int ita_invisible_in_index);
 
 /*
  * Fill the contents of the filespec "df", respecting any textconv defined by
diff --git a/sequencer.c b/sequencer.c
index eec8a60..b082635 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -469,7 +469,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		unborn = get_sha1("HEAD", head);
 		if (unborn)
 			hashcpy(head, EMPTY_TREE_SHA1_BIN);
-		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD", 0))
+		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD", 0, 0))
 			return error_dirty_index(opts);
 	}
 	discard_cache();
@@ -1064,7 +1064,7 @@ static int sequencer_continue(struct replay_opts *opts)
 		if (ret)
 			return ret;
 	}
-	if (index_differs_from("HEAD", 0))
+	if (index_differs_from("HEAD", 0, 0))
 		return error_dirty_index(opts);
 	todo_list = todo_list->next;
 	return pick_commits(todo_list, opts);
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 0e54f63..8652a96 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -129,5 +129,16 @@ test_expect_success 'cache-tree does skip dir that becomes empty' '
 	)
 '
 
+test_expect_success 'commit: ita entries ignored in empty commit check' '
+	git init empty-subsequent-commit &&
+	(
+		cd empty-subsequent-commit &&
+		test_commit one &&
+		: >two &&
+		git add -N two &&
+		test_must_fail git commit -m nothing-new-here
+	)
+'
+
 test_done
 
-- 
2.8.2.524.g6ff3d78

