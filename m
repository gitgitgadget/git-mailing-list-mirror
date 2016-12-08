Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 630571FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 21:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753358AbcLHVEN (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 16:04:13 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:32912 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752353AbcLHVEF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 16:04:05 -0500
Received: by mail-pf0-f179.google.com with SMTP id d2so85223504pfd.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 13:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VwxD0RP6dxr30wi2/eF50UDhbWc7/qijk519nsbSVzU=;
        b=kl0uWJDvWtZIK0DIYgS05EunQI7o4fF4TLIh94VXtqPvV57nA6rfHLhUPpzR/1MmQL
         fc7zG1jyUb1B9VzFQDcj9z7Ro2lOV+0sV1WPpVosGdP/zFeWpDzjDREAoIgSrdc8CVh6
         gydPUHYNC5MnYzuKyF7Yrgb6ysxV7IOMcdI8zUgTwNgG6/EeFaNcQ9WFT7xPgs1jangW
         BqVZmeTQoHxX2ws1Ksk5nO3uYYjyiqRc56oFceeMuMsteVpry1Nbu37f/la+bJm91Vi7
         WqtpX/fcvDJzj1hYA3OF2l61TVzIC9wi5keHjVe7O94YO3J59F8RCHuER2KjcBXhCItK
         PFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VwxD0RP6dxr30wi2/eF50UDhbWc7/qijk519nsbSVzU=;
        b=a87RSVeeU0Zuf5QvdmHuIjlistBQhRj7Ir/OJKpvHXb/+7u2hdkmvN58aKA5rdvrU2
         ZNITkW38lsJbMOx38LzRIg++xgaaIZJtW+aoIzyvrU5MBezulfmvuS91r596iAwtNO52
         XNIRivOZVzz3RL+w6dZg/0T5kH1ooQwZMz27zjDOREr8Dka9PTrCKeIxk06uXVKyJ4l3
         o4Jw2mLZf26esIFxg9QEetVezVmslqyXApfcRZnmg2fI8xhs24jpW8P6jpLItZNORMtV
         XGwHwENmx0f0FAy7Tv1E9bgHUhfSQqMowJCNChBWOIgUuLwkFwZDxCgRAEWBnkYrJVQ2
         di+w==
X-Gm-Message-State: AKaTC01xvOWv0ev2fJElPldwGBjDGC3XRzDMdy/QWbVTBtiGKCScZFT++391WT2guc1JYyfG
X-Received: by 10.99.121.69 with SMTP id u66mr131479522pgc.96.1481231016615;
        Thu, 08 Dec 2016 13:03:36 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6884:a3d1:aaf8:234b])
        by smtp.gmail.com with ESMTPSA id p1sm52446879pgc.29.2016.12.08.13.03.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 13:03:36 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 3/6] test-lib-functions.sh: teach test_commit -C <dir>
Date:   Thu,  8 Dec 2016 13:03:26 -0800
Message-Id: <20161208210329.12919-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.29.g7c00390.dirty
In-Reply-To: <20161208210329.12919-1-sbeller@google.com>
References: <20161208210329.12919-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Specifically when setting up submodule tests, it comes in handy if
we can create commits in repositories that are not at the root of
the tested trash dir. Add "-C <dir>" similar to gits -C parameter
that will perform the operation in the given directory.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib-functions.sh | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index fdaeb3a96b..579e812506 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -157,16 +157,21 @@ debug () {
 	 GIT_TEST_GDB=1 "$@"
 }
 
-# Call test_commit with the arguments "<message> [<file> [<contents> [<tag>]]]"
+# Call test_commit with the arguments
+# [-C <directory>] <message> [<file> [<contents> [<tag>]]]"
 #
 # This will commit a file with the given contents and the given commit
 # message, and tag the resulting commit with the given tag name.
 #
 # <file>, <contents>, and <tag> all default to <message>.
+#
+# If the first argument is "-C", the second argument is used as a path for
+# the git invocations.
 
 test_commit () {
 	notick= &&
 	signoff= &&
+	indir= &&
 	while test $# != 0
 	do
 		case "$1" in
@@ -176,21 +181,26 @@ test_commit () {
 		--signoff)
 			signoff="$1"
 			;;
+		-C)
+			indir="$2"
+			shift
+			;;
 		*)
 			break
 			;;
 		esac
 		shift
 	done &&
+	indir=${indir:+"$indir"/} &&
 	file=${2:-"$1.t"} &&
-	echo "${3-$1}" > "$file" &&
-	git add "$file" &&
+	echo "${3-$1}" > "$indir$file" &&
+	git ${indir:+ -C "$indir"} add "$file" &&
 	if test -z "$notick"
 	then
 		test_tick
 	fi &&
-	git commit $signoff -m "$1" &&
-	git tag "${4:-$1}"
+	git ${indir:+ -C "$indir"} commit $signoff -m "$1" &&
+	git ${indir:+ -C "$indir"} tag "${4:-$1}"
 }
 
 # Call test_merge with the arguments "<message> <commit>", where <commit>
-- 
2.11.0.rc2.29.g7c00390.dirty

