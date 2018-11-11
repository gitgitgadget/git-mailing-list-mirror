Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66EE61F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 06:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeKKQLL (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 11:11:11 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36337 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbeKKQLK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 11:11:10 -0500
Received: by mail-oi1-f193.google.com with SMTP id r127-v6so4765373oie.3
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 22:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mtfZyQCvGTLrItylsV4YbZAfxEuQI5GK14yAcs/anmQ=;
        b=NMw0IWbjMjR21qnKqJiO0VwYmHaQhAjsfzgANKDiFQ/XGihzwvp0KN5y10Hs13QcmC
         DZyP8nD/6oQQzXwDvrt+rruJDPt6HFlqkGum+w0TbeY+NhQRNaq7xs3FvC7cr/CkX87E
         OP0pj2lEd28hTzo9SksVOO8xxg1Ac7XKbYnf5ZoYHb/Fsj9KD6xVlu5uF32SorK42nCY
         y7lqVyjTWMYp1ImbbPFB5ojAKK+70PYsWEEu8nJSH0l2PtWQrxaryOvPnhP+EwC4H7RX
         XJ9VDRdvaWvuZ2JiIpEo8zgaCw8U9PFzvAz4m/BNPk3zIZpgd0k25Bhf7Aj4Wpkrph4r
         82iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mtfZyQCvGTLrItylsV4YbZAfxEuQI5GK14yAcs/anmQ=;
        b=k9nN8UOpaZGAFTq0Wr9Vg3PvWdskde0DgGMmVasJsZXTIovwrcSWqopyqmOwHL0kXQ
         YRNJuBKXGv+gPdGv+bz4ku4E4UX02dPA4gBb8bvfdBQ4u5f8irS7lImr9JFojjXDrMC3
         DZjQ4najfKYFK6A5KcC8XEgQ2I2xwRucKRVu2Nov/O8glLu8VaJxtYtnhEg7a2sM/Pz6
         0PwNfEMjgzBvhgEQzB5prgQGFd+fHTRVZpbWmtGvOopB9EhQcsd5CZfc6T3lG4sIZ1Zz
         6g+btoew97voqCKi/MMIKljGIkXshbKYcPUGLDK5vfPWQQ2xFfYfoIcwHTWfL1EkRIb6
         mAow==
X-Gm-Message-State: AGRZ1gLQR5iFAOIRlGBcXqz2NRL7kWN5ZYkdE58DYRXUmmEWNKZXfiIG
        4l3I9MTeoGt56Bbf8RBcVm/n2stW
X-Google-Smtp-Source: AJdET5d+8Lgtxg+vk3ZOw6EZlPE0gPTNH4/pgNlncX+Cs9ZLu6gUTWEz6PhdWKpidNoR4zDQOpDL4w==
X-Received: by 2002:aca:3807:: with SMTP id f7-v6mr2068132oia.46.1541917411699;
        Sat, 10 Nov 2018 22:23:31 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id f34sm1286855otb.25.2018.11.10.22.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Nov 2018 22:23:31 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     larsxschneider@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net, me@ttaylorr.com, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 10/10] fast-export: add --always-show-modify-after-rename
Date:   Sat, 10 Nov 2018 22:23:12 -0800
Message-Id: <20181111062312.16342-11-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.866.g82735bcbde
In-Reply-To: <20181111062312.16342-1-newren@gmail.com>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fast-export output is traditionally used as an input to a fast-import
program, but it is also useful to help gather statistics about the
history of a repository (particularly when --no-data is also passed).
For example, two of the types of information we may want to collect
could include:
  1) general information about renames that have occurred
  2) what the biggest objects in a repository are and what names
     they appear under.

The first bit of information can be gathered by just passing -M to
fast-export.  The second piece of information can partially be gotten
from running
    git cat-file --batch-check --batch-all-objects
However, that only shows what the biggest objects in the repository are
and their sizes, not what names those objects appear as or what commits
they were introduced in.  We can get that information from fast-export,
but when we only see
    R oldname newname
instead of
    R oldname newname
    M 100644 $SHA1 newname
then it makes the job more difficult.  Add an option which allows us to
force the latter output even when commits have exact renames of files.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-export.txt | 11 ++++++++++
 builtin/fast-export.c             |  7 +++++-
 t/t9350-fast-export.sh            | 36 +++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 4e40f0b99a..946a5aee1f 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -128,6 +128,17 @@ marks the same across runs.
 	for intermediary filters (e.g. for rewriting commit messages
 	which refer to older commits, or for stripping blobs by id).
 
+--always-show-modify-after-rename::
+	When a rename is detected, fast-export normally issues both a
+	'R' (rename) and a 'M' (modify) directive.  However, if the
+	contents of the old and new filename match exactly, it will
+	only issue the rename directive.  Use this flag to have it
+	always issue the modify directive after the rename, which may
+	be useful for tools which are using the fast-export stream as
+	a mechanism for gathering statistics about a repository.  Note
+	that this option only has effect when rename detection is
+	active (see the -M option).
+
 --refspec::
 	Apply the specified refspec to each ref exported. Multiple of them can
 	be specified.
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index cc01dcc90c..db606d1fd0 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -38,6 +38,7 @@ static int use_done_feature;
 static int no_data;
 static int full_tree;
 static int reference_excluded_commits;
+static int always_show_modify_after_rename;
 static int show_original_ids;
 static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 static struct string_list tag_refs = STRING_LIST_INIT_NODUP;
@@ -407,7 +408,8 @@ static void show_filemodify(struct diff_queue_struct *q,
 				putchar('\n');
 
 				if (oideq(&ospec->oid, &spec->oid) &&
-				    ospec->mode == spec->mode)
+				    ospec->mode == spec->mode &&
+				    !always_show_modify_after_rename)
 					break;
 			}
 			/* fallthrough */
@@ -1099,6 +1101,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 			 &reference_excluded_commits, N_("Reference parents which are not in fast-export stream by sha1sum")),
 		OPT_BOOL(0, "show-original-ids", &show_original_ids,
 			    N_("Show original sha1sums of blobs/commits")),
+		OPT_BOOL(0, "always-show-modify-after-rename",
+			    &always_show_modify_after_rename,
+			 N_("Always provide 'M' directive after 'R'")),
 
 		OPT_END()
 	};
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 5ad6669910..d0c30672ac 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -638,4 +638,40 @@ test_expect_success 'merge commit gets exported with --import-marks' '
 	)
 '
 
+test_expect_success 'rename detection and --always-show-modify-after-rename' '
+	test_create_repo renames &&
+	(
+		cd renames &&
+		test_seq 0  9  >single_digit &&
+		test_seq 10 98 >double_digit &&
+		git add . &&
+		git commit -m initial &&
+
+		echo 99 >>double_digit &&
+		git mv single_digit single-digit &&
+		git mv double_digit double-digit &&
+		git add double-digit &&
+		git commit -m renames &&
+
+		# First, check normal fast-export -M output
+		git fast-export -M --no-data master >out &&
+
+		grep double-digit out >out2 &&
+		test_line_count = 2 out2 &&
+
+		grep single-digit out >out2 &&
+		test_line_count = 1 out2 &&
+
+		# Now, test with --always-show-modify-after-rename; should
+		# have an extra "M" directive for "single-digit".
+		git fast-export -M --no-data --always-show-modify-after-rename master >out &&
+
+		grep double-digit out >out2 &&
+		test_line_count = 2 out2 &&
+
+		grep single-digit out >out2 &&
+		test_line_count = 2 out2
+	)
+'
+
 test_done
-- 
2.19.1.866.g82735bcbde

