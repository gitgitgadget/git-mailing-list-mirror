Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF92C001DF
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 13:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjGKNbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 09:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjGKNbo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 09:31:44 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36101E6C
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 06:31:43 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7658752ce2fso416089085a.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689082302; x=1691674302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i587RNCUvdX8WA7bNKetV3Xxs2OD/ioIn1qkvZ84bbQ=;
        b=dM6l5LQocfQP6UkkxdDAHzE7jRsSp+JQfCFhAht8lz5BjMDUH5sSiHujygPiYrYvoU
         CYnWVEfa8EdEqa78hCo8HU9UE/rn3s69Z4v++lapgIzEAqHlsGKtaEGt77TmpRexkN4u
         pt8BsIY5xK8bPBx2nxXYumxuVA2fBsSbsKFw44r6dBqN1IKDT/wjCuXH4ke0aB1Smt1G
         OCjekA4WQEOR5BUm7VxoBidIIYP8W+nhuUVmb5g5FLEgwPDbYGVHlZtFpqxhH6i7lfzy
         uTeHUCz8KY2XkU99tRgXTjAQZk20b1iK5yDhIinyND17PjLK5Y+DWE++0HWf41om+n1H
         +EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689082302; x=1691674302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i587RNCUvdX8WA7bNKetV3Xxs2OD/ioIn1qkvZ84bbQ=;
        b=Ye8NI4LCPjFCfBzduUf0S32kKBAWwQikEiIZE62IeQQyLsUHMKIszrTciDYSw6CMAI
         FRFOCfcw4dh4RjlauPQNdcVS8iWs4Q8MXXpqiRoxEGxeeL+qKPFHEw8YXF3N8nqeNFD4
         qmE92YjF7V+xjmem+8Cia5bCL56+p4w5KhhdvCormk8eDIMMSoaEFZZXilLN2D0q9g5w
         X2sCm1BBimG6XrKV27MUzv3OOg3RhHEC/teGWVPfHW+2w1BiEDWBuk5b1Wfyejj5RJ0W
         6ZugQEypWRsgX+mTXCQvzPogoFLEM0TedoWohBwFMxK3ItD/nEOS/YlNKeIRTkJW+UM5
         KaFQ==
X-Gm-Message-State: ABy/qLaZo/5nUwcRhzGNL8Cyf6C+IpaPYcE9Mrn3A0416ERCjpzZLMkz
        AHD9GxV4sFVYszCjGi2+Z04CCrn9tfuuAw==
X-Google-Smtp-Source: APBJJlHv8TrpKaX0bZUHagfxnOe3Tslxyg2RFmDcq7BFtKm/3zWIEfUfL3+1XSVXn1NegwzcrTcxRQ==
X-Received: by 2002:a05:620a:450f:b0:767:d0c:9ec1 with SMTP id t15-20020a05620a450f00b007670d0c9ec1mr17770147qkp.59.1689082301887;
        Tue, 11 Jul 2023 06:31:41 -0700 (PDT)
Received: from localhost.localdomain ([69.158.190.118])
        by smtp.googlemail.com with ESMTPSA id oq5-20020a05620a610500b00766fbeb3e7csm966010qkn.132.2023.07.11.06.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:31:41 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v3 3/3] check-attr: integrate with sparse-index
Date:   Tue, 11 Jul 2023 09:30:35 -0400
Message-Id: <20230711133035.16916-4-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230711133035.16916-1-cheskaqiqi@gmail.com>
References: <20230707151839.504494-1-cheskaqiqi@gmail.com>
 <20230711133035.16916-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set the requires-full-index to false for "diff-tree".

Add a test to ensure that the index is not expanded whether the files
are outside or inside the sparse-checkout cone when the sparse index is
enabled.

The `p2000` tests demonstrate a ~63% execution time reduction for
'git check-attr' using a sparse index.

Test                                            before  after
-----------------------------------------------------------------------
2000.106: git check-attr -a f2/f4/a (full-v3)    0.05   0.05 +0.0%
2000.107: git check-attr -a f2/f4/a (full-v4)    0.05   0.05 +0.0%
2000.108: git check-attr -a f2/f4/a (sparse-v3)  0.04   0.02 -50.0%
2000.109: git check-attr -a f2/f4/a (sparse-v4)  0.04   0.01 -75.0%

Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 builtin/check-attr.c                     |  3 +++
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 15 +++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index b22ff748c3..c1da1d184e 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -122,6 +122,9 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, check_attr_options,
 			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	if (repo_read_index(the_repository) < 0) {
 		die("invalid cache");
 	}
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 96ed3e1d69..39e92b0841 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -134,5 +134,6 @@ test_perf_on_all git diff-files -- $SPARSE_CONE/a
 test_perf_on_all git diff-tree HEAD
 test_perf_on_all git diff-tree HEAD -- $SPARSE_CONE/a
 test_perf_on_all "git worktree add ../temp && git worktree remove ../temp"
+test_perf_on_all git check-attr -a -- $SPARSE_CONE/a
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 839e08d8dd..db2c38ab70 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2299,4 +2299,19 @@ test_expect_success 'check-attr with pathspec outside sparse definition' '
 	test_all_match git check-attr  -a --cached -- folder1/a
 '
 
+test_expect_success 'sparse-index is not expanded: check-attr' '
+	init_repos &&
+
+	echo "a -crlf myAttr" >>.gitattributes &&
+	mkdir ./sparse-index/folder1 &&
+	cp ./sparse-index/a ./sparse-index/folder1/a &&
+	cp .gitattributes ./sparse-index/deep &&
+	cp .gitattributes ./sparse-index/folder1 &&
+
+	git -C sparse-index add deep/.gitattributes &&
+	git -C sparse-index add --sparse  folder1/.gitattributes &&
+	ensure_not_expanded check-attr -a --cached -- deep/a &&
+	ensure_not_expanded check-attr -a --cached -- folder1/a
+'
+
 test_done
-- 
2.39.0

