Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFB791FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756177AbcLAU0S (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:26:18 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35768 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753124AbcLAU0M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:26:12 -0500
Received: by mail-pg0-f44.google.com with SMTP id p66so98577195pga.2
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 12:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gklxZ8MZvRimGYL+1vFoZX7aMBMplm2QCBz5dQctST0=;
        b=CE2AgiQx1j6Gd2PiGwcy8LrIF5TqJOF9TIeYsFLQdG02dBqRNvwnsAUpj8qOZ2Paji
         Nmpi7kgWhE9pdUMJZZE5bpiJwT5bTDNktxwFKbCoLF7h4Xi2Q8x4yNRM++SUlcFNguV3
         qOKuYP82tKESLNU07cvUFHpmLoPD42HwWMz9yHR+0sajPOigY05AcugsoIzMSc4RjFXa
         16NaoePbUvk7XZU1cRpK8vweJhN6rwx8mnOxoyVKqjDwqCPIpYGS3u0d0EAvQPHdzd/y
         Dsu542FQI3Fdh3rhzYTphNGX+b+QGYswypkGOLLawJW49UeA2QTPlXYx/XS2GExQ3pY+
         q3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gklxZ8MZvRimGYL+1vFoZX7aMBMplm2QCBz5dQctST0=;
        b=V8Rd15yYwmm692R8IuwUZDuokgQqNY4uQPu0Y9xWp4lnphb/FiPSKT1tsu0NEm6tZk
         0oadeBS150UFc2brHiJSelW5dJWGmtjvsVDaRhd79gs/5jmUtZjxO6gH+F9rMybVFYPv
         hZzNWUI4PHCGIVAmJ2ynch/Li0afvHFDKzXZqRUL/d6XUfTrjrBuRG8E+/G6FRRuFY3k
         4HkDeNyVW5CadWoqJQ+Rhaur7fgY/j8arob+izormEWR0j0Xmq/5zo82zNlAYwbcF5iN
         WGlweqgWLlN2ilzz/dNDMnSMuEiM5S7SJYS+Q8Xd3dWwZ+mwlI6/QQRI41DbgIj6vZbb
         Jszg==
X-Gm-Message-State: AKaTC03d5UqKGImZQfKLhnYWWk9GtvotO+/hIB2RpgBybq+nbNo8MHINCj7zwLYT6rNlFr98
X-Received: by 10.99.19.65 with SMTP id 1mr72519783pgt.71.1480623972150;
        Thu, 01 Dec 2016 12:26:12 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:18d1:181b:bbf2:e96f])
        by smtp.gmail.com with ESMTPSA id p64sm2050422pfi.88.2016.12.01.12.26.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 12:26:11 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 3/5] test-lib-functions.sh: teach test_commit -C <dir>
Date:   Thu,  1 Dec 2016 12:25:52 -0800
Message-Id: <20161201202554.19944-4-sbeller@google.com>
X-Mailer: git-send-email 2.10.2.613.g22f2156
In-Reply-To: <20161201202554.19944-1-sbeller@google.com>
References: <20161201202554.19944-1-sbeller@google.com>
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
2.10.2.613.g22f2156

