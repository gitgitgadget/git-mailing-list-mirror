Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBFC51F463
	for <e@80x24.org>; Wed, 25 Sep 2019 01:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411370AbfIYBkS (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 21:40:18 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:39748 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389596AbfIYBkR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 21:40:17 -0400
Received: by mail-pg1-f173.google.com with SMTP id u17so2259208pgi.6
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 18:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OumwuTqVmtGx/iUW4iyLL8K9MG5ULwEe2xoWD+7MpXw=;
        b=A6RRd7iYnEi4ojOyzs8ukhAf2ikpbR50ygUM+axcJZidrO9zM9ApU8nXEcHD2BA9l/
         JG9Ie/8YWTD8gAEzkNhNb2FmLRw1Hk0x8t0mddWiGjDynvyamzHv4y1OckhGs6tlWSTe
         e2KltquC2eSZ3J2HmmInYwHH77I8TeJob20uoJljuc5qgFY+qJZHtz/8K1JwHHTkutSe
         lkiNY0FSQlle9btoT2k20Kx8aq+znZUKndunnxfoNcccnAJgfXBcCy8eIZCHBkOp5xRb
         53s7XtI7Prg4rvyxC+t72vfseuoIDuz4PSza3ixTRfqVInyfluzsJP8jMsWQMesVv/Jx
         mmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OumwuTqVmtGx/iUW4iyLL8K9MG5ULwEe2xoWD+7MpXw=;
        b=qXPOYtspd4c/CDZGmBYIPfB4kK+X1HBqaMVhhyULYVFLYDq77k5XZ8m1E+Z1UQjqew
         2lZ9fjITWEnTvaGMtu6GhjsMreTz52eDD0aa3xB1KGhsvuavqxxU00knga3DXPd3ynUt
         aAbghhBz93fmKr5bp8kj2qsPRmJaiJzaNVIfA+gTMYXmK0tUPCW8kH5Z/p/Kest4zxKw
         mbJE5k2ImZkShlr80/jZynmdgVo55a9EUeykvQXll9MD7PujZAhvqjjCUBVq8ZeQECEw
         FePQao3JWD6FLr1m9GrBfpreHZC/nbRik2W0OT1hDipLM/XcBb4hUOmnpEg9RtXWedpu
         TYSw==
X-Gm-Message-State: APjAAAW2ZFGBPnfQnVkDQ37/4qq6NpejE34qUodVN3eirbfvyQubG0jq
        zdDXV6YvsIlRW/kVIh/7ZxJsBR43Svg=
X-Google-Smtp-Source: APXvYqxb/kJFW+gR/UavkU9wCWQmFUrZYS0mVCdjvD5jy42+pFgMXgG+WU+pKt85zIHYB9fvhxzmcQ==
X-Received: by 2002:a17:90a:be08:: with SMTP id a8mr3525214pjs.92.1569375615255;
        Tue, 24 Sep 2019 18:40:15 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id h4sm3759050pgg.81.2019.09.24.18.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Sep 2019 18:40:14 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 3/8] fast-import: allow tags to be identified by mark labels
Date:   Tue, 24 Sep 2019 18:40:00 -0700
Message-Id: <20190925014005.17056-4-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.177.g8af0b3ca64
In-Reply-To: <20190925014005.17056-1-newren@gmail.com>
References: <20190925014005.17056-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark identifiers are used in fast-export and fast-import to provide a
label to refer to earlier content.  Blobs are given labels because they
need to be referenced in the commits where they first appear with a
given filename, and commits are given labels because they can be the
parents of other commits.  Tags were never given labels, probably
because they were viewed as unnecessary, but that presents two problems:

   1. It leaves us without a way of referring to previous tags if we
      want to create a tag of a tag (or higher nestings).
   2. It leaves us with no way of recording that a tag has already been
      imported when using --export-marks and --import-marks.

Fix these problems by allowing an optional mark label for tags.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-import.txt |  1 +
 fast-import.c                     |  3 ++-
 t/t9300-fast-import.sh            | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 0bb276269e..4977869465 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -774,6 +774,7 @@ lightweight (non-annotated) tags see the `reset` command below.
 
 ....
 	'tag' SP <name> LF
+	mark?
 	'from' SP <commit-ish> LF
 	original-oid?
 	'tagger' (SP <name>)? SP LT <email> GT SP <when> LF
diff --git a/fast-import.c b/fast-import.c
index dab905d667..0271d81d0d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2713,6 +2713,7 @@ static void parse_new_tag(const char *arg)
 		first_tag = t;
 	last_tag = t;
 	read_next_command();
+	parse_mark();
 
 	/* from ... */
 	if (!skip_prefix(command_buf.buf, "from ", &from))
@@ -2769,7 +2770,7 @@ static void parse_new_tag(const char *arg)
 	strbuf_addbuf(&new_data, &msg);
 	free(tagger);
 
-	if (store_object(OBJ_TAG, &new_data, NULL, &t->oid, 0))
+	if (store_object(OBJ_TAG, &new_data, NULL, &t->oid, next_mark))
 		t->pack_id = MAX_PACK_ID;
 	else
 		t->pack_id = pack_id;
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 74bc41333b..3ad2b2f1ba 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -94,6 +94,23 @@ test_expect_success 'A: create pack from stdin' '
 	reset refs/tags/to-be-deleted
 	from 0000000000000000000000000000000000000000
 
+	tag nested
+	mark :6
+	from :4
+	data <<EOF
+	Tag of our lovely commit
+	EOF
+
+	reset refs/tags/nested
+	from 0000000000000000000000000000000000000000
+
+	tag nested
+	mark :7
+	from :6
+	data <<EOF
+	Tag of tag of our lovely commit
+	EOF
+
 	INPUT_END
 	git fast-import --export-marks=marks.out <input &&
 	git whatchanged master
@@ -176,6 +193,8 @@ test_expect_success 'A: verify marks output' '
 	:3 $(git rev-parse --verify master:file3)
 	:4 $(git rev-parse --verify master:file4)
 	:5 $(git rev-parse --verify master^0)
+	:6 $(git cat-file tag nested | grep object | cut -d" " -f 2)
+	:7 $(git rev-parse --verify nested)
 	EOF
 	test_cmp expect marks.out
 '
-- 
2.23.0.177.g8af0b3ca64

