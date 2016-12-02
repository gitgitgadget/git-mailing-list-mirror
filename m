Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CCD0203EA
	for <e@80x24.org>; Fri,  2 Dec 2016 23:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755479AbcLBXn0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 18:43:26 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33163 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752790AbcLBXnR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 18:43:17 -0500
Received: by mail-pg0-f43.google.com with SMTP id 3so112516919pgd.0
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 15:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9kqS6JHyfLad0o4gHnfDV7fnSzfFmv5yPlcL88jyM9U=;
        b=EWotT4MBIfD2KVoQNQawSAP3LIOcvS0QUwm1msPxL2n00GApQ0lRFkiG6bwPjMyEzv
         g1gq2ByHa6y1mVnk0sp9LxrVgOJUPKTKqqyTV4B7uDWzPojKDaT2mhICjFoyDS8RT9z6
         fQCAAzZR3kA20FVaXAzBeJzuo7Jh6uo6e2QNtkCQYhVDxBlWMEypt4hQQWmNAPJBDBRh
         fh22zQ/3SKhtm7HbdSjrjTibanbw5g+nOxbcgh36TRHfCLcR0sorJ+X9AqqHQA6OaHZy
         EGA4wuYxeIL3ela2uWw+QmAhNRY7dw79CDHH9YjckLm+SfhkRuQ6HVAlFognWJo8MDSi
         8MVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9kqS6JHyfLad0o4gHnfDV7fnSzfFmv5yPlcL88jyM9U=;
        b=OACw+/koEj7JssvVr7MnQXCzh6DYz3VmKnqHUk8T6QpHnnnYVH3C8BxkxrR1RmHbkX
         +s0B8IWKB2bGscqIwXjd6eNMn/Dzdd9kJ5f+ZnTKXyCO81L+1sdEFjYkbU2syixBJrZe
         1NrCboBPN0CbJGiwrfqDiKQkIwdNot5DAKRvbs84i1vbYfXi0ipNHY8Iiay02FsXT3nN
         o4jarhHCH1BLL/2VO0Fxq4nbxdmufInzOdMc8DeDOHc5PzwiLG07dBgRNQFhK6KCdqqh
         jglYepF5t2AvPkg2vd0N1HcOD3kEX6ucuayPVLN1/16CLTEnbgPDg/g4TBxI/i3kTeLs
         XItQ==
X-Gm-Message-State: AKaTC01NceMGZPFk8koMfDO5Yc5GY+M1lyT9dBdK9cRCMtheZvulo7Bs9M5ebn+lFFqzhfzl
X-Received: by 10.99.217.81 with SMTP id e17mr83180487pgj.127.1480722147339;
        Fri, 02 Dec 2016 15:42:27 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id p25sm10184790pfk.20.2016.12.02.15.42.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 15:42:26 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com, bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 3/5] test-lib-functions.sh: teach test_commit -C <dir>
Date:   Fri,  2 Dec 2016 15:42:18 -0800
Message-Id: <20161202234220.24664-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161202234220.24664-1-sbeller@google.com>
References: <20161202234220.24664-1-sbeller@google.com>
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
2.11.0.rc2.28.g2673dad

