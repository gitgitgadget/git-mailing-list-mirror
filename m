Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9A692021E
	for <e@80x24.org>; Tue, 22 Nov 2016 19:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933471AbcKVTXS (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 14:23:18 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34131 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933281AbcKVTXB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 14:23:01 -0500
Received: by mail-pg0-f50.google.com with SMTP id x23so10520967pgx.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 11:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oyIi4yoSFXihGaoj+IU4YaqeExjTK/YuGmg2OJigylg=;
        b=RkrndKU52W8dVqMfdvF/Dl4TG38OJhXsfNrkjkvufEkcx/U5IIT1YRJnjo0BXynmn9
         FuTOj8xnR6Yorm5oiYFurgSVD9ISwoqvT7XJZ2s/qbs47SUyFSzhkfoaqHDF3dPFdlph
         11rrxd/Lm7pSeT7Jd+hbLMlKeqVDXWMVso4Xt8SZPsGbEOimqJfijYVjMKpGZei9JlVL
         QeA7GLYAmF+FjoSCkZ5hIZdoCTJOATGm3baVr329GiWSJNCH1hL5avMmEHv1Utknf2K8
         pYrPaw5KqQuuTX1am+qkFCvD0yHDYUXtRIEHxorlN8U2HE9olVJsZUV881seHzHDTcAC
         IxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oyIi4yoSFXihGaoj+IU4YaqeExjTK/YuGmg2OJigylg=;
        b=SOIVHnvC/02biH7Qd+azD3hk8CzGhvDL4j6hugDVsGt8XcL6LaRNV33yti9bvQnPw9
         ItlehwvxOMbtMSPQpel+R9XnmcCcr9AvIkSQJO4IqShscKBid4j8Aow4D+qoLw2+JOQQ
         fp++udKf7oa481of+3s8Rkv5/Pl+tpnZ4taEJJAJ0uxmouzi/5Zw6WFvGATlXm1vlZBu
         J7HU91c2idYRHMso1A0CQSncwF2x53NtZsw562mv8qTOgzfQWFjBkAFD2Li6S93infqV
         qd0Jd/G1JflnSYuzY0Pve3+afll3DttGlnwG5dfQv89wfLcnsHZ0sGSzMPjtXlLMSjsl
         O+dg==
X-Gm-Message-State: AKaTC00ZtD/OpafsbJ4ClWrPfztFDH/YygXwIrKZ/VKnKx0cOA7up8GHtWYjb9fYefNmF71A
X-Received: by 10.98.9.91 with SMTP id e88mr27495735pfd.72.1479842567525;
        Tue, 22 Nov 2016 11:22:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:3d4e:3f15:a371:dcb8])
        by smtp.gmail.com with ESMTPSA id y6sm29026084pge.27.2016.11.22.11.22.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 11:22:47 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
        hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 3/4] test-lib-functions.sh: teach test_commit -C <dir>
Date:   Tue, 22 Nov 2016 11:22:34 -0800
Message-Id: <20161122192235.6055-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.4.g3396b6f.dirty
In-Reply-To: <20161122192235.6055-1-sbeller@google.com>
References: <20161122192235.6055-1-sbeller@google.com>
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
2.11.0.rc2.4.g3396b6f.dirty

