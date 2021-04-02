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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BE4C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 11:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E726108B
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 11:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhDBLfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 07:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhDBLe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 07:34:59 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8910AC061788
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 04:34:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j18so4499438wra.2
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 04:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dcKQz6H6g2cv7p2iTAVawGWLM4fABs0Vv7ZPEt/Y1+Y=;
        b=tFhsjCqRP8mOvEaX+TPxj8DYMm4YD2/2/W9DQeBDKiAxv44vv4H6YmhIp+8YaPPiOy
         ux/KlojS0KrDRvUydzj1LtNO4Bka0hSJlUmTaCCR5rvjbEnti1/y/8LxNPaeFNHhOlqd
         A7z4n615mmkTQx3tDEOnYhAzg9JZHo8xnfTbsTkJW/Rt0ibVhaEmafikZ7qhewVtOXnJ
         yexMG8KAOmzbiC8CzCdVXJxLMJMcqss4jReCUBzd3SvpTL106/OUplonB8KL+RC09Cb7
         IhLf+ztruugdWtVO1rr8ng0/i7OO2VLleZvY4wUvlqqz2AbD0Ge//SSY8vNSwUkUbIGR
         xWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dcKQz6H6g2cv7p2iTAVawGWLM4fABs0Vv7ZPEt/Y1+Y=;
        b=ARlQH8e3y3Dkiz/XKRBpbDBEomU90698p+W0OeRARvaT9ppjmXlR2P17IdLKN3Dav7
         3LbDidFhqfAGDp2OXhSP35ZWq1PjS2RUk/lyHhx/14BELpTvC22/6kn3Y3XOWFAsjmVZ
         pAOtrNr+H6PBhCWH7skn02y43ebGLk4uDki/Kpanw4ute9fB0jlS6oKRmPd2GTRH+F8t
         xBkfxVed2gRrbMlF8fbwjoThcz8v7N/sBNM4giBYbPyynXYslPZE4XDhdj29qgsstaYk
         4ZzRs8TYAvj1UKo4qI6nrYYegcDt9F17K2C2Bm8E+hssic+vSiWYuYRmKFor3XGzkoqu
         /wMQ==
X-Gm-Message-State: AOAM532ABd8V6vfQurcfx7u4LQOMh0YgSLt6ttTqZxNWUtK81ZpZ6Pn1
        4XSGToGYeMMFthw6f5S+WnOgzftIenZHiw==
X-Google-Smtp-Source: ABdhPJyuWRcjSgMfo+Vjn4nzVPj7O84XPQgqWLHaCjGAXrVdXY5aRaNgHc9a+qm7En3zrEUR/UEN3w==
X-Received: by 2002:a5d:6ccb:: with SMTP id c11mr15058449wrc.122.1617363289009;
        Fri, 02 Apr 2021 04:34:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 12sm11535818wmw.43.2021.04.02.04.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 04:34:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] git-send-email: replace "map" in void context with "for"
Date:   Fri,  2 Apr 2021 13:34:33 +0200
Message-Id: <patch-1.3-bea11504a67-20210402T112946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.482.g6691c1be520
In-Reply-To: <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com>
References: <YGTt2cNwq3BlpB7n@google.com> <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com>
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

