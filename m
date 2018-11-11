Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28CD71F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 06:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeKKQLD (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 11:11:03 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45795 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeKKQLD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 11:11:03 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so4721769ota.12
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 22:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zf8DEGUnzTd5YbCJ6JXA1bfCOXUQG87b2q3bqn4b1Js=;
        b=bpUblVRW+smTlzMT3Y3VHGEtHx8RB1VaBHsp0uFHmA9SdSkHGLoicsY6oTHFz8mb+T
         zxA18sxlgIoDyloO4hMkf8cbKmFJK/2UPiTrYezcodR6nP38ERtwBlDtBAODmrjfMM8K
         58Xc3DoIxutZOE9AEwBGIQUnFz8nuNJl53i5+a+o/zhtB1w9v6lxTrX9nlhRM4Y7BnNt
         R14gseTT0wMGDUZD4tmx7K5cgcu80kWv8X7TLhsm5MjTl1qhKxiyntTrSMmr/tyHriez
         H2hSwkBqsoXfQ2fZOqyB+Ju7GBBPosYjfli5EH+sb8RwiIUnEwAL1ItJqS96RzrPAYpk
         k+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zf8DEGUnzTd5YbCJ6JXA1bfCOXUQG87b2q3bqn4b1Js=;
        b=cOao1FbPCnnb2EHUMlvTjvVTSJuQo8DAGzXsxjnOY4jryz6Hl8V4zXYDDLHg8hpTlO
         dVm0qvetUVDESF0qCHnQz98O0FJkzwhkl5e/TjzwXRJiS7TeCz7AOjckIJUC25N4oe0A
         BC1E6V3+oA+zt9Jj/yOGp3bfLWpxiqCOVq/mtFQfarprkoPihnve5wWlWEqps9HPox59
         8nynE5cInO+ob+WBU642tRa1FP/nzBLVLmmCyOQuNg6oD2epEBbwHt67yOFEgh2IZt9Y
         fWX8wHLBtguAetaFUwpD00QJaHHV17jDXTMh1EdMTrZl47tIBoRipTpt5wnEhqWk0oDI
         RjOA==
X-Gm-Message-State: AGRZ1gJSeOw6EYbsb5Xiza9TtbWIO4sRP1mKlwUzTr075dBDCZdBj6ta
        pAlfYir0hPXkWC6qbLcGSlDCY7BN
X-Google-Smtp-Source: AJdET5fHY0DCLFkMBxKW1T5eFq3/k+WDa0/+o/PTAzy9jPS6UaRBLhMrEZ45Bw5Rpt7qEVDH+mgr/w==
X-Received: by 2002:a9d:7502:: with SMTP id r2mr9406542otk.273.1541917403924;
        Sat, 10 Nov 2018 22:23:23 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id f34sm1286855otb.25.2018.11.10.22.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Nov 2018 22:23:23 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     larsxschneider@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net, me@ttaylorr.com, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 04/10] fast-export: avoid dying when filtering by paths and old tags exist
Date:   Sat, 10 Nov 2018 22:23:06 -0800
Message-Id: <20181111062312.16342-5-newren@gmail.com>
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

If --tag-of-filtered-object=rewrite is specified along with a set of
paths to limit what is exported, then any tags pointing to old commits
that do not contain any of those specified paths cause problems.  Since
the old tagged commit is not exported, fast-export attempts to rewrite
such tags to an ancestor commit which was exported.  If no such commit
exists, then fast-export currently die()s.  Five years after the tag
rewriting logic was added to fast-export (see commit 2d8ad4691921,
"fast-export: Add a --tag-of-filtered-object  option for newly dangling
tags", 2009-06-25), fast-import gained the ability to delete refs (see
commit 4ee1b225b99f, "fast-import: add support to delete refs",
2014-04-20), so now we do have a valid option to rewrite the tag to.
Delete these tags instead of dying.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c  |  9 ++++++---
 t/t9350-fast-export.sh | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 1a299c2a21..89de9d6400 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -774,9 +774,12 @@ static void handle_tag(const char *name, struct tag *tag)
 					break;
 				if (!(p->object.flags & TREESAME))
 					break;
-				if (!p->parents)
-					die("can't find replacement commit for tag %s",
-					     oid_to_hex(&tag->object.oid));
+				if (!p->parents) {
+					printf("reset %s\nfrom %s\n\n",
+					       name, sha1_to_hex(null_sha1));
+					free(buf);
+					return;
+				}
 				p = p->parents->item;
 			}
 			tagged_mark = get_object_mark(&p->object);
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 6a392e87bc..5bf21b4908 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -325,6 +325,26 @@ test_expect_success 'rewriting tag of filtered out object' '
 )
 '
 
+test_expect_success 'rewrite tag predating pathspecs to nothing' '
+	test_create_repo rewrite_tag_predating_pathspecs &&
+	(
+		cd rewrite_tag_predating_pathspecs &&
+
+		touch ignored &&
+		git add ignored &&
+		test_commit initial &&
+
+		git tag -a -m "Some old tag" v0.0.0.0.0.0.1 &&
+
+		echo foo >bar &&
+		git add bar &&
+		test_commit add-bar &&
+
+		git fast-export --tag-of-filtered-object=rewrite --all -- bar >output &&
+		grep -A 1 refs/tags/v0.0.0.0.0.0.1 output | grep -E ^from.0{40}
+	)
+'
+
 cat > limit-by-paths/expected << EOF
 blob
 mark :1
-- 
2.19.1.866.g82735bcbde

