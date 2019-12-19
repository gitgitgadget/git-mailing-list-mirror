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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E86FC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9312467B
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyUKS9wj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfLSWVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:21:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35971 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfLSWVp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:21:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id x184so4084727pfb.3
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p2ArS+YljEb7t4oUKI+NSVa4SXdQS2+gUCxgbp6aCbE=;
        b=IyUKS9wjqdoPmeVCKsufEaFsRxVk4dnB5t+pctJL6BnOEyrqoDrJeELRoolNtX4lq2
         LIl5n5Xi2kkrUIyMz+DK9d12VqRujgHLngcosCOwY7ccg1zdc2t+Xz6tGwLfyt8NDW6j
         zi8lFelLHDSW5sgXhydTUp72jTRwcoppbq+Zv7ZjxVAjHwb9KI4xeG0kVauCcgWeQPN3
         CTw/Z52q4kRYL/UVyJ+xn4EuVpTsVgevWLm3qUPI7FtzW3OXzl8rIvl1L7p2WPJ/AcUJ
         844rlYySmp8fCQtmhZns1XK3wEGsC1yfJZYDuKZhpwbiWjUCSmcOvSINh02kBx2f5wdu
         LH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p2ArS+YljEb7t4oUKI+NSVa4SXdQS2+gUCxgbp6aCbE=;
        b=d2sBsyVw4fBmslQSK7Cg3POiH9lFd8FoSjhiH1x3VRQLfFuoR+enzHWSrhd+LFX+up
         Z3LozrNaQfwjlnRzT+AogiqIgi10ZJg6sbqikE1nMHVcq/Lrh86QXAzSXcQwYAWVnSkK
         tbCx6kbk8BDHlV9rMXx8VI+ofbEXn+CexnK/V54zEXFKsdS7wunQlu8IKEOxa/bevjQp
         HBc8PglzhJ1fbi7AqMNUeBCgIoDdK1BKxMGcNa5jcJE5W0uO2Oxp6C7WylZ2wTlILoL3
         3ert6M9SOwp/dyMbuam554KSNFKltJOvwu8Frm9N3Tb23eEMSCP/lZnPUSjY6oKNgmvw
         wbyw==
X-Gm-Message-State: APjAAAXVBb2F884M3fo7B3qQN5GQmp4xQmtFrBw4ROP5qZFmEBWiad8s
        ox9beZ5PteNGVP79jEJNqkmK72we
X-Google-Smtp-Source: APXvYqzNy9PGTOVIEVwNI3/j854q5XTz4UZ7EDFwq0d4QM6sLiWYSqK48xz3FL3Jnlt69RgKWDPFeg==
X-Received: by 2002:a65:56c6:: with SMTP id w6mr11764226pgs.167.1576794104553;
        Thu, 19 Dec 2019 14:21:44 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id o19sm11428528pjr.2.2019.12.19.14.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 14:21:44 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/16] t1409: let sed open its own input file
Date:   Thu, 19 Dec 2019 14:22:46 -0800
Message-Id: <d57dfe95e2ace0b543ddb4fba6f9c14cac5f02fc.1576794144.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576794144.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com> <cover.1576794144.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In one case, we were using a redirection operator to feed input into
sed. However, since sed is capable of opening its own input file, make
sed do that instead of redirecting input into it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1409-avoid-packing-refs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index c46848eb8e..f74d890e82 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -8,7 +8,7 @@ test_description='avoid rewriting packed-refs unnecessarily'
 # shouldn't upset readers, and it should be omitted if the file is
 # ever rewritten.
 mark_packed_refs () {
-	sed -e "s/^\(#.*\)/\1 t1409 /" <.git/packed-refs >.git/packed-refs.new &&
+	sed -e "s/^\(#.*\)/\1 t1409 /" .git/packed-refs >.git/packed-refs.new &&
 	mv .git/packed-refs.new .git/packed-refs
 }
 
-- 
2.24.1.703.g2f499f1283

