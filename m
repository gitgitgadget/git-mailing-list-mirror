Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717D41F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbdBCCth (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:49:37 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36421 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752200AbdBCCtc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:32 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so1169420wmd.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RrJalK6Htn9WR7Eg3segy7dtvDbUAwqCzACmFg23M3k=;
        b=VAU6kMu1kUGDVuvrG0Skk8QyYUmCmuZqUfD3jUxxeP9DzdYl5iZyxJc7vF729kUjgF
         9tEeldtlFlW1scnDBCfVHMXSlTtRTSmJ/rWaR/Co3TOIsP8M2fPC112RBOGZxKvvtnne
         vfW8O6oINuLzW5VAriKYIwn6WLvDi8k5nDHAnYZeKoleGT5pAd6/pwG/TDVQec/f+8TR
         OCDxue6mft6mZ1Ghk/sO30B9c5v7Qb+2HNE2ZHKFimNcu07dk4rKo+apM5nQdNKNmxyj
         dLlr9qdOarIoiQFr8mCfxjESGuo2GzE+SD3mKUcs0Uly4+puJ8Cd1VXbMeo8Xjz1zMVN
         JRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RrJalK6Htn9WR7Eg3segy7dtvDbUAwqCzACmFg23M3k=;
        b=uEfUG4N+YIbW+A0YCqFZRER+MgjhPeNcqEtxSTIZ4Slck6zGSuo5z9kfkGUyFgIfC0
         F2c+akL7Rv+WktXXF/d/z0T9CUI4JQUT3OaW9Na/d7AL7m+9o2Zo91j8vbVbZBJeoOn/
         yx4aBC9S4yQCJebiwRoQgSDcGsYxCNjv4CpKbZ19i6NBHzjL/he0n+6Ee745sDeqG1As
         /qp2vvIUpsQZuHbNvcN9svRmiF/mPrLpYWAvTL9Oxwb3XeQRhPvc3zVFe28Uo68jBq/U
         cHzmoRjJXYaF6K7Pila+J8uyYqdXx1AJNcNUW0Fdlds3N7CBPBr5NQzGNlI8qTPsnhGI
         rqLw==
X-Gm-Message-State: AIkVDXI/pqJVivW33UsvvCoBdIp5Ji6Y5dO5uEMjllnmsCyf0LugUO7KEBxnDp+BwFLMBQ==
X-Received: by 10.223.176.93 with SMTP id g29mr9969765wra.12.1486090170910;
        Thu, 02 Feb 2017 18:49:30 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:30 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 19/21] completion: don't guard git executions with __gitdir()
Date:   Fri,  3 Feb 2017 03:48:27 +0100
Message-Id: <20170203024829.8071-20-szeder.dev@gmail.com>
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

Three completion functions, namely __git_index_files(), __git_heads()
and __git_tags(), first run __gitdir() and check that the path it
outputs exists, i.e. that there is a git repository, and run a git
command only if there is one.

After the previous changes in this series there are no further uses of
__gitdir()'s output in these functions besides those checks.  And
those checks are unnecessary, because we can just execute those git
commands outside of a repository and let them error out.  We don't
perform such a check in other places either.

Remove this check and the __gitdir() call from these functions,
sparing the fork()+exec() overhead of the command substitution and the
potential 'git rev-parse' execution.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1a849761f..1c7493ff2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -312,35 +312,25 @@ __git_ls_files_helper ()
 #    slash.
 __git_index_files ()
 {
-	local dir="$(__gitdir)" root="${2-.}" file
-
-	if [ -d "$dir" ]; then
-		__git_ls_files_helper "$root" "$1" |
-		while read -r file; do
-			case "$file" in
-			?*/*) echo "${file%%/*}" ;;
-			*) echo "$file" ;;
-			esac
-		done | sort | uniq
-	fi
+	local root="${2-.}" file
+
+	__git_ls_files_helper "$root" "$1" |
+	while read -r file; do
+		case "$file" in
+		?*/*) echo "${file%%/*}" ;;
+		*) echo "$file" ;;
+		esac
+	done | sort | uniq
 }
 
 __git_heads ()
 {
-	local dir="$(__gitdir)"
-	if [ -d "$dir" ]; then
-		__git for-each-ref --format='%(refname:short)' refs/heads
-		return
-	fi
+	__git for-each-ref --format='%(refname:short)' refs/heads
 }
 
 __git_tags ()
 {
-	local dir="$(__gitdir)"
-	if [ -d "$dir" ]; then
-		__git for-each-ref --format='%(refname:short)' refs/tags
-		return
-	fi
+	__git for-each-ref --format='%(refname:short)' refs/tags
 }
 
 # Lists refs from the local (by default) or from a remote repository.
-- 
2.11.0.555.g967c1bcb3

