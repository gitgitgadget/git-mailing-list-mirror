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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4866CC197BF
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F8B023A22
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgLHA2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbgLHA2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:28:16 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77BEC0611CB
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:27:07 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id x13so6834567oto.8
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kMAJv4uj8ftdk5LXHn2yCEjBfJ/TR6LfKZhTE9hG4fI=;
        b=aEDcFAllCxmYmyw2muyQf2jMZQnRb9D3VlLQGOZKOY/JoKdrZjyMP2fLM2HaR9JpCA
         xjgGRvUnEZ3PDV9QAWxzf4oPEmclcvWa8+bFMcAamH1l1YjAh2MqYtlNnk3FFamfCxPT
         82XEopWCOnK2PMNHcIXH0ZjyONcXxvo8vHYjFUjvy/EkMmn5ei6kXccJyqR4nZDf9dZB
         SJQ5Ap7CL2NScBq4bunTCZ6FyJK1uCrRcRaspRGYVvW5rONUsukytYb0Fb3rHvX1ibn5
         yuWUnY6eCUJfTO/yTyb2g8PZsqtlYaTVqixME7NUKsgFGVsYUiM+b6jlmQnDK29y3US7
         il9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kMAJv4uj8ftdk5LXHn2yCEjBfJ/TR6LfKZhTE9hG4fI=;
        b=pZvdc4Us+XpKwhzGsy0bNvFb7iOyKuSatOLV32t5A86OAyP9QsHo8IeNz9HVtKta4a
         355XQrh40aEHN0cZt4InTb/g5xxSUHQjtcqjYX4469Yv3Iswy2EiSi+Gfdb4fzkY/xao
         u6rTc9p0DDF7UGSemB3KSRB7D1yu2oFXPBP56mEuhSmHC1o1F/aRPaUVsTx2SEa4VbdK
         t7UwNe3C0oso5uOI4dOaQ8HNUTyoW572MWl1YpBVYHkFkmhVM/oble4g/JbxvZtzx17g
         6I2c2mhjiYkGmZ6t58C+5KdpTeu1SNxuTTCHOKs9aneCsQTW7spJegzRPtUHwtfzccsR
         MY9Q==
X-Gm-Message-State: AOAM530YuXACkKHhvNcfeWSAp5yDOoi2hrRb7uGJPwooj/iFPQS2xuAz
        UV3YuCtOIZTQbiG0mUz9R/e4mfefpn5H9stM
X-Google-Smtp-Source: ABdhPJyXBI9iWBY/+gHmztwkLOchhhise2mfJyrs9O1MwnfCkL0fWXZRh9sgFNAo3EI2V5VKmGq5qA==
X-Received: by 2002:a05:6830:4036:: with SMTP id i22mr3387844ots.127.1607387226899;
        Mon, 07 Dec 2020 16:27:06 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s189sm3331898oia.7.2020.12.07.16.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:27:06 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 10/19] pull: show warning with --ff
Date:   Mon,  7 Dec 2020 18:26:39 -0600
Message-Id: <20201208002648.1370414-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's unclear why --ff should remove the warning, since:

  git pull --ff

Is implicitly the same as:

  git pull

Unless of course pull.ff is specified otherwise.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c               | 2 +-
 t/t7601-merge-pull-config.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 3874434421..f5bdae680f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1033,7 +1033,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (default_mode && !can_ff && opt_verbosity >= 0 && !opt_ff) {
+	if (default_mode && !can_ff && opt_verbosity >= 0 && (!opt_ff || !strcmp(opt_ff, "--ff"))) {
 		advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
 			"you need to specify if you want a merge, or a rebase.\n"
 			"You can squelch this message by running one of the following commands:\n"
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 1de64e6cc5..d709799f8b 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -46,7 +46,7 @@ test_expect_success 'pull.rebase not set and pull.ff=true' '
 	git reset --hard c2 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false' '
@@ -78,7 +78,7 @@ test_expect_success 'pull.rebase not set and --merge given' '
 test_expect_success 'pull.rebase not set and --ff given' '
 	git reset --hard c2 &&
 	git pull --ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given' '
-- 
2.29.2

