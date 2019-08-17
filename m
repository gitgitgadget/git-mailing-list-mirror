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
	by dcvr.yhbt.net (Postfix) with ESMTP id 741B61F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfHQSmF (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42689 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfHQSmD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id i30so4799960pfk.9
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jmiFH5dseSuCwb7G5Y/Qo6cZt6qnwyVrWFv9QGPkwDA=;
        b=DL7umkttWL2nlIXyQBlZPK5elc35DxyC4vPEYqImDwbom8mr1fpujDs/9Zz5RxJXDf
         4a575/gfva4pRy8rFDTF3fIaeujlhihjtOrL6Bmur7YXlq9GPls8peIUsS8W4mPpSsOI
         oCACHI9oSD90v35M+2kFlMnEKR/vkWo9paPdsTSLjxNlVFDXpwo7RcRFYSxJDlaO6C9B
         YXDEiCrLY+e/iQMB4QfUsmGVAnY2RJsG3l+fz1yZL/fFfW2HkucbI0B3+vdYUPZYu9OT
         lyT+Jt6JPZo1aJuttf1Uavo2y/53KDQKVZvj7QCTU5zEDI2o5jEMpyiVuIsoTknWdnz8
         VnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jmiFH5dseSuCwb7G5Y/Qo6cZt6qnwyVrWFv9QGPkwDA=;
        b=JgMg4gHRr/extBkhqgdEOcSEiRqjHRnTukUI5pSf88AF1onnO5QIOEIbkwx7iQZl13
         Ueg3tEkXoLEzh7As0tmK7jGj4xBAj8yfHsuuW1rmDqvWaHq8eqRxqE0JxdX3z1sou5fv
         BlkyQZltlt8iBbK/1qwjNs4A/7ZgWJ/K71Z1DBcrYVB3t4Dq2vScX7PM22uLPc7S3Qdn
         H+OTedCe1+ZwLYOKYI7Kb5UnJ2xEigpk7mK5is+au62trBxvTrCyJF385JzfPdTSeXJs
         jrVmrB2q7Ds+fz5LiNEfF24sCXm/5XGcF1lzaJxkfGRWnSbP/UJdYYQ7TDHDYl5nCJ6X
         B2OA==
X-Gm-Message-State: APjAAAXgkgQn72T5l5h6bAyG++P45W5njTrJbgDv/NmnM4Ks1uTK8srD
        +236/DdMuayc19gv/JyEy3c2Gqwg
X-Google-Smtp-Source: APXvYqxcqP+/y1BGmZ/gXJ3CZPZtD1Jf8vkNMlXfnev5uZ+erugAMuZWvkZXbUYADy6/fBSIxPY74g==
X-Received: by 2002:aa7:9ab8:: with SMTP id x24mr16343545pfi.98.1566067322355;
        Sat, 17 Aug 2019 11:42:02 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:01 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 03/24] merge-recursive: enforce opt->ancestor != NULL when calling merge_trees()
Date:   Sat, 17 Aug 2019 11:41:23 -0700
Message-Id: <20190817184144.32179-4-newren@gmail.com>
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

We always want our conflict hunks to be labelled so that users can know
where each came from.  The previous commit fixed the one caller in the
codebase which was not setting opt->ancestor (and thus not providing a
label for the "merge base" conflict hunk in diff3-style conflict
markers); add an assertion to prevent future codepaths from also
overlooking this requirement.

Enforcing this requirement also allows us to simplify the code for
labelling the conflict hunks by no longer checking if the ancestor label
is NULL.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1d960fa64b..a67ea4957a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1019,7 +1019,7 @@ static int merge_3way(struct merge_options *opt,
 {
 	mmfile_t orig, src1, src2;
 	struct ll_merge_options ll_opts = {0};
-	char *base_name, *name1, *name2;
+	char *base, *name1, *name2;
 	int merge_status;
 
 	ll_opts.renormalize = opt->renormalize;
@@ -1043,16 +1043,13 @@ static int merge_3way(struct merge_options *opt,
 		}
 	}
 
-	assert(a->path && b->path && o->path);
-	if (strcmp(a->path, b->path) ||
-	    (opt->ancestor != NULL && strcmp(a->path, o->path) != 0)) {
-		base_name = opt->ancestor == NULL ? NULL :
-			mkpathdup("%s:%s", opt->ancestor, o->path);
+	assert(a->path && b->path && o->path && opt->ancestor);
+	if (strcmp(a->path, b->path) || strcmp(a->path, o->path) != 0) {
+		base  = mkpathdup("%s:%s", opt->ancestor, o->path);
 		name1 = mkpathdup("%s:%s", branch1, a->path);
 		name2 = mkpathdup("%s:%s", branch2, b->path);
 	} else {
-		base_name = opt->ancestor == NULL ? NULL :
-			mkpathdup("%s", opt->ancestor);
+		base  = mkpathdup("%s", opt->ancestor);
 		name1 = mkpathdup("%s", branch1);
 		name2 = mkpathdup("%s", branch2);
 	}
@@ -1061,11 +1058,11 @@ static int merge_3way(struct merge_options *opt,
 	read_mmblob(&src1, &a->oid);
 	read_mmblob(&src2, &b->oid);
 
-	merge_status = ll_merge(result_buf, a->path, &orig, base_name,
+	merge_status = ll_merge(result_buf, a->path, &orig, base,
 				&src1, name1, &src2, name2,
 				opt->repo->index, &ll_opts);
 
-	free(base_name);
+	free(base);
 	free(name1);
 	free(name2);
 	free(orig.ptr);
@@ -3390,6 +3387,8 @@ int merge_trees(struct merge_options *opt,
 	int code, clean;
 	struct strbuf sb = STRBUF_INIT;
 
+	assert(opt->ancestor != NULL);
+
 	if (!opt->call_depth && repo_index_has_changes(opt->repo, head, &sb)) {
 		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
 		    sb.buf);
-- 
2.23.0.rc2.28.g5f89f15d7b.dirty

