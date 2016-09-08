Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93F8D1F856
	for <e@80x24.org>; Thu,  8 Sep 2016 23:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750747AbcIHXrN (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 19:47:13 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32922 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbcIHXrM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 19:47:12 -0400
Received: by mail-qk0-f194.google.com with SMTP id n66so4627715qkf.0
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 16:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qepa9AfPxZg+/mgaMSvRCOZKs/iasoPfAtEKb+osIgw=;
        b=jiWq94kYP+93DVxIAgRYuz0iwqDRHTWTBcA0xXXmDdpY22+WXHLxXZekMrzZdqxbQT
         H+NK92E6Bbsmuritqar7cOmv6+/BTqsTGVodkX1HlIsNozxgJpjxUkyt7feFsDOwIryJ
         FQe8YDZYqxhdCJNHCX6qk3YSVIJ/AMVD+SJrItamkExRDFJVQlrilPkENTRTB5d0bdqr
         kDOQdcix7gdboiAyxkEYrT8B9Vryn0uaOSJDOko7muzM4BuAdj73wqEcgzXw9B8fYcYs
         CMQ+vL3tm+VRYmHQAy0V7nqM8CtPL+rdFwzMcL/jl2xDdKN4DsstAB83ELYv/TqYEP2Y
         9Afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qepa9AfPxZg+/mgaMSvRCOZKs/iasoPfAtEKb+osIgw=;
        b=L8XGO424aimYBLvSn1td6UYugSjdU+zUJAGAg3ScQkS9G/lNBAJW//S0f0lFGuHf3K
         Jr1lFEj06wZbI0KY78c2lTBsbuvTjWTg9256kOdlM42R/nnYaZlYasCzpxkHT1WwT5B6
         cz/pg/udntbWD1eXYHIMvBdekX0SkMW5S8F6GAxEzliwfUklPrI7CAs8m83XFfaCXoLj
         vquU9vhUs1yo9B3wkgTOnauPaT0D4mXzPaJ3MmEYeO7jcg7oHB3D3FmRzpAHnPtIaEcL
         Ko5jzwa/dV2xms/0qhQ1sfN20pR6Yo5P6py8K4IVnlJfzUFlzfzhkkJIJ8W514CeCMAP
         /EYA==
X-Gm-Message-State: AE9vXwNhIyxDBVWzmP1N2EfiG3xEu+LxgZZ2Wd6VehZpK0acV4W0HY/u9E9xI82PE5hd6Q==
X-Received: by 10.55.137.3 with SMTP id l3mr784003qkd.128.1473378431610;
        Thu, 08 Sep 2016 16:47:11 -0700 (PDT)
Received: from localhost.localdomain.localdomain (cpe-66-67-97-212.nycap.res.rr.com. [66.67.97.212])
        by smtp.gmail.com with ESMTPSA id p40sm349222qtp.32.2016.09.08.16.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Sep 2016 16:47:11 -0700 (PDT)
From:   Aaron M Watson <watsona4@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron M Watson <watsona4@gmail.com>,
        Jon Seymour <jon.seymour@gmail.com>,
        David Caldwell <david@porkrind.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Aguilar <davvid@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] Allow stashes to be referenced by index only
Date:   Thu,  8 Sep 2016 19:46:37 -0400
Message-Id: <1473378397-22453-1-git-send-email-watsona4@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of referencing "stash@{n}" explicitly, it can simply be
referenced as "n".  Most users only reference stashes by their position
in the stash stask (what I refer to as the "index"). The syntax for the
typical stash (stash@{n}) is slightly annoying and easy to forget, and
sometimes difficult to escape properly in a script. Because of this the
capability to do things with the stash by simply referencing the index
is desirable.

This patch includes the superior implementation provided by Øsse Walle
(thanks for that), with a slight change to fix a broken test in the test
suite. I also merged the test scripts as suggested by Jeff King, and
un-wrapped the documentation as suggested by Junio Hamano.

Signed-off-by: Aaron M Watson <watsona4@gmail.com>
---
 Documentation/git-stash.txt |  3 ++-
 git-stash.sh                | 17 +++++++++++++++--
 t/t3903-stash.sh            | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 92df596..2e9cef0 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -39,7 +39,8 @@ The latest stash you created is stored in `refs/stash`; older
 stashes are found in the reflog of this reference and can be named using
 the usual reflog syntax (e.g. `stash@{0}` is the most recently
 created stash, `stash@{1}` is the one before it, `stash@{2.hours.ago}`
-is also possible).
+is also possible). Stashes may also be referenced by specifying just the
+stash index (e.g. the integer `n` is equivalent to `stash@{n}`).
 
 OPTIONS
 -------
diff --git a/git-stash.sh b/git-stash.sh
index 826af18..d8d3b8d 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -384,9 +384,10 @@ parse_flags_and_rev()
 	i_tree=
 	u_tree=
 
-	REV=$(git rev-parse --no-flags --symbolic --sq "$@") || exit 1
+	REV=$(git rev-parse --no-flags --symbolic --sq "$@" 2> /dev/null)
 
 	FLAGS=
+	ARGV=
 	for opt
 	do
 		case "$opt" in
@@ -404,10 +405,13 @@ parse_flags_and_rev()
 					die "$(eval_gettext "unknown option: \$opt")"
 				FLAGS="${FLAGS}${FLAGS:+ }$opt"
 			;;
+			*)
+				ARGV="${ARGV}${ARGV:+ }'$opt'"
+			;;
 		esac
 	done
 
-	eval set -- $REV
+	eval set -- $ARGV
 
 	case $# in
 		0)
@@ -422,6 +426,15 @@ parse_flags_and_rev()
 		;;
 	esac
 
+	case "$1" in
+		*[!0-9]*)
+			:
+		;;
+		*)
+			set -- "${ref_stash}@{$1}"
+		;;
+	esac
+
 	REV=$(git rev-parse --symbolic --verify --quiet "$1") || {
 		reference="$1"
 		die "$(eval_gettext "\$reference is not a valid reference")"
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 2142c1f..f82a8c4 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -131,6 +131,26 @@ test_expect_success 'drop middle stash' '
 	test 1 = $(git show HEAD:file)
 '
 
+test_expect_success 'drop middle stash by index' '
+	git reset --hard &&
+	echo 8 > file &&
+	git stash &&
+	echo 9 > file &&
+	git stash &&
+	git stash drop 1 &&
+	test 2 = $(git stash list | wc -l) &&
+	git stash apply &&
+	test 9 = $(cat file) &&
+	test 1 = $(git show :file) &&
+	test 1 = $(git show HEAD:file) &&
+	git reset --hard &&
+	git stash drop &&
+	git stash apply &&
+	test 3 = $(cat file) &&
+	test 1 = $(git show :file) &&
+	test 1 = $(git show HEAD:file)
+'
+
 test_expect_success 'stash pop' '
 	git reset --hard &&
 	git stash pop &&
@@ -604,6 +624,21 @@ test_expect_success 'invalid ref of the form stash@{n}, n >= N' '
 	git stash drop
 '
 
+test_expect_success 'invalid ref of the form "n", n >= N' '
+	git stash clear &&
+	test_must_fail git stash drop 0 &&
+	echo bar5 > file &&
+	echo bar6 > file2 &&
+	git add file2 &&
+	git stash &&
+	test_must_fail git stash drop 1 &&
+	test_must_fail git stash pop 1 &&
+	test_must_fail git stash apply 1 &&
+	test_must_fail git stash show 1 &&
+	test_must_fail git stash branch tmp 1 &&
+	git stash drop
+'
+
 test_expect_success 'stash branch should not drop the stash if the branch exists' '
 	git stash clear &&
 	echo foo >file &&
-- 
2.7.4

