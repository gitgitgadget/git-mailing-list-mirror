Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39A5C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC4420855
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK9oMJor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfKUAqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:46:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41647 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfKUAqN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:46:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id t8so602687plr.8
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 16:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/jF96UBCj1jwkog11fgqYrfIDZIeYYAz+Exl0oj/OOY=;
        b=dK9oMJor1JB9tQRd/PW1ovFLtzXKuXN3OFzVb+lQtdqtROMNJpjsTEVcrlC9VFV48B
         /QVqVA59+lhgMUzrBbqGD71eI9EekqEqmAaIzaz+TlX/id0auFh9+4boD/cxaWdjbLtF
         B0L45MpSerDkxR3vyLlcVoWWuIbJfzZHlpnWNVwu00QaWRebkfMvyrBsdwhmOKeIFswE
         PMRFCjt3Tw8hoWnuYtGkELmxbWuyPnd2wWmjsSxWQXFmVh+4HHNgm0/T6+RVaElSUAfV
         9foYaVLSkuQ9OVzk1qQt6oHa/nyVwJrfQ+TPvuPlRomekpuWhZNfhZ0wX2XALoMCjv1M
         bJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/jF96UBCj1jwkog11fgqYrfIDZIeYYAz+Exl0oj/OOY=;
        b=RBlEal46CEGw4YJa7rMhIN4olsbuuykbsWzHQH/6aWwFELIWa/lpbeV52GzkPQlH8a
         5+cxt0BGB1Llnrz6cfb+OMnOmmM6AWTi08r+kC/r4hfITlbNNRwKji5w+VW+u/7irMzu
         J1561reVo4s+EtyxskFlAGtYFTREiTlzoIfbZiixAf6MeEwAKW84IZhFQ74D9ibQTWas
         ZQIS11nHaTSwafTomEegZGE6Uu1Hnv24xWzJ9DOWRe9PSC4zL0bVR68pPthXg3W9xf6k
         rPgD3DtKcBmQUJy9G/MkZcPWCtfP7NmD+2zheiuXrXoSjke8TlMTWUBS/ZFJDj6xz5MF
         ZKxQ==
X-Gm-Message-State: APjAAAUTmVdQpiWNCU7SCvXxyVTiw2ec57KBDRK/3OMEdzmKIC6K2/tn
        Cpfg2lHsPRXb18JMQbvhQCBTnSXo
X-Google-Smtp-Source: APXvYqyZJWjwJShbwTW8w4c5N5GQCjcXSqgB6VaFfPg6m+/D6qFWB0q8Ggh33wITBM47up03PK2q5A==
X-Received: by 2002:a17:90a:d78b:: with SMTP id z11mr7710122pju.36.1574297172350;
        Wed, 20 Nov 2019 16:46:12 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id m65sm7825951pje.3.2019.11.20.16.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:46:11 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:46:10 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 10/21] t4138: stop losing return codes of git commands
Message-ID: <6c91594492e0be4b7ae7638e964f610534a170ca.1574296987.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
 <cover.1574296987.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574296987.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a pipe, only the return code of the last command is used. Thus, all
other commands will have their return codes masked. Rewrite pipes so
that there are no git commands upstream so that we will know if a
command fails.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4138-apply-ws-expansion.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t4138-apply-ws-expansion.sh b/t/t4138-apply-ws-expansion.sh
index 3b636a63a3..b19faeb67a 100755
--- a/t/t4138-apply-ws-expansion.sh
+++ b/t/t4138-apply-ws-expansion.sh
@@ -17,8 +17,8 @@ test_expect_success setup '
 	printf "\t%s\n" 1 2 3 >after &&
 	printf "%64s\n" a b c >>after &&
 	printf "\t%s\n" 4 5 6 >>after &&
-	git diff --no-index before after |
-		sed -e "s/before/test-1/" -e "s/after/test-1/" >patch1.patch &&
+	test_expect_code 1 git diff --no-index before after >patch1.patch.raw &&
+	sed -e "s/before/test-1/" -e "s/after/test-1/" patch1.patch.raw >patch1.patch &&
 	printf "%64s\n" 1 2 3 4 5 6 >test-1 &&
 	printf "%64s\n" 1 2 3 a b c 4 5 6 >expect-1 &&
 
@@ -33,8 +33,8 @@ test_expect_success setup '
 		x=$(( $x + 1 ))
 	done &&
 	printf "\t%s\n" d e f >>after &&
-	git diff --no-index before after |
-		sed -e "s/before/test-2/" -e "s/after/test-2/" >patch2.patch &&
+	test_expect_code 1 git diff --no-index before after >patch2.patch.raw &&
+	sed -e "s/before/test-2/" -e "s/after/test-2/" patch2.patch.raw >patch2.patch &&
 	printf "%64s\n" a b c d e f >test-2 &&
 	printf "%64s\n" a b c >expect-2 &&
 	x=1 &&
@@ -56,8 +56,8 @@ test_expect_success setup '
 		x=$(( $x + 1 ))
 	done &&
 	printf "\t%s\n" d e f >>after &&
-	git diff --no-index before after |
-	sed -e "s/before/test-3/" -e "s/after/test-3/" >patch3.patch &&
+	test_expect_code 1 git diff --no-index before after >patch3.patch.raw &&
+	sed -e "s/before/test-3/" -e "s/after/test-3/" patch3.patch.raw >patch3.patch &&
 	printf "%64s\n" a b c d e f >test-3 &&
 	printf "%64s\n" a b c >expect-3 &&
 	x=0 &&
@@ -84,8 +84,8 @@ test_expect_success setup '
 		printf "\t%02d\n" $x >>after
 		x=$(( $x + 1 ))
 	done &&
-	git diff --no-index before after |
-	sed -e "s/before/test-4/" -e "s/after/test-4/" >patch4.patch &&
+	test_expect_code 1 git diff --no-index before after >patch4.patch.raw &&
+	sed -e "s/before/test-4/" -e "s/after/test-4/" patch4.patch.raw >patch4.patch &&
 	>test-4 &&
 	x=0 &&
 	while test $x -lt 50
-- 
2.24.0.450.g7a9a4598a9

