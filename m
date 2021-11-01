Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB672C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C274560EE9
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhKATB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbhKAS7D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 14:59:03 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF383C061766
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 11:56:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b12so25054675wrh.4
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 11:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c0QxQO69dwzkLPhvseRHCAphU10DpsqqwD+1Q6eCgP4=;
        b=AhYUYb8taWDDuQnPZjMfDILJVzFeAp20m5lAOkMP6RnxqV6tOfLIBe8gsibS2utwpc
         TdMgL+B2s0nEctWCCYE7f5Q3lbq4qr2ZUjcNdALsZSsI8ZFsgMkR/xjCrgA+nc+gOKoh
         o8HTU1gC22MF8rJpWFTrLNPMO2XCjbm196sF7KZNGRYUNxqjzdCLItOaYwXzQFASyGeT
         uwXLlMvJznGWDiVq1Ppe8XhSzmRr7VqDAG+boI/V5G2/6Rdnf19v60Wluo5eZkRibIP9
         +zd/ZoAgdAEKaAOUA9R/l5GS/Lfhcw41IimIrkKWTfUVrvkdWIboo8wPzK5GkTF4c+DZ
         aVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c0QxQO69dwzkLPhvseRHCAphU10DpsqqwD+1Q6eCgP4=;
        b=z651veUpeaoyXzS5L2Hja8OiKTzIXCE/MXpMS6HEaDmiwHeKg2f8iZ8rVpmHK5yb2U
         dn4cLTgRqTgv/vuA29o6cY4NDg83bEu02kx6QfZey1lsVLAZsG4/a+LyQLah70VWmHjD
         MQEHtiQdy9GETX+2AahogAdQh6+SZchgR+hKHL/VMaJDKckNQ5jaiBXA0FZN0zS5PiTx
         +rAcohzKarq7HxkyFT6LrGkutOw9MoKLgxthhj6XMM2dpJmCFEIedBPKOUJzOEF7Dqpp
         OJMl4HOIlfrUmCMvXwG33mADsE4B7drDRPXEpGZCjcA/YdyPmGkvsZSl3plrlGKlWZDR
         gt9w==
X-Gm-Message-State: AOAM533S2pSN2MbGW0im+oyaQ/ADxRru99J9eDgamOJTerKsdJisjHkq
        aamx1yYJkGdKs0N+iPdrymmKcn+uxzurwth9
X-Google-Smtp-Source: ABdhPJw+k/f6AoIGweQpCqAKjUZ6x9/ZOE+I/X2ypGyrhEasam117nWh3LXgfUjCSIaM+PGxGVCh7Q==
X-Received: by 2002:adf:a489:: with SMTP id g9mr26911185wrb.235.1635792988149;
        Mon, 01 Nov 2021 11:56:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm314185wmq.4.2021.11.01.11.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 11:56:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 04/17] am: convert {pre,post}-applypatch to use hook.h
Date:   Mon,  1 Nov 2021 19:56:09 +0100
Message-Id: <patch-v4-04.17-80a2171ddaf-20211101T184938Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
References: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Teach pre-applypatch and post-applypatch to use the hook.h library
instead of the run-command.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 8677ea2348a..4b334cb7b12 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1609,7 +1609,7 @@ static void do_commit(const struct am_state *state)
 	const char *reflog_msg, *author, *committer = NULL;
 	struct strbuf sb = STRBUF_INIT;
 
-	if (run_hook_le(NULL, "pre-applypatch", NULL))
+	if (run_hooks("pre-applypatch"))
 		exit(1);
 
 	if (write_cache_as_tree(&tree, 0, NULL))
@@ -1661,7 +1661,7 @@ static void do_commit(const struct am_state *state)
 		fclose(fp);
 	}
 
-	run_hook_le(NULL, "post-applypatch", NULL);
+	run_hooks("post-applypatch");
 
 	strbuf_release(&sb);
 }
-- 
2.33.1.1570.g069344fdd45

