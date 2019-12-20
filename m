Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBD3C2D0D2
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88EE2082E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEsNpkTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfLTSOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:14:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41607 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfLTSOn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:14:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id w62so5624944pfw.8
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p2ArS+YljEb7t4oUKI+NSVa4SXdQS2+gUCxgbp6aCbE=;
        b=KEsNpkTgifh4tvM8wkp4etAZoBlKRDAgbIOk4+1avclblflOfGmNaz0klEJFa0dXXr
         /AO/ZWJhaCr8OuHAMbUiQIVYOReN1vO2gAT8q3oH2lwLygLma2MeitYuMjyFxZ+ZpFJq
         Lyklm6fF1Mfri/74Saa4ggiU/M9Qt/cMfyLB4q4v/3J+o6xD6leQgIL2Rcl7d17vSY6o
         Ge1qcPj7O07OdoIX8uHrG8B2ZAlvtT9jASUE9OQ/bEFevDTNu4WI6ZyFVezTzLWSwmX9
         xdro6Rr2Dsiz389Chmyiz56RK5PPpBHStpQka2D4pVOwAM7lnyNms4fZNrp4BDlubBmz
         KesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p2ArS+YljEb7t4oUKI+NSVa4SXdQS2+gUCxgbp6aCbE=;
        b=iSxQkoX5RqpHTnfX2+vK3d9XzrN0eetzvWJ7+ahDvecsrRabtrR6ghlvnGDllbl7yq
         4kNBTash8iKhv59izUqiqPwQRsFrS2mZjOarAKPkqrYIRcd7S67Z9xw9Ts6mDsLa78Gn
         IvhxgBFmUgLCF2eeP91xF6Natwp+lune+LwgQBKVg84UZpJhpwok0TjC5ee7rBOhOi8n
         hKhNs/syv6htxax/vB2c7PfkglFlSJXjbES2TLjc/OpWfgfF+VaYFKpxRigNf12G4ZtZ
         uF34A52Ci7q7J+f/xogzr8AgtmXDYgLWFl50MDjCwCd/Gc4apf2SaVO9RF/KqU1FR/ze
         f4kQ==
X-Gm-Message-State: APjAAAUlm4FiDGujqPSY2AZcVUQc2w3yqQB6yZyCDXAoHrNJ/95qMZ8A
        hcYOVgrPf09ApZpdDFS0wmEpnUrS
X-Google-Smtp-Source: APXvYqxH4oXHosAO4wCjIlX+hNdeku/s9j/sm1GuvelTZY2Kn1itnaPM4GELWBKWYy04l5/iwRPBAg==
X-Received: by 2002:a62:8f8f:: with SMTP id n137mr4469540pfd.82.1576865682864;
        Fri, 20 Dec 2019 10:14:42 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id c78sm14063082pfb.122.2019.12.20.10.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:14:42 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/15] t1409: let sed open its own input file
Date:   Fri, 20 Dec 2019 10:15:57 -0800
Message-Id: <e2fe278bfabc802681eb1c6325d54c4af4bfec8e.1576865664.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576865663.git.liu.denton@gmail.com>
References: <cover.1576794144.git.liu.denton@gmail.com> <cover.1576865663.git.liu.denton@gmail.com>
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

