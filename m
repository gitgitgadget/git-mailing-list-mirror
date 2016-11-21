Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D3E1FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 20:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754833AbcKUUnA (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 15:43:00 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33006 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754037AbcKUUm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 15:42:57 -0500
Received: by mail-pg0-f42.google.com with SMTP id 3so134004221pgd.0
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 12:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jCsAhKm7myiXkjttBJ6TEHOWM0CfQyXp0irKEYD89uQ=;
        b=f3fcNNIvi13VljJMehwcbz7PvH4tw4RcSW2Q9uKejK40Z4i4CKP+Ydd5XS6iMclscz
         DL4oRpYJtS3A1uz2tJIpK1Rz8Ij6WlvdT70lErYrPN6lK+ti0myKxlye2b1JMUFb7urr
         DZJOrAY7FPmtYxLZqNWzZOdxYz5SjZ72zrbXZBLXW5gvx24L/c4uI1Ae9oFVgXqvCwlF
         jcNzpai6BQuXeJLA9I5b7HkalSHvXaIHInj8+phBbsVmsBcnvManCZYavP3o3A7p2hiz
         iwtSr24F6WD78BDh19lKxErRU0Ti7dSHfD7n3NHZFFFwIAialRnQhMWN5vyLXGO++mot
         Dpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jCsAhKm7myiXkjttBJ6TEHOWM0CfQyXp0irKEYD89uQ=;
        b=PZC4gPzMUmruGQQ0RhvitKACTnK/TjAJQODO/68mDGx/J/q/TAMiFpNTucJcz3wnCo
         1UQ8aXugH0Fn2xqlwqfsRywBeu1mOfGfK9XO3hP273r4ZEi8hlp3oXnOAkLtF0sXxNwQ
         mnnDbS+CUG2jiOoDVJ9ibi4lx2XvVnSR1XmBBCG4y245pH6d4iXwnBqQqoDOvqvF0Xxr
         OqpXxs6zRDYlPBlK1JTzJq1Yf9gRshTIEHRrWHuv5r9grcty7OAQfXAdWgEJRDX2Z+sN
         Pr55QGP39ObubY6Z1RsYH7yagwoOBfFh4bYVGTGzfFE/pOG7bjMgxh15SAM/5uRMFupT
         O+7A==
X-Gm-Message-State: AKaTC03unESHw1HJzvUgoTIO6kW9Q6Osxg4k3VYg/x+ZcFiauMNQppV+WSCKJBPmHwjCMkmY
X-Received: by 10.98.137.153 with SMTP id n25mr20277271pfk.89.1479760920009;
        Mon, 21 Nov 2016 12:42:00 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1d4e:2913:1c16:dc05])
        by smtp.gmail.com with ESMTPSA id w16sm21531946pgc.30.2016.11.21.12.41.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Nov 2016 12:41:59 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de,
        hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] test-lib-functions.sh: teach test_commit -C <dir>
Date:   Mon, 21 Nov 2016 12:41:45 -0800
Message-Id: <20161121204146.13665-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.18.g0126045.dirty
In-Reply-To: <20161121204146.13665-1-sbeller@google.com>
References: <20161121204146.13665-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Specifically when setting up submodule tests, it comes in handy if
we can create commits in repositories that are not at the root of
the tested trash dir. Add "-C <dir>" similar to gits -C parameter
that will perform the operation in the given directory.

Signed-off-by: Stefan Beller <sbeller@google.com>
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
2.11.0.rc2.18.g0126045.dirty

