Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5291C0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 14:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbjHKOXC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 10:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbjHKOXA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 10:23:00 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881C42D78
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 07:22:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-26b0b92e190so1216318a91.1
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 07:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691763775; x=1692368575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqpmKic0LF5yfjzjyZXryHcsAXau2MJS3mu7++6nKgQ=;
        b=W7ZkL4I970hIlGzz4kNush6J0Do6RssYudnkW7ULk0ScuIaDhfzBetm+G2+k0+6iwX
         eermwR12AdOMt4ptSGbmIimjl16AEgCpmgo2UxMDCHyBgC+XRDyfGbDFwwRB5AtNNa7M
         jGi9xy8kd/rc2Y3CzW5rha7aHaopc0K2PQblK5F2/+YJMilRnsYFYMBQzUZWmph194Ba
         roJODhYCpcgL6JNzFBIffs3EJMUYF+t2Orsi7s0txIuiAUBqwxuVhoWls/UUoMFyGr+R
         40bNpHjSb2FOV0sj7WGWRqaJ9iylwjFz0lSUR0Wjn4WR/c5V00eMOJqNzztVoo8Vcamw
         cjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691763775; x=1692368575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqpmKic0LF5yfjzjyZXryHcsAXau2MJS3mu7++6nKgQ=;
        b=XXb7fShce8ViStjUe1yr4ozFwCjaWdrRFcCaNlpB8ln561TJkz/uzQdQDGNt5H0J0+
         ORJbikFaAC/4PZX/rRj4TTbmIu58lfVOafIzy9V7VhqGzHebxByxcqC2g+dVgoDzb6cK
         3XycVg0XOLXQBRstS79ZoppAPPo1Ay3otRYoOvFBrK/QHLpqyCAxJ1M+YcCN349y8FOM
         uBIYScyO3i32hHiD0yJD7YvVT/E/t58eFu3l2mf9oAVSRw4V2kihIaKkQCJtDQpaBe2Z
         TRTqAddcv/poYQfJfU5PZ1hY4OyISiSqLNCLui6RUaC5eMs993mxRCcoIsVuU+lE8yyL
         8SZA==
X-Gm-Message-State: AOJu0YxDH7WVwCtGRm8h5Ex8VO6eXQYCb/X7ian94gUeEDjjVoON1tuw
        UXIwmT+fZJqE/3cgnlbzenz50F7tKR4z8GGQ
X-Google-Smtp-Source: AGHT+IH7O/3+h4XiMX9UAIOLBmUmltFZTqf/U1DrXFpDTMmCwU4aRp9bHyFbrm0ofgyIt01toKiIsw==
X-Received: by 2002:a17:90a:6fa1:b0:269:4fe8:687 with SMTP id e30-20020a17090a6fa100b002694fe80687mr2789631pjk.19.1691763775476;
        Fri, 11 Aug 2023 07:22:55 -0700 (PDT)
Received: from cheska.. ([120.231.214.68])
        by smtp.googlemail.com with ESMTPSA id p2-20020a17090a284200b00264044cca0fsm10000329pjf.1.2023.08.11.07.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 07:22:55 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v5 3/3] check-attr: integrate with sparse-index
Date:   Fri, 11 Aug 2023 10:22:11 -0400
Message-Id: <20230811142211.4547-4-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230811142211.4547-1-cheskaqiqi@gmail.com>
References: <20230718232916.31660-1-cheskaqiqi@gmail.com>
 <20230811142211.4547-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set the requires-full-index to false for "check-attr".

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
index dc84b3e2e1..2a4f35e984 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2316,4 +2316,19 @@ test_expect_failure 'diff --check with pathspec outside sparse definition' '
 	test_all_match test_must_fail git diff --check --cached -- folder1/a
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
+	git -C sparse-index add --sparse folder1/.gitattributes &&
+	ensure_not_expanded check-attr -a --cached -- deep/a &&
+	ensure_not_expanded check-attr -a --cached -- folder1/a
+'
+
 test_done
-- 
2.39.0

