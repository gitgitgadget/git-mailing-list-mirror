Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E987C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08A622450
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWDvtC24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787104AbgJZRC4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:02:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39587 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775592AbgJZRBv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 13:01:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id d3so13250834wma.4
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LOsRglWXY+n9K3CRFstIO+D5wM+7Jv2UbOBcy+4tIHA=;
        b=eWDvtC24gdHnZ0CjOaf9M8UstTKQnfHRH/bhSLuqKQs1YxWdlDNCurEJxSnjU2APeV
         NjuFaro1PesszEqi3RpnxII4tb4iRdHlwlmZIXxgpTlmhj3YENEe7V2xOEyjg5UoDiX7
         dLDQEePRgIExyqjDYC+2+zGg9XfEy7X9ftW9FSN2RS9mbiuqFUIy7rTTEvd5n1E5Pz+x
         6HZyNcrabWT2WomH49D9Tkg7hWzBh5r53YAxkIag45LnhtOxBc8k9zoVQdkwGKiICPgp
         UlmCRP36ftNdhzXGwuW5J/GhEOZYQZK3Tqi95RL4Nt1aPlPD0VlB6SFRJhZgbqiT3a0B
         FrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LOsRglWXY+n9K3CRFstIO+D5wM+7Jv2UbOBcy+4tIHA=;
        b=lsnPdd0MsPChWSU8Zyn46aHbgpnRbsI8yP6b/aKwYT/5p5eZJCr+L3oZ2fj+3z/JRk
         hMKWFAAcEayTKju69+9BfMurShOYdTmL/iUDD/UQ2/mBwEXIRMWnegWlf8CKi7zd8Z65
         P2O2B4mj5Cm776TOrDB8tA0mx1afm7NsrwksbmBVoM6UV2owUf7PfHfGfrp9KtqxiDzs
         5CMYrmtz7J0+QNDLro9jd4QHlge0XVW0zXrXxxKt82kEFX4gZupi55pKfPldxahHr7F3
         Vz5htsvsmo7fu5saTFTFEVZ1gNw4UvnbHVwt6LUB3bPH6+Xa14EW9suP3Oapquh/4QFA
         aMoQ==
X-Gm-Message-State: AOAM533AstWYZeLlRQKh3Rf1aZhSYlHww6xoCvd9842oPhJ7ZDan+5/H
        x0xY0RP5zDapjQI89cRbZoxKfGu0M6o=
X-Google-Smtp-Source: ABdhPJySXzV0Nu4LFn+SilKMH/kZ3li2bKr5CvjrwcTZt5hLZfY2wotJKAMwGuHcPrDTd8aH0E3z1A==
X-Received: by 2002:a7b:c750:: with SMTP id w16mr16217545wmk.136.1603731708950;
        Mon, 26 Oct 2020 10:01:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm21618579wmm.34.2020.10.26.10.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 10:01:48 -0700 (PDT)
Message-Id: <38919982c41f02edbdb62a6fac794bba597584e5.1603731704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.769.v2.git.1603731704.gitgitgadget@gmail.com>
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
        <pull.769.v2.git.1603731704.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 17:01:38 +0000
Subject: [PATCH v2 3/9] t6416: correct expectation for rename/rename(1to2) +
 directory/file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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

