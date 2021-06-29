Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976B0C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 11:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A3C661DD4
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 11:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhF2LPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 07:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhF2LPx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 07:15:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D18C061760
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 04:13:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u6so3190053wrs.5
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 04:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oLNRX4g8YYbeN8n/g4rtcPcjYSljj7AuXSJGltqZ6TU=;
        b=IGCrzGHnUbjeBdDnRf+v2UV6BzfrWtZR2eFZ1wQH8/1H+4rGZm4A6aFsOu7Z9HsjtH
         7CzuD+iMcTiWP9KVBEovUDg7rFlCZIb9WU9sC3QeZGS/uQEtg99uW36h6wciaJmCIPGT
         iMSPR17ovgdypWiDlgF5oo1IrefVXPG9dO0spaE67v5VsD1rxnM/fSK4nV+kEqy7EnNC
         JfgscJNWhjuE1ymSDj2CR7TDm4QDCy9SSVKb+Thf76G/yIKfEG9YBbba51/H/KyJZ7Hi
         EOO0Qvbi78Xqp5cZ//nFqPNH72Xyo+/TQu1Kh8yr+79cQFhSu7qRYhiXipc2C+G6NGhX
         4QWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oLNRX4g8YYbeN8n/g4rtcPcjYSljj7AuXSJGltqZ6TU=;
        b=ZFIInflHj4YqTSffXQQQEY52Ki08LUClo6swmtbH/SUAXBrlwYSmSM6svVEPF2fNeY
         MivAO+tVjSWsV9bXEKhf+kjiuJrE8oEefSDKofK1+rS22UxhWblE9IGjU+EJUG3nD3jT
         wG1cKP8HXJ5CiVN4gSHROGVmu3+qqzCElV4SEmbQqfIpVHWoM0ublzBA8mulXd8MDrSb
         38SfCt9yuw+ddM1INGa9WKjqIE1Lw7Vb18HcOowx7lDS99Ec7yDAUeS0N0yHwJHjAsnV
         ozbHd6XT5JiAIoPvbPpK+aYxHWrZrZrMMRi8MAIyiawbQem9Iv1IFgoKPicChxcX7q8J
         FESg==
X-Gm-Message-State: AOAM530cptX5gA3chwoGQ/82tTvVxPUoqz93CTR5UQ+INM0iBSg+Ogih
        IwVsHl1Y16juOpIlJakESCq7hTuGKE7+Bw==
X-Google-Smtp-Source: ABdhPJyDTmDBuISKPxFCxyJDuxq+yAYWggGe3twS66vV11BjyiDHiEEhE9VbtyFEiXCdVEI4dvzX9A==
X-Received: by 2002:a5d:6d8d:: with SMTP id l13mr31259101wrs.358.1624965203793;
        Tue, 29 Jun 2021 04:13:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1sm2499370wmn.10.2021.06.29.04.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 04:13:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/5] Makefile: normalize clobbering & xargs for tags targets
Date:   Tue, 29 Jun 2021 13:12:59 +0200
Message-Id: <patch-5.5-5195d99e25-20210629T110837Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.613.g20d5ce26552
In-Reply-To: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com> <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the "tags", "TAGS" and "cscope.out" targets rely on ping into
xargs with an "echo <list> | xargs" pattern, we need to make sure
we're in an append mode.

Unlike recent changes of mine to make use of ".DELETE_ON_ERROR" we
really do need the "rm $@+" at the beginning (note, not "rm $@").

This is because the xargs command may decide on multiple invocations
of the program. We need to make sure we've got a union of its results
at the end.

For "ctags" and "etags" we used the "-a" flag for this, for cscope
that behavior is the default. Its "-u" flag disables its equivalent of
an implicit "-a" flag.

Let's also consistently use the $@ and $@+ names instead of needlessly
hardcoding or referring to more verbose names in the "tags" and "TAGS"
rules.

These targets could perhaps be improved in the future by factoring
this "echo <list> | xargs" pattern so that we make intermediate tags
files for each source file, and then assemble them into one "tags"
file at the end.

The etags manual page suggests that doing that (or perhaps just
--update) might be counter-productive, in any case, the tag building
is fast enough for me, so I'm leaving that for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 7b0d9773b0..926c9efe43 100644
--- a/Makefile
+++ b/Makefile
@@ -2730,18 +2730,19 @@ FIND_SOURCE_FILES = ( \
 FOUND_SOURCE_FILES = $(shell $(FIND_SOURCE_FILES))
 
 $(ETAGS_TARGET): $(FOUND_SOURCE_FILES)
-	$(QUIET_GEN)$(RM) "$(ETAGS_TARGET)+" && \
-	$(FIND_SOURCE_FILES) | xargs etags -a -o "$(ETAGS_TARGET)+" && \
-	mv "$(ETAGS_TARGET)+" "$(ETAGS_TARGET)"
+	$(QUIET_GEN)$(RM) $@+ && \
+	echo $(FOUND_SOURCE_FILES) | xargs etags -a -o $@+ && \
+	mv $@+ $@
 
 tags: $(FOUND_SOURCE_FILES)
-	$(QUIET_GEN)$(RM) tags+ && \
-	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
-	mv tags+ tags
+	$(QUIET_GEN)$(RM) $@+ && \
+	echo $(FOUND_SOURCE_FILES) | xargs ctags -a -o $@+ && \
+	mv $@+ $@
 
 cscope.out: $(FOUND_SOURCE_FILES)
-	$(QUIET_GEN)$(RM) cscope.out && \
-	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@ -b
+	$(QUIET_GEN)$(RM) $@+ && \
+	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@+ -b && \
+	mv $@+ $@
 
 .PHONY: cscope
 cscope: cscope.out
-- 
2.32.0.613.g20d5ce26552

