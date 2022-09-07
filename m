Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBC2C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 08:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiIGI1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 04:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiIGI1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 04:27:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7F2A2A9A
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 01:27:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t7so14124519wrm.10
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Dxo/6zLHt+5JLsnHrqgp3k9Ot/IsC/bYbSni+chKz80=;
        b=ivo6PMrnaivqSFfA4efcq6pCHvIAUcCktjxBpN5rnUIKO0GctGCYdYIrm38j4CPi3B
         QO658JigvF+iuGg4YvgApuwBkvcvZUpDo42z89eicFaczsrjXZWLD2sO3yxgDmPRWQd7
         nNwqol+1ikhIgsvBu27GNtaAC8N63qOQeEq1rcy+L/22LZKlMLwE/2ypw/QMHR6kHaOv
         yxp+qfiNteeXEFdnVs2/d6zDaLGJiE+kdmdGROfl2bhkht9GIUe6vVGiDarui3VYtdVD
         oezagzk5UmTve9Rxn7DGc51eCTdOkU40dw3xYC6B/Jtca2uWPoWWAx71u22mbQENRZqo
         G9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Dxo/6zLHt+5JLsnHrqgp3k9Ot/IsC/bYbSni+chKz80=;
        b=312HkRs2R6rCbDJO7Vdp0QvCopvTJEvgCOxw4wHF87bqG+nG1T+nt4CQMrKnaqBDg0
         /DFUyTG5Y5oO64nrGLLINegNw5wDjyRjMe/jVLkEAjA/vivL5CfAerlK9GkGMIam07RK
         WUSL+ycnOb/UoFq2qvB6jL7+4p2q1mH0tsG0f4z7bnN9ybwE1fq46KD/jrkWxfdFDq7x
         ggC3Y+LnlQ37zCVle1XAZuJp924UpcCi15vOTMPI9mNGCWhLBk/KekacD/+3xsgM2OJW
         79WTHx9TkzL+EeGGP5OFkVXaSspipouutxTFkD36eeoYhHsD/PqJrZHUGV8oHxbrZPRP
         5bVg==
X-Gm-Message-State: ACgBeo3rV2XhlVUPcVZ8PAU+iX2wCQcNfEYD09WgWEXvffcf2Rifntgp
        lQ3jAAJ5ylrN8zJop6nP/dEdnzsFxDF9+A==
X-Google-Smtp-Source: AA6agR4co1fQR/zRms8Yp+WlfH6t6MECzlc4On+uht4Gj6PX0iJ1yfLHhIfzdyQNHax3ieoxgW2UPw==
X-Received: by 2002:a5d:488c:0:b0:226:ded7:69f8 with SMTP id g12-20020a5d488c000000b00226ded769f8mr1285243wrq.418.1662539233476;
        Wed, 07 Sep 2022 01:27:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003a3170a7af9sm19532096wmq.4.2022.09.07.01.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 01:27:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/9] grep docs: de-duplicate configuration sections
Date:   Wed,  7 Sep 2022 10:26:58 +0200
Message-Id: <patch-v4-2.9-e5ad838e1d7-20220907T082419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1490.g9adf4224da0
In-Reply-To: <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Include the "config/grep.txt" file in "git-grep.txt", instead of
repeating an almost identical description of the "grep" configuration
variables in two places.

There is no loss of information here that isn't shown in the addition
to "grep.txt". This change was made by copying the contents of
"git-grep.txt"'s version over the "grep.txt" version. Aside from the
change "grep.txt" being made here the two were identical.

This documentation started being copy/pasted around in
b22520a37c8 (grep: allow -E and -n to be turned on by default via
configuration, 2011-03-30). After that in e.g. 6453f7b3486 (grep: add
grep.fullName config variable, 2014-03-17) they started drifting
apart, with only grep.fullName being described in the command
documentation.

In 434e6e753fe (config.txt: move grep.* to a separate file,
2018-10-27) we gained the include, but didn't do this next step, let's
do it now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/grep.txt |  7 +++++--
 Documentation/git-grep.txt    | 29 ++---------------------------
 2 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index 182edd813a5..e521f20390c 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -17,8 +17,11 @@ grep.extendedRegexp::
 	other than 'default'.
 
 grep.threads::
-	Number of grep worker threads to use.
-	See `grep.threads` in linkgit:git-grep[1] for more information.
+	Number of grep worker threads to use. If unset (or set to 0), Git will
+	use as many threads as the number of logical cores available.
+
+grep.fullName::
+	If set to true, enable `--full-name` option by default.
 
 grep.fallbackToNoIndex::
 	If set to true, fall back to git grep --no-index if git grep
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 58d944bd578..dabdbe8471d 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -343,34 +343,9 @@ performance in this case, it might be desirable to use `--threads=1`.
 CONFIGURATION
 -------------
 
-grep.lineNumber::
-	If set to true, enable `-n` option by default.
-
-grep.column::
-	If set to true, enable the `--column` option by default.
-
-grep.patternType::
-	Set the default matching behavior. Using a value of 'basic', 'extended',
-	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
-	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
-	value 'default' will return to the default matching behavior.
-
-grep.extendedRegexp::
-	If set to true, enable `--extended-regexp` option by default. This
-	option is ignored when the `grep.patternType` option is set to a value
-	other than 'default'.
-
-grep.threads::
-	Number of grep worker threads to use. If unset (or set to 0), Git will
-	use as many threads as the number of logical cores available.
-
-grep.fullName::
-	If set to true, enable `--full-name` option by default.
-
-grep.fallbackToNoIndex::
-	If set to true, fall back to git grep --no-index if git grep
-	is executed outside of a git repository.  Defaults to false.
+include::includes/cmd-config-section-all.txt[]
 
+include::config/grep.txt[]
 
 GIT
 ---
-- 
2.37.3.1490.g9adf4224da0

