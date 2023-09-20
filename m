Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D05C00454
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 15:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbjITPDC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjITPDA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 11:03:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BC8A9
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 08:02:54 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50307acd445so6862917e87.0
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695222172; x=1695826972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pP4w3Oxz4rxyFace+/ZmI4kvPP53bAC/w/sfylrAsWE=;
        b=SO7SI/Ze7pnJsoVEwM8WHhZgGDeIXhZENkRXcRXcgyMfXD0SLzO6uzwY/4C7VeyxH3
         Y1HE//XRhJF6jv7Zij1hjCfgROyWQFPKBU6ZWV8hRCKbKJCN661pbzOz43jykUmInTYU
         SUKlqcv612Qp6vBqWKGc6Kr0UgTGIm6Dlb5i/4YOEZq7vgcd0V2x5tcEzc04XntT0Bhs
         12MN/gCaQiQLHMpB0C+v18vGnoFwZ+8eFW49+MT6N62Pq23hDkivrG0Oe1f60fJ0AuF1
         BOCj3dZ3LZuwbAZ9Sy/8eyfMgIioE5zBklGdJ+vy9P5gxnANhG9jhasbMSTQtOkpJJpM
         1y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695222172; x=1695826972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pP4w3Oxz4rxyFace+/ZmI4kvPP53bAC/w/sfylrAsWE=;
        b=BiUqBJARl10kbzYexlHT3188jj0GxUZVDtfdLyGogKL16oFzvfMYallSte+xtVDmHz
         kXhkqRkJ2mmhiqRSz3+HHYXWsUdYS5Nub4cbROBMsLXz6kOaVDeTDBvKAfOhIfec4u+I
         FIiLA2l/8gGmuxn66LaK7xYd/f428w/PCtnq/UMgb1KzZ+pTrxF4E5c6UVOWmye/msu0
         QF9+JouUejsXE/tvFMJGU+5/RjiTxGZjDBB5fKI4CEUDJM3InwEN6Tljgn0A3OPZ6HHi
         1iQlBpiL+w0mImJ8D77RrBn1M6j29b8VhV3mGT1juxceLpMFdO8IujZs9Om/eFy8Qyr0
         SFBw==
X-Gm-Message-State: AOJu0YwW7fcNcf7NgiBHh7S0voth2591HZ9SXTagPbtvix9dvWH6ySmL
        JttAEk0c5tFi2K2iEzh/WsY=
X-Google-Smtp-Source: AGHT+IHcbW8ZpdoFlOOIJh8CmJNDqSDq/XRN0oeKOyBu3yhs/fKFfi5pgNlpEzH58rjunLvKFPsqSw==
X-Received: by 2002:a05:6512:114f:b0:503:2e6:6862 with SMTP id m15-20020a056512114f00b0050302e66862mr3376184lfg.32.1695222172364;
        Wed, 20 Sep 2023 08:02:52 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q12-20020ac25a0c000000b004f37bd02a89sm2701741lfn.287.2023.09.20.08.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:02:51 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 2/2] diff-merges: introduce '-d' option
Date:   Wed, 20 Sep 2023 18:02:44 +0300
Message-Id: <20230920150244.171772-3-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230920150244.171772-1-sorganov@gmail.com>
References: <20230909125446.142715-1-sorganov@gmail.com>
 <20230920150244.171772-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option provides a shortcut to request diff with respect to first
parent for any kind of commit, universally. It's implemented as pure
synonym for "--diff-merges=first-parent --patch".

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt | 4 ++++
 Documentation/git-log.txt      | 2 +-
 diff-merges.c                  | 3 +++
 t/t4013-diff-various.sh        | 8 ++++++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 8035210c1418..19bb78ff6652 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -48,6 +48,10 @@ ifdef::git-log[]
 	similar to '--diff-merges=on' (which see) except `-m` will
 	produce no output unless `-p` is given as well.
 
+-d::
+	Produce diff with respect to first parent.
+	Shortcut for '--diff-merges=first-parent -p'.
+
 -c::
 	Produce combined diff output for merge commits.
 	Shortcut for '--diff-merges=combined -p'.
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 9b7ec96e767a..59bd74a1a596 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -120,7 +120,7 @@ By default, `git log` does not generate any diff output. The options
 below can be used to show the changes made by each commit.
 
 Note that unless one of `--diff-merges` variants (including short
-`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
+`-d`, `-m`, `-c`, and `--cc` options) is explicitly given, merge commits
 will not show a diff, even if a diff format like `--patch` is
 selected, nor will they match search options like `-S`. The exception
 is when `--first-parent` is in use, in which case `first-parent` is
diff --git a/diff-merges.c b/diff-merges.c
index ec97616db1df..6eb72e6fc28a 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -125,6 +125,9 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 	if (!suppress_m_parsing && !strcmp(arg, "-m")) {
 		set_to_default(revs);
 		revs->merges_need_diff = 0;
+	} else if (!strcmp(arg, "-d")) {
+		set_first_parent(revs);
+		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
 		revs->merges_imply_patch = 1;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5de1d190759f..a07d6eb6dd97 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -473,6 +473,14 @@ test_expect_success 'log --diff-merges=on matches --diff-merges=separate' '
 	test_cmp expected actual
 '
 
+test_expect_success 'log -d matches --diff-merges=1 -p' '
+	git log --diff-merges=1 -p master >result &&
+	process_diffs result >expected &&
+	git log -d master >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'deny wrong log.diffMerges config' '
 	test_config log.diffMerges wrong-value &&
 	test_expect_code 128 git log
-- 
2.25.1

