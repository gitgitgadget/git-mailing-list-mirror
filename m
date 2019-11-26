Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EFEC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DBC2068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVaKgPDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfKZBSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:18:14 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:46653 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKZBSO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:18:14 -0500
Received: by mail-pj1-f67.google.com with SMTP id a16so7448735pjs.13
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s+25cXUitbRIILBQxNigN1bTyahqYM675wyaEPunVdE=;
        b=RVaKgPDtRTmHs9Zrj23B7C4awnGnnTRAUDtUqwK7yEZggSTeOa5YnVe7cphRitbZ+3
         kelKfV0eBJAPfOFzwUGrfEX0FUStsj82/8KE1Nq11+ufwVCKYT/TzymQlbij8GLu3JU6
         W8JwPHyo69zTrUF6FaExDfPILaCGIEombD7zgI1jdRWvned8qcz8myQzIZECNoBhPj+N
         +AM7g/kuIUpqOEy752kTLdTB9BzxMySv7yMTIz6wJUgRAg5LiTg0rUPW8JBeUGGUW+/p
         eeO22N8ZZtxbVyvWKplBUXhtrj6WoL0Kq1+mEcz8eGldizfS2Zh0xwzalwZC1MUE9PVM
         TbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s+25cXUitbRIILBQxNigN1bTyahqYM675wyaEPunVdE=;
        b=skFCzFNCSwREkSHdcFePhp9AOoTV6xy3z/H+Ny29vRGHwGpAW19Yb01y969eaJXPAN
         V6r9ePAh2Qfgpn9PpenoY0dEhovghPzoAY51Es2Wx+F106DA9NnfDP1VGnuXezuYc7FK
         UOG4InTNBQxmZSynshIBHJb2Zcb6JmqlaJx7gmC7tG0ljrSn9/b9DIHAG9nd8w7d+V8h
         anaFHOoXt9hd4AmVW661fvDuZ28tToq50HCxB0MADzjVFtp/J9S5AEcQXjnHo2TpL4Tb
         8VF6tdioBj9QB6qboswXL2c99jRdEKwlnvgdVQH4r+Ju4aGU1HI0RzMeRbNO+7V0N8mR
         MILQ==
X-Gm-Message-State: APjAAAXFezR9xmjUq5ocWKALpDiHnlJIr+Lvi/yh98qSp9epgLyevG4q
        3kGlpqe6eJlZyDSCS/nXpFBb1JZn
X-Google-Smtp-Source: APXvYqzgcAjOtel/WNoWpWkcCnD7cDHtADvSL9coYKhlDzPnt5RkTtkBkg1dEVkULSp8hYpghiqUUA==
X-Received: by 2002:a17:90a:195e:: with SMTP id 30mr2869813pjh.60.1574731093205;
        Mon, 25 Nov 2019 17:18:13 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id p16sm10245455pfn.171.2019.11.25.17.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:18:12 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:18:11 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 11/27] t4138: stop losing return codes of git commands
Message-ID: <d512319be0f3a19cafb696ca9f6f2ccb7d0b8e85.1574731022.git.liu.denton@gmail.com>
References: <cover.1574449072.git.liu.denton@gmail.com>
 <cover.1574731022.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574731022.git.liu.denton@gmail.com>
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
2.24.0.504.g3cd56eb17d

