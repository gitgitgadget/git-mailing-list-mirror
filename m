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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3E4C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 11:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD251619AB
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 11:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbhF2LcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 07:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbhF2LcI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 07:32:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A92C061760
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 04:29:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j11-20020a05600c1c0bb02901e23d4c0977so1577529wms.0
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 04:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t7SzyISZebYsr2LXf9HYfptT48h5YeNbvQEp7hvN5dY=;
        b=W9RY/V32MpLRcSLgV6lOdFd9BG8h+zHzCCTFDbT6dWdBcLgqot617crrsaR4ocuLN5
         3I9Zzm+XCtJWgCkcpkzD8ar/3twEmXHmTtaMyIcbmK1nmF0CBPXJDUKzHlNgRn99vVwJ
         2HUaI257vME6o/ypb+uyexMDPTKdmsanH7Nmbkp4J278VHTc5RglWqBRS8wqzTzweob+
         DyXY+ahJx08E8aofonvd+H95hZWHGMUTBGxgvho8KkKc5xR0InchldHOzea2DGVL3x5n
         //QxGTqAbuCCl+DMjkCF/w1PhVV3FVAjExAowfzJJbVIHbFEaDMoEuadududDFtjcEqP
         l9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t7SzyISZebYsr2LXf9HYfptT48h5YeNbvQEp7hvN5dY=;
        b=KzP/ZJKgx1GgMxcvngkyJrXp6NRSNl0R+Gfdjx3+j3UWii2k9lG1ATNS4cYuMUp2cQ
         TB0z5C5SPs6XIBoQqHNcwB1llySRZAXwmVJEx/KcldBbdCC22B7QPzui45EHvUXMCHn6
         7d2BVIBjJl3+BLoDhCQWlKQntWkmUzUEFCbXSrsWkW4ACSRUJmaJC9YbUgqS0TX3ghNE
         Dvm4mD8fWL5o1xuyf+vYqyHIdKRK2gwhpjMq+KLgsPHpqAhBO36qBp50o2/FeKSUSbjc
         2i4re8fxNIDeSWKv82xYrApnj2/wXZfTql3ineNwJQjbf2we4N1zzEZODyNx44yJQrrk
         PfaQ==
X-Gm-Message-State: AOAM530vWNDETDKUKVU5qQM2PS8MI/m20VsjtDl8tuVKuN5heagI9RMp
        kuMNQuU6HNBiy9sMHGjq9vbvC+Dd8LvjOw==
X-Google-Smtp-Source: ABdhPJzV+kpQZqrr62rZMFUjfV2yJN07qcLXwPBnpmsYOu9jbj8tWcwoOM3AyCSZGsgMcDzYH9ODYA==
X-Received: by 2002:a7b:c770:: with SMTP id x16mr30971701wmk.56.1624966178561;
        Tue, 29 Jun 2021 04:29:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z8sm18129661wrw.18.2021.06.29.04.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 04:29:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] test-lib.sh: set COLUMNS=80 for --verbose repeatability
Date:   Tue, 29 Jun 2021 13:29:36 +0200
Message-Id: <patch-1.1-bd2bd89a2b-20210629T112910Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.615.g90fb4d7369
In-Reply-To: <patch-1.1-765c2793122-20210624T101839Z-avarab@gmail.com>
References: <patch-1.1-765c2793122-20210624T101839Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests will fail under --verbose because while we've unset COLUMNS
since b1d645b58ac (tests: unset COLUMNS inherited from environment,
2012-03-27), we also look for the columns with an ioctl(..,
TIOCGWINSZ, ...) on some platforms. By setting COLUMNS again we
preempt the TIOCGWINSZ lookup in pager.c's term_columns(), it'll take
COLUMNS over TIOCGWINSZ,

This fixes t0500-progress-display.sh., which broke because of a
combination of the this issue and the progress output reacting to the
column width since 545dc345ebd (progress: break too long progress bar
lines, 2019-04-12). The t5324-split-commit-graph.sh fails in a similar
manner due to progress output, see [1] for details.

The issue is not specific to progress.c, the diff code also checks
COLUMNS and some of its tests can be made to fail in a similar
manner[2], anything that invokes a pager is potentially affected.

See ea77e675e56 (Make "git help" react to window size correctly,
2005-12-18) and ad6c3739a33 (pager: find out the terminal width before
spawning the pager, 2012-02-12) for how the TIOCGWINSZ code ended up
in pager.c

1. http://lore.kernel.org/git/20210624051253.GG6312@szeder.dev
2. https://lore.kernel.org/git/20210627074419.GH6312@szeder.dev/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

No code changes since v1, just the suggested commit message change.

Range-diff against v1:
1:  765c279312 ! 1:  bd2bd89a2b test-lib.sh: set COLUMNS=80 for --verbose repeatability
    @@ Commit message
         preempt the TIOCGWINSZ lookup in pager.c's term_columns(), it'll take
         COLUMNS over TIOCGWINSZ,
     
    -    This fixes the t0500-progress-display.sh test when run as:
    +    This fixes t0500-progress-display.sh., which broke because of a
    +    combination of the this issue and the progress output reacting to the
    +    column width since 545dc345ebd (progress: break too long progress bar
    +    lines, 2019-04-12). The t5324-split-commit-graph.sh fails in a similar
    +    manner due to progress output, see [1] for details.
     
    -        ./t0500-progress-display.sh --verbose
    -
    -    It broke because of a combination of the this issue and the progress
    -    output reacting to the column width since 545dc345ebd (progress: break
    -    too long progress bar lines, 2019-04-12). The
    -    t5324-split-commit-graph.sh fails in a similar manner due to progress
    -    output, see [1] for details.
    -
    -    A more narrow fix here would be to only do this in the --verbose mode,
    -    but there's no harm in setting this for everything. If we're not
    -    connected to a TTY the COLUMNS setting won't matter.
    +    The issue is not specific to progress.c, the diff code also checks
    +    COLUMNS and some of its tests can be made to fail in a similar
    +    manner[2], anything that invokes a pager is potentially affected.
     
         See ea77e675e56 (Make "git help" react to window size correctly,
         2005-12-18) and ad6c3739a33 (pager: find out the terminal width before
    @@ Commit message
         in pager.c
     
         1. http://lore.kernel.org/git/20210624051253.GG6312@szeder.dev
    +    2. https://lore.kernel.org/git/20210627074419.GH6312@szeder.dev/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     

 t/test-lib.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 54938c6427..1a6ca772d6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -406,14 +406,15 @@ LANG=C
 LC_ALL=C
 PAGER=cat
 TZ=UTC
-export LANG LC_ALL PAGER TZ
+COLUMNS=80
+export LANG LC_ALL PAGER TZ COLUMNS
 EDITOR=:
 
 # A call to "unset" with no arguments causes at least Solaris 10
 # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
 # deriving from the command substitution clustered with the other
 # ones.
-unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
+unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
 	my @env = keys %ENV;
 	my $ok = join("|", qw(
 		TRACE
-- 
2.32.0.615.g90fb4d7369

