Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28EE61FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 18:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbdBLSlm (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 13:41:42 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36054 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbdBLSli (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 13:41:38 -0500
Received: by mail-pg0-f65.google.com with SMTP id 75so7596758pgf.3
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 10:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bNHoWAHxLqcPsmdf3KDz5rEC3PNK1u3zqoECVb1IaoI=;
        b=BtLrVw7P777QrZSRzrJOFuJfaHUvB15GukkEC18rIq9t2rRrWgXxGcelNi6LT8JqpN
         aorgfPqOV+xxYL9UMzkQ9onwMgkqCOOmV7CkCNADLuqmg0vCzs5uy+i1lLpc3Fq6L3mZ
         khBHNaJ5jmx0DwkT+0qBBxOE1p6FTcdJqPeRftIh5k4MbVDXvS58dnzmJ2pDGAskOXJc
         FQB5ZM9AkcqI20jNqK4vhFeiJQ7got4+J9+/+eTaxcLUwbpeexi2tdXtyVQMncVF4D1f
         lauI6pPQLlwBwvCWS92B6irOfrTKdLLavd7f9Yoz6coF8xYbnNQlytK9ndx9bGSopRFD
         /eQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=bNHoWAHxLqcPsmdf3KDz5rEC3PNK1u3zqoECVb1IaoI=;
        b=HBBzqx1oqKeiLCON++otqnZaglG3sWiCq+J2VZICKDqmbey9uFG/UUWEjt/jS/zirJ
         oo8L5Sgo76eWXzMgADIcWqY/Ppgci9nNuQHXR5YBiXK75DRvxpwZhb55KOstPdK9KvuA
         fWq/JvX0lHuPJ6K1zzjFXbJ7b4WSo9Y2Qhn9PTOOLahaQRoOulNJhQlHwFa/6dtmsozG
         LBQTqMCfaoT8udM7E7I87YGxlW/wVDA4x3eIHrrB1moEchLx89RKTO2xKrUr94UXkmIE
         oMWLRQAMZ3REYfif4Efmira/XxSQBv+FP1wXxKkhXZN89gsqOdPJidWW8Seo1rKVNzng
         3m3A==
X-Gm-Message-State: AMke39mqZ8Se4fxSoJckoGsjt5fnwpKrWk/qEpGjrEdBd2Smaa1voZCzMZvuQkt1VpHSOg==
X-Received: by 10.98.149.93 with SMTP id p90mr22101960pfd.72.1486924897953;
        Sun, 12 Feb 2017 10:41:37 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:644a:2999:a3b7:74ee])
        by smtp.gmail.com with ESMTPSA id z4sm10054543pge.49.2017.02.12.10.41.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 12 Feb 2017 10:41:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 3/3] setup_revisions(): allow a rev that begins with a dash
Date:   Sun, 12 Feb 2017 10:41:32 -0800
Message-Id: <20170212184132.12375-4-gitster@pobox.com>
X-Mailer: git-send-email 2.12.0-rc1-212-ga9adfb24fa
In-Reply-To: <20170212184132.12375-1-gitster@pobox.com>
References: <xmqqa89sguu4.fsf@gitster.mtv.corp.google.com>
 <20170212184132.12375-1-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now all the preparatory pieces are in place, it is a matter of
handling a truly unknown option _after_ handle_revision_arg()
decides that arg is not a rev.  

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 We _could_ do without a new variable maybe_opt and instead check if
 arg begins with a dash one more time, but it is cleaner to do it
 the way this patch does to avoid writing the same check twice.  We
 may be hit with a desire similar to but an opposite of the current
 topic (which wants to allow a rev that begins with a dash), to
 start allowing an option that does not begin with a dash someday.

 revision.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index eccf1ab695..0f772ba73d 100644
--- a/revision.c
+++ b/revision.c
@@ -2203,6 +2203,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	read_from_stdin = 0;
 	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
+		int maybe_opt = 0;
+
 		if (*arg == '-') {
 			int opts;
 
@@ -2232,13 +2234,20 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			}
 			if (opts < 0)
 				exit(128);
-			/* arg looks like an opt but something we do not recognise. */
-			argv[left++] = arg;
-			continue;
+			/*
+			 * arg looks like an opt but something we do not recognise.
+			 * It may be a rev that begins with a dash; fall through to
+			 * let handle_revision_arg() have a say in this.
+			 */
+			maybe_opt = 1;
 		}
 
 		if (!handle_revision_arg(arg, revs, flags, revarg_opt)) {
 			got_rev_arg = 1;
+		} else if (maybe_opt) {
+			/* it turns out that it is not a rev after all */
+			argv[left++] = arg;
+			continue;
 		} else {
 			int j;
 			if (seen_dashdash || *arg == '^')
-- 
2.12.0-rc1-212-ga9adfb24fa

