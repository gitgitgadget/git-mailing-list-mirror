Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0BBB1FAF4
	for <e@80x24.org>; Tue,  7 Feb 2017 09:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbdBGJRH (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 04:17:07 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35620 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752011AbdBGJRF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 04:17:05 -0500
Received: by mail-pg0-f66.google.com with SMTP id 204so11632497pge.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 01:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nwpgY4I3XYDJHLO6XfWEOKLprBNdtTWjQflumQrnugA=;
        b=dkg2MVnil2SaJg/fxt8GZRDQfJadoCgXePN3iRdIXTNSbxRA6Z3zzKySRkJU9GV1mp
         zkNO6YBxByQ8oI+Zl00lX+51QpS3CUzfUXTss/QhwoWpA+tC4/iWSiAxf1EWk0t/Qdjl
         1KCK/jZbt2/XxyGnAzmuvbqV8IQf+55CXmXWXW0zGqu26CkvfD0RVMXJ+0PI0ojGrEkn
         gEI+THaJzkFZGg5t5CSzHqjXqau+lnzS7omhf6QdcjUJDYGpbtpBl79iks3xAPzcHzvL
         Vjkzqgxv/VJTr5SDfFZP2LPpyQhjhu2n/6C2Bc9lY0DLSqUp4vFF7vbn8TxL+xazpEgu
         KuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nwpgY4I3XYDJHLO6XfWEOKLprBNdtTWjQflumQrnugA=;
        b=m8dgsqNDr8kifxIY5f47NhCLb/LsyUB6n3VIw98kDCCLQ8TWcyQ1PGeFyLzOMtgOZO
         ucNXAHSFSFL7kzZVqXUWup74kkhS50rCrUcLxqQV5hgsazbW+DAyvlUR+aY63u4GyzzM
         O2tmlUoto5LxAz8Nxl5teaVfI0k6IYd7X9qzEfoFxiDi50Q9TARktWfdNife582r0wXo
         La+WGvXgeaQwDQrW0iMVY6ITTNBkN8JSzPxJnqaZLTDM1CjrlwzHdqe1rWSKYpsj/+OI
         jhTNFVx7Gbttnh1slzLEwHb9Y8Xo1HJ2bV5mITh43atdbz+1aoDzNmO7IjXvENjynEl7
         ERnQ==
X-Gm-Message-State: AIkVDXJsDATRNcSPq0KDlL4Rtp25Fdl+KE406MhuFX/HGOoINOs7cq9INS0aWYPhmw8n3g==
X-Received: by 10.99.172.2 with SMTP id v2mr18979289pge.100.1486459025086;
        Tue, 07 Feb 2017 01:17:05 -0800 (PST)
Received: from localhost.localdomain (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id w123sm1320102pfb.44.2017.02.07.01.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 01:17:03 -0800 (PST)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git ML <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] t7800: simplify basic usage test
Date:   Tue,  7 Feb 2017 01:16:59 -0800
Message-Id: <20170207091700.20156-1-davvid@gmail.com>
X-Mailer: git-send-email 2.12.0.rc0.228.g6c028b8e94
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use "test_line_count" instead of "wc -l", use "git -C" instead of a
subshell, and use test_expect_code when calling difftool.  Ease
debugging by capturing output into temporary files.

Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
This patch applies on top of js/difftool-builtin in next
"difftool: fix bug when printing usage"

 t/t7800-difftool.sh | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 21e2ac4ad6..97bae54d83 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -24,16 +24,15 @@ prompt_given ()
 }
 
 test_expect_success 'basic usage requires no repo' '
-	lines=$(git difftool -h | grep ^usage: | wc -l) &&
-	test "$lines" -eq 1 &&
+	test_expect_code 129 git difftool -h >output &&
+	grep ^usage: output &&
 	# create a ceiling directory to prevent Git from finding a repo
 	mkdir -p not/repo &&
-	ceiling="$PWD/not" &&
-	lines=$(cd not/repo &&
-		GIT_CEILING_DIRECTORIES="$ceiling" git difftool -h |
-		grep ^usage: | wc -l) &&
-	test "$lines" -eq 1 &&
-	rmdir -p not/repo
+	test_when_finished rm -r not &&
+	test_expect_code 129 \
+	env GIT_CEILING_DIRECTORIES="$(pwd)/not" \
+	git -C not/repo difftool -h >output &&
+	grep ^usage: output
 '
 
 # Create a file on master and change it on branch
-- 
2.12.0.rc0.228.g6c028b8e94

