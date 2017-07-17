Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2041320357
	for <e@80x24.org>; Mon, 17 Jul 2017 20:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbdGQULz (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 16:11:55 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:32792 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbdGQULy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 16:11:54 -0400
Received: by mail-lf0-f67.google.com with SMTP id t72so27276lff.0
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 13:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CkFgF11etwswCquMZBDgwcMXrNW/JOefYAz0g5u+y8Y=;
        b=LksTKVwdHCsQWtc5+JieHZsi3s2oK1hzNt5KkVtNvsPDlFf/I+YfyMDn/4qFeeFt5/
         CWUfoMWQu3T9xVlLXnwvzENR9e5aCzia2jKfAwTdYEsyt5cfA0e0BgmfrV09YvTMiwMK
         af20mT/wIR0JBYwa8zq21loMIcHyXgpbTWATtOB9JBGWsYNsVG6FANzqD5zhLQGmWWxh
         ViisbN+mdtJV8aBcsXjeUNibJi9nUqVOqlsKSBXtowsJrg5ZHTtEgSDwUqwJP2irNvdf
         uhS7tRkPUpXVOAz7MvQ3CeQnHDpMFhAeveDc8q0iQoC4xwnIVEaFwLwxuYr0g7h6fIf7
         vRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CkFgF11etwswCquMZBDgwcMXrNW/JOefYAz0g5u+y8Y=;
        b=Tn4x1XBB7/ZuG6gwKSbbCPeSN/vTZKInWv8GzfG2NkYbdL6HcTaeKsXV0LQff+SAW7
         sb+QgPZV42dNNPKK4xX7CUlbNLm86bCROOP5MlM71yFgHUHCdOMWUbtppJsb5bvqcvek
         Px4A/d4qeYehn6VGGHdTE+2VWeIiMQmPS2FAy3iCPRn2MRBDhtJT2J7hq4144AlPU9L2
         jLVfAYYSjLPZwrNohphXu0DUsLsZn4G5nov+Kt7VMR9MTsU8mQbK1D2mKFnKJ/McKUYJ
         D1TP/Z8c5acG7ZHGuiNqsk4hnOvgs7AXiQUlhqCDHV4954fCAOXp91fiqJ3wE1PoUOJK
         s1FQ==
X-Gm-Message-State: AIVw111xAnkxHBy1QITDUWVltnmBa4O9I4wi/c91tOcaYhZvhba5wNY3
        19OGViKmmA6fcLma
X-Received: by 10.25.196.66 with SMTP id u63mr7665438lff.159.1500322312311;
        Mon, 17 Jul 2017 13:11:52 -0700 (PDT)
Received: from localhost.localdomain (c83-248-253-33.bredband.comhem.se. [83.248.253.33])
        by smtp.gmail.com with ESMTPSA id l12sm30752ljb.39.2017.07.17.13.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 13:11:51 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 10/10] git.c: ignore pager.* when launching builtin as dashed external
Date:   Mon, 17 Jul 2017 22:10:52 +0200
Message-Id: <fa91f778e1acff812ddadb313e9979c470edc43b.1500321658.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.rc0
In-Reply-To: <cover.1500321657.git.martin.agren@gmail.com>
References: <cover.1499723297.git.martin.agren@gmail.com> <cover.1500321657.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running, e.g., `git -c alias.bar=foo bar`, we expand the alias and
execute `git-foo` as a dashed external. This is true even if git foo is
a builtin. That is on purpose, and is motivated in a comment which was
added in commit 441981bc ("git: simplify environment save/restore
logic", 2016-01-26).

Shortly before we launch a dashed external, and unless we have already
found out whether we should use a pager, we check `pager.foo`. This was
added in commit 92058e4d ("support pager.* for external commands",
2011-08-18). If the dashed external is a builtin, this does not match
that commit's intention and is arguably wrong, since it would be cleaner
if we let the "dashed external builtin" handle `pager.foo`.

This has not mattered in practice, but a recent patch taught `git-tag`
to ignore `pager.tag` under certain circumstances. But, when started
using an alias, it doesn't get the chance to do so, as outlined above.
That recent patch added a test to document this breakage.

Do not check `pager.foo` before launching a builtin as a dashed
external, i.e., if we recognize the name of the external as a builtin.
Change the test to use `test_expect_success`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
One could address this in run_argv(), by making the second call to
execv_dashed_external() conditional on "!is_builtin()" whereas a builtin
would be started as "git foo". (Possibly after unrolling and cleaning up
the "while (1)"-loop.) That seems like the wrong fix for this particular
issue, but might be a wanted change on its own -- or maybe not --, since
it would mean one could relay, e.g., "-c baz" to "git -c baz foo" (but
only for builtins...).

 t/t7006-pager.sh | 2 +-
 git.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index df258c5d4..8b2ffb1aa 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -201,7 +201,7 @@ test_expect_success TTY 'git tag -a respects --paginate' '
 	test -e paginated.out
 '
 
-test_expect_failure TTY 'git tag as alias ignores pager.tag with -a' '
+test_expect_success TTY 'git tag as alias ignores pager.tag with -a' '
 	# git-tag will be launched as a dashed external, which
 	# 1) is the source of a potential bug, and
 	# 2) is why we use test_config and not -c.
diff --git a/git.c b/git.c
index 82ac2a092..6b6d9f68e 100644
--- a/git.c
+++ b/git.c
@@ -559,7 +559,7 @@ static void execv_dashed_external(const char **argv)
 	if (get_super_prefix())
 		die("%s doesn't support --super-prefix", argv[0]);
 
-	if (use_pager == -1)
+	if (use_pager == -1 && !is_builtin(argv[0]))
 		use_pager = check_pager_config(argv[0]);
 	commit_pager_choice();
 
-- 
2.14.0.rc0

