Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48C871F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbdBCCyp (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:54:45 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35272 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752225AbdBCCyg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:54:36 -0500
Received: by mail-wm0-f65.google.com with SMTP id u63so1192878wmu.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qOi9RT33RwAN+iqAXbnUBBQzg7HTDH1FaSmlJlulpxc=;
        b=ghold8ymfvEHoAvjNLFPzBysk0eGPi9Z0slPbMotEl7/8Sb0EC56jK0SP6hS4MQ+yL
         ZDebxS5t3FQMDc3cio2tSYW6JhOlGs85/FAyLXmlhm7N7LcljNc5agAbuNnCkGc8KYBW
         5i0NoqrSfVTrFnNpbmenMBq7XJMyDNsz3MQH9RjIe07vEcgzAlhp+duaBjryxNJ9NoYU
         BHNfqgwSYnYvN3Std1/RYrpjDg6zoXh0k/uUssETJO2p1jW3ObwQDZ0/ok+IJrn8aSph
         SyjRZpUTg1WnaE2BZqBCV6LzAK6hy4k/qMlZmrB1ExOWSjOuV2Y4kVxsdyJOZcG/NutH
         4j4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qOi9RT33RwAN+iqAXbnUBBQzg7HTDH1FaSmlJlulpxc=;
        b=G84JAxXgZtk7fwhqtlp8MdY9ryzkgTISl3fNj3ka2B4VfTScbbJEl5gQ1U2x2POsGg
         jjj2RvqnEroynX4Qd1wN4RxkX0fYUCddCSyTIZfTvDWUaun1SRmyAU9xJnhIAUxb6Czc
         zvL0AXtqYjjc5gHxq1VUDg/H2mrXbU6lBwpyGby9/C6sXjn4HT+qt8tkalE3fyk1BMBY
         5f7dXlJb3MfWmvbEPEG+UNHGM8jht7/vTkZJIfNTRHl0eIZour009cr12c1YzakhyQsk
         RDwERQAbPg+4vhufqexh2GAKBmMjyT8IYvOCAoIdAPuPjDKiI1KO9vvAWi6sHTYUDVCO
         RoHQ==
X-Gm-Message-State: AIkVDXJJnNLzASK1sdV/SzfExz/iPzFm1Imnv4qmaQa0MhGnu+H/MEJDncyu8uWN6NuSVQ==
X-Received: by 10.223.140.145 with SMTP id a17mr11196783wrb.1.1486090474853;
        Thu, 02 Feb 2017 18:54:34 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id c133sm652291wmd.13.2017.02.02.18.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:54:34 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 11/12] completion: list only matching symbolic and pseudorefs when completing refs
Date:   Fri,  3 Feb 2017 03:54:04 +0100
Message-Id: <20170203025405.8242-12-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203025405.8242-1-szeder.dev@gmail.com>
References: <20170203025405.8242-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous changes in this series ensure that __git_refs() lists
only refs that match the current word to be completed, but
non-matching symbolic and pseudo refs still show up in its output.

Filter out non-matching symbolic and pseudo refs as well, so anything
__git_refs() outputs matches the current word to be completed, as it
will allow us to optimize how refs are placed into the COMPREPLY
array.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 20 ++++++++++++++++----
 t/t9902-completion.sh                  |  4 ----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9f5a6f44e..0ad02cec6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -355,7 +355,8 @@ __git_tags ()
 # 2: In addition to local refs, list unique branches from refs/remotes/ for
 #    'git checkout's tracking DWIMery (optional; ignored, if set but empty).
 # 3: Currently ignored.
-# 4: The current ref to be completed (optional).
+# 4: List only refs matching this word instead of the current word being
+#    completed (optional).
 #
 # Use __git_complete_refs() instead.
 __git_refs ()
@@ -399,7 +400,12 @@ __git_refs ()
 			;;
 		*)
 			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD; do
-				if [ -e "$dir/$i" ]; then echo $pfx$i; fi
+				case "$i" in
+				$cur_*)	if [ -e "$dir/$i" ]; then
+						echo $pfx$i
+					fi
+					;;
+				esac
 			done
 			format="refname:strip=2"
 			refs=("refs/tags/$cur_*" "refs/tags/$cur_*/**"
@@ -432,12 +438,18 @@ __git_refs ()
 		;;
 	*)
 		if [ "$list_refs_from" = remote ]; then
-			echo "HEAD"
+			case "HEAD" in
+			$cur_*)	echo "HEAD" ;;
+			esac
 			__git for-each-ref --format="%(refname:strip=3)" \
 				"refs/remotes/$remote/$cur_*" \
 				"refs/remotes/$remote/$cur_*/**"
 		else
-			__git ls-remote "$remote" HEAD \
+			local query_symref
+			case "HEAD" in
+			$cur_*)	query_symref="HEAD" ;;
+			esac
+			__git ls-remote "$remote" $query_symref \
 				"refs/tags/$cur_*" "refs/heads/$cur_*" \
 				"refs/remotes/$cur_*" |
 			while read -r hash i; do
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 499be5879..5e06acc17 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -847,7 +847,6 @@ test_expect_success 'setup for filtering matching refs' '
 
 test_expect_success '__git_refs - only matching refs' '
 	cat >expected <<-EOF &&
-	HEAD
 	matching-branch
 	matching/branch
 	matching-tag
@@ -874,7 +873,6 @@ test_expect_success '__git_refs - only matching refs - full refs' '
 
 test_expect_success '__git_refs - only matching refs - remote on local file system' '
 	cat >expected <<-EOF &&
-	HEAD
 	master-in-other
 	matching/branch-in-other
 	EOF
@@ -887,7 +885,6 @@ test_expect_success '__git_refs - only matching refs - remote on local file syst
 
 test_expect_success '__git_refs - only matching refs - configured remote' '
 	cat >expected <<-EOF &&
-	HEAD
 	master-in-other
 	matching/branch-in-other
 	EOF
@@ -912,7 +909,6 @@ test_expect_success '__git_refs - only matching refs - remote - full refs' '
 
 test_expect_success '__git_refs - only matching refs - checkout DWIMery' '
 	cat >expected <<-EOF &&
-	HEAD
 	matching-branch
 	matching/branch
 	matching-tag
-- 
2.11.0.555.g967c1bcb3

