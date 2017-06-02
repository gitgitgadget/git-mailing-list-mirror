Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA4320D12
	for <e@80x24.org>; Fri,  2 Jun 2017 10:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbdFBKdm (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 06:33:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34087 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbdFBKdl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 06:33:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id d127so17914859wmf.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 03:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u05mCVlnBoz6DYuGBU+3RV8OhfvTdRbFNORjL2t6WDQ=;
        b=OwceStNRc8pbAQ/5hensTnm0eYtfZjIwTeyy9pF1VGRUQcsZV9+8OI9xbYQaxJEqnK
         5W3q3/45CPMFvhpgQMPaul4EbO6XQbwtZHgj66dym4YzvURYyTLMkVHR0tRFG49wLzqT
         8JzQEtbfySccv63pCXmNKltpCtLXj0a+6rYMRh/N7xtB4k8DjhnTYk+0pLouV6xXtmku
         RW0UgJmRYEyPs6vv0OmyabpTJjLovwWZFgFnalL8gmHWv94IyAqeBfHiouArHOZTrXky
         jnYZoXRpW+gStYNoxUs4fNX9yM7Ed4tQPgnPgl3VOwFZPPc1W0ZggKNMDiAfRRpqrE7a
         TT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u05mCVlnBoz6DYuGBU+3RV8OhfvTdRbFNORjL2t6WDQ=;
        b=ZM5NPAKXIt/r0NSoZLg2Dhlu8yezeSXA6gKBZUy0u3LEs+5YzFtQwVoel7z1jRdiGq
         u6iMM0nkuALE5iQpaMQ0g7aW3M5CCit5s33AcPLVwSahZDqZFVPaAefUQkEK+x8B7wUa
         ucEz7SHUwINX3NoJ92y6p+Wwmm14TMMW9t1ZT/5toGR5WdwnLiNXq5KEPI+FaM9bysFe
         wjOeXvpFaERqBcaglgcIWLuiqpiumYRHHrBYDDZL1vceDvmeO5JV6Rddh8Bzddbo+IPt
         tjai5rL5thdaVueBGBKGzOkEEXaY1y3mpPo3Cbu9Mh8OT5YVFWULdtdaHhFAciG7I1cN
         g+Pg==
X-Gm-Message-State: AODbwcD8HcGbS8PCEhVueQN7PGXAYbJYXPoInI1y00OLllRQMWGfTzbF
        oghyC34Ut3IqXe2TCbs=
X-Received: by 10.80.146.71 with SMTP id j7mr5532938eda.17.1496399619937;
        Fri, 02 Jun 2017 03:33:39 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id x26sm1356747edx.62.2017.06.02.03.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Jun 2017 03:33:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] perf: work around the tested repo having an index.lock
Date:   Fri,  2 Jun 2017 10:33:30 +0000
Message-Id: <20170602103330.25663-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.506.g27d5fe0cd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the tested repo has an index.lock file it should be removed. This
file may be present if e.g. git-status previously crashed in that
repo, and it will make a lot of git commands fail. Let's try harder
and remove the lock.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/perf-lib.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index b6fc880395..b50211b259 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -108,7 +108,14 @@ test_perf_create_repo_from () {
 		cd "$repo" &&
 		"$MODERN_GIT" init -q &&
 		test_perf_do_repo_symlink_config_ &&
-		mv .git/hooks .git/hooks-disabled 2>/dev/null
+		mv .git/hooks .git/hooks-disabled 2>/dev/null &&
+		if test -f .git/index.lock
+		then
+			# We may be copying a repo that can't run "git
+			# status" due to a locked index. Since we have
+			# a copy it's fine to remove the lock.
+			rm .git/index.lock
+		fi
 	) || error "failed to copy repository '$source' to '$repo'"
 }
 
-- 
2.13.0.506.g27d5fe0cd

