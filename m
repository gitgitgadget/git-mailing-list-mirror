Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E5D01F404
	for <e@80x24.org>; Sun, 25 Mar 2018 16:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753734AbeCYQzG (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 12:55:06 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34549 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753650AbeCYQzF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 12:55:05 -0400
Received: by mail-pl0-f67.google.com with SMTP id u11-v6so10483973plq.1
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 09:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VIOcjVXNAqOAQaEVHyOhCKYAM7EYM/KXODB7gTbzQuk=;
        b=t7PASSuuSFAf2uXABRHTNybBgr8j3byXLsaIYeLJOjNFADKOL5/njVnb7y7q+oj5n2
         KdBZr9dQk3B53uXAaEH69fAt4EZGzF3nWY2yn6/WS3zpig2kbtp31wYizQrMTG2V/hcE
         PS0R/+56eFjO8cavm5/AKWuyFooFmzE4vHvUu2kEE5uQ0E4MreYTPWGqIwsSTUzzGB/w
         RFEag/0GT/oNBdOWBvynKp4RH6uXBm64g8TDcbhypz57YlHQmxNDZWx+xEcqmbezjhRU
         uHemnyHf1bLksowmsjpXrX801H7q+RfdA/6TBISDqlZAm2YpJh4XZfuilUmG4gbNoZFC
         29TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VIOcjVXNAqOAQaEVHyOhCKYAM7EYM/KXODB7gTbzQuk=;
        b=GpCw22spcHHnC3NEh6idV3rSMkEjmyj3TRjO7x4X4tWQiH6G/SlriokubCqQeoHBaH
         7Yu9/NZ+E+vRFUEvqGsmsS1TIw6dm7aP/0OhAGtZwxw9elmzUqAWXqvrObZwUPN/Runa
         PKHt9vVC5ejqY5wCC3gLaPgcRfAkj51QYx01iI3anct7Yw0VgjG4W2fRQ8alDBICqP6V
         dfpHbwmEHJ0jCbKVh9NNE/6p3SYapAw4Ma7h0Q3xEsqTf4f2cCLUmAGdVWEPoHTP6wTG
         AR5m7PO274WgyJkDH8DtY8fxr7V0lctiRY9BGLdgyZt876kIsYbyrGeITiPyXvUPwJHS
         F6vw==
X-Gm-Message-State: AElRT7FkhyGMYo2SKSht5lUSCOjJ/wTEo3NkK5FV/OaChcNwURAm1/G0
        j3uQg0aIgTobQfvCd5KrRME=
X-Google-Smtp-Source: AG47ELulaRqJny3/v0AX36dV8NNlMUpPwDyJH87AjWMShUsspBkR/cj5aybyTRA1I/c6gHpadR+Q/A==
X-Received: by 2002:a17:902:2e43:: with SMTP id q61-v6mr36784237plb.404.1521996905023;
        Sun, 25 Mar 2018 09:55:05 -0700 (PDT)
Received: from localhost.localdomain (softbank126094196092.bbtec.net. [126.94.196.92])
        by smtp.gmail.com with ESMTPSA id t20sm25840848pfh.182.2018.03.25.09.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Mar 2018 09:55:04 -0700 (PDT)
From:   Yuki Kokubun <orga.chem.job@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Yuki Kokubun <orga.chem.job@gmail.com>
Subject: [PATCH v4] filter-branch: fix errors caused by refs that point at non-committish
Date:   Sun, 25 Mar 2018 16:54:58 +0000
Message-Id: <1521996898-7052-1-git-send-email-orga.chem.job@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <xmqqr2o8f7hd.fsf@gitster-ct.c.googlers.com>
References: <xmqqr2o8f7hd.fsf@gitster-ct.c.googlers.com>
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

