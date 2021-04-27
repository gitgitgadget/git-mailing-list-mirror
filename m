Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F26C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 19:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B87761026
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 19:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbhD0Tll (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 15:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238696AbhD0Tlj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 15:41:39 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EF3C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 12:40:55 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id m37so516374pgb.8
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 12:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h8NhP3EVCN1cA6VR/KvJSNFe5X5YbPHilRs9Z6KgkNI=;
        b=DZVDG6JB7ryvPlSN7B/UfO+m9Rp+n1rMrh3afzSS9T2JC8r7aHg/yIU5neHdny3T+X
         aQMo2FNLlU13qDAeZ+GdKwVtf/jcpEn86UeIqDOQhW8jQzBy3uRIvCGiBUXjaENEs/7e
         weKlwHTRDHouZ1L7IeUR6cOZl54hLt185JlZjeltZ+umWvUwzR2aiWGVpEzIIahY5Srx
         j1fzmVaCY5sGicQ0MFHlzS9IANRrAb7haf33kYR4YDxA2H6o1uuOrwiz3oowV9tawO9E
         lgpiIUnCfTO1ndMZocSHvqbuqDiU4TCZwJei6EvOOxbF1qyGyVuDWuED4LmrGx30pkb9
         VfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h8NhP3EVCN1cA6VR/KvJSNFe5X5YbPHilRs9Z6KgkNI=;
        b=qhdhQ1/CXD7uFhobEylhnfb6sh1bKiwBU+rL8AayajsLH/Vhqeot4EyEZ2bIikEs5p
         zLhrIkra7V/6i1MBjRl4YUFpC94hSTUU8wQHQpU6tZkRg6+EtA1eBpIeYRFPjdM024KC
         n0APR/0FteLlmpmBnTpT/PjtNaYCF45QAm6g/dEarZhkHBHfWJncUbiB/l7WrONSeMcB
         WZC2X9naS/jFNCF9UcdVd6h/tLYi/Yan7Furps/4As+Orz0IR2JXPKToLTw6u1/4+QAD
         QfEuZH+VW2+45jddLoUCdYVPq2bC0oHpK6abH7lWo0dxYx+6fIniElf6WXwChJOatzGf
         p9qA==
X-Gm-Message-State: AOAM533WUsuG+w/gvilQVj7oZcbhX5LGNZacRyoXKUq6Lmfnlt+QPsqX
        a9Ar7QqgWRlHBrhGTxlhhsHdjktxF7rMXzdK
X-Google-Smtp-Source: ABdhPJyifNQ2HJUMbM80Ai/KQjEaY9TOcfvrlVSKeh9dwru24JKeEK7pxvZRF31iBZD72AvyNtL05w==
X-Received: by 2002:a63:d14b:: with SMTP id c11mr24085958pgj.290.1619552454281;
        Tue, 27 Apr 2021 12:40:54 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id m5sm2917885pjc.10.2021.04.27.12.40.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Apr 2021 12:40:53 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     ross@skydio.com, abe@skydio.com, brian.kubisiak@skydio.com,
        Jerry Zhang <jerry@skydio.com>
Subject: [PATCH V2] git-apply: add --allow-empty flag
Date:   Tue, 27 Apr 2021 12:40:49 -0700
Message-Id: <20210427194049.14399-1-jerry@skydio.com>
X-Mailer: git-send-email 2.31.1.367.g30381d2e76
In-Reply-To: <20210427011246.28054-1-jerry@skydio.com>
References: <20210427011246.28054-1-jerry@skydio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some users or scripts will pipe "git diff"
output to "git apply" when replaying diffs
or commits. In these cases, they will rely
on the return value of "git apply" to know
whether the diff was applied successfully.

However, for empty commits, "git apply" will
fail. This complicates scripts since they
have to either buffer the diff and check
its length, or run diff again with "exit-code",
essentially doing the diff twice.

Add the "--allow-empty" flag to "git apply"
which allows it to handle both empty diffs
and empty commits created by "git format-patch
--always" by doing nothing and returning 0.

Add tests for both with and without --allow-empty.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
This patch applies on top of "git-apply: add --quiet flag".
The conflict is in Documentation -> Synopsis and is
trivial to solve.

V1 -> V2:
- Moved behavior under a flag
- Added tests for both cases

 Documentation/git-apply.txt |  6 +++++-
 apply.c                     |  8 ++++++--
 apply.h                     |  1 +
 t/t4126-apply-empty.sh      | 16 ++++++++++++++++
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index a32ad64718..b6d77f4206 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	  [--ignore-space-change | --ignore-whitespace]
 	  [--whitespace=(nowarn|warn|fix|error|error-all)]
 	  [--exclude=<path>] [--include=<path>] [--directory=<root>]
-	  [--verbose | --quiet] [--unsafe-paths] [<patch>...]
+	  [--verbose | --quiet] [--unsafe-paths] [--allow-empty] [<patch>...]
 
 DESCRIPTION
 -----------
@@ -256,6 +256,10 @@ When `git apply` is used as a "better GNU patch", the user can pass
 the `--unsafe-paths` option to override this safety check.  This option
 has no effect when `--index` or `--cached` is in use.
 
+--allow-empty::
+	Don't return error for patches containing no diff. This includes
+	empty patches and patches with commit text only.
+
 CONFIGURATION
 -------------
 
diff --git a/apply.c b/apply.c
index 918e0988bb..0ddde5e8a8 100644
--- a/apply.c
+++ b/apply.c
@@ -4732,8 +4732,10 @@ static int apply_patch(struct apply_state *state,
 	}
 
 	if (!list && !skipped_patch) {
-		error(_("unrecognized input"));
-		res = -128;
+		if (!state->allow_empty) {
+			error(_("unrecognized input"));
+			res = -128;
+		}
 		goto end;
 	}
 
@@ -5061,6 +5063,8 @@ int apply_parse_options(int argc, const char **argv,
 		OPT_CALLBACK(0, "directory", state, N_("root"),
 			N_("prepend <root> to all filenames"),
 			apply_option_parse_directory),
+		OPT_BOOL(0, "allow-empty", &state->allow_empty,
+			N_("don't return error for empty patches")),
 		OPT_END()
 	};
 
diff --git a/apply.h b/apply.h
index da3d95fa50..16202da160 100644
--- a/apply.h
+++ b/apply.h
@@ -66,6 +66,7 @@ struct apply_state {
 	int threeway;
 	int unidiff_zero;
 	int unsafe_paths;
+	int allow_empty;
 
 	/* Other non boolean parameters */
 	struct repository *repo;
diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
index ceb6a79fe0..f89c53c5f6 100755
--- a/t/t4126-apply-empty.sh
+++ b/t/t4126-apply-empty.sh
@@ -31,6 +31,22 @@ test_expect_success 'apply empty' '
 	test_cmp expect empty
 '
 
+test_expect_success 'apply empty patch fails' '
+	git reset --hard &&
+	git commit --allow-empty -m "empty commit" &&
+	git format-patch --always HEAD~ >empty.patch &&
+	test_must_fail git apply empty.patch &&
+	test_must_fail git apply - </dev/null
+'
+
+test_expect_success 'apply with --allow-empty succeeds' '
+	git reset --hard &&
+	git commit --allow-empty -m "empty commit" &&
+	git format-patch --always HEAD~ >empty.patch &&
+	git apply --allow-empty empty.patch &&
+	git apply --allow-empty - </dev/null
+'
+
 test_expect_success 'apply --index empty' '
 	git reset --hard &&
 	rm -f missing &&
-- 
2.29.0

