Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B36DC33CA1
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C872075A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb4Ajixx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgAGExq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:53:46 -0500
Received: from mail-qv1-f44.google.com ([209.85.219.44]:35029 "EHLO
        mail-qv1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbgAGExj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:53:39 -0500
Received: by mail-qv1-f44.google.com with SMTP id u10so19958309qvi.2
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IUqS2ToxxIaU+JGMqM0slg+lmdW/PYLUq2Mp3ANUqOY=;
        b=Jb4AjixxpucSr5IV9UcZ/aCVXZpHgvJCkRQnVZSRQWSaGjSTe8r0aoOUeTIyWZ8zzJ
         0SHYa/tjXroYwOxBmNqNustqROzKlyhVDcnx9mWEYIdDXw1kDdrVOnac+seSSkcK/tjT
         8Zaf8Qcf2CUmPd9ZdMjUshO1IvvUYqoMr4iO1xwfRIiBHMUI/E5oE7uvDM38Cf3RE8zx
         HX0CyMeDCR9I3I9MYry5w8NqvOe0oKaCgVeL6LykbEgJAjzu2adZnJdYFGIxYap03P9k
         MzzyREg9zpHN450aRB1SI2IOzpTU0kmLRwTP8hrRSVRTHpwcumFt8ABj8/Vw99qTsw1c
         nBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IUqS2ToxxIaU+JGMqM0slg+lmdW/PYLUq2Mp3ANUqOY=;
        b=VPlb1pf4634Fbd2RzakSfPXahvYMsZ4/esJ458fcmDthaLqzmOh3hrzNGmh/DCPlNT
         B1OFusGNKxVvVYsnaJ7zKksdeWLFp01Z364984nYVXafc+qBQrS9NQRzV0Tg62mr3vsz
         KVUCb0d6wc3RtDYRsdJXWFRsHIG429yyq9c1DnM7JV8O4dBcY1xTvToNT4Lkugh/geMR
         pFIuJTdkR5Cm6EcR2r0YdBd9spIAjmP86Zn+sJg6aAcAO5wciDlDiHb73eq/T4B1jb7y
         1YRn2VH9nBPYl36ZQmuu53YcOSrOKyLt3C87y9haKrJPtW2343jPtC6XCnUdTfInXrsp
         wThw==
X-Gm-Message-State: APjAAAWQ70N2QzoxTjjmtIrSGlEQpf8j+FsckPZFouxMArTVwa6zA/FL
        vpEmY4/psmpxUDDQQs7nK3Raxnqe
X-Google-Smtp-Source: APXvYqzuDBjJDK2qyz7Wt1vnNOY3AHc/ImW+UT4QLDD8YrIWLVViJI2XPc2rJukzHLvcAczBoLBRDA==
X-Received: by 2002:a0c:ed32:: with SMTP id u18mr83085016qvq.2.1578372817976;
        Mon, 06 Jan 2020 20:53:37 -0800 (PST)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id t2sm21663893qkc.31.2020.01.06.20.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:53:37 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/16] t3419: stop losing return code of git command
Date:   Mon,  6 Jan 2020 23:53:09 -0500
Message-Id: <ea36028d53224d364ce95afe8b523e3400a7becd.1578372682.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <cover.1578372682.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com> <cover.1578372682.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix invocation of git command so its exit codes is not lost within
a non-assignment command substitution.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3419-rebase-patch-id.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index 49f548cdb9..94552669ae 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -80,7 +80,8 @@ do_tests () {
 		git commit -q -m "change big file again" &&
 		git checkout -q other^{} &&
 		git rebase master &&
-		test_must_fail test -n "$(git rev-list master...HEAD~)"
+		git rev-list master...HEAD~ >revs &&
+		test_must_be_empty revs
 	'
 
 	test_expect_success $pr 'do not drop patch' '
-- 
2.25.0.rc1.180.g49a268d3eb

