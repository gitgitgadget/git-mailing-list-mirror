Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E32BC2D0CE
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018A820882
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RF599Cdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfL0Nrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:47:43 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35896 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfL0Nrm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 08:47:42 -0500
Received: by mail-qk1-f195.google.com with SMTP id a203so21909604qkc.3
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 05:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nMrlJmXkhSmJujxH2Sv9cx6KyoLY0vnpsh+tHoYJpzQ=;
        b=RF599CdhfSkQNUL4PohieudJWunJdD/FF9/M1aD0ogKgrsCf2jgiyiuuTQvqIsnhmG
         X7BtZl4MdX5W0ukT78sdMsIwfNvMQSDgHFnuDGfhkkv6hxhayYOb29aIQhlB8cyKUfAz
         U+Ryfsm64xS9A/NkyunpYy1PMmDy3MpvL5/1WomzZuNsulPsQqOJnuhBt5swK9UrET1z
         nUlr4pI7+Aaz24F8pJH0DYr6u8nGkfcqs0bX5/PcnbwIng8ihkJ9TaePpSrRezSN3Yo9
         8UnJu93vhH3ECUa80b6LFCy6f3KfRWWUqx7amo+TVw/UDGJ/yJk7QDNINo6bIPbq1678
         cAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nMrlJmXkhSmJujxH2Sv9cx6KyoLY0vnpsh+tHoYJpzQ=;
        b=DqLDl4VgMxluzNsn8DZ33bLoCDy3C0VxIz3SWP6nYX+MnqHLVw8aSMin3890T6KiXu
         j8Kp9xGAr1vyv058r04vL2I6RLoXoSVaS029zunB1ZWcO2rqIe5ffXmim497UTp1oXMU
         ygI8IChUkNmhg5jo57KIWqdmzlxo4M0SUGTDyUJ5U6bDU2WBeZbZOyjxqhFZj44ubRG2
         4e5OcyUp8STBLiXihIjasFd5f69cdLU/pKwKrEWP9P8vF2koj85ciGcaxKbpUR4GJ8Xp
         SJ3JHHrOc8Re+dyJ9Iw/23GVviLODxQ8gmKUVdzWS3VE0aN20N5kOsIy+w0Tf2a7M16r
         3fIQ==
X-Gm-Message-State: APjAAAXnTqEVeMYWXHz7fXWDsBh8XRmhlM3XJAjhY9OHsjQyZ9dTOire
        YPJU2N4PLFfwKxBF2+/WxA02chOF
X-Google-Smtp-Source: APXvYqzArpMUUIewZuvs54LdqjNoVvA8ZSVcVhg31dBp53qvi+/YLoYnwFb18ZBjJX1S7vrAu7Vesg==
X-Received: by 2002:a05:620a:634:: with SMTP id 20mr34022651qkv.269.1577454460902;
        Fri, 27 Dec 2019 05:47:40 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d9sm10510184qth.34.2019.12.27.05.47.40
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:47:40 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 06/16] t2018: replace "sha" with "oid"
Date:   Fri, 27 Dec 2019 08:47:15 -0500
Message-Id: <0e3072f03c3e34810acdb5f08c3fb5effc39d3a3.1577454401.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577454401.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of the effort to become more hash-agnostic, replace all
instances of "sha" with "oid".

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2018-checkout-branch.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 69758041f4..6b36c7800a 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -4,12 +4,12 @@ test_description='checkout'
 
 . ./test-lib.sh
 
-# Arguments: <branch> <sha> [<checkout options>]
+# Arguments: <branch> <oid> [<checkout options>]
 #
 # Runs "git checkout" to switch to <branch>, testing that
 #
 #   1) we are on the specified branch, <branch>;
-#   2) HEAD is <sha>; if <sha> is not specified, the old HEAD is used.
+#   2) HEAD is <oid>; if <oid> is not specified, the old HEAD is used.
 #
 # If <checkout options> is not specified, "git checkout" is run with -b.
 do_checkout () {
@@ -22,9 +22,9 @@ do_checkout () {
 	exp_branch=$1 &&
 	exp_ref="refs/heads/$exp_branch" &&
 
-	# if <sha> is not specified, use HEAD.
+	# if <oid> is not specified, use HEAD.
 	head=$(git rev-parse --verify HEAD) &&
-	exp_sha=${2:-$head} &&
+	exp_oid=${2:-$head} &&
 
 	# default options for git checkout: -b
 	if [ -z "$3" ]; then
@@ -33,16 +33,16 @@ do_checkout () {
 		opts="$3"
 	fi
 
-	$should_fail git checkout $opts $exp_branch $exp_sha &&
+	$should_fail git checkout $opts $exp_branch $exp_oid &&
 
 	if test -z "$should_fail"
 	then
 		echo "$exp_ref" >ref.expect &&
 		git rev-parse --symbolic-full-name HEAD >ref.actual &&
 		test_cmp ref.expect ref.actual &&
-		echo "$exp_sha" >sha.expect &&
-		git rev-parse --verify HEAD >sha.actual &&
-		test_cmp sha.expect sha.actual
+		echo "$exp_oid" >oid.expect &&
+		git rev-parse --verify HEAD >oid.actual &&
+		test_cmp oid.expect oid.actual
 	fi
 }
 
-- 
2.24.1.810.g65a2f617f4

