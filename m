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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A912FC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 09:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D8461D02
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 09:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhF3JTF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 05:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhF3JTC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 05:19:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8543C06175F
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 02:16:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u6so2708578wrs.5
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 02:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BuYXLHFsgDO0bPR+A3QKT3jSxa5O19P3tSEcm2nbMdU=;
        b=P0OhuUEKLBtFtVVjFxIE8KBiVBSg28cCIqNZ3mJY9Bkf1YwDHxC23NyVvCjShUB6ST
         Ej0TwbLQBKM1ZZ7jZtU0tLR38VipE83EZYu8aul4x8CysNlqRLWXCK97XvL0wPROzfA/
         4VlksY3gGxvroPz9ysfP++M1+dE30cxhCA/qimCnaYTfZIla+uTXJVEUAuEorlCXCxvM
         dz3MQNdd8wKz8B77Zhc8Jo/nukYj//5Ro0mUiD5lYqVjoojftt8tWrMm3XmFzL5aXRuI
         NfJwkfVNyB7Zt1BhFubSuK9Ta5QS8SLtNzk3q8YhnATqujgRZ5tCHvQ6ylO9KKe79vwN
         1piA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BuYXLHFsgDO0bPR+A3QKT3jSxa5O19P3tSEcm2nbMdU=;
        b=JfE1kdb5HA7XxgZ3DGblxVQtAxE4oMCpFfH8v1LY9ludZ57kugTHPVNjPwMD4fUXRX
         BTqSP8/LMRnpP7ZaV/eDDGw136kzd+JFUuInyZFBv7ouwfBna0gADS72X6Pi6WK4Pq4t
         IuHuXBjNSP1mUfA5yuG+NjU6JkwK5XEj8XUh/aLh+vfAnqeL3dbFAglSloEXQAVX+MRk
         4dhgjMerL4ip8bl9vFewSyh3QPSsx9zcnKUuh10Qa44BGLRG1SrLvbQA0ocvWMHva2bv
         If6q72mjLBTDwyUICn1fq1sM/TnneuXatR4ZTPii0PHPaKFA3CTtOMolRpKgkNNmycp3
         IJDw==
X-Gm-Message-State: AOAM531QZJIt6GuNDvCwMGmZujJaUQQMnKTNY/lIxESEpgqQZdurGLPF
        EvCkVaI6wSy0L2Ykmj8zf5YQeQz5rqflBw==
X-Google-Smtp-Source: ABdhPJx2Y3nniO9C8rMVffiJr6F/BUIj3bnI502HjKXzj3XKzQvefU+/Qe8fzFfY/uoKObDy0RnBKw==
X-Received: by 2002:a5d:5405:: with SMTP id g5mr11666129wrv.12.1625044592194;
        Wed, 30 Jun 2021 02:16:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2sm20372711wro.16.2021.06.30.02.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 02:16:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/3] bundle doc: split out open v.s. closed discussion from <rev-arg>
Date:   Wed, 30 Jun 2021 11:16:27 +0200
Message-Id: <patch-2.3-fe61f20f19f-20210630T091548Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.613.g8e17abc2eb
In-Reply-To: <cover-0.3-00000000000-20210630T091548Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210624T193730Z-avarab@gmail.com> <cover-0.3-00000000000-20210630T091548Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split out the discussion of why you should or should not create "open
bundles" into a new section, away from the discussion of our handling
of the rev-args syntax.

See 2e0afafebd (Add git-bundle: move objects and references by
archive, 2007-02-22) for the introduction of the documentation being
changed here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-bundle.txt | 40 +++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index e19c2b83c91..3bb3b71526c 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -44,7 +44,8 @@ header indicating what references are contained within the bundle. The
 header is (mostly) in the format emitted by linkgit:git-show-ref[1].
 
 Like the the packed archive format itself bundles can either be
-self-contained or thin (see "--thin" in linkgit:git-pack-objects[1]).
+self-contained or thin, see the "OPEN (THIN) AND CLOSED BUNDLES"
+section below.
 
 See link:technical/bundle-format.html[the `bundle-format`
 documentation] for more details.
@@ -141,10 +142,20 @@ contained in the union of the given bases.  Each basis can be
 specified explicitly (e.g. `^master~10`), or implicitly (e.g.
 `master~10..master`, `--since=10.days.ago master`).
 
-It is very important that the basis used be held by the destination.
-It is okay to err on the side of caution, causing the bundle file
-to contain objects already in the destination, as these are ignored
-when unpacking at the destination.
+OPEN AND CLOSED BUNDLES
+-----------------------
+
+When creating bundles it is possible to create bundle tips that are
+either closed or open under reachability, i.e. those that contain all
+the history needed to get to a given point (closed), and those that do
+not (open). A revision such as "master" will produce a closed tip, a
+range such as "master~2..master" will not (unless the full history is
+contained within that range).
+
+When creating "open" bundles it is very important that the basis used
+be held by the destination.  It is okay to err on the side of caution,
+causing the bundle file to contain objects already in the destination,
+as these are ignored when unpacking at the destination.
 
 `git clone` can use any bundle created without negative refspecs
 (e.g., `new`, but not `old..new`).
@@ -154,6 +165,25 @@ If you want to provide the same set of refs that a clone directly
 from the source repository would get, use `--branches --tags` for
 the `<git-rev-list-args>`.
 
+THIN BUNDLES
+------------
+
+Bundles that are "open" (see above) are created "thin" by using the
+`--thin` option to linkgit:git-pack-objects[1]. Whether a bundle (or
+packfile) is "thin" is a subset of whether it's "open". What "thin"
+means is that such a packfile can store an object in a deltified form
+against a base object that is not in the same packfile.
+
+To put it another way, when creating "open" bundles we assume that the
+objects leading up to the starting range(s) already exist in the
+recipient repository, which allows us to save space. When we run 'git
+bundle unbundle' we invoke linkgit:git-index-pack[1] with the
+`--fix-thin` option.
+
+See the discussion of "thin pack" in
+link:technical/pack-format.html[the pack format documentation] for
+further details.
+
 EXAMPLES
 --------
 
-- 
2.32.0.613.g8e17abc2eb

