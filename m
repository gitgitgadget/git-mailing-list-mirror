Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B59C35671
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 22:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB5F206D7
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 22:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCY8dpa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgBVWfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 17:35:14 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:33691 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgBVWfO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 17:35:14 -0500
Received: by mail-wr1-f53.google.com with SMTP id u6so6058942wrt.0
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 14:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R3KqidS87oMfZWEQuJFy2UnHNpKNj4M4MKmHdV6za2c=;
        b=OCY8dpa5oVbduE/NAM3KZHqb1BYkpZk6mcGrZWC59aPZvTeTJ7JHiTmaFZRgYZfMIO
         1Jm7jkUVFPvnRXFNrZvKHnKpJeBlaGMgdA91/5Dhd2v5FWIxBRHGI+AVFA33s16JtB1c
         GC/Nj6KZ97xLiw/GOc8WIfJ+JXnk724KfiCtlOqNFOjN5SFIhGZxYMZaciKSAY07brwE
         ac7Do2DZB7rdj+M5u4WM127Gg/uslZ5+89/k2WjjkbGqUAAoPbvLMbppqmaCS4BdRotj
         Yo5V3Tk+UC0YOEgv49YVVzR4odd52OaZnP5Zo4unC1DWKs643f2J9V959pQKRCH4qnEZ
         KDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R3KqidS87oMfZWEQuJFy2UnHNpKNj4M4MKmHdV6za2c=;
        b=BXVtORNWuI6z1Cs61Ys3bIB1v5JtFHc07LwB7zNk3vWmznZKcOCnLzmsgTjsSBxCs7
         o74Cvn2ERthMfNLl4sdXRAWbRKNlztC64gfpgfnwGPsh49BjdAj5J3z7umn0WAIHF8ry
         8tLTx2TeHbQwSAMbortslkT+sYYg0IvGgI3sgRGVSKim7ctSkcUYIO5ChG3Y9ZzlkXWp
         w14Dven+v67mYmLZ7M+GdeyiM9llXE7v5GiomwxeP/8J5ZkJ4DrlbA93Lr9Z0wOnHuQ0
         I0za/pGkNFpXQIEcTW4g/hha8z6RorqhPnGqD7Jf2bUTNld1Zi6fVFsLDXYD86J9+wHA
         M/2A==
X-Gm-Message-State: APjAAAV7sZPbzqoRSm7z5bUk1P5/gERB2PpG+cxUvO0c8Y5+BuVWcYHl
        elVXO6gUeC+G1/QxLwnltVnafULz
X-Google-Smtp-Source: APXvYqwebLFgGR8T5zi5zMw3o3aX67H8yPc61gL8Ij9uoKjUgMO2PEku/NP228/OXUKDg2BB7NOcmQ==
X-Received: by 2002:a5d:498f:: with SMTP id r15mr55371745wrq.284.1582410911664;
        Sat, 22 Feb 2020 14:35:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18sm4781890wrw.49.2020.02.22.14.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 14:35:11 -0800 (PST)
Message-Id: <b3e573d44a99a828e710f06b723942107189afeb.1582410908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
References: <pull.535.git.1581620351.gitgitgadget@gmail.com>
        <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Feb 2020 22:35:06 +0000
Subject: [PATCH v2 3/4] bug: denyCurrentBranch and unborn branch with ref
 namespace
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

git supports an interesting feature 'Git namespaces' that allows
dividing the refs of a single repository into multiple namespaces, each
of which has its own branches, tags, and HEAD. But unfortunately, there
exists a bug in `denyCurrentBranch` which allows pushing into a non-bare
repository using a ref namespace even if it does not have any commits

Here is a nice and short demonstration of that bug.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 t/t5509-fetch-push-namespaces.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index e3975bd21de..c89483fdba2 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -152,4 +152,13 @@ test_expect_success 'clone chooses correct HEAD (v2)' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'denyCurrentBranch and unborn branch with ref namespace' '
+	cd original &&
+	git init unborn &&
+	git remote add unborn-namespaced "ext::git --namespace=namespace %s unborn" &&
+	test_must_fail git push unborn-namespaced HEAD:master &&
+	test_config -C unborn receive.denyCurrentBranch updateInstead &&
+	git push unborn-namespaced HEAD:master
+'
+
 test_done
-- 
gitgitgadget

