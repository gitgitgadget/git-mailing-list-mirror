Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D24E11FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 21:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933005AbcLGVCG (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 16:02:06 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36759 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932339AbcLGVCF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 16:02:05 -0500
Received: by mail-pf0-f178.google.com with SMTP id 189so79184275pfz.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 13:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/t762J47XfViKpMdaGYO3GwFnELd/Fwx2Ritqpns7c8=;
        b=elv0Nwy1Cqn8NQzPEP+tJlmSEOdTDBoBXHhS1/rffSw7A1b/05qY5vCPQDr69U0ZU/
         Yv3Lq1keCKTaV019HeTKY1JZat5o4+1op9D7onxIrlQjsuR8pFhJb/D4ZmndcykxyiIW
         /hdlX6lNCq4bGSXINZEAt9J3hKIBvUgAFX5QmwPMbm9uq2eR63v4/Qu4pmT2tge3BhDo
         Z0wLSoVn2g8zfKs+U+d8eBLW3LS6g/ckvjEmS+eMiaTDFEZ14w1Khi9ZxYAwPUt+uXU1
         +f1rR52ZHFfkCPKDN3OQej5blZaoHjtq7ZYxIO09lhv1LjqHu5uidDleSIUkBS9rpsNM
         8jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/t762J47XfViKpMdaGYO3GwFnELd/Fwx2Ritqpns7c8=;
        b=S2ADV3vsvFCcQoa3m8pxslcPf+oWNsV4xTYTRTtC6y9zn3iGbX/xKTAz5kvZDb2i4E
         1us+Htt9b5lbTiMZc1hpsMnxRaSFSvaGPYAGKx2JOU/0yYb291zBN+vVWHycHwReILxg
         ih6TaiblE9Z8WHA1d6+Kh8l3uvF4QTj+AFxC/jb3u8WaJ8u3wChBxHovpUAC0BZxOZEc
         G1KaxGQ7mrghoGb57Zpvwcqc0xMAaomPs6FXpAEiAE5oiwW1prjYR3pOvknZkGBSXd2H
         pmLbxgxASMca1T/fTFb9GcXxTdHH5ylS+bL7p2GkTVf3sNRqn1/456OzC6+71KzJ06Jv
         ic0w==
X-Gm-Message-State: AKaTC0106ofvVaBkE3qDE4iWQ3j9OxvDNvVpsCw8Ne0NSlEOjWSmDIKaJ/pb7lBuW4BdYTRc
X-Received: by 10.99.242.5 with SMTP id v5mr122433390pgh.181.1481144524463;
        Wed, 07 Dec 2016 13:02:04 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2441:4f9a:ad0f:a8d7])
        by smtp.gmail.com with ESMTPSA id y20sm44738888pfj.26.2016.12.07.13.02.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 13:02:03 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 3/5] test-lib-functions.sh: teach test_commit -C <dir>
Date:   Wed,  7 Dec 2016 13:01:55 -0800
Message-Id: <20161207210157.18932-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2af45f1.dirty
In-Reply-To: <20161207210157.18932-1-sbeller@google.com>
References: <20161207210157.18932-1-sbeller@google.com>
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
2.11.0.rc2.28.g2af45f1.dirty

