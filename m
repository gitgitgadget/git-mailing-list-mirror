Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57773C4332F
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396AE60E54
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhIUKZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 06:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhIUKZn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 06:25:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91B6C061575
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t7so4321465wrw.13
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YJq5Xh/G/r0K+xh06bV/qLGR4+89b3t/Z277xbA+z+o=;
        b=YPxIrYzJMRmMoaybftbWvFwSH33+31uWBPykRCP16JoLLeaQWiZZVxehUZ3xjT5bJk
         wFhKI354tClyodd8VDAepYiDjsLz/C/ZN6MIy+mP9cnBB+DFmZWdXCU8F0LF6bQ7SY7L
         TjsmO4tnsIhwjw8Y1o9s705+pJPwSPP6BNFORH9NbFEw8pBNmeJBhvBsaB25CgpAxETc
         OxgFo0cOknT26is8lQ8iln3bMBwiKpf05iIP+udnxc3mhbgcAYwBueGaibhB6QqRL71M
         833+ZVwykJ7chKTxJ76HKRgr8rryTR1ZnT/zNecRSfMk1Sz+LKkgLHIi89RUSIyhds4X
         Qq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YJq5Xh/G/r0K+xh06bV/qLGR4+89b3t/Z277xbA+z+o=;
        b=7Axs3XwAjoxRH42mKSQctMbL2IEkFcBV/y2Y70YaHFUlA0x+wg36ItpqJEIXISgY6E
         HE+SUWMlnPx9flbZgXoyDtVc03s2evT9JkPob6zqE0QnoQLX7AOXfZ+a/gde1B5mJsBx
         lUlxqB3/uDQPj3Oq1XgojvhQajIHmPeY8UNbiSxdXihMA/8AQlC8DAAQJVi4Z5pmwzJb
         zS7z2Yn6eLcoBwgW07AVx/zYPOJF65r1CaNc/GT1Fse1cHb80KAJMCshQ/Lxv2sVUk2D
         2dd3K0GB/7PcMmMGqJ+L+bDGdIElUcIxkvwmvlVDfpUcSeVPCbsAgh6ibwAATbvUAUZt
         UB+w==
X-Gm-Message-State: AOAM531E9K2fJLrcDHqUB5bnNWUMbT4i1WPxSvDRzVU8Wk3MduAYUw+/
        kXjnfk9cH4hzZsPzNgVbhBa0J0BC1o8=
X-Google-Smtp-Source: ABdhPJwwMSzJe2wnlnaBrOHTZLHccbFACtPQi1Z5Bg4yQzG4Irvng9vtQVIbKwm23v/8CSWh0MWirw==
X-Received: by 2002:a05:6000:144d:: with SMTP id v13mr26267311wrx.303.1632219853353;
        Tue, 21 Sep 2021 03:24:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y64sm2531646wmc.38.2021.09.21.03.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 03:24:13 -0700 (PDT)
Message-Id: <6866630528b24d7629adebea132970241fa0d380.1632219848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
References: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
        <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Sep 2021 10:24:03 +0000
Subject: [PATCH v3 06/10] t3407: strengthen rebase --abort tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The existing tests only check that HEAD points to the correct
commit after aborting, they do not check that the original branch
is checked out.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3407-rebase-abort.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 7eba9ec1619..f8264449b6c 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -19,6 +19,13 @@ test_expect_success setup '
 	test_commit "merge should fail on this, too" a e pre-rebase
 '
 
+# Check that HEAD is equal to "pre-rebase" and the current branch is
+# "to-rebase"
+check_head() {
+	test_cmp_rev HEAD pre-rebase &&
+	test "$(git symbolic-ref HEAD)" = refs/heads/to-rebase
+}
+
 testrebase() {
 	type=$1
 	state_dir=$2
@@ -29,7 +36,7 @@ testrebase() {
 		test_must_fail git rebase$type main &&
 		test_path_is_dir "$state_dir" &&
 		git rebase --abort &&
-		test_cmp_rev to-rebase pre-rebase &&
+		check_head &&
 		test_path_is_missing "$state_dir"
 	'
 
@@ -41,7 +48,7 @@ testrebase() {
 		test_must_fail git rebase --skip &&
 		test_cmp_rev HEAD main &&
 		git rebase --abort &&
-		test_cmp_rev to-rebase pre-rebase &&
+		check_head &&
 		test_path_is_missing "$state_dir"
 	'
 
@@ -56,7 +63,7 @@ testrebase() {
 		test_must_fail git rebase --continue &&
 		test_cmp_rev ! HEAD main &&
 		git rebase --abort &&
-		test_cmp_rev to-rebase pre-rebase &&
+		check_head &&
 		test_path_is_missing "$state_dir"
 	'
 
-- 
gitgitgadget

