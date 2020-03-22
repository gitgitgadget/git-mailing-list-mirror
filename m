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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58848C4332E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2702120754
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcZD9jEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgCVA4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 20:56:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36721 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgCVAz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 20:55:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2so4241158plo.3
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 17:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rkd8uyUmh0bMHjbwE3grOKlvj01CNcl+MQc1EDP3wcM=;
        b=CcZD9jEaif06juS8ey3DpQz6Xau8buFvfiOcNnTztqrY05Fq6qv1z3X8GbPf4KwUWF
         2VCIfzv2K4zyc+SpGCSp8gywD/779pZJ/b/OHxB8Zxr5UK2Q0/9bXQjYb9sTRK+ybQum
         2HkNMWk9pNIQhjR1U2NErBpRM7kHmeTgEbzSqnzDybGnNBnjyOn/3tbvxt5U/T4wb4ET
         qV0L35/+oS4SSmgEDmaBUftHh+rMsUJqEyd0BroxUBlJm/9XSOh7bDdwPgv6AVrDicYu
         n/UN5WMmxjNnCLeD2w0smz8lkiob5Hzab3S5DrytzRpOnzvbmmnkyB+WehKuyrb1w+s+
         dvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rkd8uyUmh0bMHjbwE3grOKlvj01CNcl+MQc1EDP3wcM=;
        b=Cn3Th6cXqyE70YW2X7JsUIMBk5CdqizQZoovNc4GFikfbqvqcYccjtGi2zUxE05wtX
         9g9XZFC/w1zSa3zOiIDq3+rL+iDwMqm5Ry/Ek0R821Nm3tUJXffRLBYR7VSIo0zk7LNm
         Yh4norWUC2hOebOBV/fI3G4wu4KtDprWoTpYXBfuEENeaL7A6mpFfF9FB1xDxtpJ3ml5
         g4bgWzQlAZMBiFhkiIh5NORyhrbRYlbFicx7ZCDJqwUlDWrVeCC1Pew0JrljNLInhCT4
         ueCI/ObgKBXE9CmF70xZt2OqE7LKsVit3mkO1BWDiDNd6GyJi6EaTlqIWG+afqQ6c1GM
         5YmQ==
X-Gm-Message-State: ANhLgQ2Hyik3AYzEeoe1OOxdIM1hG3XwrjS3ZwNGAKDWoV/Ngv/DAQed
        EDJuSdG+FCQ8f+oWdL5OKP0JCMGD
X-Google-Smtp-Source: ADFU+vtAf5ZM93KwWm1uF/uC6imRWRmo52Nfj8CHo6inf88DR3dMoYeqNZnWYrmWt+Jf5LnFUahmSA==
X-Received: by 2002:a17:90a:368f:: with SMTP id t15mr17982257pjb.23.1584838558590;
        Sat, 21 Mar 2020 17:55:58 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id r7sm9235641pfg.38.2020.03.21.17.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 17:55:58 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 1/6] t4061: use POSIX compliance regex(7)
Date:   Sun, 22 Mar 2020 07:55:10 +0700
Message-Id: <4830bd3aaf6cadc02c00732f8447646064a6ae3e.1584838133.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d
In-Reply-To: <cover.1584838133.git.congdanhqx@gmail.com>
References: <cover.1584838133.git.congdanhqx@gmail.com>
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

Fix it by using literal `+` instead.

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

