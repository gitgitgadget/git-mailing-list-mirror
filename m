Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4477D1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 00:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeJJH5w (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 03:57:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45508 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJJH5w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 03:57:52 -0400
Received: by mail-io1-f67.google.com with SMTP id e12-v6so2612772iok.12
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 17:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=JPiQ3mNEMMzjEphOriMwbHJBTQYbvguvSEC5TJtYX+E=;
        b=R8EEQjm+9qdWpUShvRj0JSZzVnss7Ya5Q/ZvwEkH4L6nqPOStcLRa3uu4hzdNBTUr1
         RQkOqXZG3Ogr/xFFDLxWr+yhoIItWZmgH+FR6wt2DQX3iamcVsTcbQat5tVtMb+vOngM
         cchx9baDAYtmAqfvyhjFEIOGozero21lH7UignABiURZn6GO3cPTN/sNqp+86QLXeb42
         H3AE+cfE1l+dOgr2XRMqX74QC8u3VMsL3qQbABuIJrtE8ajHrWtbaYvZ5nZ8GHfyQFJ5
         XTzreVOKbn88BFqctFHLuiCwqoCxfLUzvjL/s2D3uNizqeaT0aDXF5xOEIcO5qglnnJ+
         dU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=JPiQ3mNEMMzjEphOriMwbHJBTQYbvguvSEC5TJtYX+E=;
        b=DuGvrof2+ahJpa2lLp1295HX7l75mdcMJ08fekWobtGPY0DZbCfGz/uvDDsVtN+zxc
         5p1yJW2yFQ41SMnaxRLWGPavGnh1oa1SVSRnCh6EK+xOG5ef44Qx5p3UOhD9pZsk84JO
         VkvFUPqrD+HZKKrRyHLCVT7FReF/wGxUvFh9X0OfZKvnFB9iih/uOEA1hLRiEy58vCPu
         dLO3aiukIU/r5Wp/n+1glQQ7MUGYkgQPD6CHZqlgB2RnhlgY3CRelh2rU4P4y4wpUKiy
         yqM25HSFsTECHD2YPIA/N5YVbDI8kWCQgJktYqsVF2QZNUgApe0syKnNcQ7RuvC7vKPC
         qDlQ==
X-Gm-Message-State: ABuFfoiLSjUsYoqbluT13uiXaaNuqj6dHvEthg8W0ai1m5XPSuWD4BZd
        51EdI9tt8QGa5EBwu5dFMamTkp0o
X-Google-Smtp-Source: ACcGV60P+5mUJ6WpDCd2zkq/YjVDu6qLTqlqDEKmTpzRsB0cj6JNSpp+A7BOl9AjK0AXYTsibswIFA==
X-Received: by 2002:a5e:830a:: with SMTP id x10-v6mr21690964iom.298.1539131902011;
        Tue, 09 Oct 2018 17:38:22 -0700 (PDT)
Received: from zebian.home (cbl-45-2-119-34.yyz.frontiernetworks.ca. [45.2.119.34])
        by smtp.gmail.com with ESMTPSA id l15-v6sm4399731iok.78.2018.10.09.17.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 17:38:21 -0700 (PDT)
From:   Noam Postavsky <npostavs@users.sourceforge.net>
To:     git@vger.kernel.org
Cc:     Noam Postavsky <npostavs@users.sourceforge.net>
Subject: [PATCH v6] log: fix coloring of certain octupus merge shapes
Date:   Tue,  9 Oct 2018 20:37:43 -0400
Message-Id: <20181010003743.17198-1-npostavs@users.sourceforge.net>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For octopus merges where the first parent edge immediately merges into
the next column to the left:

| *-.
| |\ \
|/ / /

then the number of columns should be one less than the usual case:

| *-.
| |\ \
| | | *

Also refactor the code to iterate over columns rather than dashes,
building from an initial patch suggestion by Jeff King.

Signed-off-by: Noam Postavsky <npostavs@users.sourceforge.net>
Reviewed-by: Jeff King <peff@peff.net>
---
 graph.c                      |  56 +++++++++++++++++-------
 t/t4214-log-graph-octopus.sh | 102 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+), 15 deletions(-)
 create mode 100755 t/t4214-log-graph-octopus.sh

diff --git a/graph.c b/graph.c
index e1f6d3bddb..a3366f6dac 100644
--- a/graph.c
+++ b/graph.c
@@ -842,27 +842,53 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
 }
 
 /*
- * Draw an octopus merge and return the number of characters written.
+ * Draw the horizontal dashes of an octopus merge and return the number of
+ * characters written.
  */
 static int graph_draw_octopus_merge(struct git_graph *graph,
 				    struct strbuf *sb)
 {
 	/*
-	 * Here dashless_commits represents the number of parents
-	 * which don't need to have dashes (because their edges fit
-	 * neatly under the commit).
-	 */
-	const int dashless_commits = 2;
-	int col_num, i;
-	int num_dashes =
-		((graph->num_parents - dashless_commits) * 2) - 1;
-	for (i = 0; i < num_dashes; i++) {
-		col_num = (i / 2) + dashless_commits + graph->commit_index;
-		strbuf_write_column(sb, &graph->new_columns[col_num], '-');
+	 * Here dashless_parents represents the number of parents which don't
+	 * need to have dashes (the edges labeled "0" and "1").  And
+	 * dashful_parents are the remaining ones.
+	 *
+	 * | *---.
+	 * | |\ \ \
+	 * | | | | |
+	 * x 0 1 2 3
+	 *
+	 */
+	const int dashless_parents = 2;
+	int dashful_parents = graph->num_parents - dashless_parents;
+
+	/*
+	 * Usually, each parent gets its own column, like the diagram above, but
+	 * sometimes the first parent goes into an existing column, like this:
+	 *
+	 * | *---.
+	 * | |\ \ \
+	 * |/ / / /
+	 * x 0 1 2
+	 *
+	 * In which case there will be more parents than the delta of columns.
+	 */
+	int delta_cols = (graph->num_new_columns - graph->num_columns);
+	int parent_in_old_cols = graph->num_parents - delta_cols;
+
+	/*
+	 * In both cases, commit_index corresponds to the edge labeled "0".
+	 */
+	int first_col = graph->commit_index + dashless_parents
+	    - parent_in_old_cols;
+
+	int i;
+	for (i = 0; i < dashful_parents; i++) {
+		strbuf_write_column(sb, &graph->new_columns[i+first_col], '-');
+		strbuf_write_column(sb, &graph->new_columns[i+first_col],
+				    i == dashful_parents-1 ? '.' : '-');
 	}
-	col_num = (i / 2) + dashless_commits + graph->commit_index;
-	strbuf_write_column(sb, &graph->new_columns[col_num], '.');
-	return num_dashes + 1;
+	return 2 * dashful_parents;
 }
 
 static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
new file mode 100755
index 0000000000..dab96c89aa
--- /dev/null
+++ b/t/t4214-log-graph-octopus.sh
@@ -0,0 +1,102 @@
+#!/bin/sh
+
+test_description='git log --graph of skewed left octopus merge.'
+
+. ./test-lib.sh
+
+test_expect_success 'set up merge history' '
+	cat >expect.uncolored <<-\EOF &&
+	* left
+	| *---.   octopus-merge
+	| |\ \ \
+	|/ / / /
+	| | | * 4
+	| | * | 3
+	| | |/
+	| * | 2
+	| |/
+	* | 1
+	|/
+	* initial
+	EOF
+	cat >expect.colors <<-\EOF &&
+	* left
+	<RED>|<RESET> *<BLUE>-<RESET><BLUE>-<RESET><MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
+	<RED>|<RESET> <RED>|<RESET><YELLOW>\<RESET> <BLUE>\<RESET> <MAGENTA>\<RESET>
+	<RED>|<RESET><RED>/<RESET> <YELLOW>/<RESET> <BLUE>/<RESET> <MAGENTA>/<RESET>
+	<RED>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> * 4
+	<RED>|<RESET> <YELLOW>|<RESET> * <MAGENTA>|<RESET> 3
+	<RED>|<RESET> <YELLOW>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
+	<RED>|<RESET> * <MAGENTA>|<RESET> 2
+	<RED>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
+	* <MAGENTA>|<RESET> 1
+	<MAGENTA>|<RESET><MAGENTA>/<RESET>
+	* initial
+	EOF
+	test_commit initial &&
+	for i in 1 2 3 4 ; do
+		git checkout master -b $i || return $?
+		# Make tag name different from branch name, to avoid
+		# ambiguity error when calling checkout.
+		test_commit $i $i $i tag$i || return $?
+	done &&
+	git checkout 1 -b merge &&
+	test_tick &&
+	git merge -m octopus-merge 1 2 3 4 &&
+	git checkout 1 -b L &&
+	test_commit left
+'
+
+test_expect_success 'log --graph with tricky octopus merge with colors' '
+	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
+	git log --color=always --graph --date-order --pretty=tformat:%s --all >actual.colors.raw &&
+	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
+	test_cmp expect.colors actual.colors
+'
+
+test_expect_success 'log --graph with tricky octopus merge, no color' '
+	git log --color=never --graph --date-order --pretty=tformat:%s --all >actual.raw &&
+	sed "s/ *\$//" actual.raw >actual &&
+	test_cmp expect.uncolored actual
+'
+
+# Repeat the previous two tests with "normal" octopus merge (i.e.,
+# without the first parent skewing to the "left" branch column).
+
+test_expect_success 'log --graph with normal octopus merge, no color' '
+	cat >expect.uncolored <<-\EOF &&
+	*---.   octopus-merge
+	|\ \ \
+	| | | * 4
+	| | * | 3
+	| | |/
+	| * | 2
+	| |/
+	* | 1
+	|/
+	* initial
+	EOF
+	git log --color=never --graph --date-order --pretty=tformat:%s merge >actual.raw &&
+	sed "s/ *\$//" actual.raw >actual &&
+	test_cmp expect.uncolored actual
+'
+
+test_expect_success 'log --graph with normal octopus merge with colors' '
+	cat >expect.colors <<-\EOF &&
+	*<YELLOW>-<RESET><YELLOW>-<RESET><BLUE>-<RESET><BLUE>.<RESET>   octopus-merge
+	<RED>|<RESET><GREEN>\<RESET> <YELLOW>\<RESET> <BLUE>\<RESET>
+	<RED>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET> * 4
+	<RED>|<RESET> <GREEN>|<RESET> * <BLUE>|<RESET> 3
+	<RED>|<RESET> <GREEN>|<RESET> <BLUE>|<RESET><BLUE>/<RESET>
+	<RED>|<RESET> * <BLUE>|<RESET> 2
+	<RED>|<RESET> <BLUE>|<RESET><BLUE>/<RESET>
+	* <BLUE>|<RESET> 1
+	<BLUE>|<RESET><BLUE>/<RESET>
+	* initial
+	EOF
+	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
+	git log --color=always --graph --date-order --pretty=tformat:%s merge >actual.colors.raw &&
+	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
+	test_cmp expect.colors actual.colors
+'
+test_done
-- 
2.11.0

