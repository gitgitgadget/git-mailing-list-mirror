Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD5D61F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeDPWlg (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:41:36 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40443 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751942AbeDPWl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:41:28 -0400
Received: by mail-wr0-f196.google.com with SMTP id v60so26368792wrc.7
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E50A7fLsFB1dl3biS4C/mBAtS+ANTK/wsKSXr1Y/X/U=;
        b=py1N9n4DO3679vvFkpj8iUis/8Q8y63VNX2MFpM0XetRgyIYNZ8fKPUeiKEtKJlul1
         HbjQboqMXJoIg8hsBBD2YZNxDi4ofIGQrSEfu908jU/25KYIPwmXarMIvI0EL5GnI1sW
         fpMwt75FpiGH+mNiQouuz371eaBG7QrdgG9EIbxrgMQJXsrldrbJwRNiGlaDd7PLJrLe
         7rnsicMNAFNlZPRCvcIOqvIr6m9UKymg1+QfWcTJXRSLUW3tu8xpxhM7kgR7gJGSQxN7
         VEoB0Fb2ls7+gmi3WYPHHwewt2oMtJutu3S6qB1t7pKBQMoqha3qJLZTOp+/SaIoHizP
         A/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E50A7fLsFB1dl3biS4C/mBAtS+ANTK/wsKSXr1Y/X/U=;
        b=Af8Bciqvh2BWck1KkphJe4OFnvSiP1IoA3baYcKHrdVt+HRVJB0fUyOuMPUzDKzbqj
         /lH/SOsroVm+i6ZTxeWO4Yvl7cl0gRc27+lTiq7dNowc43GfH2V9j01B/XAtw8R+xzzG
         UE6eVYfCIBC6YjhaKqYdajwmeRi7HZr2RdEd2LjDVWemluqGXqMJNM1fig/0NopPbjLq
         b+DtoyYOvxkStSJ/BkgEYjvDUxh8EdEIfcB6ZceIhmLPB6v/vGJxIYGKuMG9xU6wOIGp
         ulyLSxasp0GmhVuMZVz84q/kmRjkdqlFpfX8+vbHu33hbL+J16oP2rQ962K2TZVGEQTl
         fmIw==
X-Gm-Message-State: ALQs6tBWxHNW2K2q931wEpg2WGVxYDLmy7ka1uecnDooHkEZjKGKFDKy
        vLt/NNOfBVwWGaE3HLkvg9X5Fg==
X-Google-Smtp-Source: AIpwx48OIVQ2yiVojP5c9DdaQdysDb6shrjF4QS8Zts/YhhdIRas+SMvWtNLBgI2j9712c//NWVXcQ==
X-Received: by 10.28.18.199 with SMTP id 190mr81232wms.50.1523918486908;
        Mon, 16 Apr 2018 15:41:26 -0700 (PDT)
Received: from localhost.localdomain (x590d89db.dyn.telefonica.de. [89.13.137.219])
        by smtp.gmail.com with ESMTPSA id p128sm14977788wmd.45.2018.04.16.15.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Apr 2018 15:41:26 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 06/11] completion: let 'ls-files' and 'diff-index' filter matching paths
Date:   Tue, 17 Apr 2018 00:41:10 +0200
Message-Id: <20180416224113.16993-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.gbe216a3084
In-Reply-To: <20180416224113.16993-1-szeder.dev@gmail.com>
References: <20180318012618.32691-1-szeder.dev@gmail.com>
 <20180416224113.16993-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During git-aware path completion, e.g. 'git rm dir/fil<TAB>', both
'git ls-files' and 'git diff-index' list all paths in the given 'dir/'
matching certain criteria (cached, modified, untracked, etc.)
appropriate for the given git command, even paths whose names don't
begin with 'fil'.  This comes with a considerable performance
penalty when the directory in question contains a lot of paths, but
the current word can be uniquely completed or when only a handful of
those paths match the current word.

Reduce the number of iterations in this codepath from the number of
paths to the number of matching paths by specifying an appropriate
globbing pattern to 'git ls-files' and 'git diff-index' to list only
paths that match the current word to be completed.

Note that both commands treat backslashes as escape characters in
their file arguments, e.g. to preserve the literal meaning of globbing
characters, so we have to double every backslash in the globbing
pattern.  This is why one of the path completion tests specifically
checks the completion of a path containing a literal backslash
character (that test still fails, though, because both commands output
such paths enclosed in double quotes and the special characters
escaped; a later patch in this series will deal with those).

This speeds up path completion considerably when there are a lot of
non-matching paths to be filtered out.  Uniquely completing a tracked
filename at the top of the worktree in linux.git (over 62k files),
i.e. what's doing all the hard work behind 'git rm Mak<TAB>' to
complete 'Makefile':

  Before this patch, best of five, on Linux:

    $ time cur=Mak __git_complete_index_file

    real    0m2.159s
    user    0m1.299s
    sys     0m1.089s

  After:

    real    0m0.033s
    user    0m0.023s
    sys     0m0.015s

  Difference: -98.5%
  Speedup:     65.4x

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 11 ++++++-----
 t/t9902-completion.sh                  |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ae6127155e..3948265d32 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -434,11 +434,11 @@ __git_ls_files_helper ()
 {
 	if [ "$2" == "--committable" ]; then
 		__git -C "$1" -c core.quotePath=false diff-index \
-			--name-only --relative HEAD
+			--name-only --relative HEAD -- "${3//\\/\\\\}*"
 	else
 		# NOTE: $2 is not quoted in order to support multiple options
 		__git -C "$1" -c core.quotePath=false ls-files \
-			--exclude-standard $2
+			--exclude-standard $2 -- "${3//\\/\\\\}*"
 	fi
 }
 
@@ -449,11 +449,12 @@ __git_ls_files_helper ()
 #    If provided, only files within the specified directory are listed.
 #    Sub directories are never recursed.  Path must have a trailing
 #    slash.
+# 3: List only paths matching this path component (optional).
 __git_index_files ()
 {
-	local root="$2" file
+	local root="$2" match="$3" file
 
-	__git_ls_files_helper "$root" "$1" |
+	__git_ls_files_helper "$root" "$1" "$match" |
 	while read -r file; do
 		case "$file" in
 		?*/*) echo "${file%%/*}" ;;
@@ -481,7 +482,7 @@ __git_complete_index_file ()
 		cur_="$dequoted_word"
 	esac
 
-	__gitcomp_file "$(__git_index_files "$1" "$pfx")" "$pfx" "$cur_"
+	__gitcomp_file "$(__git_index_files "$1" "$pfx" "$cur_")" "$pfx" "$cur_"
 }
 
 # Lists branches from the local repository.
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 6856b263f8..f7a9dd446d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1515,6 +1515,7 @@ test_expect_success 'complete files - UTF-8 in ls-files output' '
 			"árvíztűrő/Сайн яваарай"
 '
 
+# Testing with a path containing a backslash is important.
 if test_have_prereq !MINGW &&
    mkdir 'New\Dir' 2>/dev/null &&
    touch 'New\Dir/New"File.c' 2>/dev/null
-- 
2.17.0.366.gbe216a3084

