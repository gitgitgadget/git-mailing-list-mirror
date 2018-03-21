Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF12F1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 15:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeCUPb4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 11:31:56 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42583 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752760AbeCUPbx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 11:31:53 -0400
Received: by mail-pl0-f66.google.com with SMTP id w15-v6so3325326plq.9
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 08:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+H9d51IkxmCk9ZZ47TqjuldDH9XIxw6dFKoDgrndLy0=;
        b=DJI/4SXU1iGG7G4JIvOyGrnISZsv8ltoI8N4Gy2yIinM4km4JX1c4VfMux27pAyZjN
         I42p/c1euFH7z9f29up8DIrG4H/VSXGEcnkN1NMPRJL4QoTvlM8/kAWIweRkdmL0N8WS
         X2qFahXQiMizz3/azu2dDF9J+Ozz+eueV08aGdBh/PZNVlt5PLG/SafQL5CEL+GOMqfF
         oY91c0EF5xL6CzSz+F0NoSvWSo45XvxUjkNrFh6k40nl7uTV+j6nqOn8mfLTq0cRtRJQ
         SswYcHoU4oXO2B3jFcscLvjZr6DeEpC8iLyQN6zyxvhOmwvdT6Nj700/dfmi7wfxBDjL
         TvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+H9d51IkxmCk9ZZ47TqjuldDH9XIxw6dFKoDgrndLy0=;
        b=iYYFcnBdwu+j+gXJr+9ND9WL3SI6kpME20vJc5my/pE9VnshETfLjJsXCJdTTqkljK
         bmmC/n5yFNxXkPYMUAW0l/H39iVBWcBkHXJ/vI0c8HoHn8H9R/zF2KrlrgQF7mf0ZJth
         lLZVpJNB17TXo6wwsq9c6Ggt70Plxuozi6JXEpzoDTJftUOFX7lpzkVlExTMptVKQ5Qj
         93oz5gkm50U7f9vC1BgUObSZvPo9k7honCXGjjbKarV2+ztdzGSxcLjVrNaV8YccIKsi
         dy+6ST8N7xVjDvcEQ1JYBcjUBtZVOetvOxYC+HXPU995pJN8V9M6MW8pGqrkULz/9CcT
         nu3Q==
X-Gm-Message-State: AElRT7ElcyBDajmgXeST/dIGVnvq2eBWIf0mtc2GZ6L2BF2re3WHU+2u
        k0W8lPMRuzabSB1lI3H9HKE3VN0q
X-Google-Smtp-Source: AG47ELvCeZpEOXKQ7hvERo3CFVBUgcKAghpWZiIZNBJxTBbREnHDG6UpO/i522AfqgQ1NEbOY76wLA==
X-Received: by 2002:a17:902:988c:: with SMTP id s12-v6mr5875599plp.318.1521646312511;
        Wed, 21 Mar 2018 08:31:52 -0700 (PDT)
Received: from localhost.localdomain (softbank126094241038.bbtec.net. [126.94.241.38])
        by smtp.gmail.com with ESMTPSA id j14sm8625333pfn.113.2018.03.21.08.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Mar 2018 08:31:51 -0700 (PDT)
From:   Yuki Kokubun <orga.chem.job@gmail.com>
To:     git@vger.kernel.org
Cc:     Yuki Kokubun <orga.chem.job@gmail.com>
Subject: [PATCH] filter-branch: consider refs can refer to an object other than commit or tag
Date:   Wed, 21 Mar 2018 15:31:39 +0000
Message-Id: <1521646299-16193-1-git-send-email-orga.chem.job@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20180321103504.9483-1-orga.chem.job@gmail.com>
References: <20180321103504.9483-1-orga.chem.job@gmail.com>
In-Reply-To: <20180321103504.9483-1-orga.chem.job@gmail.com>
References: <20180321103504.9483-1-orga.chem.job@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git filter-branch -- --all" can be confused when refs that refer to objects
other than commits or tags exists.
Because "git rev-parse --all" that is internally used can return refs that
refer to an object other than commit or tag. But it is not considered in the
phase of updating refs. Such refs can be created by "git replace" with
objects other than commits or trees.

Signed-off-by: Yuki Kokubun <orga.chem.job@gmail.com>
---
This patch fix the bug of the first patch.
The first patch did not consider tags.

 git-filter-branch.sh     | 11 ++++++++++-
 t/t7003-filter-branch.sh | 13 +++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 1b7e4b2cd..f7cd97b86 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -251,7 +251,16 @@ done < "$tempdir"/backup-refs
 
 # The refs should be updated if their heads were rewritten
 git rev-parse --no-flags --revs-only --symbolic-full-name \
-	--default HEAD "$@" > "$tempdir"/raw-heads || exit
+	--default HEAD "$@" > "$tempdir"/raw-objects || exit
+# refs/replace can refer to an object other than commit or tag
+while read ref
+do
+	type=$(git cat-file -t "$ref")
+	if test $type = commit || test $type = tag
+	then
+		echo "$ref"
+	fi
+done >"$tempdir"/raw-heads <"$tempdir"/raw-objects
 sed -e '/^^/d' "$tempdir"/raw-heads >"$tempdir"/heads
 
 test -s "$tempdir"/heads ||
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 7cb60799b..efeaf5887 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -470,4 +470,17 @@ test_expect_success 'tree-filter deals with object name vs pathname ambiguity' '
 	git show HEAD:$ambiguous
 '
 
+test_expect_success 'rewrite repository including refs/replace that point to non commit object' '
+	test_when_finished "git reset --hard original" &&
+	tree=$(git rev-parse HEAD^{tree}) &&
+	test_when_finished "git replace -d $tree" &&
+	echo A >new &&
+	git add new &&
+	new_tree=$(git write-tree) &&
+	git replace $tree $new_tree &&
+	git reset --hard HEAD &&
+	git filter-branch -f -- --all >filter-output 2>&1 &&
+	! fgrep fatal filter-output
+'
+
 test_done
-- 
2.16.2.18.g09cb46d

