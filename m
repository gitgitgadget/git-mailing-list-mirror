Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 565941F462
	for <e@80x24.org>; Wed, 19 Jun 2019 20:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfFSU5L (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 16:57:11 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:35683 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfFSU5K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 16:57:10 -0400
Received: by mail-qt1-f201.google.com with SMTP id v58so714431qta.2
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 13:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=hmZ/fmRSiuprdfGPo+jCgfrsDmMUbxT20r+SiFM8G6o=;
        b=O+EupEFYMK/yvGNoqz79nCBlytymTIIp+RmTgeP4Vf3MflK73BYgiH/dh2NmAnZo8D
         3yAc1OUz7+M+8tqfStqhIVzvtiG99NkSi5WOxVwSz1iJhP/KTUED5cyGEYlBQkTYucGc
         dhc550l+a3ArARWfpsPgnM9x0b5zbtgIatl8E+GtU6MWVuazrWC6A7DZsnILbZ+U/3Ul
         dbJmMIpFOF+PyJXQDMlZ24y/d2rm1mNBcjdDacH1D23ShIskf8bqP7xlXVMBCi4Ikccr
         wXyqGflFHwBpYXZsEa/W1Ml1t+Bs+6fZN1haeGGojMxXFi7xUOVtEiPQ5+MnKrnbuBHF
         V8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=hmZ/fmRSiuprdfGPo+jCgfrsDmMUbxT20r+SiFM8G6o=;
        b=QYk1EsGYm0Tz8H6KktFNoJd5aMVJ5J9KlvDTcqZwiWXrTsK/zEIbbCH8gW+/cORXEM
         AN25ototLT6qSryQXPdE0Rb8RkE1xA2J1ChsZ+iMPbVKThUCnILJyflYDi20R7FduK/4
         Q2wy4p3Ezj6+0jwkTPpzR/iuXUoObnLgE+mSlknvxl06EvNDyPhLoZsuS1zZV0JJil9D
         Rmj2CT8uD06Ug67VKDv5szqi8vX7Hyhuxat68GLkEA5MSbrhqvN55zD7U5l7VUMBplZq
         jtDOguLdaky7OZfSMoZTYJXLLMPcfV5VujiOyPEQKwDJ5KEWOhbuJliOhEyEOxmha4Vr
         mZTw==
X-Gm-Message-State: APjAAAUmhZR723d/+F5XUK0viGqJRnama7PLooqCfHkVLUFgzxLb0irr
        oRxOCRXi8l54OAEXQMnNg/dG4A+hVnijC5m4/hlL5fS33uh1Sk7BekFXU9qWfhZZpSIofTNyzt7
        rSx2BUglnIxPZxJN8b1QaT/DVav+rj+eoLNaRVs27jSnX28MVnrsCqjR0li3L4aRnnoR/kA+fDw
        ==
X-Google-Smtp-Source: APXvYqzIDoiQXaRh/qbA93tikd4bGGSrrhO4sHUK6LzZyd11UshUKy5T314A2Rl9SVC6FXHT5s+ZAcFbbAr0GwsLiDM=
X-Received: by 2002:ac8:6b42:: with SMTP id x2mr102442876qts.92.1560977828755;
 Wed, 19 Jun 2019 13:57:08 -0700 (PDT)
Date:   Wed, 19 Jun 2019 13:56:56 -0700
In-Reply-To: <20190618222917.261701-1-emilyshaffer@google.com>
Message-Id: <20190619205656.117272-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5] rev-list: teach --no-object-names to enable piping
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow easier parsing by cat-file by giving rev-list an option to print
only the OID of a non-commit object without any additional information.
This is a short-term shim; later on, rev-list should be taught how to
print the types of objects it finds in a format similar to cat-file's.

Before this commit, the output from rev-list needed to be massaged
before being piped to cat-file, like so:

  git rev-list --objects HEAD | cut -f 1 -d ' ' |
    git cat-file --batch-check

This was especially unexpected when dealing with root trees, as an
invisible whitespace exists at the end of the OID:

  git rev-list --objects --filter=tree:1 --max-count=1 HEAD |
    xargs -I% echo "AA%AA"

Now, it can be piped directly, as in the added test case:

  git rev-list --objects --no-object-names HEAD | git cat-file --batch-check

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Change-Id: I489bdf0a8215532e540175188883ff7541d70e1b
---
Since v4, added the new options to `git help rev-list`.

 Documentation/git-rev-list.txt     |  1 +
 Documentation/rev-list-options.txt | 10 ++++++++++
 builtin/rev-list.c                 | 19 ++++++++++++++++++-
 t/t6000-rev-list-misc.sh           | 20 ++++++++++++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 88609ff435..9392760b25 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -48,6 +48,7 @@ SYNOPSIS
 	     [ --date=<format>]
 	     [ [ --objects | --objects-edge | --objects-edge-aggressive ]
 	       [ --unpacked ]
+	       [ --object-names | --no-object-names ]
 	       [ --filter=<filter-spec> [ --filter-print-omitted ] ] ]
 	     [ --missing=<missing-action> ]
 	     [ --pretty | --header ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 71a1fcc093..286fc163f1 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -708,6 +708,16 @@ ifdef::git-rev-list[]
 	Only useful with `--objects`; print the object IDs that are not
 	in packs.
 
+--object-names::
+	Only useful with `--objects`; print the names of the object IDs
+	that are found. This is the default behavior.
+
+--no-object-names::
+	Only useful with `--objects`; does not print the names of the object
+	IDs that are found. This inverts `--object-names`. This flag allows
+	the output to be more easily parsed by commands such as
+	linkgit:git-cat-file[1].
+
 --filter=<filter-spec>::
 	Only useful with one of the `--objects*`; omits objects (usually
 	blobs) from the list of printed objects.  The '<filter-spec>'
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 660172b014..301ccb970b 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -49,6 +49,7 @@ static const char rev_list_usage[] =
 "    --objects | --objects-edge\n"
 "    --unpacked\n"
 "    --header | --pretty\n"
+"    --[no-]object-names\n"
 "    --abbrev=<n> | --no-abbrev\n"
 "    --abbrev-commit\n"
 "    --left-right\n"
@@ -75,6 +76,9 @@ enum missing_action {
 };
 static enum missing_action arg_missing_action;
 
+/* display only the oid of each object encountered */
+static int arg_show_object_names = 1;
+
 #define DEFAULT_OIDSET_SIZE     (16*1024)
 
 static void finish_commit(struct commit *commit);
@@ -255,7 +259,10 @@ static void show_object(struct object *obj, const char *name, void *cb_data)
 	display_progress(progress, ++progress_counter);
 	if (info->flags & REV_LIST_QUIET)
 		return;
-	show_object_with_name(stdout, obj, name);
+	if (arg_show_object_names)
+		show_object_with_name(stdout, obj, name);
+	else
+		printf("%s\n", oid_to_hex(&obj->oid));
 }
 
 static void show_edge(struct commit *commit)
@@ -484,6 +491,16 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		if (skip_prefix(arg, "--missing=", &arg))
 			continue; /* already handled above */
 
+		if (!strcmp(arg, ("--no-object-names"))) {
+			arg_show_object_names = 0;
+			continue;
+		}
+
+		if (!strcmp(arg, ("--object-names"))) {
+			arg_show_object_names = 1;
+			continue;
+		}
+
 		usage(rev_list_usage);
 
 	}
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 0507999729..52a9e38d66 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -48,6 +48,26 @@ test_expect_success 'rev-list --objects with pathspecs and copied files' '
 	! grep one output
 '
 
+test_expect_success 'rev-list --objects --no-object-names has no space/names' '
+	git rev-list --objects --no-object-names HEAD >output &&
+	! grep wanted_file output &&
+	! grep unwanted_file output &&
+	! grep " " output
+'
+
+test_expect_success 'rev-list --objects --no-object-names works with cat-file' '
+	git rev-list --objects --no-object-names --all >list-output &&
+	git cat-file --batch-check <list-output >cat-output &&
+	! grep missing cat-output
+'
+
+test_expect_success '--no-object-names and --object-names are last-one-wins' '
+	git rev-list --objects --no-object-names --object-names --all >output &&
+	grep wanted_file output &&
+	git rev-list --objects --object-names --no-object-names --all >output &&
+	! grep wanted_file output
+'
+
 test_expect_success 'rev-list A..B and rev-list ^A B are the same' '
 	git commit --allow-empty -m another &&
 	git tag -a -m "annotated" v1.0 &&
-- 
2.22.0.410.gd8fdbe21b5-goog

