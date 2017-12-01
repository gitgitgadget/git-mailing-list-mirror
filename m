Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CBAD20C11
	for <e@80x24.org>; Fri,  1 Dec 2017 06:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbdLAGDF (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 01:03:05 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44796 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbdLAGDE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 01:03:04 -0500
Received: by mail-pf0-f194.google.com with SMTP id m26so4205895pfj.11
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 22:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Da2521CB9EZRe4/ARt0os52IQ2Hu28e2IYrdiuStkZ8=;
        b=A50kCsEa99kb7s1ZgbKfc1+OuBWEWWuc4ZRCvCRtiH92p5Q2+xbYNlirJDqs5qbkDw
         AF5tiYagCUX/J8WSmpocczCzBAaKd1kjYEON10GrZ+EVsNa3oJoEc4muE0ZY85xAyJoT
         CddaXDtruEi+PgwvJ/JJ2iOq6uP5sKnROC8Ad1WCvP8etD0tVmOWt2OJqDdLlKkU85eZ
         wrnOCHA/mUrfa93x8sEHpgtls7lK/6xbiHEFmxVbEnAoUFjCpzWtkEzM/yjRUMjTaTfR
         maItT1DznfXO1afz1klqPpBTZAsUSJrV2DhkqG5Nn7x1NryDhjikQRolAGw3fLgjuaQd
         PbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Da2521CB9EZRe4/ARt0os52IQ2Hu28e2IYrdiuStkZ8=;
        b=EIOH8PSMA10KUShggH34K8LWgMsnS7DlcQkbyQfwr/p+wWGRfq0Gv2u29dCzuCAVEr
         CnLdHamTr5zOdYqbLZYXULF6xgbDfSd2glYtEZiQnXpVPO4dQ5lKbV6DPN9dvD+8TCn3
         Bdyg41Gd0XcbqQGs5T68AjMz/RubQKxdL1drNiBoBkJw0mgEGyINDG68M31QRqm7zvH2
         QUrObyaCJep2DckcGQxgg0qtuqRprd8qftNDAgtDAkH+D2wzZn4EWt1XX5Ynnz2WnBcy
         b+Eog9lWix+wV8WDrYP7W4KWW5ngY7GRef5xAnx1lk8Z6na7mkI5x2jhSuAukq5zSGJG
         2Npg==
X-Gm-Message-State: AJaThX4+xB+/jCWZdS/Hpk7cy5YlKfZdDoAijeNlzl1pwvRa5oqsHr8m
        EMI957KalMXBjtI/ZRhzr+HLnu2o
X-Google-Smtp-Source: AGs4zMasn/iiwMe6zkjcduUTh/VdgSZLpH4OgB8tPdTJ8oXdKLKRNbbcdpbFf7Yyl08NEn3281XmOg==
X-Received: by 10.99.95.70 with SMTP id t67mr4812397pgb.49.1512108183525;
        Thu, 30 Nov 2017 22:03:03 -0800 (PST)
Received: from localhost.localdomain ([117.209.247.216])
        by smtp.gmail.com with ESMTPSA id 82sm10288874pfm.136.2017.11.30.22.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Nov 2017 22:03:02 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v5 4/4] builtin/branch: strip refs/heads/ using skip_prefix
Date:   Fri,  1 Dec 2017 11:29:33 +0530
Message-Id: <20171201055933.19368-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c
In-Reply-To: <20171129034620.4719-1-kaartic.sivaraam@gmail.com>
References: <20171129034620.4719-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding the offset strlen("refs/heads/") to skip
the prefix "refs/heads/" use the skip_prefix() function which
is more communicative and verifies that the string actually
starts with that prefix.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
Sorry, missed a ';' in v4.

The surprising thing I discovered in the TravisCI build for v4
was that apart from the 'Documentation' build the 'Static Analysis'
build passed, with the following output,

-- <snip>
$ ci/run-static-analysis.sh
GIT_VERSION = 2.13.1.1972.g6ced3f745
     SPATCH contrib/coccinelle/array.cocci
     SPATCH result: contrib/coccinelle/array.cocci.patch
     SPATCH contrib/coccinelle/free.cocci
     SPATCH contrib/coccinelle/object_id.cocci
     SPATCH contrib/coccinelle/qsort.cocci
     SPATCH contrib/coccinelle/strbuf.cocci
     SPATCH result: contrib/coccinelle/strbuf.cocci.patch
     SPATCH contrib/coccinelle/swap.cocci
     SPATCH contrib/coccinelle/xstrdup_or_null.cocci

The command "ci/run-static-analysis.sh" exited with 0.
-- <snip> --

+Cc: SZEDER
I guess static analysis tools make an assumption that the source
code is syntactically valid for them to work correctly. So, I guess
we should at least make sure the code 'compiles' before running
the static analysis tool even though we don't build it completely.
I'm not sure if it's a bad thing to run the static analysis on code
that isn't syntactically valid, though.


 builtin/branch.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ca9d8abd0..196d5fe9b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -462,6 +462,8 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 {
 	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
+	const char *interpreted_oldname = NULL;
+	const char *interpreted_newname = NULL;
 	int recovery = 0;
 	int clobber_head_ok;
 
@@ -493,6 +495,11 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	reject_rebase_or_bisect_branch(oldref.buf);
 
+	if (!skip_prefix(oldref.buf, "refs/heads/", &interpreted_oldname) ||
+	    !skip_prefix(newref.buf, "refs/heads/", &interpreted_newname)) {
+		die("BUG: expected prefix missing for refs");
+	}
+
 	if (copy)
 		strbuf_addf(&logmsg, "Branch: copied %s to %s",
 			    oldref.buf, newref.buf);
@@ -508,10 +515,10 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	if (recovery) {
 		if (copy)
 			warning(_("Created a copy of a misnamed branch '%s'"),
-				oldref.buf + 11);
+				interpreted_oldname);
 		else
 			warning(_("Renamed a misnamed branch '%s' away"),
-				oldref.buf + 11);
+				interpreted_oldname);
 	}
 
 	if (!copy &&
@@ -520,9 +527,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	strbuf_release(&logmsg);
 
-	strbuf_addf(&oldsection, "branch.%s", oldref.buf + 11);
+	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
 	strbuf_release(&oldref);
-	strbuf_addf(&newsection, "branch.%s", newref.buf + 11);
+	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
 	strbuf_release(&newref);
 	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
 		die(_("Branch is renamed, but update of config-file failed"));
-- 
2.15.0.531.g2ccb3012c

