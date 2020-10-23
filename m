Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE608C56201
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C2421D47
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BijItXtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751212AbgJWQBc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464808AbgJWQBb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 12:01:31 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31409C0613D4
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x7so2504603wrl.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LOsRglWXY+n9K3CRFstIO+D5wM+7Jv2UbOBcy+4tIHA=;
        b=BijItXtcQ1kPmtBVINzymAiCIEkHSTt78Gw6VltrUNmhcBt7MfEgZUCxrTLzhjKgbE
         /41/L/PyA5nCnZ0PhmOMCOCZptXpyyK3uz+nbeLXVpDx1ADHYE/bMfJ0YNQR+mIoqC4v
         a2ztQHvGah/3jVOIboCjFW31U/UwI5tiXGAwQzw3GJlqfSZbU3CzZxYJhHnTDY48Y/Cq
         UdyV8VzSrXXlHX5ok1ZJW/1d7rcWme/Xx8hsUwjLOX595ONborZ2h728ItJvquD72XBA
         bFauFvGx95gn1Co+byVWitMBmPAHVKMXRAZh89L8mZFb/dIFUBHit+UaNyaauE5M+37t
         4qiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LOsRglWXY+n9K3CRFstIO+D5wM+7Jv2UbOBcy+4tIHA=;
        b=WVqMfS5+BlCERFVnngm/v8CDnnYLf/sM0VT4YFKBPs56DIb6OtIFjf9jpCy5iIBJcv
         70cBwAGOkJKwXbA9S2KWMfJZ+p4SltUATrtSp9/g4ZCkPe/Ze0c/yg8iXVwylLDUSeo0
         LCKv0wFq9ABMAVfx6kdQTGrQNJJ8ZVpqg7LZ0pZ0pKfl1vbvafm2gXMcUe06F1b34HrB
         1Znuwm+3UasHoLXEg2bV3QZK/QCsT/jOQ3nmxpCJRtDKi1wfMSPVrtxgihBd4WVkxpug
         QA61xIx9LNY0YHZ6/cqPmXdZ4Boh1rGugu98k1B6Ga+UzzzKjaBuXCfRLFqpImdeziTZ
         ZIxA==
X-Gm-Message-State: AOAM530dQwGJ7Sg/qFNp3pDs8Q7rwevT9QJjQD/93UdeOtM3qYYC8X+A
        wdJEsY8ZoaNETYpJJxJURfOzTgQF61w=
X-Google-Smtp-Source: ABdhPJwrP3KcxLmcQi2m03FOeB5l4Uqt1f4L3YgQOdRQBTO4ttfolDTnpllUx9DfOjhPRiFlhWh7cw==
X-Received: by 2002:a5d:5086:: with SMTP id a6mr3287610wrt.283.1603468888698;
        Fri, 23 Oct 2020 09:01:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9sm4156187wmm.4.2020.10.23.09.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:01:28 -0700 (PDT)
Message-Id: <1eae84b7878dc6ebe7ee1fb4e860c316cd773ad5.1603468885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.769.git.1603468885.gitgitgadget@gmail.com>
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 16:01:18 +0000
Subject: [PATCH 3/9] t6416: correct expectation for rename/rename(1to2) +
 directory/file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When files are renamed and modified, we need to do three-way content
merges to get the appropriate content in the right location.  When we
have a rename/rename(1to2) conflict (both sides rename the same file,
but differently), that merged content should be placed in each of the
two resulting files.  merge-recursive handled that fine when that was
all that was involved, but when one or more of the two resulting files
were ALSO involved in a directory/file conflict, it failed to propagate
the merged content to that file.  Unfortunately, the one test in t6416
that touched on this combination of cases had been coded to not expect
the merged contents to be present.

Fix the test to check for the right behavior, and record how the
different merge backends will be expected to handle it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6416-recursive-corner-cases.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index 0317e83970..887c2195a9 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -786,7 +786,7 @@ test_expect_success 'merge of D1 & E3 succeeds' '
 	)
 '
 
-test_expect_success 'merge of D1 & E4 notifies user a and a2 are related' '
+test_expect_merge_algorithm failure success 'merge of D1 & E4 puts merge of a and a2 in both a and a2' '
 	test_when_finished "git -C directory-file reset --hard" &&
 	test_when_finished "git -C directory-file clean -fdqx" &&
 	(
@@ -804,7 +804,7 @@ test_expect_success 'merge of D1 & E4 notifies user a and a2 are related' '
 		test_line_count = 1 out &&
 
 		git rev-parse >expect                  \
-			A:ignore-me  B:a   D1:a  E4:a2 &&
+			A:ignore-me  B:a   E4:a2  E4:a2 &&
 		git rev-parse   >actual                \
 			:0:ignore-me :1:a~Temporary\ merge\ branch\ 2  :2:a  :3:a2 &&
 		test_cmp expect actual
-- 
gitgitgadget

