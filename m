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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B0151F462
	for <e@80x24.org>; Thu, 13 Jun 2019 21:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfFMVvX (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 17:51:23 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43890 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfFMVvW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 17:51:22 -0400
Received: by mail-pf1-f202.google.com with SMTP id j7so215037pfn.10
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 14:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=Y1Yik7+cFULme6AAG2G1XyUtNRXeAu/yj36xlo99Fl4=;
        b=bLgVM8O/8IMtj/DBBBMyOLpXIILsmLO1LTs1DDzYCPQ9tWUQp+m/+Oj3uOKoqh9hga
         mktqJfL0UOxpuBOLVdcaEW3iaB92zquxWhdgnEJQiBwYFA7yDdBvSZvCuqVeWfBs2sfV
         TaaD0UbMZjkoI2xdLeYTOaugbV7otzxzphfcTDKgyWzKAE/YWelrrPumsHA4MT8KFHAD
         61/cfN9GrSiChqX9Zr2BSJApF62DvBloKNkGEOhGU0pJ+p+6NoNrYyeJruY7a1q58vMZ
         Ldhu6H/MOJUo2fS8VHsJQtD0fo29eSlVTI6rVTOWb7wssPpJ5UpR/OXfE8NfjWnG2lPR
         TAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=Y1Yik7+cFULme6AAG2G1XyUtNRXeAu/yj36xlo99Fl4=;
        b=N45LdXf3Os9kK5/gZkSeI4bkj2JVDU2f0017pN1T7gUHYaJvBhOLkKgdG9hQ+8fyGB
         IOa+VUpGJ4VoaqITPQZW6cnQeg3KM+qMfHSRO6efc1e/xED5codWhtn6m8pMD5FDBxB4
         uyRLO5wGquHDLihXTKhw2njhLTeJK3Pdbr3+BYEO2kZLUIYLh+Kug7Cfi2BD61kTOPTl
         CCaX3nZU8p+jGxGBaVhYRvFGThI60N2/euvIXN7elZ3LP/gGWNXCsQPy8YvL8lK3PlzE
         8I3TRvf6UkQpYNwybbNDPFKHe1xk2Yp4Y9MyTSrwxgPI0vkmrJEZTVWxw7PHVLd0YDSe
         RNCQ==
X-Gm-Message-State: APjAAAXH7Vpt/NM5Rwm/kn8IixfawPL1bjgbuiL0qD3ivTpCOvxbIdvM
        tSt3tkB+seeyWfgbjFH7UglWsjg5YOgTb/nPZw32ePMhInjERWHjWM8Q6JiujV3/utmHEUgibkl
        mYlYm8jmeoDrs205NSynaJevA0HrgpRrYYKpFElnAOwa5WNxKx87/Agjy5jdLvGW4TCpQpqibeA
        ==
X-Google-Smtp-Source: APXvYqzTMqUrGYGvrLYsO9aFq4aeeibWq21EsP1LibMxcAJn6CHIETuiJSQ+npsuJtuMeQ6+XLR6n/4DB3mKXHVPaaA=
X-Received: by 2002:a63:574b:: with SMTP id h11mr7298780pgm.25.1560462681337;
 Thu, 13 Jun 2019 14:51:21 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:51:03 -0700
In-Reply-To: <20190607225900.89299-1-emilyshaffer@google.com>
Message-Id: <20190613215102.44627-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2] rev-list: teach --oid-only to enable piping
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow easier parsing by cat-file by giving rev-list an option to print
only the OID of an object without any additional information. This is a
short-term shim; later on, rev-list should be taught how to print the
types of objects it finds in a format similar to cat-file's.

Before this commit, the output from rev-list needed to be massaged
before being piped to cat-file, like so:

  git rev-list --objects HEAD | cut -f 1 -d ' ' \
    | git cat-file --batch-check

This was especially unexpected when dealing with root trees, as an
invisible whitespace exists at the end of the OID:

  git rev-list --objects --filter=tree:1 --max-count=1 HEAD \
    | xargs -I% echo "AA%AA"

Now, it can be piped directly, as in the added test case:

  git rev-list --objects --oid-only HEAD | git cat-file --batch-check

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Change-Id: I489bdf0a8215532e540175188883ff7541d70e1b
---
It didn't appear that using an existing --pretty string would do the
trick, as the formatting options for --pretty apply specifically to
commit objects (you can specify the commit hash and the tree hash, but
I didn't see a way to more generally pretty-print all types of objects).
rev-list doesn't appear to use parse-options-h, so I added a new option
as simply as I could see without breaking existing style; it seemed
wrong to add a flag to the `struct rev_list_info` as the definition of
struct and flag values alike are contained in bisect.h. There are a
couple other options to rev-list which are stored as globals.

At the moment, this doesn't work with --abbrev, and although I think
it'd be a good fit, right now --abbrev doesn't seem to work without
--abbrev-commit, and both those options end up being eaten by
setup_revisions() rather than by rev-list itself.

 - Emily

 builtin/rev-list.c       | 21 ++++++++++++++++++++-
 t/t6000-rev-list-misc.sh | 18 ++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 9f31837d30..ff07ea9564 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -48,7 +48,7 @@ static const char rev_list_usage[] =
 "    --children\n"
 "    --objects | --objects-edge\n"
 "    --unpacked\n"
-"    --header | --pretty\n"
+"    --header | --pretty | --oid-only\n"
 "    --abbrev=<n> | --no-abbrev\n"
 "    --abbrev-commit\n"
 "    --left-right\n"
@@ -75,6 +75,8 @@ enum missing_action {
 };
 static enum missing_action arg_missing_action;
 
+static int arg_oid_only; /* display only the oid of each object encountered */
+
 #define DEFAULT_OIDSET_SIZE     (16*1024)
 
 static void finish_commit(struct commit *commit, void *data);
@@ -90,6 +92,11 @@ static void show_commit(struct commit *commit, void *data)
 		return;
 	}
 
+	if (arg_oid_only) {
+		printf("%s\n", oid_to_hex(&commit->object.oid));
+		return;
+	}
+
 	graph_show_commit(revs->graph);
 
 	if (revs->count) {
@@ -255,6 +262,10 @@ static void show_object(struct object *obj, const char *name, void *cb_data)
 	display_progress(progress, ++progress_counter);
 	if (info->flags & REV_LIST_QUIET)
 		return;
+	if (arg_oid_only) {
+		printf("%s\n", oid_to_hex(&obj->oid));
+		return;
+	}
 	show_object_with_name(stdout, obj, name);
 }
 
@@ -484,6 +495,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		if (skip_prefix(arg, "--missing=", &arg))
 			continue; /* already handled above */
 
+		if (!strcmp(arg, ("--oid-only"))) {
+			arg_oid_only = 1;
+			continue;
+		}
+
 		usage(rev_list_usage);
 
 	}
@@ -499,6 +515,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		/* Only --header was specified */
 		revs.commit_format = CMIT_FMT_RAW;
 
+	if (arg_oid_only && revs.commit_format != CMIT_FMT_UNSPECIFIED)
+		die(_("cannot combine --oid-only and --pretty or --header"));
+
 	if ((!revs.commits && reflog_walk_empty(revs.reflog_info) &&
 	     (!(revs.tag_objects || revs.tree_objects || revs.blob_objects) &&
 	      !revs.pending.nr) &&
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 0507999729..996ba1799b 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -48,6 +48,24 @@ test_expect_success 'rev-list --objects with pathspecs and copied files' '
 	! grep one output
 '
 
+test_expect_success 'rev-list --objects --oid-only has no whitespace/names' '
+	git rev-list --objects --oid-only HEAD >output &&
+	! grep wanted_file output &&
+	! grep unwanted_file output &&
+	! grep " " output
+'
+
+test_expect_success 'rev-list --objects --oid-only is usable by cat-file' '
+	git rev-list --objects --oid-only --all >list-output &&
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
2.22.0.rc2.383.gf4fbbf30c2-goog

