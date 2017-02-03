Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 106531FAF4
	for <e@80x24.org>; Fri,  3 Feb 2017 02:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbdBCCt0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:49:26 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36347 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752198AbdBCCtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:25 -0500
Received: by mail-wm0-f68.google.com with SMTP id r18so1168966wmd.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C1YzDSWuF1b1O0WBy92JQGe9wkGQOkEFrbANxMQq2Bs=;
        b=WtJ+z5rBy66IITnZsFA68JiO5ZYi44u9U6EcJ2AsmdHwfSAV18wnBBgeIaxqkU8eCx
         brM1xTuL0ODLQULAtYaI00/94rBtbVfugsxuaZiB+johqohq4FtCxv+zUrIUV/is+AV+
         XrPjMWk5XW6QPbNJf+xDQOrtaKuT3jLNi3oHUzSjQKgu8Ng7T2ByYpeymHG0n/dWmcu8
         aY2KXD6eWmmhLE5j/RtApxYY2UNrVwUpYuf7F8Sr+Uwzqn7vMnIH11fGryIK/4V5E0h4
         BGSoB9TW5UtdDrcyyCfK5uX5sYQxenHae7j/XF+uLSw4H/LB3k2REn22srNXX01HPHBH
         ssKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C1YzDSWuF1b1O0WBy92JQGe9wkGQOkEFrbANxMQq2Bs=;
        b=BuiHvEButT0hCSXIxeEfsME+nctcuhfqXd+m1M1mO+qtAfv901GRGxZ0Z96aK4/Tf+
         mlzJFAU/Z9+6s8TMIynbVb0VjODkjmGrcaIo0Ts8q6a5QZTIVMT5eZYbTZKDtuev8L0V
         S9/HUBA8+RPsY1rzBVBK+afOSi2YNbFXTZ5kSdSwOtD3klQLfsZRTaTiPebdkPhlMhdp
         QkJG7miNgZzHITBI5T+o43Zv8eCfLY3JTx51KyneKTJ3NNte8xl210n/4B9PeLZzp9W6
         36rCHbjBlCExZoRnQbRYGoYVbgULCHmO1zGaEwakuFZalz5URNwcz4vOYixrIIdQoMVp
         RPtA==
X-Gm-Message-State: AIkVDXIDQ3N/0V+LdtgG5A/PN1K3tRux9zpkLSC/iRm0y10o4XNSj8uUvKTNLmVK9L1SOw==
X-Received: by 10.223.130.118 with SMTP id 109mr11749962wrb.10.1486090163642;
        Thu, 02 Feb 2017 18:49:23 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:22 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 11/21] completion: don't list 'HEAD' when trying refs completion outside of a repo
Date:   Fri,  3 Feb 2017 03:48:19 +0100
Message-Id: <20170203024829.8071-12-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203024829.8071-1-szeder.dev@gmail.com>
References: <20170203024829.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When refs completion is attempted while not in a git repository, the
completion script offers 'HEAD' erroneously.

Check early in __git_refs() that there is either a repository or a
remote to work on, and return early if neither is given.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 8 ++++++--
 t/t9902-completion.sh                  | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fd0ba1f3b..6b489b7c8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -346,7 +346,11 @@ __git_refs ()
 	local list_refs_from=path remote="${1-}"
 	local format refs pfx
 
-	if [ -n "$remote" ]; then
+	if [ -z "$remote" ]; then
+		if [ -z "$dir" ]; then
+			return
+		fi
+	else
 		if __git_is_configured_remote "$remote"; then
 			# configured remote takes precedence over a
 			# local directory with the same name
@@ -360,7 +364,7 @@ __git_refs ()
 		fi
 	fi
 
-	if [ "$list_refs_from" = path ] && [ -d "$dir" ]; then
+	if [ "$list_refs_from" = path ]; then
 		case "$cur" in
 		refs|refs/*)
 			format="refname"
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a201b5212..5b4defaa5 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -599,7 +599,7 @@ test_expect_success '__git_refs - non-existing URL remote - full refs' '
 	test_must_be_empty "$actual"
 '
 
-test_expect_failure '__git_refs - not in a git repository' '
+test_expect_success '__git_refs - not in a git repository' '
 	(
 		GIT_CEILING_DIRECTORIES="$ROOT" &&
 		export GIT_CEILING_DIRECTORIES &&
-- 
2.11.0.555.g967c1bcb3

