Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7F6C2BA16
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854E520730
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfEz3uGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgDHEGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 00:06:11 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:36832 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgDHEGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 00:06:09 -0400
Received: by mail-pj1-f51.google.com with SMTP id nu11so645134pjb.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 21:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3sx9/YbpIJhEpk+6cj+C2cktu3z0l+GEx8rIPMU0dnw=;
        b=CfEz3uGBGDy0DrAZ5oypztM8lkurgiJeCCA9ZgdK034E/gXIiAmWJf/VIRDSzhDder
         H1JTGog0dJWqMjV1HdLHCrqPZNfhGuVRYs8uui7uwNmNiO6HFl7R9lgO1uPCoVrUamuL
         QWkC/ZdBtSUutqSMWwVWkEMxtWh+E+Kvnp20xSJpZjoAYnFc780Qrd9swqp2JcoxMO0s
         L1iHEdJ7jDkgnx63eCWfMlV+XDDS9qcngi7OBYrpJ7a1P19ZluaeAZ0FV7wuPYpwV75M
         lnJPoLEml/wBO8oyIEgRy4OBYt/QMG4av6dn5SXi2FXg0b01BYufDVdyQeKBt57EKLiK
         sSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3sx9/YbpIJhEpk+6cj+C2cktu3z0l+GEx8rIPMU0dnw=;
        b=Aeh8JO9nPK8aLUtuNQPHgdsUkV+/DuJSZ5gvNC4gRiOpT/59V6fZsyHV9Ebc6DX4Lt
         AmSuLjBb181Bkv+eBioQt2W2orxsS6N6JIh6HwhCYvYpptNMQcqWmlWzEIeRB13PfC6n
         qC5Lww+lWiTM5BYN8IYHZ2R54vwFiNmt/PMUNzYt53KANFSa//3HoySZNxLwz8YdC+uq
         kKyqMfz4rYHXFHRYVUR2Az4m6Fz4HrAHVzZKkIJ2s1Er6Y/XHrvK3JONX6ct/nuN4HsC
         jaURgum9hHmA6qsB1KKC5ZKKxQ++zUm5ydAlD4c6AW3EDBjLFr1kk6ihdLur3w1ykj8v
         CrTA==
X-Gm-Message-State: AGi0PuZD2Gx7vU8cWdztldOr4NLnojV/9sxiiYCtb69SGl4zVlisho/u
        FjHkAV+As6XOfY8RhHnVLUPXbT4s8MU=
X-Google-Smtp-Source: APiQypKl62CxoY8m+JRGIxC5g0bBj+24OVH8GxvvDXAnWexZ6LhTJRUuI6curWcFHSIPALCbo/ibYg==
X-Received: by 2002:a17:90a:240f:: with SMTP id h15mr3061227pje.176.1586318767935;
        Tue, 07 Apr 2020 21:06:07 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s9sm2879725pjr.5.2020.04.07.21.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 21:06:07 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 06/12] ci: run gem with sudo to install asciidoctor
Date:   Wed,  8 Apr 2020 11:05:37 +0700
Message-Id: <795ec656c6172b139a5a55f1760e0ecfe434b5f3.1586309211.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1586309211.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586309211.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In a later patch, we will run Documentation job in GitHub Actions.
The job will run without elevated permission.

Run `gem` with `sudo` to elevate permission in order to be able to
install to system location.
This will also keep this installation in-line with other installation in
our Linux system for CI.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
[Danh: reword commit message]
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 371902bb75..a6a1dafa15 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -72,7 +72,7 @@ Documentation)
 		libcurl4-openssl-dev
 
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
-	gem install --version 1.5.8 asciidoctor
+	sudo gem install --version 1.5.8 asciidoctor
 	;;
 GETTEXT_POISON)
 	sudo apt-get -q update
-- 
2.26.0.334.g6536db25bb

