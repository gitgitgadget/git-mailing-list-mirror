Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223ACC7114E
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECED420718
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+HLUiJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgBOVgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:36:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51673 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgBOVgr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:36:47 -0500
Received: by mail-wm1-f65.google.com with SMTP id t23so13523254wmi.1
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QCov4sUjvq/PZiblIOxZJ99b1fnCNg92mFhtkd4sYzA=;
        b=o+HLUiJfgDjaINVEWheKCazWn1KfvUrCHcvrTk7OAUScGfEYsV/A6P/1WiDFI8dVGX
         dOG+ad/y+O7w1dFVYElhQzkLHakD1kxj87i3R3+vjVeMjvAzedj0blIKG8kdPf6iIYAw
         Zu7AzWOS8NvYyVGIK4udDwkRZVygG3DEiR6R/TH9cZDsTQPE+mq4KgUU/IfkIWnh/3KL
         bM++txdS1+Eb8Mgj4yPyMv7pM3SMeUamyukjx2hnPOr5sn6fAayOTbPjSU067yA9TdZf
         /qEvCZb7bs47VEblAF8UkueOzSKvqGY60mLGzStWYRe8vUNfPfmZa99M/yLkfXZnf6/y
         SodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QCov4sUjvq/PZiblIOxZJ99b1fnCNg92mFhtkd4sYzA=;
        b=mJswvM/ARDFcxGUCqEHiFbJEzXBTvoHJk75552a2WoNbfny0uFwhkoRsZfnYvX0rT2
         mRlTQiH5R0mOtfRTtnl0w8MmaYyt4rmVtgtUDA8aXSq36K3us2j1EKh9ZXId57JTe9ot
         9vrS/D1t1kDqmQrM3jI330qXIERX9mijO5bVWUwGkI4UxNTEIgx0aJtu16SZjScoiTsH
         8grLezPYnG11oQJ4cJcVLmTcdjMcn1W0twWW6D0qnIZaq2meyTLGzBvGk1R0KZ/C81SZ
         eIrUaYsXzajFPTIJkyOhslnCA2l52qgh9PtCZ1cVUMduB37T09HUgadEnq74ek7IiRvQ
         wJtg==
X-Gm-Message-State: APjAAAUbUJrNHnEb7K9rvFdAfuRy95c/5iNtcbLclhJtow+5fN/Yo3zd
        71A6I+dPvMajpKID51g0I0QEQqVC
X-Google-Smtp-Source: APXvYqyKz2H2f1P9wu503YLL16IVPAYtLfw68LyEBoRTkynJC72umH0a7Ic+r5UXUwL02gf0Vb10mA==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr12138955wmb.81.1581802604885;
        Sat, 15 Feb 2020 13:36:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14sm12760194wrm.51.2020.02.15.13.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 13:36:44 -0800 (PST)
Message-Id: <10fdd162a05b6e76a02f9ba9f2e00b972dba31e6.1581802602.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Feb 2020 21:36:23 +0000
Subject: [PATCH v5 02/20] t3404: directly test the behavior of interest
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

t3404.3 is a simple test added by commit d078c3910689 ("t3404: todo list
with commented-out commands only aborts", 2018-08-10) which was designed
to test a todo list that only contained commented-out commands.  There
were two problems with this test: (1) its title did not reflect the
purpose of the test, and (2) it tested the desired behavior through a
side-effect of other functionality instead of directly testing the
desired behavior discussed in the commit message.

Modify the test to directly test the desired behavior and update the
test title.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3404-rebase-interactive.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ae6e55ce79a..c41531f3490 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -72,15 +72,16 @@ test_expect_success 'rebase --keep-empty' '
 	test_line_count = 6 actual
 '
 
-test_expect_success 'rebase -i with empty HEAD' '
+test_expect_success 'rebase -i with empty todo list' '
 	cat >expect <<-\EOF &&
 	error: nothing to do
 	EOF
 	(
 		set_fake_editor &&
-		test_must_fail env FAKE_LINES="1 exec_true" \
-			git rebase -i HEAD^ >actual 2>&1
+		test_must_fail env FAKE_LINES="#" \
+			git rebase -i HEAD^ >output 2>&1
 	) &&
+	tail -n 1 output >actual &&  # Ignore output about changing todo list
 	test_i18ncmp expect actual
 '
 
-- 
gitgitgadget

