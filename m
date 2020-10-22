Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BD8C55178
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 03:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85B87223C7
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 03:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oL+Dy0nQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895250AbgJVDBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 23:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895247AbgJVDBY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 23:01:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D69AC0613CF
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 20:01:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d78so157724wmd.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 20:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1Ef/8ZxkLtSCBI23VBtlkS9reXhwctv2fuHH6MwFNuo=;
        b=oL+Dy0nQ9fTv1HeKYWnLbm0L0kxPunazOFXdBbq03bngS/9Y9NR/YVj6ou812i9QJM
         4dZ/UHIt0SPFLtfeBUCQOK+UCHVvMAcGxRqJZ4ekeIppkmJXB8Df86xGqzrD6RXH9GZo
         5mPgWCUSPhYVHjfTlUN17vv9K8JBIAuHtamlHYbMecDyI16cm7TuyDUbH2vPugJUDLDW
         GdNUwo59j8yqx27NethgwtyqDQM3mEjCxhIM4QW0/+ssl99A4a0PmMlA2V5rsE8MZtHi
         Wwf/Zw0g5fjUIA+pFWQgUhHnPiXQeF+k9tycLbg2Zg+elmKn4JVIHh4eO7RWDV4U41D6
         VKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1Ef/8ZxkLtSCBI23VBtlkS9reXhwctv2fuHH6MwFNuo=;
        b=mjEzpksQ3mgTiLmOHfV7B0oWHox/8r3NOfVeOgFibNGNOpBb8fVexIPpkemjPFF5+Q
         o5ejvtUGJsuXQCh6cZoYzh1it3Yu2FbpqhVs+jv6lhL+l8kgjxqfjNnoJB8BMfQ/9R1o
         4zFIx2rr4vDkI1/5s2SXXW0coDuRyyRCReMskSI+tDr1ei0YAlQTDROoSxYOlaGaNNA9
         oGQSZdPfNz504zgsgLajL9AvBLqkDeQQQ4M+AzIeeKpS+YBly3fq4/eZcGyBaJ/PBos9
         OE8dxyZzyKkduE7VS6mRnPDHs3pT2Yi1a3BqJmGYIRumnvodBQqGtAZP8x7uJHPp92ni
         nS5w==
X-Gm-Message-State: AOAM530dLPdEQJx4AOGTXR2boAd+bbOIlStarksnITjFi9ZWlL6/T3Yh
        cAVz/biqpqVXStftAza9JQNLqTSw66M=
X-Google-Smtp-Source: ABdhPJwsagbQTECvnM1rEkrIMWK+JoJl3HfM4b4WeMNJxdfo/8khtG9c7e7zedBdyxKKSANmuReqiQ==
X-Received: by 2002:a7b:cb13:: with SMTP id u19mr375603wmj.89.1603335682697;
        Wed, 21 Oct 2020 20:01:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t12sm544188wrm.25.2020.10.21.20.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 20:01:22 -0700 (PDT)
Message-Id: <75a87887be5d8364b37655f0588ed98a52de92bc.1603335680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.576.v4.git.1603335680.gitgitgadget@gmail.com>
References: <pull.576.v3.git.1602526169.gitgitgadget@gmail.com>
        <pull.576.v4.git.1603335680.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Oct 2020 03:01:19 +0000
Subject: [PATCH v4 2/2] log, show: add tests for messages containing CRLF
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

A previous commit fixed a bug in ref-filter.c causing messages
containing CRLF to be incorrectly parsed and displayed.

Add tests to also check that `git log` and `git show` correctly handle
such messages, to prevent futur regressions if these commands are
refactored to use the ref-filter API.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/t3920-crlf-messages.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
index 3f0ce02c3f..b6e09be412 100755
--- a/t/t3920-crlf-messages.sh
+++ b/t/t3920-crlf-messages.sh
@@ -105,4 +105,22 @@ test_crlf_subject_body_and_contents tag --list tag-crlf*
 
 test_crlf_subject_body_and_contents for-each-ref refs/heads/crlf*
 
+test_expect_success 'log: --oneline works with messages using CRLF' '
+	for branch in $LIB_CRLF_BRANCHES
+	do
+		cat .crlf-subject-${branch}.txt >expect &&
+		printf "\n" >>expect &&
+		git log --oneline -1 ${branch} >tmp-branch &&
+		git log --oneline -1 tag-${branch} >tmp-tag &&
+		cut -d" " -f2- <tmp-branch >actual-branch &&
+		cut -d" " -f2- <tmp-tag >actual-tag &&
+		test_cmp expect actual-branch &&
+		test_cmp expect actual-tag
+	done
+'
+
+test_crlf_subject_body_and_contents log --all --reverse --grep Subject
+
+test_crlf_subject_body_and_contents show $LIB_CRLF_BRANCHES
+
 test_done
-- 
gitgitgadget
