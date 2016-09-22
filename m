Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A656207EC
	for <e@80x24.org>; Thu, 22 Sep 2016 18:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941025AbcIVSx5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 14:53:57 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34357 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939026AbcIVSxY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 14:53:24 -0400
Received: by mail-qk0-f195.google.com with SMTP id b204so5745485qkc.1
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+scv8iwVfgHm3iz6rSb8Rj15nEJIdtEwYVWst2Q+8sc=;
        b=ttEpDEAdazg9li4oDHNdz6WiCnO36y/wVqLfDdVAYckIQQC+hvx5aY5aToD5+vINpz
         QjUmf+3D4OmH0d/NKw5l1M5G2+6u6udBFFrff6yBlAyNTwACaC1STY8sv7pICs++WUnF
         gaI4fQANLEvXngOpXCxXo9++nR/zyK7bAszzkxoNZamyOz9klCF9/98QikPcXrwe7kV7
         Y6guOFmcZcxt2UoI4Wst60OOAblMhXLmUt5ao6OagN84CSUG88X5cydB5NesiMiV4eiJ
         FEk7nOqg2+qLOLhM6ygB/9o3GpDocXvNj+u3SavHxu2OF9XKiV60WfEJ9W7N49+Yqr2l
         Rzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+scv8iwVfgHm3iz6rSb8Rj15nEJIdtEwYVWst2Q+8sc=;
        b=Vok08bP2LZI8eXqNyIPF9PAew4HXJWLBUb77RdAzA7u2byaLcuZKqU0VcLMJznawCl
         5LjjZ9MwnrwnYeWiyVeUGLnd63toxoP+ZV1L2FQYofkiWiiRy9Zkw2+JEeSj1+jUO3xR
         TQCHgl5uBl5W7wy1NvCEGKFyRzpCj/ku9w7iD4gMMHRhZ46anBp5knLSeN4WYDgDaROj
         vxoko1XJTB4rLfw2t9Yt/4JBsOwxWHvhocyD6xCU2KhZapmju6jkl5c4J9WQoQAy454A
         G4/bVgI4wh5cq71809dOVHo4hAw4NrnjpFweDKLJCRdBpwhSuT+AY2x0G7Y8FJaSfXG5
         luVg==
X-Gm-Message-State: AA6/9RlLqgCYOFYtkLXoYlWuA6wjEqMsINg156bXzYF0ygH2V2xyI9b2LcSEe1SxVkKCU+WZ
X-Received: by 10.55.98.200 with SMTP id w191mr3580953qkb.154.1474570403819;
        Thu, 22 Sep 2016 11:53:23 -0700 (PDT)
Received: from LykOS.nyu.edu (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id m87sm1675117qkl.21.2016.09.22.11.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Sep 2016 11:53:23 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH 1/6] builtin/tag: move format specifier to global var
Date:   Thu, 22 Sep 2016 14:53:12 -0400
Message-Id: <20160922185317.349-2-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160922185317.349-1-santiago@nyu.edu>
References: <20160922185317.349-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Santiago Torres <santiago@nyu.edu>

The format specifier will be likely used in other functions throughout
git tag. One likely candidate to require format strings in the future is
the gpg_verify_tag function. However, changing the signature of
functions such as for_each_ref or verify_tag would be quite burdensome.

Instead, we move the format string specifier to a static global variable
that modules can access in the same way git-log and other modules handle
this case.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/tag.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 50e4ae5..dbf271f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -30,8 +30,9 @@ static const char * const git_tag_usage[] = {
 
 static unsigned int colopts;
 static int force_sign_annotate;
+static const char *fmt_pretty;
 
-static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
+static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting)
 {
 	struct ref_array array;
 	char *to_free = NULL;
@@ -42,23 +43,23 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 	if (filter->lines == -1)
 		filter->lines = 0;
 
-	if (!format) {
+	if (!fmt_pretty) {
 		if (filter->lines) {
 			to_free = xstrfmt("%s %%(contents:lines=%d)",
 					  "%(align:15)%(refname:strip=2)%(end)",
 					  filter->lines);
-			format = to_free;
+			fmt_pretty = to_free;
 		} else
-			format = "%(refname:strip=2)";
+			fmt_pretty = "%(refname:strip=2)";
 	}
 
-	verify_ref_format(format);
+	verify_ref_format(fmt_pretty);
 	filter->with_commit_tag_algo = 1;
 	filter_refs(&array, filter, FILTER_REFS_TAGS);
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++)
-		show_ref_array_item(array.items[i], format, 0);
+		show_ref_array_item(array.items[i], fmt_pretty, 0);
 	ref_array_clear(&array);
 	free(to_free);
 
@@ -334,7 +335,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct strbuf err = STRBUF_INIT;
 	struct ref_filter filter;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
-	const char *format = NULL;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
@@ -369,7 +369,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
 			N_("print only tags of the object"), 0, parse_opt_object_name
 		},
-		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
+		OPT_STRING(  0 , "format", &fmt_pretty, N_("format"), N_("format to use for the output")),
 		OPT_END()
 	};
 
@@ -410,7 +410,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			run_column_filter(colopts, &copts);
 		}
 		filter.name_patterns = argv;
-		ret = list_tags(&filter, sorting, format);
+		ret = list_tags(&filter, sorting);
 		if (column_active(colopts))
 			stop_column_filter();
 		return ret;
-- 
2.10.0

