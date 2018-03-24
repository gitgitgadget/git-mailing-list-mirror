Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 431621F404
	for <e@80x24.org>; Sat, 24 Mar 2018 19:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbeCXTlU (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 15:41:20 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33586 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752633AbeCXTlT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 15:41:19 -0400
Received: by mail-pg0-f50.google.com with SMTP id i194so1598301pgd.0
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 12:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fexm7hw15m/xlT12f5NzFPjRnogRj36Bjs70EKRQ2KY=;
        b=ZTYNHqXXOnqpkK8Ba2f1t6IqCew8N/cGwzzedCtaELRr/42i8zeyzfPaqKEpUQFFVy
         EZZdlInh+ybT9VzpWgj8RiZ7/jSub4A/7b3OBBMXd4IcmEnxERk6YxZiHTtSj9k7OAWC
         /NuoRht0RM6sxAU+T0ZyIYPd+ME707gDTBomsPdlpYPu6cthJwf6Ayad08o2OrVwsyd7
         qjZpMXEiWC0I2RLEV4dVkmEsrpZflwboJwOga2U9qPDSdso5rcyh8hZk8oQ7pcxDbjq3
         OFnO1DFySRC+53pIZ3DK0hIQ2Y+RnJ+gFnPxRD1aOpXqU1E9VRDuUVAn8kI8uW2S3Rof
         FS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fexm7hw15m/xlT12f5NzFPjRnogRj36Bjs70EKRQ2KY=;
        b=nwi9tOWP5tekzeMZnPQXH5xwI8OB5cRrKSfWXk1L4VpEKkIPwnkRL9Bbio4YXjOkCv
         ju2q3bwr9mjZvUG33CfC5nc3lugBU6fCkP934CjJoRKYnL3wDfEKjaKfKOnJ6CezhfBA
         9R+k4CqDMa2XXoW1fGzwjtOnHnjUqK719iauP385VAHonL7SuHlE4Nfkf67MV4E7bsXF
         5qhH+WILTPVHfGo4DFoY+O0G6uFtaRra9gb8DR1k/EdcLAalMO3n1Tm8xzB1EHL55Joy
         8/BNd0WdUZs8oH7+0uPu+pSJbSf3676I84dnqMymgN1BB6/qPRQ9QvFyXuVsXp45y4dv
         5awQ==
X-Gm-Message-State: AElRT7FR5l2HdCXy2FvAiBkm7Xy3mle67ZC+qNSSZ+nxnz5o1WobYOHW
        TKqBahMqLON21C5G3WL3qbw=
X-Google-Smtp-Source: AG47ELvg2aM10bN4xy35RWOg26aOTt7+4L2coKLXG6B08pjHqf1Di+a0BayZvB4Nxg0lKhyPW+yq/Q==
X-Received: by 10.101.97.208 with SMTP id j16mr2561044pgv.431.1521920478840;
        Sat, 24 Mar 2018 12:41:18 -0700 (PDT)
Received: from localhost.localdomain (softbank126094196092.bbtec.net. [126.94.196.92])
        by smtp.gmail.com with ESMTPSA id p86sm25537658pfi.55.2018.03.24.12.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Mar 2018 12:41:18 -0700 (PDT)
From:   Yuki Kokubun <orga.chem.job@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Yuki Kokubun <orga.chem.job@gmail.com>
Subject: [PATCH v3] filter-branch: fix errors caused by refs that point at non-committish
Date:   Sat, 24 Mar 2018 19:41:07 +0000
Message-Id: <1521920467-6091-1-git-send-email-orga.chem.job@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <xmqqvadmilx5.fsf@gitster-ct.c.googlers.com>
References: <xmqqvadmilx5.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git filter-branch -- --all" print error messages when refs that point at
objects that are not committish. Such refs can be created by "git replace" with
trees or blobs. And also "git tag" with trees or blobs can create such refs.

Filter these problematic refs out early, before they are seen by the logic to
see which refs have been modified and which have been left intact (which is
where the unwanted error messages come from), and warn that these refs are left
unwritten while doing so.
---
 git-filter-branch.sh     | 14 ++++++++++++--
 t/t7003-filter-branch.sh | 14 ++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 1b7e4b2..41efecb 100755
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
index 7cb6079..04f79f3 100755
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
1.9.1

