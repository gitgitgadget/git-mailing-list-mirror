Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0FFC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F1120716
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YusdT6/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfLSSCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:02:18 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:43379 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfLSSCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:02:16 -0500
Received: by mail-ed1-f54.google.com with SMTP id dc19so5756140edb.10
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 10:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5MgGYeWMCCRYnae/q9iD5uMWOQfLIJcWu0JLO6ISVv0=;
        b=YusdT6/XYCwy7xGCfeYKJotylMzTMyazQYjuwpUTI+zp0eGroslJepN1gst3tSjqm9
         W62EfPEuClGBcP1DrWCcIpiFSkkU8ikOHo08HV7P//p1aIXCYKgHY90SWk/Lnb0KNV2n
         Va3HlpnQfL6qAJZhSMoM1KmlV6f2sRqdvw6VeN7CvMMH7WIkW2cxMdZulAxs/Op6ne8Z
         miOrM634f8OJkNB+b3kOEYVUfUSKyp4u8erNdCPeVNMoK6v2YvhaeJsn4+79hFhI7S2W
         izTf8gmy7cKLsj+aqnyFRCZ6Bz4/Dr7og45Gbf0cWFirvEg/pdGEZ3hvyBSb55pTg0zD
         2G3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5MgGYeWMCCRYnae/q9iD5uMWOQfLIJcWu0JLO6ISVv0=;
        b=T6uLPyrjpWQ7JCDBMi1EaZUBuowP4isvKYkF35/Q6OxZytCDDbz3wCaHIN+PUJ/fGb
         XxhAMM1mIej0UfzviLhtFKItgcizQLKAglI9jniCyFyKJqeoUJycinGrWG5y/Uf3dr6n
         X40E+ZqVZgibH9r38VbhDFZOXTuM/FYWlAWCsZroFnib02togRbBk34UDt+/bHob5x8O
         Du72egi1enUaV/OHNwSMiV7Eq1HK2+RGmskWwgmfj6LxqGs+hoae7YTEwuGvUBAm4TvV
         Tbb+iSrt02Z+NznWVXk64OGJc6CZfmnftA5s+k+eKQcKvqSCjBML4ytIoQ3viHnfA/rx
         3LAQ==
X-Gm-Message-State: APjAAAUXcNKGiUqQWShyDMOXUVexcl0R6AJK+mr66TViuSytDbwR7UVl
        lFhX4wvuKGZqGCa7eIk9J/o9ctgk
X-Google-Smtp-Source: APXvYqzrpO34LwcULkjQH9sxqqPQTP0v05B3clOgJcJO6Bn1iK84KW+jNjJIyj9MOLo5YSOQpc8nMw==
X-Received: by 2002:a17:906:af8d:: with SMTP id mj13mr10925616ejb.156.1576778534618;
        Thu, 19 Dec 2019 10:02:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w5sm633897eje.14.2019.12.19.10.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 10:02:13 -0800 (PST)
Message-Id: <121d3f06a6341fd9b3970d60b2b5f04a808d2187.1576778515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
References: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
        <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 18:01:54 +0000
Subject: [PATCH v3 17/18] t2024: cover more cases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

After working on `parse_branchname_arg()` I think that these cases are
worth testing.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 t/t2024-checkout-dwim.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index c35d67b697..fd993bf45d 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -156,6 +156,33 @@ test_expect_success 'checkout of branch from a single remote succeeds #2' '
 	test_branch_upstream baz repo_b baz
 '
 
+test_expect_success 'checkout of branch from a single remote succeeds with --' '
+	git checkout -B master &&
+	test_might_fail git branch -D baz &&
+
+	git checkout baz -- &&
+	status_uno_is_clean &&
+	test_branch baz &&
+	test_cmp_rev remotes/other_b/baz HEAD &&
+	test_branch_upstream baz repo_b baz
+'
+
+test_expect_success 'dont DWIM with pathspec #1' '
+	git checkout -B master &&
+	test_might_fail git branch -D baz &&
+
+	test_must_fail git checkout baz nonExistingFile 2>err &&
+	test_i18ngrep "did not match any file(s) known to git" err
+'
+
+test_expect_success 'dont DWIM with pathspec #2' '
+	git checkout -B master &&
+	test_might_fail git branch -D baz &&
+
+	test_must_fail git checkout baz -- nonExistingFile 2>err &&
+	test_i18ngrep "fatal: invalid reference: baz" err
+'
+
 test_expect_success '--no-guess suppresses branch auto-vivification' '
 	git checkout -B master &&
 	status_uno_is_clean &&
-- 
gitgitgadget

