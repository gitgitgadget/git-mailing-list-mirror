Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CEA11F404
	for <e@80x24.org>; Sun, 25 Mar 2018 17:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753591AbeCYRB7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 13:01:59 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44413 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753408AbeCYRB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 13:01:58 -0400
Received: by mail-pl0-f66.google.com with SMTP id 9-v6so10463544ple.11
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 10:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YvEHUI/AbyZ35zi/rjjNY+21XT+Bn0BKpluCrDHs6VM=;
        b=lV/gs+O9dnixFzSViOVw+ahjhp4IeNoO7dZ0yznylumq6P0a9pVRxjbSTYdE48MJdQ
         Bp/fooFBOAF8dVgC4/IFm3W52BkDlaDwYOT6z6Iaj5UT3ay0MP0cAPIwdYrg8aCqSE4u
         eg0/nJ6CrunYrOkJe6pW+j+w+I3wKh5LLW/afAmjQy4/pXFFw26j9G7xs8Awr1csLoWY
         aciM8DlNXWqZB/B9wYdSZVbX/bF9kEGDQVlWZk6iPYEBov/imn0HmJi5pd2DhZarMBNf
         xszirio/+Eqqigzo+mQfKgqASW4XHqsJm04oUcz+JoVlHXn/SUan7dyzR24eyRRD42wj
         O0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YvEHUI/AbyZ35zi/rjjNY+21XT+Bn0BKpluCrDHs6VM=;
        b=iO1/wI7PlbU3w6tlZKAp425XDBHbypDFsV5xbJf/tDl3A7EGj6FY78anEgw9bT+uKm
         Ad44PQJObgjvl627vgqaJnOodm9HmaZx5H+a6RioLV9ZAJ4GzXQR0tPkbsz2VqZDcE95
         FMZAY6NyIH8DE7fkOQx13nihKTd/LRbNl1WwmEe3JrEzSbZKfkLgNQOwE95noNx7qAla
         JirMrIFl5nkzIxHaoxRKzWFJw8pGRfamw4VkdDajsYKhjI1Lwvc7k7HDqT81UBb1QmSG
         OcdQ1FvQPQqyKQ703K3fELqpqI+YxfBRQxIB9CWj0dHZ/US/mHFEcTxVMUe9mOC72RMx
         aoiQ==
X-Gm-Message-State: AElRT7E7wSjmVTgD5Z6uQBN5BFSOQ/txHXnJZIeqrDrtey8ftFfMR0Nq
        O406zGqWxw6nvODcoJcR4W0=
X-Google-Smtp-Source: AG47ELt8WEqwaXdgS2KDIuPSAV0zAeEYmd/qIn2ojPayn18yCvnDwXpOMooTnK4/o+ZzTlcPqjBRGA==
X-Received: by 2002:a17:902:6941:: with SMTP id k1-v6mr18765902plt.185.1521997317929;
        Sun, 25 Mar 2018 10:01:57 -0700 (PDT)
Received: from localhost.localdomain (softbank126094196092.bbtec.net. [126.94.196.92])
        by smtp.gmail.com with ESMTPSA id f126sm27113693pfg.25.2018.03.25.10.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Mar 2018 10:01:57 -0700 (PDT)
From:   Yuki Kokubun <orga.chem.job@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Yuki Kokubun <orga.chem.job@gmail.com>
Subject: [PATCH v5] filter-branch: fix errors caused by refs that point at non-committish
Date:   Sun, 25 Mar 2018 17:01:50 +0000
Message-Id: <1521997310-7200-1-git-send-email-orga.chem.job@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521996898-7052-1-git-send-email-orga.chem.job@gmail.com>
References: <1521996898-7052-1-git-send-email-orga.chem.job@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git filter-branch -- --all" prints error messages when processing refs that
point at objects that are not committish. Such refs can be created by
"git replace" with trees or blobs. And also "git tag" with trees or blobs can
create such refs.

Filter these problematic refs out early, before they are seen by the logic to
see which refs have been modified and which have been left intact (which is
where the unwanted error messages come from), and warn that these refs are left
unwritten while doing so.

Signed-off-by: Yuki Kokubun <orga.chem.job@gmail.com>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
---
 git-filter-branch.sh     | 14 ++++++++++++--
 t/t7003-filter-branch.sh | 14 ++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 1b7e4b2cd..41efecb28 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -251,8 +251,18 @@ done < "$tempdir"/backup-refs
 
 # The refs should be updated if their heads were rewritten
 git rev-parse --no-flags --revs-only --symbolic-full-name \
-	--default HEAD "$@" > "$tempdir"/raw-heads || exit
-sed -e '/^^/d' "$tempdir"/raw-heads >"$tempdir"/heads
+	--default HEAD "$@" > "$tempdir"/raw-refs || exit
+while read ref
+do
+	case "$ref" in ^?*) continue ;; esac
+
+	if git rev-parse --verify "$ref"^0 >/dev/null 2>&1
+	then
+		echo "$ref"
+	else
+		warn "WARNING: not rewriting '$ref' (not a committish)"
+	fi
+done >"$tempdir"/heads <"$tempdir"/raw-refs
 
 test -s "$tempdir"/heads ||
 	die "You must specify a ref to rewrite."
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 7cb60799b..04f79f32b 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -470,4 +470,18 @@ test_expect_success 'tree-filter deals with object name vs pathname ambiguity' '
 	git show HEAD:$ambiguous
 '
 
+test_expect_success 'rewrite repository including refs that point at non-commit object' '
+	test_when_finished "git reset --hard original" &&
+	tree=$(git rev-parse HEAD^{tree}) &&
+	test_when_finished "git replace -d $tree" &&
+	echo A >new &&
+	git add new &&
+	new_tree=$(git write-tree) &&
+	git replace $tree $new_tree &&
+	git tag -a -m "tag to a tree" treetag $new_tree &&
+	git reset --hard HEAD &&
+	git filter-branch -f -- --all >filter-output 2>&1 &&
+	! fgrep fatal filter-output
+'
+
 test_done
-- 
2.16.2.18.g09cb46d

