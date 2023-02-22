Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A82C64EC4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 05:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjBVFRt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 00:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBVFRr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 00:17:47 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAA331E24
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 21:17:45 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so684356pjn.1
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 21:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MJ/mW7GQXyMLmxW25lhGHhn/8Q8kqh8FF/EYohwNvmk=;
        b=WHjKD75ZuZj4XkJycGJoDP9WFb06GDbVpx+3Kz+r5aCrF54/7etQ1I56S/CspZG5uS
         QWSlvF8UQlJttwjaoEjcy66c09b+faJYRElEhkJ9qdcqhUGImH9QkLA1R8b8ecq40S3V
         LU7/PLX0Ywax6hLGlsImUuqOGCEyYVTaAQBwV4h6oKEltu3c7kA+0vLQOgeP/6BVSoio
         w4SjEVsm7Kd0pIpRqN+EAr65WS7J69hDnFegLPJjajMdr0j73pHWoQsQIo+Tk08SsgCq
         YFhovmH4S1CsFei9rU1bdYogUB5RLBepHSVJk0z53GFE34Lk7OuGHQX0lcYAsM4w2DmO
         g6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJ/mW7GQXyMLmxW25lhGHhn/8Q8kqh8FF/EYohwNvmk=;
        b=bBdq1rE7Kx/HrD3ytjDUGr1//RhzUPO3A8ybdp9es5ub2sK4pTbtSIub7qgkHaG46x
         y7Ct4fFVZ/q1c65wOq/j5qqFwXfZB/+gA9AWMkrUasXG8XFEwAFwvWZFXhuOZIAPVGDr
         Hn0n2U5Byp+5rwYu8eP7qtQHvUyZOkvHoWKaUUIl8/EZQpCqmDa3ZR8ooMyD697TU1W6
         rLxgVKfgmenE1mwikjhneECkZLqCHZn8LcIO4NYm4l6gtVkbAe5diA8tuVBoaHFF0j14
         p8S+oML9lOTe7pzrk0X74GnBUgmdfh5XW3AotDj40B+tJ1qykU9GAKZE48qgrdTIZEb9
         FyjQ==
X-Gm-Message-State: AO0yUKWWJ7DbdWTOWcUTk108ikL4JN4ubhOvNoX9tjj4XQKPf1qiT4f4
        I6nVwl/JtKwqs+zvpZx7ZaHvqBB6I4o=
X-Google-Smtp-Source: AK7set9g9P7nqwzppUoyjX89BltbtHZPv0qxsBLkCsqlQU5VnpV/CGAnd0hFpHl9zp6YM5qwEcwZJA==
X-Received: by 2002:a17:902:c40d:b0:198:e13e:e73e with SMTP id k13-20020a170902c40d00b00198e13ee73emr10157639plk.53.1677043064962;
        Tue, 21 Feb 2023 21:17:44 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709029a0a00b0019abb539cddsm10720204plp.10.2023.02.21.21.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 21:17:44 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v3 1/3] rebase: add documentation and tests for --no-rebase-merges
Date:   Tue, 21 Feb 2023 22:17:07 -0700
Message-Id: <20230222051709.464275-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/git-rebase.txt |  4 +++-
 t/t3430-rebase-merges.sh     | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 9a295bcee4..c98784a0d2 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -529,13 +529,15 @@ See also INCOMPATIBLE OPTIONS below.
 
 -r::
 --rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
+--no-rebase-merges::
 	By default, a rebase will simply drop merge commits from the todo
 	list, and put the rebased commits into a single, linear branch.
 	With `--rebase-merges`, the rebase will instead try to preserve
 	the branching structure within the commits that are to be rebased,
 	by recreating the merge commits. Any resolved merge conflicts or
 	manual amendments in these merge commits will have to be
-	resolved/re-applied manually.
+	resolved/re-applied manually. `--no-rebase-merges` can be used to
+	countermand a previous `--rebase-merges`.
 +
 By default, or when `no-rebase-cousins` was specified, commits which do not
 have `<upstream>` as direct ancestor will keep their original branch point,
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index fa2a06c19f..e0d910c229 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -250,6 +250,31 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
 	EOF
 '
 
+test_expect_success 'do not rebase merges unless asked to' '
+	git checkout -b rebase-merges-default E &&
+	before="$(git rev-parse --verify HEAD)" &&
+	test_tick &&
+	git rebase --rebase-merges C &&
+	test_cmp_rev HEAD $before &&
+	test_tick &&
+	git rebase C &&
+	test_cmp_graph C.. <<-\EOF
+	* B
+	* D
+	o C
+	EOF
+'
+
+test_expect_success '--no-rebase-merges countermands --rebase-merges' '
+	git checkout -b no-rebase-merges E &&
+	git rebase --rebase-merges --no-rebase-merges C &&
+	test_cmp_graph C.. <<-\EOF
+	* B
+	* D
+	o C
+	EOF
+'
+
 test_expect_success 'do not rebase cousins unless asked for' '
 	git checkout -b cousins main &&
 	before="$(git rev-parse --verify HEAD)" &&
-- 
2.39.2

