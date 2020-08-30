Return-Path: <SRS0=qAd/=CI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0FFC433E6
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 22:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 157992083E
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 22:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F58vKHSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgH3Wml (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Aug 2020 18:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgH3Wmk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Aug 2020 18:42:40 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7624FC061573
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 15:42:40 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id u3so4594990qkd.9
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 15:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1SKxeTaALbNqyoIH1IgSAdmoj5jEWRHA14XRXEKZ88Q=;
        b=F58vKHSNa1bKM26zzFdLO8o0Umg6EBqX/pfAQxcJTG1FsBzv28nYQfEupHLHykCV/h
         Ux1eSQl2wfoQvEu8YVauIeiXuLrqHY2Ywwen7/qK+Cc/DHsOxz+5810K8gJLhEg3UweZ
         xjrGCpWXDV5MMIrqolPd3br37DN8YHd2kbzgZ2xNWg1GOi/SbH3QGQP+ZidL9JI+eSZW
         xCsRv9uAuq3G0MHOwDMQzQxqB/O4DKzbK6GmmsxGJwFY9eScoSPtLhK6AUnN6NrhwqMk
         pGc21I7bG9HCO0VWYZR+rxVEm3T5zC0H61mh9dgCh3HmBrswwewYq+umgBui6vJaDSH0
         TcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1SKxeTaALbNqyoIH1IgSAdmoj5jEWRHA14XRXEKZ88Q=;
        b=j5Ky4T+knxW+qwbiDaqgL3rES01ofCTBmZKje8ZY9QRVnjaXRrSCNJJ6HlDiPeH4wF
         VLU+IYn288Mpxx+wXk5VwyfrQ7NFnR1C7O+E5fkWdzpJRhfXa60EVUm40e13IQ1IklGB
         nfI+IKV9tY+7U3Jvmh0opViF7WUnsmigTamJUoi36FnCoSM4HvdduKMrtD7mxqToUyCZ
         AUlaCmAx5PdvBpjosapaKNw7lHclvlRRvIxNYVq8G3J6XTDeWGHZB02vdAGL9de93nb3
         qAMqzyRL7CCKXmoINAbsg/TiP2GrPYcrlqDcvNRUD5dawZKaW0Ne5FgqTl7kjXJFZqIs
         ASQQ==
X-Gm-Message-State: AOAM530/cJ7hrQ+Wjo62dTzajF9pNvXV7rYb0UHHNlSJvud23i8OHcne
        nMDFamPBXDGaDD2FTtz7novkuAF1XP83uw==
X-Google-Smtp-Source: ABdhPJyBDiaVrwKMD2juLW5JQ6Z4yB9B3xuSGtXES5Ly+OdKmZNVd/1SyJstIUmoxveeQcuDAqVIUg==
X-Received: by 2002:a05:620a:64b:: with SMTP id a11mr6342847qka.313.1598827357347;
        Sun, 30 Aug 2020 15:42:37 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id u8sm6783695qkj.9.2020.08.30.15.42.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2020 15:42:36 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] t3200: clean side effect of git checkout --orphan
Date:   Sun, 30 Aug 2020 18:42:00 -0400
Message-Id: <20200830224200.21103-1-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200829225648.11971-1-alipman88@gmail.com>
References: <20200829225648.11971-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "refuse --edit-description on unborn branch for now" test in t3200
switches to an orphan branch, causing subsequent git commands
referencing HEAD to fail. Avoid this side-effect by switching back to
master after the test finishes.

This has gone undetected, as the next affected test expects failure -
but it currently fails for the wrong reason.

Verbose output of the next test referencing HEAD,
"--merged is incompatible with --no-merged":

  fatal: malformed object name HEAD

Which this commit corrects to:

  error: option `no-merged' is incompatible with --merged

Signed-off-by: Aaron Lipman <alipman88@gmail.com>
---
Whoops, fixed the effected/affected error.
Thanks for catching that, Eric!

 t/t3200-branch.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 4c0734157b..028c88d1b2 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1287,6 +1287,7 @@ test_expect_success 'detect typo in branch name when using --edit-description' '
 '
 
 test_expect_success 'refuse --edit-description on unborn branch for now' '
+	test_when_finished "git checkout master" &&
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"
 	EOF
-- 
2.24.3 (Apple Git-128)

