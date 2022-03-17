Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAB8C433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 10:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiCQKOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiCQKOq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 06:14:46 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B2FD9E9F
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso2876336wmr.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JIJcFKNFRQjbS5SfiqIp1E/FXNU+GOjWRm0zJcwKD/8=;
        b=P2FTxrn2dUWwJb6hVxm7b3LnzIHy6SCOQgp0j3WZOpD6WnnIDMbVrAfYo8V1br/4Wm
         AsuuCgtC75aAFh9DxBH32btrwCmy9nFmSth9QL+tqmi1KQVAgqWHgIbLk9fuE+ZnfoEh
         4W7UYq9BrNe/iS4l7YI/yyrj6Nru8bdd0LTwtn+Cr4RMI9k4mm/xN41xnJBipKy9QjQo
         OHf3kV8owfwMgX4iQ1Mm8BAzT5X0Tfrjy8Zi3/soubzZNNg50CZTlvqwvUqajFKNNhT4
         xY7Ye/nfHzNv4rs2sXx3sJcKMFOAPvop9bGHlCfUPS97OxTeRql/wKEvvqFyAhYys4r9
         jGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JIJcFKNFRQjbS5SfiqIp1E/FXNU+GOjWRm0zJcwKD/8=;
        b=r+o9bO5MANqnzRPnWJqa8VMwLojZuSiStsVFzfEe1MY1fdyiTaVCUhn0tfIhP4udWQ
         hTod4PTIOmqIe/crAxUFzmuTFio4v1vq5EW3vUz+8QbgMg51OduyqOXBM3wU1vJh7FWG
         JrDPOkohnv3C5XDsuylTc+I9HVqtknS/zMSX+tD2tp5bBu6UVdYk0tQPU/X6Ipum6Bi8
         QgDADaDh02b/4fT1KSOsWMH6aWDOw+L8fxBaZISZ6npLQ13W0i1eIVWnxoEJEpIplOBg
         u91t7myDar/6w5Xw8onjJwnrxNXYLQvatxQ/DTOHp0wLXtX0mJYGANLehsvOnE/gRqsc
         j8ag==
X-Gm-Message-State: AOAM533fVr4SKLc1CPoH41vuwztSOsgbITbovRDUiP3Ay0+IrM+1YsjN
        zU+7OVzJM25RBrVW4ZQIVlV9nu3InSI=
X-Google-Smtp-Source: ABdhPJwoLZUZK/VZJAdJTGgv6ouxpyp2FZGTFPJ+gCdey8dYwgXxg2NHtyvGuN/wJvitPvnMpVH86Q==
X-Received: by 2002:a05:600c:a53:b0:38a:fc5:3a90 with SMTP id c19-20020a05600c0a5300b0038a0fc53a90mr3270153wmq.15.1647512007732;
        Thu, 17 Mar 2022 03:13:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b0038bfc3ab76csm3903236wma.48.2022.03.17.03.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 03:13:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/13] bugreport tests: tighten up "git bugreport -s hooks" test
Date:   Thu, 17 Mar 2022 11:13:10 +0100
Message-Id: <patch-v3-05.13-c21e3e43a55-20220317T100820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend a test added in 788a776069b (bugreport: collect list of
populated hooks, 2020-05-07) to "test_cmp" for the expected output,
instead of selectively using "grep" to check for specific things we
either expect or don't expect in the output.

As noted in a preceding commit our .git/hooks directory already
contains *.sample hooks, so we have no need to clobber the
prepare-commit-msg.sample hook in particular.

Instead we should assert that those *.sample hooks are not included in
the output, and for good measure let's add a new "unknown-hook", to
check that we only look through our own known hooks. See
cfe853e66be (hook-list.h: add a generated list of hooks, like
config-list.h, 2021-09-26) for how we generate that data.

We're intentionally not piping the "actual" output through "sort" or
similar, we'd also like to check that our reported hooks are sorted.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0091-bugreport.sh | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index eeedbfa9193..08f5fe9caef 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -60,18 +60,22 @@ test_expect_success 'can create leading directories outside of a git dir' '
 
 test_expect_success 'indicates populated hooks' '
 	test_when_finished rm git-bugreport-hooks.txt &&
-	test_when_finished rm -fr .git/hooks &&
-	rm -fr .git/hooks &&
-	mkdir .git/hooks &&
-	for hook in applypatch-msg prepare-commit-msg.sample
-	do
-		write_script ".git/hooks/$hook" <<-EOF || return 1
-		echo "hook $hook exists"
-		EOF
-	done &&
+
+	test_hook applypatch-msg <<-\EOF &&
+	true
+	EOF
+	test_hook unknown-hook <<-\EOF &&
+	true
+	EOF
 	git bugreport -s hooks &&
-	grep applypatch-msg git-bugreport-hooks.txt &&
-	! grep prepare-commit-msg git-bugreport-hooks.txt
+
+	sort >expect <<-\EOF &&
+	[Enabled Hooks]
+	applypatch-msg
+	EOF
+
+	sed -ne "/^\[Enabled Hooks\]$/,/^$/p" <git-bugreport-hooks.txt >actual &&
+	test_cmp expect actual
 '
 
 test_done
-- 
2.35.1.1384.g7d2906948a1

