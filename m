Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03072C4332E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53E020754
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6/7gw9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgCVA4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 20:56:03 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:35403 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgCVA4C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 20:56:02 -0400
Received: by mail-pf1-f181.google.com with SMTP id u68so5509430pfb.2
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 17:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vx9MM0np547+VJB1b/JbwD5ErtmMbJfcaQa/9CDZtKA=;
        b=b6/7gw9hEcw5BmDxSeWVG/Vdz3DxaE+84E0FFWDKol4tHtlESr2N1QiXQW8hnitjJc
         PSA+EUzg2K77yT8OFlo4ipNOD7etjplHtqKZcE5LeUAAYORfgnWtk4eNyGvAeAkQXodt
         IvLAZSR9lFyF2Wma7t/OA0fDOaKOEpQnrQ37jem2Yk8RCxlq+8SRkQm1cO4BIOjt9znE
         VqA4jjaA+TKEJNQ1k9rLzTO/gj99cS3Y5Km3eN9DF0b8OxB9shpgJNrfmrNhg2wOX2xg
         lB5/kBch5eX3yTHa9lG48Nb8U2ApCgnlU4v4DLYyQZ1YZUpWYMG+FHeQwFxu/GskHKSM
         vfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vx9MM0np547+VJB1b/JbwD5ErtmMbJfcaQa/9CDZtKA=;
        b=hMPPQ9JYQvhPPr+jFD+L98PxgDrRj3XkM3Oo5G0dO9bvx6VDLCyX8xJLlQ9JYymKp+
         BM95HfZ3efYSkrfa74X+YFvxF63/WC1dOGNikoZfIZTIEw0vlNK7z0hk8su1zXRpl7mW
         gpwsU6MngJMT2Jv0xslnPnz/DQG8ja/Aj5PXGrVGpUp95yJGkrX4zPlqKyKgwIBZqI8F
         hMiZ06y39OKYh7F8DhClmM4UAYlZCPkcGIqmE9G9itVdBK4mVMifSg5x543PTUdA5eVT
         Ir0PeXPMtvujJO9Y5SoyKPSFB9yBG+gTRpEj+tkaaXpShCAyMbjvPMNhdPXm6AuOW0S5
         h3Fg==
X-Gm-Message-State: ANhLgQ2IoiV595TPsRInmhOb3MTCwAuKKN363ijnp/OYf8IKsbernQHa
        hoWA4pczwZYIeHtW2yVmmjbTaYmx
X-Google-Smtp-Source: ADFU+vsQVKCJSXcqEeOdv/B2RFK5SfP1gd9x3LYhqG13vsKYByz5AkNdWEIRyxBMD7AkMJ8uSVFV4Q==
X-Received: by 2002:aa7:95ae:: with SMTP id a14mr16625000pfk.164.1584838560758;
        Sat, 21 Mar 2020 17:56:00 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id r7sm9235641pfg.38.2020.03.21.17.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 17:56:00 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 1/8] t4061: use POSIX compliant regex(7)
Date:   Sun, 22 Mar 2020 07:55:11 +0700
Message-Id: <288e343d09dd375bbb61ba97858f518b431d0b1d.1584838148.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d
In-Reply-To: <cover.1584838148.git.congdanhqx@gmail.com>
References: <cover.1584838148.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

BRE interprets `+` literally, and
`\+` is undefined for POSIX BRE, from:
https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_03_02

> The interpretation of an ordinary character preceded
> by an unescaped <backslash> ( '\\' ) is undefined, except for:
> - The characters ')', '(', '{', and '}'
> - The digits 1 to 9 inclusive
> - A character inside a bracket expression

This test is failing with busybox sed, the default sed of Alpine Linux

We have 2 options here:

- Using literal `+` because BRE will interpret it as-is, or
- Using character class `[+]` to defend against a sed that expects ERE

ERE-expected sed is theoretical at this point,
but we haven't found it, yet.
And, we may run into other problems with that sed.
Let's go with first option and fix it later if that sed could be found.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t4061-diff-indent.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4061-diff-indent.sh b/t/t4061-diff-indent.sh
index 2affd7a100..0f7a6d97a8 100755
--- a/t/t4061-diff-indent.sh
+++ b/t/t4061-diff-indent.sh
@@ -17,7 +17,7 @@ compare_diff () {
 # Compare blame output using the expectation for a diff as reference.
 # Only look for the lines coming from non-boundary commits.
 compare_blame () {
-	sed -n -e "1,4d" -e "s/^\+//p" <"$1" >.tmp-1
+	sed -n -e "1,4d" -e "s/^+//p" <"$1" >.tmp-1
 	sed -ne "s/^[^^][^)]*) *//p" <"$2" >.tmp-2
 	test_cmp .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
 }
-- 
2.26.0.rc2.310.g2932bb562d

