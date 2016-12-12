Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 673052070D
	for <e@80x24.org>; Mon, 12 Dec 2016 19:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbcLLTEw (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 14:04:52 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36647 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752850AbcLLTEp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 14:04:45 -0500
Received: by mail-pg0-f53.google.com with SMTP id f188so38086791pgc.3
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 11:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O/xacmIroKj0C1hIRmWt0//BXX8JE4LCUszbWw+quSk=;
        b=nWR0EzDygsRugtvaEE+2ICXFSBoV80Vo7FKcjviG++zW7rsSmjNUHB/v+nqr3uaVdQ
         +Cl3rwQdEsj+O4hKpu+wMjuSyFvVfS8RJTHLherQH5+uObXQ1b8SYf4Mchh2Vjl1S4vX
         fxBt0lN5huHY+coDSctqx8xrMZVPTbCI8YHExhnAondNyWsNDtGvC85vzgqlAFCIrdQl
         LSWvQyNIuKbqw4L+q3RIOtpwTB+/hx1B/ppB9O4ugo3PGLj0jeLG+ihPhDmYs38bcGcS
         lir2N5QcoBJXhW5zdnNGZ03w8DqLy0P52mW/WK7AxCltEiCk/ut4rqjSo+rJ/9O8RCaS
         wtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O/xacmIroKj0C1hIRmWt0//BXX8JE4LCUszbWw+quSk=;
        b=bi127EP7g8d4xWNsakoMWaS75vtK7VF6xgUw+tJISsX1OEe+gCXjR8djmMhZBHVf6J
         tqYzTppuE/V3r8N9KdmikIJEClcctG/BqqrYRpBUllKsqQtd1DaFH/IYA/Fr25VeE5Du
         n47OKB4rypy7Qhldqo8z5K1EVTttXXM2WnBW69RTUoY4ciSiqJCW6OpZdID6pFXbQ7Oj
         uxA+KhFwNcHprFRrJ8EuZLyNO7J0ScOcyGHvDvcwpRJIz93RhiB8zSJArzwJ9r4uC318
         RDWux7t2Uw0xm7T3KYGKLABj76rbsHR/Flo826oQd0psAHz2FwzxA+PDbDGymtzCz4NV
         g1+g==
X-Gm-Message-State: AKaTC01bURHEISwCB/SALqWFzUm+R7FS40Jr4+NEbQZ93cHRy+aVrI5VjI8Hv63O7/TnHFxP
X-Received: by 10.84.215.148 with SMTP id l20mr188195972pli.120.1481569484638;
        Mon, 12 Dec 2016 11:04:44 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:642c:37a4:3709:a2b3])
        by smtp.gmail.com with ESMTPSA id c8sm77388937pfe.15.2016.12.12.11.04.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 11:04:44 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 3/6] test-lib-functions.sh: teach test_commit -C <dir>
Date:   Mon, 12 Dec 2016 11:04:32 -0800
Message-Id: <20161212190435.10358-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.49.ge1f3b0c.dirty
In-Reply-To: <20161212190435.10358-1-sbeller@google.com>
References: <20161212190435.10358-1-sbeller@google.com>
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
2.11.0.rc2.49.ge1f3b0c.dirty

