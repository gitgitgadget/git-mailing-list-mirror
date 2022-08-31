Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC934ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 08:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiHaImA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 04:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiHaIl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 04:41:56 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D3CB6560
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:41:54 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id d5so6967072wms.5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=G1QA90W7BkClbULc6WUseq2OEi/28M14TQ1sYTnxL3U=;
        b=hHPk+Utn3pOn6+InB04Em/b8WCPEQGx98Icnm0nxH07UT8Jq866d7loaMTvfvwx0na
         OOljipborCi3i3OQ00OdOvPp/vlpAbBiJIYd9P9d96nmQfUQMhCnEL9sGn5H6KkaFLP3
         ZY7KA3o1BHAttvHnd5cMRtzD9is9yICTsN7YuzK7CKSQtoz96H1F/0ju6vMeDeu6qwUx
         7fGDzUQMoX4MvMtlkn96VXwhdF1y4KXJ8bGopoIzbulxSQjJeO7O2XvTOgMFjpo4QlmS
         nLUQEYHXSGDbdO8GIJY4HpVJ1/LS/dD2OS0lJxOit1PjAiFcsjxqpMfjmsM+wQ6IIoye
         nBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=G1QA90W7BkClbULc6WUseq2OEi/28M14TQ1sYTnxL3U=;
        b=mwD2CAB7Fjpbk+capyHbgmy0Wcs5h3tMlKwvDwGX4zbpIi+ljNKY6+fC/IiRrPKEvi
         ZAWpjmEjNFOTrvyYHDMGb5drlTC1/8TduXTilBixlKyEL+t6KVxnntqWJiWRg9nGu7AF
         cLrswDfHWExvx9OTs+idFbry1/Ha3xgLgi5iiIJEDDkKktNL8Jd03l/LbgB03goRCWeD
         Zgr+fQPUoyzPVWcCxqaKwE/HMTJ1CKxDcBA8ThFDIyGInMzSxbrhrGtEH0zzFL0YNTql
         +rPB/n7KvDzCDIZWD/GcUu0nlErIPY5aJ8LymhYHmoR/ileNq5dZJhxUf1eZvoPZ0gEQ
         3gmw==
X-Gm-Message-State: ACgBeo1CUF3lxu2CAE5tOTC8UJVsJlOH36E3q0/E0M7SFSoLuHKbTgIc
        CtRPP/pX/wPtMQLwqyZrAA9jTGhNOygmRg==
X-Google-Smtp-Source: AA6agR6Pm52jNsHR4vwXba4RWRob3su/YglEPnlwWgAxaIK7Ee26vpItjUtCc2k6pOIQH8hJBE3j3w==
X-Received: by 2002:a05:600c:4f10:b0:3a5:f8c8:a5b5 with SMTP id l16-20020a05600c4f1000b003a5f8c8a5b5mr1261363wmq.34.1661935313139;
        Wed, 31 Aug 2022 01:41:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2-20020a7bc5c2000000b003a5c064717csm1439036wmk.22.2022.08.31.01.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 01:41:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/9] grep docs: de-duplicate configuration sections
Date:   Wed, 31 Aug 2022 10:41:33 +0200
Message-Id: <patch-v3-2.9-d16e927caa2-20220831T083759Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1406.g184357183a6
In-Reply-To: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
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
2.37.3.1406.g184357183a6

