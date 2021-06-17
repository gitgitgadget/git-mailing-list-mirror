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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ECEC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624E7613DB
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhFQKz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhFQKzx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:55:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E49C06175F
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:53:45 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n35-20020a05600c3ba3b02901cdecb6bda8so6043940wms.5
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q2A4/oeL2pfoaqZ7Ry2AnIimZBQldGusUZuKSGvKRyg=;
        b=ZDeobTYrcPUSORUwhHACdhKxB8JCt5W7cVZhUg7YyH8PuB6mOWn89MS7dEkfYl/HQI
         alPht/FdYwS+iZ+q8fMQMf8+IcbKi9KZjO3hLksTm2u72UxTwr07x9eP5OgrQBWvzcfI
         f8T2j1FkWBchuuqNDBrGlLxERJ0tUEmXujUc6LV+nmE/Hu6R6tIEJTGPR6EBXz7U1Q8M
         DZ411NWN+T0wAOzIxiyS2q9SXl6y5gE4gsZliDj7/1Si2c01CAiWvN775fL7Ri+xE7nI
         W+TYNTE9q0yaAzdOe9wYHLeuCtWm+G7YtRqLPNAnUU5+w+b/DLyR+uZqWnrKXfejWDSu
         j0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q2A4/oeL2pfoaqZ7Ry2AnIimZBQldGusUZuKSGvKRyg=;
        b=bK7coJDyM4i8yFZpZVIglyWruibcrtc2T08U0VaenX5jek2wrrKExEVhnYG5FGc3MI
         FAEH2gzUFchybAY/DDST0cvP5z9auC/wRfnIDjFc6Fh8rKJZ61/5hl0FuI5bQsw0GRir
         iRiczaor66JRBAh+B8Ddq84mstTGuVVUQz0GTB23zDnZqgAVLIMdsT+sWCnsmldX0fzP
         URW9Tfg9su4FCEjFy4SiXP1kC/tVh9GYNlhOhk5pZEoL98MOC2ZMgOwBXamUNBTZkbhr
         cDIaunbseMZSy5qSIRiNk8N0lpvGU1mAlTJoSWnQuQ4A/RG2cOFn/m7VbVzf0NArZOqs
         Fltw==
X-Gm-Message-State: AOAM532tJJci4hg23VSaiRGiqiV2B67ARQvr4dh4+MhvYpEhrBAHI/mS
        nbK1txdD0/gkyJqpcYVTblJeYC5A4H7sRA==
X-Google-Smtp-Source: ABdhPJy8JDS6GSRo0XwgXqVez6bBqoowRisUqNp6IIli24wvCTAbzyA25Cg0fxbGn2cW/U9cSuQN7A==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr4388312wmi.154.1623927224024;
        Thu, 17 Jun 2021 03:53:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 61sm5409586wrp.4.2021.06.17.03.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:53:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/4] show-branch tests: add missing tests
Date:   Thu, 17 Jun 2021 12:53:38 +0200
Message-Id: <patch-4.4-dde0177235-20210617T105245Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.571.gdba276db2c
In-Reply-To: <cover-0.4-0000000000-20210617T105245Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com> <cover-0.4-0000000000-20210617T105245Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing tests for --remotes, --list and --merge-base. These are
not exhaustive, but better than the nothing we have now.

There were some tests for this command added in f76412ed6db ([PATCH]
Add 'git show-branch'., 2005-08-21) has never been properly tested,
namely for the --all option in t6432-merge-recursive-space-options.sh,
and some of --merge-base and --independent in t6010-merge-base.sh.

This fixes a few more blind spots, but there's still a lot of behavior
that's not tested for.

These new tests show the odd (and possibly unintentional) behavior of
--merge-base with one argument, and how its output is the same as "git
merge-base" with N bases in this particular case. See the test added
in f621a8454d1 (git-merge-base/git-show-branch --merge-base:
Documentation and test, 2009-08-05) for a case where the two aren't
the same.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3202-show-branch.sh | 61 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index 54025f0337..ad9902a06b 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -85,4 +85,65 @@ test_expect_success 'show-branch --color output' '
 	test_cmp expect actual
 '
 
+test_expect_success 'show branch --remotes' '
+	cat >expect.err <<-\EOF &&
+	No revs to be shown.
+	EOF
+	git show-branch -r 2>actual.err >actual.out &&
+	test_cmp expect.err actual.err &&
+	test_must_be_empty actual.out
+'
+
+test_expect_success 'setup show branch --list' '
+	sed "s/^> //" >expect <<-\EOF
+	>   [branch1] branch1
+	>   [branch2] branch2
+	>   [branch3] branch3
+	>   [branch4] branch4
+	>   [branch5] branch5
+	>   [branch6] branch6
+	>   [branch7] branch7
+	>   [branch8] branch8
+	>   [branch9] branch9
+	> * [branch10] branch10
+	EOF
+'
+
+test_expect_success 'show branch --list' '
+	git show-branch --list $(cat branches.sorted) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'show branch --list has no --color output' '
+	git show-branch --color=always --list $(cat branches.sorted) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'show branch --merge-base with one argument' '
+	for branch in $(cat branches.sorted)
+	do
+		git rev-parse $branch >expect &&
+		git show-branch --merge-base $branch >actual &&
+		test_cmp expect actual
+	done
+'
+
+test_expect_success 'show branch --merge-base with two arguments' '
+	for branch in $(cat branches.sorted)
+	do
+		git rev-parse initial >expect &&
+		git show-branch --merge-base initial $branch >actual &&
+		test_cmp expect actual
+	done
+'
+
+test_expect_success 'show branch --merge-base with N arguments' '
+	git rev-parse initial >expect &&
+	git show-branch --merge-base $(cat branches.sorted) >actual &&
+	test_cmp expect actual &&
+
+	git merge-base $(cat branches.sorted) >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.32.0.571.gdba276db2c

