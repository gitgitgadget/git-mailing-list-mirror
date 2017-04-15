Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA1620D09
	for <e@80x24.org>; Sat, 15 Apr 2017 10:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753425AbdDOKjb (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 06:39:31 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35562 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752796AbdDOKja (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 06:39:30 -0400
Received: by mail-wr0-f194.google.com with SMTP id l44so14917375wrc.2
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 03:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vriVJvLpCffY1nIA3hMM0iDXGUZwxQLoT+82sPgOwMw=;
        b=Sfx3b3umP/Bk5fZ/z3ZPZtl1ERnC91FT2x4UD/9kobOGvUiclh+AdYd/uOLLeqWfYh
         8WCPdUOeHMKxOm/d49SjHqjjF6sGN14LNpo6Ai2QUEc8QwuQ6aFtidRZSnmK7A1PhHHU
         yZe3qMd1a89qjQUXvvZD9mvBtgX6Obpkr8tmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vriVJvLpCffY1nIA3hMM0iDXGUZwxQLoT+82sPgOwMw=;
        b=pH6wwZZNEItMB6TdbWNqds2K6tnUe3Y611Sfho8FE//39/8Eo7lF2vtRqI/1CJb3pz
         x9BTDtEp2kK46jWWntRIsbKpaCtwG0jUZ5+P2KBCWhKlGxKaqYg1BtPpf72Eo4cfUoGy
         8UMjeHH8d6tkpbxXJE84VLvPxFdSsjqqBISxN/diBg/fHFcS0RnO8SqfKzN4Vlzux/uo
         rJxxMLsOz+256clr3STNBR5yy1ArxPkbGNOdiB5MQ1WK19uPihzjqliFbeAPQ0XFUTk5
         Oa9xbZ5WsnLm7LuEwF/3niaL8/dkZrX4cCxdY9EE89MtfvSbn/fG4YIGdFUedLnUxtXg
         GzxA==
X-Gm-Message-State: AN3rC/46MHZ0S9FeFad5HKkAGdu2FBl1tj3bUMhyEYSlvDX1PVmh66WX
        1tY0vJuy8IfTfw==
X-Received: by 10.223.135.7 with SMTP id a7mr10743830wra.103.1492252768424;
        Sat, 15 Apr 2017 03:39:28 -0700 (PDT)
Received: from ldiamand-t3610.corp.roku ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id y63sm2072774wme.31.2017.04.15.03.39.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 15 Apr 2017 03:39:27 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Sam Hocevar <sam@hocevar.net>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 1/3] git-p4: add failing test for name-rev rather than symbolic-ref
Date:   Sat, 15 Apr 2017 11:36:07 +0100
Message-Id: <20170415103609.6002-2-luke@diamand.org>
X-Mailer: git-send-email 2.12.2.719.gcbd162c
In-Reply-To: <20170415103609.6002-1-luke@diamand.org>
References: <20170415103609.6002-1-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using name-rev to find the current git branch means that git-p4
does not correctly get the current branch name if there are
multiple branches pointing at HEAD, or a tag.

This change adds a test case which demonstrates the problem.
Configuring which branches are allowed to be submitted from goes
wrong, as git-p4 gets confused about which branch is in use.

This appears to be the only place that git-p4 actually cares
about the current branch.

Signed-off-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9807-git-p4-submit.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index e37239e65..ae05816e0 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -139,6 +139,22 @@ test_expect_success 'submit with master branch name from argv' '
 	)
 '
 
+test_expect_failure 'allow submit from branch with same revision but different name' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		test_commit "file8" &&
+		git checkout -b branch1 &&
+		git checkout -b branch2 &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.allowSubmit "branch1" &&
+		test_must_fail git p4 submit &&
+		git checkout branch1 &&
+		git p4 submit
+	)
+'
+
 #
 # Basic submit tests, the five handled cases
 #
-- 
2.12.2.719.gcbd162c

