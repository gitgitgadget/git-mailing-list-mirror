Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 493B91F404
	for <e@80x24.org>; Mon, 19 Feb 2018 21:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753670AbeBSVWM (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 16:22:12 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34268 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753624AbeBSVWL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 16:22:11 -0500
Received: by mail-wm0-f46.google.com with SMTP id a20so1831887wmd.1
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 13:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4hCxZtbkDyJw48/qsf0IGPFGKg+HS6BCU2S4SfWGYO0=;
        b=aYzibsVdpL+iV4prtTaVoQDMkgDxmvUqGJrtDXHdYD3zz5RA9td33jDTrZUSVSl1rZ
         TLgv57tm4tjKWyLevPBk3nRGPapkdAeSrTrHNNIBpFovx9BZoknG2zMIj/BhTgvRP0b3
         gges1t1YTiJ2GL1ymeCoRjuMZkSFP5pF2YtFoFTXPosdADrO2My/t2JI72s1hFt2jwzU
         Z9ERnC9zmt+AlD/3VttrfiN7LQs5W7dHE1QMyHu2JLW9UzlVAo6RykfzkE2rIdYsIJsd
         lMnIqMZ+W+RaUK2R2/qLZqByPwflFiOilCuX6Dg4R3xf3ZzqnL33aLtFYTs4ec+2MHW1
         RBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4hCxZtbkDyJw48/qsf0IGPFGKg+HS6BCU2S4SfWGYO0=;
        b=qKYhz/ll5p8rvw9b93KEM1J/Sfr5bOI5zgbhbM73qQnS13rSP4jiCcNZo/pSvdrLco
         9EtuECIcL+7Mp2FW6qgwr6dyFGzG4Bzb5qQvCcN7etjTqecgJjA3axz2ZxpWuIE8ULQB
         23KpBXEIawQRWCXCRTJiNi1EmZSLt/H1MzBJtZoHta2YjYfNXRX8VLkbV1YL0my5aSoS
         krhEvoeIDN4joFzeTPUm4WZPB2hFlPve0GP/L1zWDsk5yJ1vwlND/VIZbG5zd4DbJD4J
         jsjjkGlaoZ/2UpZNxRHGHNQukvimsvekdJuX9HV6q3pbLxEV6Q+nYbluV19Dsi4dmCUH
         OPdQ==
X-Gm-Message-State: APf1xPBvE19s3UfEi7rMOUQPiWTsAr5HHHjNZhq/M+JJXaMnaLADj1xh
        v8OaNqBK7oYjL/r0P7y5MrMzHg==
X-Google-Smtp-Source: AH8x224mPFPUIHUagTm0cEzldq6/KG/dydE6Ww/HsJpDvuDdoc3+N9SjcaAowRhCp+trdTitQMMvzQ==
X-Received: by 10.28.167.151 with SMTP id q145mr5314621wme.64.1519075330162;
        Mon, 19 Feb 2018 13:22:10 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.77])
        by smtp.gmail.com with ESMTPSA id d27sm32847933wrd.60.2018.02.19.13.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Feb 2018 13:22:09 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: [GSoC][PATCH] tag: Make "git tag --contains <id>" less chatty if <id> is invalid
Date:   Mon, 19 Feb 2018 23:21:30 +0200
Message-Id: <20180219212130.4217-1-ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.16.1.194.gb2e45c695.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git tag --contains <id> prints the whole help text if <id> is
invalid. It should only show the error message instead.

This bug was a side effect of looking up the commit in option
parser callback. When a error occurs in the option parser, the
full usage is shown. To fix this bug, the part related to
looking up the commit was moved outside of the option parser
to the ref-filter module.

Basically, the option parser only parses strings that represent
commits and the ref-filter performs the commit look-up. If an
error occurs during the option parsing, then it must be an invalid
argument and the user should be informed of usage, but if a error
occurs during ref-filtering, then it is a problem with the
argument.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/tag.c           | 11 +++++++++--
 parse-options.h         | 11 +++++++++++
 ref-filter.c            | 19 +++++++++++++++++++
 ref-filter.h            |  3 +++
 t/t7013-tag-contains.sh | 37 +++++++++++++++++++++++++++++++++++++
 5 files changed, 79 insertions(+), 2 deletions(-)
 create mode 100755 t/t7013-tag-contains.sh

diff --git a/builtin/tag.c b/builtin/tag.c
index a7e6a5b0f..3fce14713 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -396,6 +396,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 		OPT_GROUP(N_("Tag listing options")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
+
+		OPT_CONTAINS_STRS(&filter.with_commit_strs, N_("print only tags that contain the commit")),
+		OPT_NO_CONTAINS_STRS(&filter.no_commit_strs, N_("print only tags that don't contain the commit")),
+		OPT_WITH_STRS(&filter.with_commit_strs, N_("print only tags that contain the commit")),
+		OPT_WITHOUT_STRS(&filter.no_commit_strs, N_("print only tags that don't contain the commit")),
+
 		OPT_CONTAINS(&filter.with_commit, N_("print only tags that contain the commit")),
 		OPT_NO_CONTAINS(&filter.no_commit, N_("print only tags that don't contain the commit")),
 		OPT_WITH(&filter.with_commit, N_("print only tags that contain the commit")),
@@ -437,6 +443,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			cmdmode = 'l';
 		else if (filter.with_commit || filter.no_commit ||
 			 filter.points_at.nr || filter.merge_commit ||
+			 filter.with_commit_strs.nr || filter.no_commit_strs.nr ||
 			 filter.lines != -1)
 			cmdmode = 'l';
 	}
@@ -473,9 +480,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	}
 	if (filter.lines != -1)
 		die(_("-n option is only allowed in list mode"));
-	if (filter.with_commit)
+	if (filter.with_commit || filter.with_commit_strs.nr)
 		die(_("--contains option is only allowed in list mode"));
-	if (filter.no_commit)
+	if (filter.no_commit || filter.no_commit_strs.nr)
 		die(_("--no-contains option is only allowed in list mode"));
 	if (filter.points_at.nr)
 		die(_("--points-at option is only allowed in list mode"));
diff --git a/parse-options.h b/parse-options.h
index af711227a..3aa8ddd46 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -258,9 +258,20 @@ extern int parse_opt_passthru_argv(const struct option *, const char *, int);
 	  PARSE_OPT_LASTARG_DEFAULT | flag, \
 	  parse_opt_commits, (intptr_t) "HEAD" \
 	}
+#define _OPT_CONTAINS_OR_WITH_STRS(name, variable, help, flag) \
+	{ OPTION_CALLBACK, 0, name, (variable), N_("commit"), (help), \
+	  PARSE_OPT_LASTARG_DEFAULT | flag, \
+	  parse_opt_string_list, (intptr_t) "HEAD" \
+	}
+
 #define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, PARSE_OPT_NONEG)
 #define OPT_NO_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("no-contains", v, h, PARSE_OPT_NONEG)
 #define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
 #define OPT_WITHOUT(v, h) _OPT_CONTAINS_OR_WITH("without", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
 
+#define OPT_CONTAINS_STRS(v, h) _OPT_CONTAINS_OR_WITH_STRS("contains", v, h, PARSE_OPT_NONEG)
+#define OPT_NO_CONTAINS_STRS(v, h) _OPT_CONTAINS_OR_WITH_STRS("no-contains", v, h, PARSE_OPT_NONEG)
+#define OPT_WITH_STRS(v, h) _OPT_CONTAINS_OR_WITH_STRS("with", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
+#define OPT_WITHOUT_STRS(v, h) _OPT_CONTAINS_OR_WITH_STRS("without", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
+
 #endif
diff --git a/ref-filter.c b/ref-filter.c
index f9e25aea7..e7bdaa27f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2000,6 +2000,21 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
 	free(to_clear);
 }
 
+int add_str_to_commit_list(struct string_list_item *item, void *commit_list)
+{
+	struct object_id oid;
+	struct commit *commit;
+
+	if (get_oid(item->string, &oid))
+		die(_("malformed object name %s"), item->string);
+	commit = lookup_commit_reference(&oid);
+	if (!commit)
+		die(_("no such commit %s"), item->string);
+	commit_list_insert(commit, commit_list);
+
+	return 0;
+}
+
 /*
  * API for filtering a set of refs. Based on the type of refs the user
  * has requested, we iterate through those refs and apply filters
@@ -2012,6 +2027,10 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	int ret = 0;
 	unsigned int broken = 0;
 
+	/* Convert string representation and add to commit list. */
+	for_each_string_list(&filter->with_commit_strs, add_str_to_commit_list, &filter->with_commit);
+	for_each_string_list(&filter->no_commit_strs, add_str_to_commit_list, &filter->no_commit);
+
 	ref_cbdata.array = array;
 	ref_cbdata.filter = filter;
 
diff --git a/ref-filter.h b/ref-filter.h
index 0d98342b3..62f37760f 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -55,6 +55,9 @@ struct ref_filter {
 	struct commit_list *with_commit;
 	struct commit_list *no_commit;
 
+	struct string_list with_commit_strs;
+	struct string_list no_commit_strs;
+
 	enum {
 		REF_FILTER_MERGED_NONE = 0,
 		REF_FILTER_MERGED_INCLUDE,
diff --git a/t/t7013-tag-contains.sh b/t/t7013-tag-contains.sh
new file mode 100755
index 000000000..65119dada
--- /dev/null
+++ b/t/t7013-tag-contains.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='Test if git tag --contains prints only the error
+when used correctly but with an inexistent tag as argument'
+
+. ./test-lib.sh
+
+test_expect_success 'setup ' '
+	git init . &&
+	echo "this is a test" >file &&
+	git add -A &&
+	git commit -am "tag test" &&
+	git tag "v1.0" &&
+	git tag "v1.1"
+'
+
+test_expect_success 'tag --contains <existent_tag>' '
+	! (git tag --contains "v1.0" 2>&1 | grep -o "usage")
+'
+
+test_expect_success 'tag --contains <existent_tag>' '
+	! (git tag --contains "v1.1" 2>&1 | grep -o "usage")
+'
+
+test_expect_success 'tag --contains <inexistent_tag>' '
+	! (git tag --contains "notag" 2>&1 | grep -o "usage")
+'
+
+test_expect_success 'tag --contains <inexistent_tag>' '
+	! (git tag --contains "v1.2" 2>&1 | grep -o "usage")
+'
+
+test_expect_success 'tag usage error' '
+	git tag --sort 2>&1 | grep -o "usage"
+'
+
+test_done
-- 
2.16.1.194.gb2e45c695.dirty

