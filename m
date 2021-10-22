Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A38C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE0A60EB8
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhJVI6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 04:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbhJVI6K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 04:58:10 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C45C061243
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 01:55:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r10so395390wra.12
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 01:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLdcbX4FsDO3bKhkiNV7H6izC80ybg2FKj8JSLwRl9E=;
        b=Kzx5cEg8xuhqqJIIXZK9VnZ9GfXGRxCRpd+0612MwOk8BXfuJcyWNHeIjmRKXeSpp4
         axmeT5rw34gvN8P+pb7Dqrgrv9DZO2XkpXtTMu9qADunuhEnEF6WdQ9JYf7S3NvzKwb0
         uj0LcUR7AjM3Rsu6a5y8PeyrfsZsK2Rl9fwWbcVX5/gEMjl1k2rGEmSH2j5q72x9ppeS
         I2UmJI5pxoSH/ZtbG0y4pvZhntORD2RhtJIIYs0/pUTLsiAsLXatoku1HwH6w0LwcE1M
         lxUXiSL6SZ5bkd2i1GoRyHlVZ5dJzzd3wHR2QU4yPAhgOBp1uPkh7+w+vkfUwhtytlLU
         OTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLdcbX4FsDO3bKhkiNV7H6izC80ybg2FKj8JSLwRl9E=;
        b=jQCOicBMqtJ7ljgtgTJGEIwzg2/CIfrqvOl2oxCxQO4KavzI0C1ASqJEEYZFlV2SBK
         4sIPUqakuu2QbHR671qTMn9y4nKXVQQueQx3XPRTurCHCdbUNn82d8rdsLeS6HrOWP6c
         une0ASHySo/9gfjMP70WTY854HYI+i0cimMQzvwOa78ndAwlKuk39LOLFj3rYaNtBcww
         P8SThT8MDPKW20ltipaHWx3xofL+N6GTE6xfdW/qBjmHy2IVt1/jhfnOKFLYtd1ZAh32
         S2D95rmjtFyboRo4UpAOArh8czpDGwo3flJIjx+h1kvl1AkpKbRFdbXGzNZ8GK0djo4d
         pstw==
X-Gm-Message-State: AOAM530Ub4MK2lsY683DednoNlUKTA6zSFYNteksEB04SUJNiTUtZkkt
        yIkcZpP+jA2mpA/tYQo6G8AammKsDMGdBg==
X-Google-Smtp-Source: ABdhPJw34KSq127iD2nQwEuwIPHdKoubiH9dtdJvL2YiARI2VuLOAMhX4rkyutU2RMVXetARrDuA6g==
X-Received: by 2002:adf:e9c8:: with SMTP id l8mr13634746wrn.188.1634892951035;
        Fri, 22 Oct 2021 01:55:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b19sm10609069wmj.9.2021.10.22.01.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 01:55:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/6] grep: fix a "path_list" memory leak
Date:   Fri, 22 Oct 2021 10:55:41 +0200
Message-Id: <patch-v2-3.6-8e941e40711-20211022T085306Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-v2-0.6-00000000000-20211022T085306Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20211022T085306Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Free the "path_list" used in builtin/grep.c, it was declared as
STRING_LIST_INIT_NODUP, let's change it to a STRING_LIST_INIT_DUP
since an early user in cmd_grep() appends a string passed via
parse-options.c to it, which needs to be duplicated.

Let's then convert the remaining callers to use
string_list_append_nodup() instead, allowing us to free the list.

This makes all the tests in t7811-grep-open.sh pass, 6/10 would fail
before this change. The only remaining failure would have been due to
a stray "git checkout" (which still leaks memory). In this case we can
use a "git reset --hard" instead, so let's do that, and move the
test_when_finished() above the code that would modify the relevant
file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c       | 9 +++++----
 t/t7811-grep-open.sh | 3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 555b2ab6008..9e34a820ad4 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -401,7 +401,7 @@ static void append_path(struct grep_opt *opt, const void *data, size_t len)
 
 	if (len == 1 && *(const char *)data == '\0')
 		return;
-	string_list_append(path_list, xstrndup(data, len));
+	string_list_append_nodup(path_list, xstrndup(data, len));
 }
 
 static void run_pager(struct grep_opt *opt, const char *prefix)
@@ -839,7 +839,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	struct grep_opt opt;
 	struct object_array list = OBJECT_ARRAY_INIT;
 	struct pathspec pathspec;
-	struct string_list path_list = STRING_LIST_INIT_NODUP;
+	struct string_list path_list = STRING_LIST_INIT_DUP;
 	int i;
 	int dummy;
 	int use_index = 1;
@@ -1159,8 +1159,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			strbuf_addf(&buf, "+/%s%s",
 					strcmp("less", pager) ? "" : "*",
 					opt.pattern_list->pattern);
-			string_list_append(&path_list,
-					   strbuf_detach(&buf, NULL));
+			string_list_append_nodup(&path_list,
+						 strbuf_detach(&buf, NULL));
 		}
 	}
 
@@ -1195,6 +1195,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (hit && show_in_pager)
 		run_pager(&opt, prefix);
 	clear_pathspec(&pathspec);
+	string_list_clear(&path_list, 0);
 	free_grep_patterns(&opt);
 	object_array_clear(&list);
 	free_repos();
diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index a98785da795..1dd07141a7d 100755
--- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -3,6 +3,7 @@
 test_description='git grep --open-files-in-pager
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pager.sh
 unset PAGER GIT_PAGER
@@ -114,8 +115,8 @@ test_expect_success 'modified file' '
 	unrelated
 	EOF
 
+	test_when_finished "git reset --hard" &&
 	echo "enum grep_pat_token" >unrelated &&
-	test_when_finished "git checkout HEAD unrelated" &&
 	GIT_PAGER=./less git grep -F -O "enum grep_pat_token" >out &&
 	test_cmp expect actual &&
 	test_must_be_empty out
-- 
2.33.1.1494.g88b39a443e1

