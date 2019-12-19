Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2921C2D0D2
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD97524672
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzi0bwjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfLSWVt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:21:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33420 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfLSWVo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:21:44 -0500
Received: by mail-pl1-f193.google.com with SMTP id c13so3214083pls.0
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cq3i6CU2w1OvkLOnIHEPmtZ2dO3HE+MsuoDzwGrRs/Q=;
        b=bzi0bwjkdPXYG1qlJ7x7sgyrcKISEAvt2kazPMa/qZ8nNlYgw5lLxb9ugd4GDQoS9h
         r7h36kNznjN0E5/KH1lW+iPg/YqDV9s0Ho33e0gNE6c94YGtjydhoMbdlpEkLYjbwtlI
         FHzY89O5hrnEAlpv3uCLXNmH+utWNrS3N4WtOj07q5/TfijEImJfWBsR62O0/3qp0fNJ
         e6X08pvxJVF70nw0fD66P+x0271Xbo5vq5exCY5BnhIGpLThbNq3ybYHlKlOneG5xmzo
         K88JdU17EhdesUFWR2iAMKYXKfpfPllTsquY53eyjidK+G8XJeyu/C/kM0dBcVdkOZ1d
         eufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cq3i6CU2w1OvkLOnIHEPmtZ2dO3HE+MsuoDzwGrRs/Q=;
        b=rYZeX1wCNx0Fs4+RYfUAl+9uLviAZycnHBYpqSppblWHQfcjW9w3zhpsynoVgCFVz6
         cRQiU1UCifar5pR+qlNFXayOEBEZAUpchJmpj25CnZ2pqyZaz7TadY/gcBbIi0OkSTfe
         740Rbky9JBALM2t4HEEfOxPmwBnmydrN7Dv167ZRCiMz6Dwvvf055/iJe8yiY4SzKXNK
         PG0FtFqbjs3jSQJ2uO0XwMYg6BmvtHA7SkwNvyOflcqekTw+b/Hnr4oXrbucqIOCCcRl
         KXeOiohgmOdNzKgjqvslsEsxMFgvOGgdGJNnUAq8Pfa9boayIoCnsyll3kde4CHnF1HA
         D3Gg==
X-Gm-Message-State: APjAAAXJvflYFhMm1oI/cq8AaUXXVho3Ug7R7QdVWMZZQMuIQlmKSM3Q
        moCrlY40YmkrpmleQFibWpWO7UP2
X-Google-Smtp-Source: APXvYqxmDNjwaJL0L0osHKRvBma/aJQ95EuKYMf4v0t6/jxbHOzCplxvOzu4lF5oyXTSoG/SkQehAg==
X-Received: by 2002:a17:902:bd4b:: with SMTP id b11mr10485793plx.6.1576794103771;
        Thu, 19 Dec 2019 14:21:43 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id o19sm11428528pjr.2.2019.12.19.14.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 14:21:43 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/16] t1307: reorder `nongit test_must_fail`
Date:   Thu, 19 Dec 2019 14:22:45 -0800
Message-Id: <d6ea8a6df0517c34136b0bddbce0948f9c8d448e.1576794144.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576794144.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com> <cover.1576794144.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we plan on only allowing `test_must_fail` to work on a
restricted subset of commands, including `git`. Reorder the commands so
that `nongit` comes before `test_must_fail`. This way, `test_must_fail`
operates on a git command.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1307-config-blob.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
index 37dc689d8c..002e6d3388 100755
--- a/t/t1307-config-blob.sh
+++ b/t/t1307-config-blob.sh
@@ -74,7 +74,7 @@ test_expect_success 'can parse blob ending with CR' '
 '
 
 test_expect_success 'config --blob outside of a repository is an error' '
-	test_must_fail nongit git config --blob=foo --list
+	nongit test_must_fail git config --blob=foo --list
 '
 
 test_done
-- 
2.24.1.703.g2f499f1283

