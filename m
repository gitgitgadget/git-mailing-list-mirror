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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EE581F609
	for <e@80x24.org>; Tue, 18 Jun 2019 22:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbfFRW3Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 18:29:25 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:53051 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbfFRW3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 18:29:25 -0400
Received: by mail-pg1-f202.google.com with SMTP id a13so10862736pgw.19
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=r4lunItTjt4NzeA4NO3m6hNj4ZyLfFNy5kyfdyvnF6E=;
        b=FF3r045dtJAkm6FaTqh4gy0jSBmwbvkSkpjtSd1CSwRWVQV3tTmH8Ff+cwuwhOpPCk
         SyIo0tD2IucHMsQOjpWvOGaPeB7sSjNhiBZYCtQoP0JbdJ9AlH2q4EGes7VgIBo/6t3C
         XkVxwnUFJAMxSjpoqat2cH0GXD2Mje8jxjxfFYQs6rkAZGF5LNWl/78fytSqH9Y0g7dB
         CV6pMRppBRijWVJkU9gtHf2l4Yh8ghwGtT7r+FmYI2KO36Zr3FQaBstzbLpzUi0eSiPc
         OLbS84h0hZ7Mt8ONgyJQlRIWGhpzXxuhrmgbBwRmicc+e5Xb3eRjrXtuJXOK6MtdwlQY
         phuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=r4lunItTjt4NzeA4NO3m6hNj4ZyLfFNy5kyfdyvnF6E=;
        b=p7YzqOAMOtpbVym+eetGgWDNfjhGZoQxY7EpHLnpjRdNdqb2NvDeNRAXgHjv+CWPis
         VhCpbgqr6+MkeRjC0fnC7u9/j3V5Kv0aJwHLacRr16TRvoEXkuaNloZ2dyikaYLzePFA
         guDt0srEWGNAoqOKevhrGajVw5iOCb1AGX+OYc5xsPn7GuGhZjepZutQizFmjka7E0ps
         rshzgzoalyqBQbWmQmZk6I5XWFrO78LcGBhi8JjsA30FxbfmGT7gzsYsJVatG7ujJDJH
         BuKNXjg2ej/iZ5dKSLN7EpdKSrTl8CPe11j1pqDZMWyMCw/QzplpGcTm9e9hLpbz0hAa
         7Vlg==
X-Gm-Message-State: APjAAAVvHh4lm9nmOAHHFLD5Rvis42cyvI3dGeUZBRzp0WHBanm6pkz3
        SPcUWssnlU4KCW/WtNqV/0PnrA/CHcJGV6EqKy1k1nGjGQXaLEUwfhqsVEDJEm5N35XBQcjvn8F
        wiWkg/GaeLnCmGI9QzXczY4RvLIn1AFFM6tyO62HcKyg3eRsP9hka6a/xnN8fYubUTp7KHMS9cA
        ==
X-Google-Smtp-Source: APXvYqxPy6w4zR4Uwn5LWv3wrzhISAaa40d++kCEbGBDXc5zpWOS+v4L6OLR609EwtTfEX96WJpenmmM1+Np650UFJk=
X-Received: by 2002:a63:c60b:: with SMTP id w11mr4611480pgg.356.1560896963701;
 Tue, 18 Jun 2019 15:29:23 -0700 (PDT)
Date:   Tue, 18 Jun 2019 15:29:17 -0700
In-Reply-To: <20190614234855.257318-1-emilyshaffer@google.com>
Message-Id: <20190618222917.261701-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v4] rev-list: teach --no-object-names to enable piping
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
Since v3, added a corresponding "--object-names" arg to pair with
"--no-object-names", and "last-one-wins" logic. Also added a test to
validate this new arg and the logic.

I did not take Junio's suggestion of naming the arg "show_object_names"
as "arg_show_object_names" better matches the existing style of
builtin/revlist.c.

In adding the test, I noticed that I had left in a test about --oid-only
that doesn't apply after the changes from v2->v3; that test is removed.

 - Emily

 builtin/rev-list.c       | 19 ++++++++++++++++++-
 t/t6000-rev-list-misc.sh | 20 ++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

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

