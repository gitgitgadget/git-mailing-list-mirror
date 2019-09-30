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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BDA01F463
	for <e@80x24.org>; Mon, 30 Sep 2019 21:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbfI3VK1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 17:10:27 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:43782 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732627AbfI3VK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 17:10:27 -0400
Received: by mail-pf1-f174.google.com with SMTP id a2so6286642pfo.10
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 14:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xw9PesypsbgQp7G0GGZXS1KbVnHdc8F6rT05h/ptazc=;
        b=nLKR22IADkXvFyayrR1nJZ309NTS1yl1mRB7d2iQijGN06h/m0WrxO9AZIyKZTuwtY
         bHDjgr1SZhVC/r9ST/AlJ//7mwPjX99MS6V5PDw4p8vl93tR8fKfqaGz6mW382RTY1IJ
         t6nGDHp1rrW7xLvnefh/NCSCVwXaS7ffPUHNoNkwO4/qfGrarkYpqJ89XKPFs9CAMAJl
         B3ZSqJuH7dKGgQtdBhkt96itzrpLVhpKYh8YMw5SaHnBYmVM8TxKeH7rIOBN7OP4dEId
         J2u5cn0wBZYpTLw1mcTzG3qwBiSGxuV2PA1QnTyH4Hl4EWyuS4JNDb/7KdKwTTtWK4WS
         bZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xw9PesypsbgQp7G0GGZXS1KbVnHdc8F6rT05h/ptazc=;
        b=hnEUdLzF3CURS2kGcCq6Z8WUMyWZJxxbFzi+X4lSn9QJe80lIcYTbk6PxwDQIFf1Vw
         jaSkhaYgx/Ws15ogAhgelU7Z91YG46uhf5AXChyXp4ytBmOgfeQPq4Vy9jZM5tiSE63F
         f+019F4G3apaQp/jA6GQwG5P2Ndu3aOAWajkJT/ktxCDl4cVNzIPvzxotUZ2+4mKst+d
         YIIVvGrURvsSqL+bOb2EcFFOuFwnNMDoPJ/c2dr+nrV35xKuu8DsvhCHPCzIpXH4guwz
         rashEnexBkXQT5/45hRz+HI85PSzOPlpwBPjex4NuLs9zYiD2qFh3ad8XYNmbzhPWOJ0
         XUfQ==
X-Gm-Message-State: APjAAAWcAQfEns/+nu1mPV8s/U0l8gWmM/f19MfX2Duf7dNsorcMiqUA
        54FeaHpRb4tzom/y/OESblUzkhd0Ed0=
X-Google-Smtp-Source: APXvYqz44YNW/eLMnzIoIv33QNlRmpeZ0TfApXIQQo0FQHH1yRlduQCnSYTMSvYa1iXdhLuf9w7pkw==
X-Received: by 2002:a62:e917:: with SMTP id j23mr23719340pfh.50.1569877826223;
        Mon, 30 Sep 2019 14:10:26 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id w11sm13404609pfd.116.2019.09.30.14.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Sep 2019 14:10:25 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 3/8] fast-import: allow tags to be identified by mark labels
Date:   Mon, 30 Sep 2019 14:10:13 -0700
Message-Id: <20190930211018.23633-4-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.264.gac739dbb79
In-Reply-To: <20190930211018.23633-1-newren@gmail.com>
References: <20190925014005.17056-1-newren@gmail.com>
 <20190930211018.23633-1-newren@gmail.com>
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
index 546da3a938..0042440487 100644
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
2.23.0.264.gac739dbb79

