Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941E7C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 04:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6452D20719
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 04:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLJZ/++D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgCZEhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 00:37:50 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:41765 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgCZEhu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 00:37:50 -0400
Received: by mail-pf1-f175.google.com with SMTP id z65so2165647pfz.8
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 21:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=59G8EJqdPdCXQu1bW2RtjXEIWnfC37lI1/5lFVAm+c0=;
        b=nLJZ/++DSZ3arioiQuxo8SfCmVj5ztmFeaKw03T/PQO5C3g8RWY+ftH362ryAkS2S2
         DpVaOHL/2TJK3vBwblLrhn/DwqyyL/jO9xAO9ebA51rpTUW3BdnO/lhDcqjjBlax4I07
         Yno83iIuB3XoZMdFG4FfZg7JFfj7PBjCAV8R2tykCxp8ka3LyX347BiQLZE7Jc2YMmQy
         i1xwM/CfBTl/x+J3PXPlDQXsSD+eTBz9ll3Yw+Dt1WeqvgMYe/JbW3KdUjRPYRCGI/cV
         H+wfmleH0bqgRj5ZbTiw6Ne7Aqtd3Y0tdpMlCjaTM2b3s6o2ElP8vT9HoqsWD1ELc9KY
         I7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59G8EJqdPdCXQu1bW2RtjXEIWnfC37lI1/5lFVAm+c0=;
        b=LT2dQ7TF+m9DbbgmVngXM6QM3b0cQwmGW9anDQ+U9PDm0gnoMMDEuwPQJirWR0WWW3
         sNMIrmvVzFsRc1X2cMECWQ0MQ7PFnmKClAB9oBwerF5Il/J/9ok8JX5hbbdAM2LW+aXK
         uqftEsZ6WPzaxBgumSndiv0J9gZoq4ljnLXNPS1mRxCxHj0XB0KEkZap1i1r9WcZC1u6
         PxHEQ1jyNIhOLNj/xBtKqyidQQ/fR0QcArJn3HNBfIMwCdJrPCii2Da/Hb4bF+Mz0ZV/
         oWyIck9pITBsJ6RHLP8ZxfC+O75G48xEBfiYsJkC0o7Ry4ZLx9HoNOmmcAc1zbLwTaBi
         AxiA==
X-Gm-Message-State: ANhLgQ2vYTTbidx3w8DZcWuTVY/7MBTSOKnhjrldqAG4p9B3GmQ7NWLb
        limzmw0BZWFm5kx1J1Ebw6jQSvdL
X-Google-Smtp-Source: ADFU+vtjKMHFhq0UM0UPkWRgJL1+qoYUABmbDlTX0MNWaJDcxg9YvINwwaWoMNK2+i1SFUs848n6+Q==
X-Received: by 2002:a63:f010:: with SMTP id k16mr6432800pgh.328.1585197468573;
        Wed, 25 Mar 2020 21:37:48 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id u21sm639344pjy.8.2020.03.25.21.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 21:37:48 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 1/8] t4061: use POSIX compliant regex(7)
Date:   Thu, 26 Mar 2020 11:37:31 +0700
Message-Id: <08839cac15fcb8452918563e0a9512975ba65b92.1585197360.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.357.g1e1ba0441d
In-Reply-To: <cover.1585197360.git.congdanhqx@gmail.com>
References: <cover.1584838148.git.congdanhqx@gmail.com> <cover.1585197360.git.congdanhqx@gmail.com>
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
2.26.0.rc2.357.g1e1ba0441d

