Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DB9C77B60
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjDAItl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDAIs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:48:28 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B93EC70
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:30 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-177ca271cb8so25651815fac.2
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ClP4+G8EANBxoQLN9k+EL8E7lZ3C8NNyuypldIXcOQ=;
        b=X6HCtTRJNrkRrvHnPx80YJD5E0BT8PyqYL6M32SSGOVT7s6/zKFd+1ucARNd+ZJ2XE
         3lfG5Hq9wB3O6ZC7XWhhmHPAPfVy1YwODAFOk2QLCbdrufT22tPVqFhypj99EkMU6SNC
         LEeQ8R9mdr6IIeJ0S2QLNeu8wXvViCQvTt68C/p9WVcn3moWCRe0/xcYlUXMiIOL8srZ
         9HO7KaDPEav+wvNRwZd0cJyeshyRNpFFOmFcwarlwwZMOVPhmpTQc00zC4G4Tj7D4NqC
         0f9ENtmhTU3h4zDC+8gMVbPDsjZqibHRqZb9w23bTmJg7AKiB3qOipox4YY3EfuT7xMC
         iXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ClP4+G8EANBxoQLN9k+EL8E7lZ3C8NNyuypldIXcOQ=;
        b=ToWPVbQlQSW4FZt6yXVEMoEtD1ksCVV1IITU92aOkdK1iQa2iKY3GbYjbwD7caRPQu
         ba0ex7lmkCurjz5+xM/PLbXePvjWY/CyV6WTUADIGDYUGwXYATSTTO/FIg2x1BLcyC3j
         X7iP088CEAtQ9Nsw1dr6o4LNpH+gKIM2F45i/ql9cT0vR6aK8j54Pum6Wd0XcogiMcEe
         NzvMKOsSEBCAtr4utiA5p1tXhsN6mxMzI5ty9icLrP4kD1kVCZakU9KvQ1MPz0Nt2Rly
         BwAfPWhim9HMGS5aAG97q7YIr2DtGdIWTGTx9RJHyo2BDNNBx8wf9rI39Psl/HrHGS7a
         XPmg==
X-Gm-Message-State: AAQBX9dLU3kFl6DcGlYkiS0d2Dm7vmfCHsGKqDaWPVXNBMwS4rhBnEnv
        vpLb7u62fTnGiIPIOM1IFbfRswAC8gg=
X-Google-Smtp-Source: AKy350YdICyeE7dYJP7BKyXYLgLrd9GvD2q5uRwjgqDPiblW56O1/rVnHVIp27VU+WPHSCMcYc+NHQ==
X-Received: by 2002:a05:6870:2046:b0:172:48e:b8c4 with SMTP id l6-20020a056870204600b00172048eb8c4mr5620760oad.17.1680338849438;
        Sat, 01 Apr 2023 01:47:29 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id k21-20020a0568301bf500b006a17bffbc61sm2086689otb.38.2023.04.01.01.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:29 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 45/49] completion: bash: simplify _get_comp_words_by_ref()
Date:   Sat,  1 Apr 2023 02:46:22 -0600
Message-Id: <20230401084626.304356-46-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need the whole functionality of _get_comp_words_by_ref(), we
know exactly what we need from that function, so only do that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 30 ++++++--------------------
 t/t9902-completion.sh                  | 21 ++++--------------
 2 files changed, 10 insertions(+), 41 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3f48b61cbe..7b46ce503d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -419,30 +419,12 @@ __git_reassemble_comp_words_by_ref()
 if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
 _get_comp_words_by_ref ()
 {
-	local exclude cur_ words_ cword_
-	if [ "$1" = "-n" ]; then
-		exclude=$2
-		shift 2
-	fi
-	__git_reassemble_comp_words_by_ref "$exclude"
-	cur_=${words_[cword_]}
-	while [ $# -gt 0 ]; do
-		case "$1" in
-		cur)
-			cur=$cur_
-			;;
-		prev)
-			prev=${words_[$cword_-1]}
-			;;
-		words)
-			words=("${words_[@]}")
-			;;
-		cword)
-			cword=$cword_
-			;;
-		esac
-		shift
-	done
+	local words_ cword_
+	__git_reassemble_comp_words_by_ref "=:"
+	cword=$cword_
+	cur=${words_[cword]}
+	prev=${words_[cword-1]}
+	words=("${words_[@]}")
 }
 fi
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index b4ed415245..fdc81d5d3f 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -40,23 +40,10 @@ GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout rebase'
 # So let's override it with a minimal version for testing purposes.
 _get_comp_words_by_ref ()
 {
-	while [ $# -gt 0 ]; do
-		case "$1" in
-		cur)
-			cur=${_words[_cword]}
-			;;
-		prev)
-			prev=${_words[_cword-1]}
-			;;
-		words)
-			words=("${_words[@]}")
-			;;
-		cword)
-			cword=$_cword
-			;;
-		esac
-		shift
-	done
+	cword=$_cword
+	cur=${_words[cword]}
+	prev=${_words[cword-1]}
+	words=("${_words[@]}")
 }
 
 print_comp ()
-- 
2.33.0

