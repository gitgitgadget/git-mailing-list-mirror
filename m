Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6363C433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 20:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239558AbiBRUxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 15:53:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239554AbiBRUxX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 15:53:23 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B406ADFFC
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 12:53:06 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so7245526wml.5
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 12:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oo85ptKQcRvpAdpINaciLMCQG5nIm0/o1a91PNPmYxQ=;
        b=jNSxH73zcbm5hZ5hC/LAypmszApEdvPN4zHUdBNRK5nY+NLoardarbfxOmkyasudv1
         vE/FVSKucEooGTjWc/VYk0F0WSSBzgrJZ76uQ/Ey2Lk3KdTrspTncb4ZY6rY2OZLfrnM
         SJlTcFDIZI3sBf2XzCj8gQXZ14AU/7aukAVgzoUvmFauB4xEZdS2+fIfTwqVkqW0gFMX
         +To6/pn3G87mP1/YWZ+jW50zhB1c4gzhyQTgheu8hJwedVIG4nEDu54owCz+sQu7nwtC
         D1duONrY8ecnQ0COx+XhSCOi5H4gJinJZKSwcqog+oR4j941fmo4pdEfu2pcA16V09uE
         G5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oo85ptKQcRvpAdpINaciLMCQG5nIm0/o1a91PNPmYxQ=;
        b=nEIFd4Wb7Ml04+5LSp6mlfzkVfNqFEOfh9DTtIaCgZdmoguLfgiIrHjolutKzlddqd
         AIO+fDDkHB91Tsrk6chGLYX/61xOWbd84DSDV2Exnjxbh+DrlIgVGPyG8W3luuRO1zER
         VgpQFC9DdBGJTPpPoOwx4f3068QkSRJE4UFFHd3P+EaV/9fE7EGqcu4F0CzNE8HjK36M
         dP5RQjh8UlI2iOJXknUXFf0VdJcwKsBCatXUr9nM66gelYvdAS1InBLJOg1FQk67Rn2v
         qJjvMujw0v5qrnF9C5s/VeP3YQVSL+Drkui6tWZK9RasuKZ9cKX8vjBk9kwxgBBw5EvJ
         lcqw==
X-Gm-Message-State: AOAM531MElejvRVHLKomKdgZK2qJQX8/tCUouHdwltdBA7O3RabXI23F
        H5qke1agPzdtrRMUdsCWL85yAT6pV6kKew==
X-Google-Smtp-Source: ABdhPJxajrhiwxtUhKxYgrfwjCEgIeWj96r90ZsiX7wXWTtj3BUkPiz8C/XgsvY3sx6ewQ/0RKN+0g==
X-Received: by 2002:a05:600c:4fd6:b0:352:c2c6:8f34 with SMTP id o22-20020a05600c4fd600b00352c2c68f34mr12452311wmq.186.1645217584659;
        Fri, 18 Feb 2022 12:53:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e3sm36076143wrr.94.2022.02.18.12.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 12:53:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Aaron Schrab <aaron@schrab.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] hook tests: test for exact "pre-push" hook input
Date:   Fri, 18 Feb 2022 21:52:58 +0100
Message-Id: <patch-1.2-7cf279205eb-20220218T204719Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1031.g277d4562d2e
In-Reply-To: <cover-0.2-00000000000-20220218T204719Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220218T204719Z-avarab@gmail.com>
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
index 660f876eec2..47f6eb509d6 100755
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
2.35.1.1031.g277d4562d2e

