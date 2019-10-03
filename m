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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DDA51F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 20:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbfJCU1W (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 16:27:22 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:41400 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJCU1V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 16:27:21 -0400
Received: by mail-pl1-f174.google.com with SMTP id t10so2031488plr.8
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 13:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vsL9D9C+xGSJMKgH6ztcRLf/tZGCHwzhHGJAAg/eKwM=;
        b=T3V/csI8ONqMlkPpLox4B7VW1TZuqeTG+/XryTG3UWxP6iVL321a5oq3nggU2+4z9t
         mxm6KyBBHmrfBBBtwldT9a06FVv9ZKQRp6IOBflSbyc/0EakQ3H2n5p14zwYa8exaECt
         IuAHtYv/8O6TSihFTlia43IZy+C8/duRIUGFhyH2rocz0+pWQNOyO8cM9k/7BJgHAmt4
         xE9kCAmfTxHQa6zHl5sBPaIZgjOfIEuKvLLyLclM7VZfojrBBKH3wbbH2t6Jj4ARex1F
         ipmiSNtj0MoeBwya0NnXUSG1vgbl0DvHP8wJ8GUIzifFcTivypE5FPdpb38WWXfDD938
         lttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vsL9D9C+xGSJMKgH6ztcRLf/tZGCHwzhHGJAAg/eKwM=;
        b=ZpG/g4ZQWHZi2aEMGtGTEU08+F04nsiTHEjzZGflZUqU2enmCXFs56ou8SrwRxeQZj
         9UkLlB6A9EQ3MTmEPywy4vkNZYOaW+szjSczxH82XBU39V/4o7D7QS49jmGHfoZhBRE5
         F7sF48xuvj2X2DUadqIvsIAYvJyAqw83yQPOi+p9Z/qyF0wyZW8E3NVuuv1WKgxwH6NS
         XeYbzPgPUE6uAMuS39SG9ZYwZamOZGTB9WbjcqObcXiIi1x0ZzMWcG5Y/+s+NPFNxBPO
         vhr1azVsxQmjs2Pp2KUFC4Nnf0nbjRUL6r2HeKAaJqN5Goekv7wJOwR+qGdRDpHrnU+j
         pXYQ==
X-Gm-Message-State: APjAAAUHIAznZdXWKvARHA6EiluQtrWA9htUHw88t1zazaYxKkObtiSI
        MCHhKg2dwCI5B1FwZfr/BXU=
X-Google-Smtp-Source: APXvYqxU1s2z7JHSCsi359ZNplmvGU+cQlq85AQAjFQN+D25LVxtYTAW+E97Z8z6R18kF4/H+Qec4Q==
X-Received: by 2002:a17:902:6b4c:: with SMTP id g12mr11748042plt.80.1570134438812;
        Thu, 03 Oct 2019 13:27:18 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id c64sm4055498pfc.19.2019.10.03.13.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Oct 2019 13:27:18 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH -v3 3/8] fast-import: allow tags to be identified by mark labels
Date:   Thu,  3 Oct 2019 13:27:04 -0700
Message-Id: <20191003202709.26279-4-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.264.g3b9f7f2fc6
In-Reply-To: <20191003202709.26279-1-newren@gmail.com>
References: <20190930211018.23633-1-newren@gmail.com>
 <20191003202709.26279-1-newren@gmail.com>
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
index caae0819f5..5b9e9e3b02 100644
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
2.23.0.264.g3b9f7f2fc6

