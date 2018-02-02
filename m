Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDCD31F404
	for <e@80x24.org>; Fri,  2 Feb 2018 04:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeBBE6A (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 23:58:00 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46404 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeBBE56 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 23:57:58 -0500
Received: by mail-pf0-f193.google.com with SMTP id w69so3199793pfd.13
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 20:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I0PXXz3n6lBiBRJXP+l4TfzYhThz1Dh/wm2xQw9w2cY=;
        b=pX7KRhrHiWxribakwkBD/Ht/TFpbHXtkd4WvX+6maAeFcoiG62zDunGAdyHjRMs3GD
         kK7SaAAA8WASfr3c6b9uqOlDCGz4MEpmVdohUTgYhxiGa5OmG7I0qfkVgzXvKOCEe2dT
         zyE0VWzDGDNu8x6n9Gzbgk+fSGJ9NnLk+QS7z2NA+v8XXEN8eQmZTr8mnKbNGbtBHyaK
         GZ2jKwsm/Io4y9DHyWDmAEK3b4c88JsDgnd2U4o7HnvrEUdbsPqYdX38iivkrVt14/iK
         W8wo889+5vSjKb3+FyjSGZSnwM4kajdc6zQKKEfIqQjmLSyqEHl1kDfBlOnG+I9SKchC
         C91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I0PXXz3n6lBiBRJXP+l4TfzYhThz1Dh/wm2xQw9w2cY=;
        b=gsFDKgva59mlIt8ac8RKXlYBA/wlOQVnXHyRZrLQp6qMIxjjvqUEWeWH3leTK5dfyQ
         2z/EaMh/YtJbgtFt30GqNp2ZcZ7TzykIcOpDAo4iFDkXjvh2nLTiJBEC+QFCxf7HoWXZ
         LPFrM/Ur02jV5aVyqASnle9sQrqDLhmgU2iJuRYlwajoIqnqEmSydOkPsVvim62JjOGT
         7gDhCvgmAGLzFY/eMvDShMu2f+LBMtpSQtXNj5DEfC7ou09EcoeY+329CTubnG6Q2NMk
         frkJViGxUTci6fAA2oCgyShJE03Ze4VZmFvqTs3x1zgEWt9B5Sbc4J7mP1bqx8brMDLs
         NAGg==
X-Gm-Message-State: AKwxytfu2SV8wn/vUsicU/kHSSOKQYZrpyiNubtaKuLVm8TkAjq/eLiF
        /tHX0e8MTxGLpZfLMNN8IoHJkv+2
X-Google-Smtp-Source: AH8x225X5DF9+zS3MALVkPHx5YOpm9QR5AqbbHPamRyl6iJlrwpQYHWNk0qSnfyOESiw1KpfRrmqdQ==
X-Received: by 10.99.113.16 with SMTP id m16mr26083139pgc.29.1517547477678;
        Thu, 01 Feb 2018 20:57:57 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.200])
        by smtp.gmail.com with ESMTPSA id e3sm1496467pfb.143.2018.02.01.20.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 20:57:57 -0800 (PST)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, sbeller@google.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH v1 1/5] submodule foreach: correct '$path' in nested submodules from a subdirectory
Date:   Fri,  2 Feb 2018 10:27:41 +0530
Message-Id: <20180202045745.5076-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180202045745.5076-1-pc44800@gmail.com>
References: <20180202045745.5076-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running 'git submodule foreach' from a subdirectory of your
repository, nested submodules get a bogus value for $sm_path:
For a submodule 'sub' that contains a nested submodule 'nested',
running 'git -C dir submodule foreach echo $path' would report
path='../nested' for the nested submodule. The first part '../' is
derived from the logic computing the relative path from $pwd to the
root of the superproject. The second part is the submodule path inside
the submodule. This value is of little use and is hard to document.

There are two different possible solutions that have more value:
(a) The path value is documented as the path from the toplevel of the
    superproject to the mount point of the submodule.
    In this case we would want to have path='sub/nested'.

(b) As Ramsay noticed the documented value is wrong. For the non-nested
    case the path is equal to the relative path from $pwd to the
    submodules working directory. When following this model,
    the expected value would be path='../sub/nested'.

The behavior for (b) was introduced in 091a6eb0fe (submodule: drop the
top-level requirement, 2013-06-16) the intent for $path seemed to be
relative to $cwd to the submodule worktree, but that did not work for
nested submodules, as the intermittent submodules were not included in
the path.

If we were to fix the meaning of the $path using (a) such that "path"
is "the path from the toplevel of the superproject to the mount point
of the submodule", we would break any existing submodule user that runs
foreach from non-root of the superproject as the non-nested submodule
'../sub' would change its path to 'sub'.

If we would fix the meaning of the $path using (b), such that "path"
is "the relative path from $pwd to the submodule", then we would break
any user that uses nested submodules (even from the root directory) as
the 'nested' would become 'sub/nested'.

Both groups can be found in the wild.  The author has no data if one group
outweighs the other by large margin, and offending each one seems equally
bad at first.  However in the authors imagination it is better to go with
(a) as running from a sub directory sounds like it is carried out
by a human rather than by some automation task.  With a human on
the keyboard the feedback loop is short and the changed behavior can be
adapted to quickly unlike some automation that can break silently.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh             |  1 -
 t/t7407-submodule-foreach.sh | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 156255a9e..7305ee25f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -345,7 +345,6 @@ cmd_foreach()
 				prefix="$prefix$sm_path/"
 				sanitize_submodule_env
 				cd "$sm_path" &&
-				sm_path=$(git submodule--helper relative-path "$sm_path" "$wt_prefix") &&
 				# we make $path available to scripts ...
 				path=$sm_path &&
 				if test $# -eq 1
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 6ba5daf42..0663622a4 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -82,9 +82,9 @@ test_expect_success 'test basic "submodule foreach" usage' '
 
 cat >expect <<EOF
 Entering '../sub1'
-$pwd/clone-foo1-../sub1-$sub1sha1
+$pwd/clone-foo1-sub1-$sub1sha1
 Entering '../sub3'
-$pwd/clone-foo3-../sub3-$sub3sha1
+$pwd/clone-foo3-sub3-$sub3sha1
 EOF
 
 test_expect_success 'test "submodule foreach" from subdirectory' '
@@ -196,6 +196,38 @@ test_expect_success 'test messages from "foreach --recursive" from subdirectory'
 	) &&
 	test_i18ncmp expect actual
 '
+sub1sha1=$(cd clone2/sub1 && git rev-parse HEAD)
+sub2sha1=$(cd clone2/sub2 && git rev-parse HEAD)
+sub3sha1=$(cd clone2/sub3 && git rev-parse HEAD)
+nested1sha1=$(cd clone2/nested1 && git rev-parse HEAD)
+nested2sha1=$(cd clone2/nested1/nested2 && git rev-parse HEAD)
+nested3sha1=$(cd clone2/nested1/nested2/nested3 && git rev-parse HEAD)
+submodulesha1=$(cd clone2/nested1/nested2/nested3/submodule && git rev-parse HEAD)
+
+cat >expect <<EOF
+Entering '../nested1'
+$pwd/clone2-nested1-nested1-$nested1sha1
+Entering '../nested1/nested2'
+$pwd/clone2/nested1-nested2-nested2-$nested2sha1
+Entering '../nested1/nested2/nested3'
+$pwd/clone2/nested1/nested2-nested3-nested3-$nested3sha1
+Entering '../nested1/nested2/nested3/submodule'
+$pwd/clone2/nested1/nested2/nested3-submodule-submodule-$submodulesha1
+Entering '../sub1'
+$pwd/clone2-foo1-sub1-$sub1sha1
+Entering '../sub2'
+$pwd/clone2-foo2-sub2-$sub2sha1
+Entering '../sub3'
+$pwd/clone2-foo3-sub3-$sub3sha1
+EOF
+
+test_expect_success 'test "submodule foreach --recursive" from subdirectory' '
+	(
+		cd clone2/untracked &&
+		git submodule foreach --recursive "echo \$toplevel-\$name-\$sm_path-\$sha1" >../../actual
+	) &&
+	test_i18ncmp expect actual
+'
 
 cat > expect <<EOF
 nested1-nested1
-- 
2.15.1

