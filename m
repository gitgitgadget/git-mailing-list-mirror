Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FD63201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 17:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424361AbdKRR2L (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 12:28:11 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37325 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424344AbdKRR2J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 12:28:09 -0500
Received: by mail-pf0-f195.google.com with SMTP id t69so4226717pfg.4
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 09:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yy8hgHXyEKNdaqmtvIRJ8DnuKrPPWyt9CiLaTFq9fSA=;
        b=Lc9fnlrB+rbmORh68qnPtIZH62/Rc2/tWNz0srj1ahX+AogxIxzdrTLdlz77zJHz0V
         cdLhZYXZEwxL57BJSe0IKCTBUO5zbQTCKt8dftHVbU4Syo1aG6WLVmXz+OxOQ1eMqX72
         vag2fmi7jZZfeI/MGBQ+te3oGc7s14BmetynQxbr99TYhAjCWGMfxzzfiw6Y2gxbkAXe
         s5B5idg13caXeXMVBod5fkp6tL3d+TJsQ86NfAsf6hjMN3vnePGHjlA01/fNt9rqRm8b
         HRNwXUObnKI+UvTVGswbOR/S16QxlnUJQFdJsWM1SbSoBzG/p036qgp9Mw/EN7jCkdac
         43OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yy8hgHXyEKNdaqmtvIRJ8DnuKrPPWyt9CiLaTFq9fSA=;
        b=ezClC3rEuSjitH3ND8ujs0Nhxhbvzy82tVvGV9lI83wN/l6MonbVOm5+Txc8zSl7Ej
         cpkmskxu3JjcQE1Z3xHTTpbZR+afa2rIXUyIlg0a6rvsXXUqn87iQoOgF3zZIvwLotA6
         dNUbK9fVKxkQ436J1wwWofFY3au9EgaGttsp+HoKkvWkROwLxeKN8miQDQFcMvX6yNBX
         SrBVOMtDMY/xsP5winZz1Lgrc9Cv9W2cDCZ3inlqCBVj/3Pg5S9JVYOnJ1Oj+bcHdNjj
         6LhMjnbECE/FExVNJWpbLvzdfFDnk41zUbCFlk+btYaWQ1MyNANa9z2IVsqwWYixUeIG
         aWVg==
X-Gm-Message-State: AJaThX5+YfLKv8qwxgIATIBIEfH0lt4xg/bzMxlrk0FzJ9JVJluGIYVc
        XnWXIQPSuc+6l547FVjRCa0oeYDG
X-Google-Smtp-Source: AGs4zMZ2aTNm+SZk+rQNdVghkGpsQaOVneqRibwn/kW5pLJri8TcIVlhXbfcfy8sKpc3pgdC+P99kA==
X-Received: by 10.84.235.8 with SMTP id o8mr5480565plk.354.1511026088539;
        Sat, 18 Nov 2017 09:28:08 -0800 (PST)
Received: from localhost.localdomain ([2405:204:72c0:fc36:f2a4:a5ab:70fc:f807])
        by smtp.gmail.com with ESMTPSA id d12sm10479749pgt.16.2017.11.18.09.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Nov 2017 09:28:07 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 4/4] builtin/branch: strip refs/heads/ using skip_prefix
Date:   Sat, 18 Nov 2017 22:56:48 +0530
Message-Id: <20171118172648.17918-5-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.291.g0d8980c5d
In-Reply-To: <20171118172648.17918-1-kaartic.sivaraam@gmail.com>
References: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20171118172648.17918-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding the offset strlen("refs/heads/") to skip
the prefix "refs/heads/" use the skip_prefix() function which
is more communicative and verifies that the string actually
starts with that prefix.

Though we don't check for the result of verification here as
it's (almost) always the case that the string does start
with "refs/heads", it's just better to avoid hard-coding and
be more communicative.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 builtin/branch.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ca9d8abd0..8c546a958 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -462,6 +462,8 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 {
 	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
+	const char *prefix_free_oldref = NULL;
+	const char *prefix_free_newref = NULL;
 	int recovery = 0;
 	int clobber_head_ok;
 
@@ -493,13 +495,17 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	reject_rebase_or_bisect_branch(oldref.buf);
 
+	/* At this point it should be safe to believe that the refs have the
+	   prefix "refs/heads" */
+	skip_prefix(oldref.buf, "refs/heads/", &prefix_free_oldref);
+	skip_prefix(newref.buf, "refs/heads/", &prefix_free_newref);
+
 	if (copy)
 		strbuf_addf(&logmsg, "Branch: copied %s to %s",
 			    oldref.buf, newref.buf);
 	else
 		strbuf_addf(&logmsg, "Branch: renamed %s to %s",
 			    oldref.buf, newref.buf);
-
 	if (!copy && rename_ref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch rename failed"));
 	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
@@ -508,10 +514,10 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	if (recovery) {
 		if (copy)
 			warning(_("Created a copy of a misnamed branch '%s'"),
-				oldref.buf + 11);
+				prefix_free_oldref);
 		else
 			warning(_("Renamed a misnamed branch '%s' away"),
-				oldref.buf + 11);
+				prefix_free_oldref);
 	}
 
 	if (!copy &&
@@ -520,9 +526,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	strbuf_release(&logmsg);
 
-	strbuf_addf(&oldsection, "branch.%s", oldref.buf + 11);
+	strbuf_addf(&oldsection, "branch.%s", prefix_free_oldref);
 	strbuf_release(&oldref);
-	strbuf_addf(&newsection, "branch.%s", newref.buf + 11);
+	strbuf_addf(&newsection, "branch.%s", prefix_free_newref);
 	strbuf_release(&newref);
 	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
 		die(_("Branch is renamed, but update of config-file failed"));
-- 
2.15.0.291.g0d8980c5d

