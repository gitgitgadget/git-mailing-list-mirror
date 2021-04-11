Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF4FC433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B57B610CA
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbhDKOew (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 10:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhDKOew (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 10:34:52 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AD4C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 07:34:35 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id c1so3854189ljd.7
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iLnDNMCHt/+W2dchbIaaA5vYTRd5u9oyXvVmsjOGAyw=;
        b=kSIX8K9eh/snr8kuwHoMk/WH9daTNIoST2pYYj4Qm9/iBFfAXVukIeTTIJDwL8CWwI
         A5ra7UJeaEg7kCjGWkaU5M1OeHaxnHj8Kxd2mI4VCyKch10OrLquSKh9L7mNCWQYpl00
         YjdGejBVl5XCM25Y/6G/W42zdOsK0SElIfoAEdxqEv+F+e+pW/TuYzppqcDjcTn6JYOL
         97aAWz5vXZ9ok55qO+cOVw3AngfYjAza0syfbcFYgUGBG0zacyZncY3NCfS6dpUKcCmL
         U34pOThjvLTyrVVIZ9ODPkI11iFpcoRgwnx5orSnTtLJyLgLKXWBKiQKTrDrVNxQ0Beo
         DwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iLnDNMCHt/+W2dchbIaaA5vYTRd5u9oyXvVmsjOGAyw=;
        b=KKJHZGNi6wf3VI9xKut8XQ2Pl+onPh10AiKocqFKkPtvZcC7JDM2hZyr6BFT0XfGe/
         P1q/7ZnpgE0zRKk3ECVfwCKzPnoMOOAAHptm55TvG1LXgp1ApJOFrEDKKdqcLs3qI1b3
         aBgCJ7oQ/FNg4Ii0myRCB3UV1p4c0sq5SgGbWQu4E8UuAq/Er7ZEzE5X0/wvT7WzJJVW
         jgUXxMmYhEUetfgmTcdnScdqvj5ByjBenHuyrsDTV1gY+lnNf0ZSCTSUhV5myt0H/1XW
         XtYAyzYUnC8XOMXxKeWU+4waz6IpwPfLSWfMGNsVNS64dE06KQYqcJJUmHvMKeDy9Dni
         5Zsw==
X-Gm-Message-State: AOAM5321REdTD1PkgT9HUzktLkrzpFhiyTr4yZxzcvYcQO6Lde4B919U
        WS4bry4V4XAxWl+ZtsSc0VA=
X-Google-Smtp-Source: ABdhPJw2sLWKOkMTFynm/wJqQvbkZNElJX7FnY3vKUnQ+RLaZyLvvk6DMbFuDnjxl5Uv0e+WvId04Q==
X-Received: by 2002:a2e:9dc2:: with SMTP id x2mr15789458ljj.306.1618151674043;
        Sun, 11 Apr 2021 07:34:34 -0700 (PDT)
Received: from localhost.localdomain (90-229-209-178-no2204.tbcn.telia.com. [90.229.209.178])
        by smtp.gmail.com with ESMTPSA id i22sm1321287lfv.120.2021.04.11.07.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 07:34:33 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, "Junio C Hamano" <gitster@pobox.com>,
        git@vger.kernel.org
Subject: [PATCH] t0091-bugreport.sh: actually verify some content of report
Date:   Sun, 11 Apr 2021 16:33:54 +0200
Message-Id: <20210411143354.25134-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.31.1.163.ga65ce7f831
In-Reply-To: <20210409212724.GE2947267@szeder.dev>
References: <20210409212724.GE2947267@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the first test in this script, 'creates a report with content in the
right places', we generate a report and pipe it into our helper
`check_all_headers_populated()`. The idea of the helper is to find all
lines that look like headers ("[Some Header Here]") and to check that
the next line is non-empty. This is supposed to catch erroneous outputs
such as the following:

  [A Header]
  something
  more here

  [Another Header]

  [Too Early Header]
  contents

However, we provide the lines of the bug report as filenames to grep,
meaning we mostly end up spewing errors:

  grep: : No such file or directory
  grep: [System Info]: No such file or directory
  grep: git version:: No such file or directory
  grep: git version 2.31.1.164.g984c2561cd: No such file

This doesn't disturb the test, which tugs along and reports success, not
really having verified the contents of the report at all.

Note that after 788a776069 ("bugreport: collect list of populated
hooks", 2020-05-07), the bug report, which is created in our hook-less
test repo, contains an empty section with the enabled hooks. Thus, even
the intention of our helper is a bit misguided: there is nothing
inherently wrong with having an empty section in the bug report.

Let's instead grep for some contents that we expect to find in a bug
report. We won't verify that they appear in the right order, but at
least we end up verifying the contents more than before this commit.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 > It does scare me..

 Maybe something like this?

 t/t0091-bugreport.sh | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index 526304ff95..9111c4c26f 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -4,29 +4,13 @@ test_description='git bugreport'
 
 . ./test-lib.sh
 
-# Headers "[System Info]" will be followed by a non-empty line if we put some
-# information there; we can make sure all our headers were followed by some
-# information to check if the command was successful.
-HEADER_PATTERN="^\[.*\]$"
-
-check_all_headers_populated () {
-	while read -r line
-	do
-		if test "$(grep "$HEADER_PATTERN" "$line")"
-		then
-			echo "$line"
-			read -r nextline
-			if test -z "$nextline"; then
-				return 1;
-			fi
-		fi
-	done
-}
-
-test_expect_success 'creates a report with content in the right places' '
+test_expect_success 'creates a report with content' '
 	test_when_finished rm git-bugreport-check-headers.txt &&
 	git bugreport -s check-headers &&
-	check_all_headers_populated <git-bugreport-check-headers.txt
+	grep "^Please answer " git-bugreport-check-headers.txt &&
+	grep "^\[System Info\]$" git-bugreport-check-headers.txt &&
+	grep "^git version:$" git-bugreport-check-headers.txt &&
+	grep "^\[Enabled Hooks\]$" git-bugreport-check-headers.txt
 '
 
 test_expect_success 'dies if file with same name as report already exists' '
-- 
2.31.1.163.ga65ce7f831

