Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C700E1FF7F
	for <e@80x24.org>; Thu,  8 Dec 2016 01:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933979AbcLHBq5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 20:46:57 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34635 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933901AbcLHBqo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 20:46:44 -0500
Received: by mail-pf0-f181.google.com with SMTP id c4so80393993pfb.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 17:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=us/MUGo5+mJ59HhsF4kge51woa99s/NdVxcbzPkRKFA=;
        b=XUII6zxm6t6Jd5qB8lNPNizGPsPQQptU44IB+m5kaLyc6p+2shYUMZ+WfSlb1A7Vmb
         kEgn8UD7VptSngdK8O6wOwYFumVSCEyN+LUOTWIkoKqbvTzI+XY6qnK2t72CNrxrVoTY
         rOwETl4jA+Ln9rgKoMnp10tyPgHEUB3JqvdPiZGJO6LEwdxrwRjEOpSv7tNEhSuDuSw/
         wY9UlISzXVOfJTSfGFdYYE4yCw4dXiTFChA90Ncd4Jg2Ax5AQLRk3hLbW42vMG+MeaLv
         rwNzGStzqd2TF+xfFKXCDNfhjsW2pOjTQ2dOoamtUDeDp+Y5q8h2TBhluTBHkAUNQdv5
         eIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=us/MUGo5+mJ59HhsF4kge51woa99s/NdVxcbzPkRKFA=;
        b=Nh8TeFPKVDY+NUB8/OQ1LCKf+gfumX1LIuEEKBKPeI7/K2q4vEJUeo2J2FZkKPvAPF
         rPwJ+qKjIwJScIall2FgEoKX75Ts9l3wvOFk5ogOau2wWAh64SmYrnzgs9Op96ihXMWc
         Lsmr3XHo1cBCBdkUw1m4CO14CVJKAWoNYHrdvJb50g7MF1JNdgiuXAnF6hX6MLCUk//0
         /VTLOPelEB6Zii9h/XZB7CzT1NbqXc0rheiygIb6IgTbLAOfM7jo1ahZpoHqiPLSObNv
         EGMOkPPjZEyuEohd0/Rfl5pgNcC/fbmfpacvjIYE27vKPCWlzf2+EWpgv4KanXPms6KL
         M1QQ==
X-Gm-Message-State: AKaTC00Ty9P8IKXYRi7b0MS1IwlcrG2rvOGrgbu0YgQlasMWI5cajYW1ALPHAasJC0YC3DYf
X-Received: by 10.99.138.75 with SMTP id y72mr126184448pgd.90.1481161603977;
        Wed, 07 Dec 2016 17:46:43 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2441:4f9a:ad0f:a8d7])
        by smtp.gmail.com with ESMTPSA id n24sm45439993pfb.0.2016.12.07.17.46.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 17:46:43 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 3/7] test-lib-functions.sh: teach test_commit -C <dir>
Date:   Wed,  7 Dec 2016 17:46:19 -0800
Message-Id: <20161208014623.7588-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.gc512cbd.dirty
In-Reply-To: <20161208014623.7588-1-sbeller@google.com>
References: <20161208014623.7588-1-sbeller@google.com>
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
2.11.0.rc2.30.gc512cbd.dirty

