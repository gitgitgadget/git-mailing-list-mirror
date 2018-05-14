Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62E381F406
	for <e@80x24.org>; Mon, 14 May 2018 21:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeENV4v (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:56:51 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:45522 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbeENV4u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:56:50 -0400
Received: by mail-qt0-f202.google.com with SMTP id f1-v6so16650873qtm.12
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=O/QCmjjSzfmlnvUNnhoTYqgXGCk9LItm1+jDgUXeEPQ=;
        b=B3ZEVfm1ZTiTYwuBXOA/Rf4zlYBWPVe4DW+gtBMvNwgmiX2GRjFVUSlxeVxMipg6oZ
         nM2IQ1MEbZWjyDwTzDaM0s73D+3v5YaqTVPEXgYjcCALCLxGEKKphjkwnw1h1KrkCaAP
         XNS3Nhe7eERTRhnUhPtxOm5wTan9olTCSwDT8DrUyQ7Tc2/8B+hD74CuGeEbiOorbroa
         rF7KUc+V0ZSPGssykm5SC42L3ZN1lI4bxkuOWKzj8sG13a1VB3a+U5lH2QENmAyNZFS9
         T/iqBI4fp94tYlgwe2njR87dm8+QauzNg9YRw5/1pBdtkcNe8MjrozcqU8dLpRuFNoSe
         +mWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=O/QCmjjSzfmlnvUNnhoTYqgXGCk9LItm1+jDgUXeEPQ=;
        b=cxqECDTudiw/YzDGyA4heDVxH4epcxmgxjDrFL1+YC90a2v6wYUNZPzzXu9ScOQOIg
         0vwtbEA7rZkLEDSfxiGpH8ZaFRMct28KhLtnb+fS1oTPV/ioANlu06x8mp9KhA48V4S3
         L+WZiyyJMcquLhtMdsKD1Ym2svg4e/dvqC434AXBkrDs6vI+o3jDEeV//BKvFh7I7ywG
         pGx1QXuAJmL4YQ+31BTxSwhG6JJAUGFPLk7KfjO9DtaUxMRn9VjHGBrMA9RSON2+1bOr
         8v5ev+lfvRQMgcjouUPC/vI76a+IH14Uv6Bl67l88r+QbKutkW9JnlVOqao/A+0Q7SdK
         DkHQ==
X-Gm-Message-State: ALKqPwcSOa3LVQ3/3QsP7uuzLWcBYm0SmkKtIUhcHbrMTniFDQAG7a00
        Q/ypus2AKc3xuEr6Oo358JbZZfMucQZS2JkFSnmhb6odcGB+oDu8cL8o8PVqvuEAR2I6qbppODK
        tUxt5driNeKqHErrrFTctjjcm7eAQVm6UaUcsNBgAar9fJhvzhjQ/J6KgEw==
X-Google-Smtp-Source: AB8JxZoOxbmip5L+LMNjk9BBRNpYcLQ/CGo1GJ6MEtoFTxMcU7l/+QyuXekJnZWkCC4shaSR73OcAooCHHY=
MIME-Version: 1.0
X-Received: by 2002:a0c:b504:: with SMTP id d4-v6mr17978537qve.7.1526335009349;
 Mon, 14 May 2018 14:56:49 -0700 (PDT)
Date:   Mon, 14 May 2018 14:55:56 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-6-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 05/35] refspec: convert valid_fetch_refspec to use parse_refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'valid_fetch_refspec()' to use the new 'parse_refspec()'
function to only parse a single refspec an eliminate an allocation.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 refspec.c | 17 ++++++++---------
 refspec.h |  3 ++-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/refspec.c b/refspec.c
index 2b898c922..98c99cd84 100644
--- a/refspec.c
+++ b/refspec.c
@@ -146,15 +146,6 @@ static struct refspec_item *parse_refspec_internal(int nr_refspec, const char **
 	die("Invalid refspec '%s'", refspec[i]);
 }
 
-int valid_fetch_refspec(const char *fetch_refspec_str)
-{
-	struct refspec_item *refspec;
-
-	refspec = parse_refspec_internal(1, &fetch_refspec_str, 1, 1);
-	free_refspec(1, refspec);
-	return !!refspec;
-}
-
 struct refspec_item *parse_fetch_refspec(int nr_refspec, const char **refspec)
 {
 	return parse_refspec_internal(nr_refspec, refspec, 1, 0);
@@ -242,3 +233,11 @@ void refspec_clear(struct refspec *rs)
 
 	rs->fetch = 0;
 }
+
+int valid_fetch_refspec(const char *fetch_refspec_str)
+{
+	struct refspec_item refspec;
+	int ret = parse_refspec(&refspec, fetch_refspec_str, REFSPEC_FETCH);
+	refspec_item_clear(&refspec);
+	return ret;
+}
diff --git a/refspec.h b/refspec.h
index f6fb251f3..b009440c0 100644
--- a/refspec.h
+++ b/refspec.h
@@ -14,7 +14,6 @@ struct refspec_item {
 	char *dst;
 };
 
-int valid_fetch_refspec(const char *refspec);
 struct refspec_item *parse_fetch_refspec(int nr_refspec, const char **refspec);
 struct refspec_item *parse_push_refspec(int nr_refspec, const char **refspec);
 
@@ -45,4 +44,6 @@ void refspec_append(struct refspec *rs, const char *refspec);
 void refspec_appendn(struct refspec *rs, const char **refspecs, int nr);
 void refspec_clear(struct refspec *rs);
 
+int valid_fetch_refspec(const char *refspec);
+
 #endif /* REFSPEC_H */
-- 
2.17.0.441.gb46fe60e1d-goog

