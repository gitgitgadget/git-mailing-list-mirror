Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66164C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4936108E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345293AbhIBNOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345207AbhIBNNt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:49 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75484C0619F6
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:15 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id z9-20020a7bc149000000b002e8861aff59so1432863wmi.0
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HKcjdgoq9juBix53/qIEgCUDSBlrNwK94m/unX61Mbs=;
        b=CjduTw+El4UboPE9TfGEl3E3+KcQ0k9p+B5W8ZjXtOfI4Uq5wi1IGoTvSAnNnnL6L/
         gcBor9/c+V5Zd3nX8e4JpaBz39gieAj/VbLr9XDN73qcZkE7l6E9CB7jat3ZHCz4rB/7
         T7cTfU2PRMPlTT6VX2SwmzOG0LjvubceEe9RnmHljucyLhy3eFsd5qe5Ikp7donyFcfd
         Y1v5fek9EYx44nB0pLGq4xEyfrH1bmOVdOcPxYBgTYwXa2o7EhNerniC8LyYWK9PQ9OZ
         oaqkqRXLsHNcxkk84e6AATT13ZSmyyPXGOCrUPkJWYts9wjlwRJUU6Wim91nBqbqfgrg
         6rOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HKcjdgoq9juBix53/qIEgCUDSBlrNwK94m/unX61Mbs=;
        b=GxumHSZINsEYSemK8cX+wLsgznobjaADO5jP2f5nsipyXTgtXpqxHfZ32cVomtazpO
         lJf4sL9PN7efHnA7RA0G++maN3mFTuZ5f+KInG2nMMYXhIybT9lLsi1KfbpHrXbQDumr
         sZMbryQ+nxBIJ15jspyDAJP5nJCZ9NT5jRfmarriMVtwcpX50kknK3C+25pNtcvyy6nk
         9j/eaSY8jBgHXcGGBErBNdD3zfq5jf7wQLx52FXJmKu3UHXa0NiphNwGBUo2WzvJqi5r
         C1Zl0P2mSqqfgEpzrwmzRXvf8vS8LMrbPpeDVVNrh5RDLcWZ7fHdcxZT57f8IWXj+ejS
         79ZQ==
X-Gm-Message-State: AOAM531sppbPs0ZzO7+Ve4jOeQ/CqInd9hiE7/U/jM2/TkpU2Ov/Zndu
        RK5kwDp4D3f1GUQD1p3f5yp0sxWcWPsSPA==
X-Google-Smtp-Source: ABdhPJzkNQR0aJ032Z2YDTnXJX0rj0GO1V/0JiKOswTd/HAHb4tjFjZkX5fzvcs59yXCMEYmydHqGw==
X-Received: by 2002:a05:600c:230a:: with SMTP id 10mr3063620wmo.79.1630588333842;
        Thu, 02 Sep 2021 06:12:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:12:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 28/36] hook tests: test for exact "pre-push" hook input
Date:   Thu,  2 Sep 2021 15:11:28 +0200
Message-Id: <patch-v5-28.36-957691f0b6d-20210902T125111Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the tests added in ec55559f937 (push: Add support for pre-push
hooks, 2013-01-13) to exhaustively test for the exact input we're
expecting. This ensures that we e.g. don't miss a trailing newline.

Appending to a file called "actual" is the established convention in
this test for hooks, see the rest of the tests added in
ec55559f937 (push: Add support for pre-push hooks, 2013-01-13). Let's
follow that convention here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5571-pre-push-hook.sh | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index ad8d5804f7b..d2857a6fbc0 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -11,7 +11,7 @@ HOOKDIR="$(git rev-parse --git-dir)/hooks"
 HOOK="$HOOKDIR/pre-push"
 mkdir -p "$HOOKDIR"
 write_script "$HOOK" <<EOF
-cat >/dev/null
+cat >actual
 exit 0
 EOF
 
@@ -20,10 +20,16 @@ test_expect_success 'setup' '
 	git init --bare repo1 &&
 	git remote add parent1 repo1 &&
 	test_commit one &&
-	git push parent1 HEAD:foreign
+	cat >expect <<-EOF &&
+	HEAD $(git rev-parse HEAD) refs/heads/foreign $(test_oid zero)
+	EOF
+
+	test_when_finished "rm actual" &&
+	git push parent1 HEAD:foreign &&
+	test_cmp expect actual
 '
 write_script "$HOOK" <<EOF
-cat >/dev/null
+cat >actual
 exit 1
 EOF
 
@@ -32,11 +38,18 @@ export COMMIT1
 
 test_expect_success 'push with failing hook' '
 	test_commit two &&
-	test_must_fail git push parent1 HEAD
+	cat >expect <<-EOF &&
+	HEAD $(git rev-parse HEAD) refs/heads/main $(test_oid zero)
+	EOF
+
+	test_when_finished "rm actual" &&
+	test_must_fail git push parent1 HEAD &&
+	test_cmp expect actual
 '
 
 test_expect_success '--no-verify bypasses hook' '
-	git push --no-verify parent1 HEAD
+	git push --no-verify parent1 HEAD &&
+	test_path_is_missing actual
 '
 
 COMMIT2="$(git rev-parse HEAD)"
-- 
2.33.0.816.g1ba32acadee

