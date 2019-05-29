Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0BEC1F462
	for <e@80x24.org>; Wed, 29 May 2019 09:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfE2JLk (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 05:11:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44882 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfE2JLj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 05:11:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id c5so785985pll.11
        for <git@vger.kernel.org>; Wed, 29 May 2019 02:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZkU0Sy3kGo2Tpxjx47UMjQZq7d/ezG/8c+Qx3KTnaGM=;
        b=kND/JYiR45BGiPxvq3UZBF8W4sdKFoCSJxjolZX/wBkerpXieDoT+14V6ROozBFXW5
         P9uluWqWc3Mic/pyhhf+O+f4I4Y0V7ImTZOkY8IhVDvtMz76Uvdj3xyvDPoyWa/WJEMy
         foxxFXl+rrULvsRSvt3wSu724XMtT4Pb7tqZsx94VBBRYvKrpv85Oqv2Yvo3aqHw/1Go
         I5bYJ1ZLrMdM2Zh8XcEb4gvpjnTNVNr9oxN8PRU6T3H0g0jwvENV0Z6A1JbC61rJ8eHV
         upSdekVfJY4ad0zN8rIhydgHFk+spjyubARvAz3q42JHoePWtGwacMEKQnA8SzCWfFCp
         cAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZkU0Sy3kGo2Tpxjx47UMjQZq7d/ezG/8c+Qx3KTnaGM=;
        b=ZL1Iedk8J+i+vzPhFILftUZuXvqqoMHMH7vrgh8gMkgDbW44XQ5d4iNhdRLXH2csh3
         NLXQr0bWLGRgG2mBC5K8SIeh4HFj+R3RKwwRVCe9UmBK5DSsXwqPPM1jusiRUL0wupOp
         +APNTYatWYhuGJ44KXf9A8/oEKFCJ7hq3jVexH5LepZoQKkH8XyYudLDLVglV/xERS3z
         H82hAp5PdBxy065jHTkeVFlgJlcMouEwAxAs2tX94cQ3hYIS/iUaUGeu/v0c86mF03r/
         jZqmCRPl7muzyHzvXhVV2qoNTUkB12ZMDkSBiUqw4ulOnIijcsOBQun7igk8E+Lx0ezI
         OM5g==
X-Gm-Message-State: APjAAAWMRiIxWAuZTh0OHN4EQXuTMqGMC+4DiQMF6AwDZRTV1KATigsn
        iCoychLNhWHB30ByzDmsKV8=
X-Google-Smtp-Source: APXvYqyPmmjIOm0eHzwc2VPt6CRx8c/ZzD7LbeLJzTt1xwD0f7DPVTSuD7nJn8/B8AmyqSzBZwqJbg==
X-Received: by 2002:a17:902:9697:: with SMTP id n23mr35204811plp.283.1559121098789;
        Wed, 29 May 2019 02:11:38 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id e14sm16793838pff.60.2019.05.29.02.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 02:11:38 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 29 May 2019 16:11:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, bturner@atlassian.com, git@vger.kernel.org,
        gitster@pobox.com, tmz@pobox.com
Subject: [PATCH v2 2/3] diff-parseopt: restore -U (no argument) behavior
Date:   Wed, 29 May 2019 16:11:15 +0700
Message-Id: <20190529091116.21898-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190529091116.21898-1-pclouds@gmail.com>
References: <20190524092442.701-1-pclouds@gmail.com>
 <20190529091116.21898-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before d473e2e0e8 (diff.c: convert -U|--unified, 2019-01-27), -U and
--unified are implemented with a custom parser opt_arg() in diff.c. I
didn't check this code carefully and not realize that it's the
equivalent of PARSE_OPT_NONEG | PARSE_OPT_OPTARG.

In other words, if -U is specified without any argument, the option
should be accepted, and the default value should be used. Without
PARSE_OPT_OPTARG, parse_options() will reject this case and cause a
regression.

Reported-by: Bryan Turner <bturner@atlassian.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c                                    | 10 ++++---
 t/t4013-diff-various.sh                   |  2 ++
 t/t4013/diff.diff_-U1_initial..side (new) | 29 ++++++++++++++++++++
 t/t4013/diff.diff_-U2_initial..side (new) | 31 ++++++++++++++++++++++
 t/t4013/diff.diff_-U_initial..side (new)  | 32 +++++++++++++++++++++++
 5 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 4d3cf83a27..80ddc11671 100644
--- a/diff.c
+++ b/diff.c
@@ -5211,9 +5211,11 @@ static int diff_opt_unified(const struct option *opt,
 
 	BUG_ON_OPT_NEG(unset);
 
-	options->context = strtol(arg, &s, 10);
-	if (*s)
-		return error(_("%s expects a numerical value"), "--unified");
+	if (arg) {
+		options->context = strtol(arg, &s, 10);
+		if (*s)
+			return error(_("%s expects a numerical value"), "--unified");
+	}
 	enable_patch_output(&options->output_format);
 
 	return 0;
@@ -5272,7 +5274,7 @@ static void prep_parse_options(struct diff_options *options)
 			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
 		OPT_CALLBACK_F('U', "unified", options, N_("<n>"),
 			       N_("generate diffs with <n> lines context"),
-			       PARSE_OPT_NONEG, diff_opt_unified),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_unified),
 		OPT_BOOL('W', "function-context", &options->flags.funccontext,
 			 N_("generate diffs with <n> lines context")),
 		OPT_BIT_F(0, "raw", &options->output_format,
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 9f8f0e84ad..a9054d2db1 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -338,6 +338,8 @@ format-patch --inline --stdout initial..master^^
 format-patch --stdout --cover-letter -n initial..master^
 
 diff --abbrev initial..side
+diff -U initial..side
+diff -U1 initial..side
 diff -r initial..side
 diff --stat initial..side
 diff -r --stat initial..side
diff --git a/t/t4013/diff.diff_-U1_initial..side b/t/t4013/diff.diff_-U1_initial..side
new file mode 100644
index 0000000000..b69f8f048a
--- /dev/null
+++ b/t/t4013/diff.diff_-U1_initial..side
@@ -0,0 +1,29 @@
+$ git diff -U1 initial..side
+diff --git a/dir/sub b/dir/sub
+index 35d242b..7289e35 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -2 +2,3 @@ A
+ B
++1
++2
+diff --git a/file0 b/file0
+index 01e79c3..f4615da 100644
+--- a/file0
++++ b/file0
+@@ -3 +3,4 @@
+ 3
++A
++B
++C
+diff --git a/file3 b/file3
+new file mode 100644
+index 0000000..7289e35
+--- /dev/null
++++ b/file3
+@@ -0,0 +1,4 @@
++A
++B
++1
++2
+$
diff --git a/t/t4013/diff.diff_-U2_initial..side b/t/t4013/diff.diff_-U2_initial..side
new file mode 100644
index 0000000000..8ffe04f203
--- /dev/null
+++ b/t/t4013/diff.diff_-U2_initial..side
@@ -0,0 +1,31 @@
+$ git diff -U2 initial..side
+diff --git a/dir/sub b/dir/sub
+index 35d242b..7289e35 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++1
++2
+diff --git a/file0 b/file0
+index 01e79c3..f4615da 100644
+--- a/file0
++++ b/file0
+@@ -2,2 +2,5 @@
+ 2
+ 3
++A
++B
++C
+diff --git a/file3 b/file3
+new file mode 100644
+index 0000000..7289e35
+--- /dev/null
++++ b/file3
+@@ -0,0 +1,4 @@
++A
++B
++1
++2
+$
diff --git a/t/t4013/diff.diff_-U_initial..side b/t/t4013/diff.diff_-U_initial..side
new file mode 100644
index 0000000000..c66c0dd5c6
--- /dev/null
+++ b/t/t4013/diff.diff_-U_initial..side
@@ -0,0 +1,32 @@
+$ git diff -U initial..side
+diff --git a/dir/sub b/dir/sub
+index 35d242b..7289e35 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++1
++2
+diff --git a/file0 b/file0
+index 01e79c3..f4615da 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++A
++B
++C
+diff --git a/file3 b/file3
+new file mode 100644
+index 0000000..7289e35
+--- /dev/null
++++ b/file3
+@@ -0,0 +1,4 @@
++A
++B
++1
++2
+$
-- 
2.22.0.rc0.322.g2b0371e29a

