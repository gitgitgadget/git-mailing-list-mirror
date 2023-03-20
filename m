Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D08C76195
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 06:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCTGAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 02:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCTGAH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 02:00:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26EB1CBD7
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 23:00:05 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso11210776pjb.2
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 23:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679292005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mG0Eh42iXR92/z6npu4aNTODQkar2R2pkU5LgoUXoUQ=;
        b=VurweSm2MJdaJdodbdvCtiIcyNDpDnYaA54bAWG1TUhEuWMNtkgwFO/ILPlPXIQzKo
         BXEoSmav2sCJCF2/dAvE44Gcd0P7RQKz4ZV3XqdeDSsdqEj/nnbXab5ruYZ52fNHSn0E
         Wy/Zy1cCtE09S/qgJ5X6LLgKBCANMHPy6kqESJsf8ZamNAdmb5w8P4KIqKp9kXulc2f5
         bVZmsREqyRVbWkYC8hSY9KPbmpHhv50OzWAezVXK8JPvCqD6J05qkce/IE06HAvg3egK
         JnPndn8KGp2P1nW5n41xKlfXxAGVOzSaEr3ZPRp0SLhfghieEHJtV32FB7fBEI5f/TP/
         DT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679292005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mG0Eh42iXR92/z6npu4aNTODQkar2R2pkU5LgoUXoUQ=;
        b=2bnojGdH/ig/RTASCs1TivT9UBkr5TEmRb8mvvIr5oTMNaXDb25QHWYFlQ7zeUEOKw
         QM1HyhEpQXzGSZa3FP0B1Yn/ks8VmRP3OhZT8c+8ER0+QVO/SAPmDpPAUuRg1Ct78rIb
         aOn8s6tuFBuB6+8w6mDfyBuLnQE++qSr7wq/T28SqKtn8k/c956t7c/wJGsfIXbSCes0
         UNe9SzyVCEzcHFRSJuMW7dZ6gjZnNZoyyZymaHT/82LhR19+Y4Zt2JUnR3gzMURFcRHa
         pJ+5dZB+118HQAyIfvM5PndrrDbfOzeZ14fduee2DLG7ZlImn1rcLr2/5famlHhKVQ+o
         vEvg==
X-Gm-Message-State: AO0yUKWGOmK3LPIgCK3GxT6ZW7O1SvxI+cuEW14bPHrlHLTN7Oeo6Gdk
        0ANuAMi45X+kt0qPbiE554c2fgbxepmJgg==
X-Google-Smtp-Source: AK7set/+MCljcX01pSqCU1FOiSvdDSP2aLvIu0SqxHIuBXKtjahj8ta4M1N93UDfbY5uFawrMSMfmQ==
X-Received: by 2002:a17:90b:4a49:b0:23d:4241:af0 with SMTP id lb9-20020a17090b4a4900b0023d42410af0mr18822491pjb.3.1679292005206;
        Sun, 19 Mar 2023 23:00:05 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id cc13-20020a17090af10d00b002353082958csm7814075pjb.10.2023.03.19.23.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 23:00:04 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        chooglen@google.com, calvinwan@google.com,
        jonathantanmy@google.com, felipe.contreras@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v8 1/3] rebase: add documentation and test for --no-rebase-merges
Date:   Sun, 19 Mar 2023 23:59:53 -0600
Message-Id: <20230320055955.461138-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230320055955.461138-1-alexhenrie24@gmail.com>
References: <20230312210456.92364-1-alexhenrie24@gmail.com>
 <20230320055955.461138-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As far as I can tell, --no-rebase-merges has always worked, but has
never been documented. It is especially important to document it before
a rebase.rebaseMerges option is introduced so that users know how to
override the config option on the command line. It's also important to
clarify that --rebase-merges without an argument is not the same as
--no-rebase-merges and not passing --rebase-merges is not the same as
passing --rebase-merges=no-rebase-cousins.

A test case is necessary to make sure that --no-rebase-merges keeps
working after its code is refactored in the following patches of this
series. The test case is a little contrived: It's unlikely that a user
would type both --rebase-merges and --no-rebase-merges at the same time.
However, if an alias is defined which includes --rebase-merges, the user
might decide to add --no-rebase-merges to countermand that part of the
alias but leave alone other flags set by the alias.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/git-rebase.txt | 18 +++++++++++-------
 t/t3430-rebase-merges.sh     | 10 ++++++++++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 9a295bcee4..4e57a87624 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -529,20 +529,24 @@ See also INCOMPATIBLE OPTIONS below.
 
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
-By default, or when `no-rebase-cousins` was specified, commits which do not
-have `<upstream>` as direct ancestor will keep their original branch point,
-i.e. commits that would be excluded by linkgit:git-log[1]'s
-`--ancestry-path` option will keep their original ancestry by default. If
-the `rebase-cousins` mode is turned on, such commits are instead rebased
-onto `<upstream>` (or `<onto>`, if specified).
+When rebasing merges, there are two modes: `rebase-cousins` and
+`no-rebase-cousins`. If the mode is not specified, it defaults to
+`no-rebase-cousins`. In `no-rebase-cousins` mode, commits which do not have
+`<upstream>` as direct ancestor will keep their original branch point, i.e.
+commits that would be excluded by linkgit:git-log[1]'s `--ancestry-path`
+option will keep their original ancestry by default. In `rebase-cousins` mode,
+such commits are instead rebased onto `<upstream>` (or `<onto>`, if
+specified).
 +
 It is currently only possible to recreate the merge commits using the
 `ort` merge strategy; different merge strategies can be used only via
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index fa2a06c19f..d46d9545f2 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -250,6 +250,16 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
 	EOF
 '
 
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
2.40.0

