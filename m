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
	by dcvr.yhbt.net (Postfix) with ESMTP id 06F951F462
	for <e@80x24.org>; Fri, 14 Jun 2019 23:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfFNXtG (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 19:49:06 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:32916 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfFNXtF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 19:49:05 -0400
Received: by mail-ot1-f74.google.com with SMTP id b1so1881505otk.0
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 16:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=Bx/RneEZBsmbH1D/h0ZOLo0rsUP9GAYrbOs/BWKUVrE=;
        b=qPAMGbaVaeo4TSnXa/jPy/B1sVFyJcQ9XXvvJDIgVfcxnsn92jwLIKmJo8230+S/e4
         OD4c0mT2kS2+g+WboHkdfaiKr7/uSyfkAMxK1FR2yWjflNsSpsBv9Xtv1TWtg0uLl9zJ
         Gonx5TEnoNcyym+4dAYSGdzr77aVsquiW+JBMBlMs1jLn5EEotvDrV9YN3b1eGAkUD1S
         M7hH5+dZv4EO0fSjD4Bn0ChwYAwYpPYkpaahlrTsrx1Lf8CE1Q81j4R0yRnS/UakI4hc
         e7P5azyfog1ZIDg1f16JYveLbUGsOeRUv9uEyicxHgMRv1lIvvg/Q5Hj/oqoIE5yJxbQ
         WtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=Bx/RneEZBsmbH1D/h0ZOLo0rsUP9GAYrbOs/BWKUVrE=;
        b=il5rgG0OHwsmya9xKLkHd6gbTCVFnnTMm0uLV3qE63mwK4y7H5LPuqolk+6nyLwa3t
         Er8hoD5oaQ7G8gWyMDQBfPLmB0yklTIlle0SrpKla7P4ZG0tljbIJZULmk4+nSUP0773
         cEL0op4gL3rCGDefe+6iY5jbycEx8G6SV0M0mqZY9p7inLyuNpbd+XwcgvJ6e/TaGuza
         D/MmlX0bzmxkjtCBsYUdEFeDbenRNdz0vMlndTQ+F42LnRW1EPSKjrWIDmd7MGiZE8wh
         mDmpMi3jyURFE0BI3gguxlubfffqPF5agou5neKy0Pu6l6gFxu4i/uV8IDe7tQT8IzkH
         W7Ug==
X-Gm-Message-State: APjAAAVbTZHy8RMBQRlLZSF3004rJkNKPcADsOK8Wc1Da12exB3J9vY3
        aZRAuPipPOQLme3uCILcaWCE84UbrUlhe8kWvzXps0pC9PlvMSGvUtz2fMMBddyjo2dkAo+z5F4
        /+96pn5z3jwHFdSg6B4RXnxfU2VYlizg4sOLJNPOArLkcJ6F5VRQN1rAjW7DWBu5bR0qd8KccWw
        ==
X-Google-Smtp-Source: APXvYqwolKDOZLsfL53fxCs31MHlDPX0WHxRxV+M20p/Gk4v3bG+6wXu4IQHoyE6hjVeOTxH7aTljgGbfxVW5+WOoQw=
X-Received: by 2002:aca:3809:: with SMTP id f9mr1108017oia.119.1560556144910;
 Fri, 14 Jun 2019 16:49:04 -0700 (PDT)
Date:   Fri, 14 Jun 2019 16:48:55 -0700
In-Reply-To: <20190613215102.44627-1-emilyshaffer@google.com>
Message-Id: <20190614234855.257318-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3] rev-list: teach --no-object-names to enable piping
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

  git rev-list --objects HEAD | cut -f 1 -d ' ' \
    | git cat-file --batch-check

This was especially unexpected when dealing with root trees, as an
invisible whitespace exists at the end of the OID:

  git rev-list --objects --filter=tree:1 --max-count=1 HEAD \
    | xargs -I% echo "AA%AA"

Now, it can be piped directly, as in the added test case:

  git rev-list --objects --no-object-names HEAD | git cat-file --batch-check

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Change-Id: I489bdf0a8215532e540175188883ff7541d70e1b
---
Based on Peff and Junio's comments, made following changes since v2:

 - Removed interaction with commit objects
 - Renamed option to "no-object-names"
 - Removed warnings when new option is combined with commit-formatting
   options (and reflected in usage)
 - Simplified logic in show_object()

Thanks for the thoughts, all.

 - Emily

 builtin/rev-list.c       | 14 +++++++++++++-
 t/t6000-rev-list-misc.sh | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 660172b014..7e2598fd22 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -49,6 +49,7 @@ static const char rev_list_usage[] =
 "    --objects | --objects-edge\n"
 "    --unpacked\n"
 "    --header | --pretty\n"
+"    --no-object-names\n"
 "    --abbrev=<n> | --no-abbrev\n"
 "    --abbrev-commit\n"
 "    --left-right\n"
@@ -75,6 +76,9 @@ enum missing_action {
 };
 static enum missing_action arg_missing_action;
 
+/* display only the oid of each object encountered */
+static int arg_no_object_names;
+
 #define DEFAULT_OIDSET_SIZE     (16*1024)
 
 static void finish_commit(struct commit *commit);
@@ -255,7 +259,10 @@ static void show_object(struct object *obj, const char *name, void *cb_data)
 	display_progress(progress, ++progress_counter);
 	if (info->flags & REV_LIST_QUIET)
 		return;
-	show_object_with_name(stdout, obj, name);
+	if (arg_no_object_names)
+		printf("%s\n", oid_to_hex(&obj->oid));
+	else
+		show_object_with_name(stdout, obj, name);
 }
 
 static void show_edge(struct commit *commit)
@@ -484,6 +491,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		if (skip_prefix(arg, "--missing=", &arg))
 			continue; /* already handled above */
 
+		if (!strcmp(arg, ("--no-object-names"))) {
+			arg_no_object_names = 1;
+			continue;
+		}
+
 		usage(rev_list_usage);
 
 	}
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 0507999729..5d87171b99 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -48,6 +48,24 @@ test_expect_success 'rev-list --objects with pathspecs and copied files' '
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
+test_expect_success 'rev-list --oid-only is incompatible with --pretty' '
+	test_must_fail git rev-list --objects --oid-only --pretty HEAD &&
+	test_must_fail git rev-list --objects --oid-only --header HEAD
+'
+
 test_expect_success 'rev-list A..B and rev-list ^A B are the same' '
 	git commit --allow-empty -m another &&
 	git tag -a -m "annotated" v1.0 &&
-- 
2.22.0.410.gd8fdbe21b5-goog

