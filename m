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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F39C43460
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 09:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6BD561103
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 09:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhDDJT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 05:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhDDJT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 05:19:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1801C0613E6
        for <git@vger.kernel.org>; Sun,  4 Apr 2021 02:19:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i18so4937315wrm.5
        for <git@vger.kernel.org>; Sun, 04 Apr 2021 02:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dcKQz6H6g2cv7p2iTAVawGWLM4fABs0Vv7ZPEt/Y1+Y=;
        b=XbWw8A0VL//+VmP1fJQEpn46cDZS53RmKhSJzROfr2tQbjDTdxNe+qH5XdG6C7y676
         Nl/1PGnZZtnl9KEY768sDQrdnhNYixymtbvEuBge3KAxP26yxwXLL7yqJVWY+hw5jKiE
         SFRPz7XS7EWeSGFWa8TojEq0X2eig7rSY330E5/3e+SzEdwdBILgtWAzqsysc47Xn9by
         NoHc388NBIottfqxTvPcXF6VOy8zG9K+tIv7Qrbivjk9q1C1OmTBhM443ylVqf8pmZUN
         5E0s5StXjAF1DFguHZS8qeWaHtSP65GvcLpmpPxUlNPG9Uom9KYYPImjg3KtRzthTGk5
         xnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dcKQz6H6g2cv7p2iTAVawGWLM4fABs0Vv7ZPEt/Y1+Y=;
        b=ky93D0WX4RivxbMzo79sCUBp6mjW+c3ptWU4zhU33Eb+ro1HtqK4n7Qp0bHEZMrYcA
         zURFK+T4KfxyfAp2c4j4IPlJ9MulSp53d7KJwrpMzIzAVXiR7+k2RcGSPX85fXrSj4UN
         roviMxCfg9M4/ueXkYCBGIO+DB08FE01TyuuahT2XAPJwp4flVc06dOVkbjtjF4ge/ZK
         gKsESAlIeFFqsfB7mwuNnmZASWrDfB1/NxI4uzFj6Idkjxw4FERZ+5k1vHCYsGKZVqKB
         aRATFL/jdwalf3sYy5voDjhQZV4NkfxVBBtPISaFq1n48CzjRwAeJXi1mZvVRU1FcCbp
         h74w==
X-Gm-Message-State: AOAM532NNcdD4rM/JnUIlyz7GCu0VAf+5YNgyscyKUbbogxKV5qeVkW7
        O8osGsHzGktl0kfSGeRrQ2tVs+TFE9yiTw==
X-Google-Smtp-Source: ABdhPJwx1TBMebcZsg1EU3FqQRYmExXoUssHo5ZEdoP2vSdcVaC91FsoqzIELhy9HiVN2ocmm6JcHQ==
X-Received: by 2002:adf:a3d3:: with SMTP id m19mr23967336wrb.24.1617527991056;
        Sun, 04 Apr 2021 02:19:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z25sm22480540wmi.23.2021.04.04.02.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 02:19:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/4] git-send-email: replace "map" in void context with "for"
Date:   Sun,  4 Apr 2021 11:19:43 +0200
Message-Id: <patch-1.5-e37b861f239-20210404T091649Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.482.g6691c1be520
In-Reply-To: <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com> <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While using "map" instead of "for" or "map" instead of "grep" and
vice-versa makes for interesting trivia questions when interviewing
Perl programmers, it doesn't make for very readable code. Let's
refactor this loop initially added in 8fd5bb7f44b (git send-email: add
--annotate option, 2008-11-11) to be a for-loop instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f5bbf1647e3..6893c8e5808 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -217,12 +217,12 @@ sub do_edit {
 		$editor = Git::command_oneline('var', 'GIT_EDITOR');
 	}
 	if (defined($multiedit) && !$multiedit) {
-		map {
+		for (@_) {
 			system('sh', '-c', $editor.' "$@"', $editor, $_);
 			if (($? & 127) || ($? >> 8)) {
 				die(__("the editor exited uncleanly, aborting everything"));
 			}
-		} @_;
+		}
 	} else {
 		system('sh', '-c', $editor.' "$@"', $editor, @_);
 		if (($? & 127) || ($? >> 8)) {
-- 
2.31.1.482.g6691c1be520

