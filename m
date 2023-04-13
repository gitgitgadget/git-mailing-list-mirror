Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642E7C77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjDML6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjDML5z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:57:55 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA3C9755
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:57:53 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-32a8a5681e0so17735ab.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681387072; x=1683979072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s42ck2SGJk+ERguLwEzDQQa9vxCoZOrv3UvRgGEFMfQ=;
        b=A+Nsu3E4GGAjiQ9gaxFtdqxFxb3fD9beQ4LbBN3SsIQP3YDAa2AmXi2q8g/UUXI+Xc
         d1hgJ+EAk9wD6kqXj39F1G5t67P+6136IqpR0q1lFFWbTaqu93Spv/DOCX28+b19AYrH
         KrYxvpXfbPVoW2lgSQADe3bGP0cJdZKSQh/ERCgV8igIkrZErQsWuUuhUxJS89fmYV9M
         1BHM17lVKWkvMtAm6hTBvlLrycSuhc+elbyAHpfxyoSOedTNPE6WGBzNsuargNnFxopF
         eQyjI7gLHgksC29vV+bd2gsQ76QVkppDl0gVFxNYPBCO8g6eOfTvrJX1Mb3R6HXFcz/D
         4Tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681387072; x=1683979072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s42ck2SGJk+ERguLwEzDQQa9vxCoZOrv3UvRgGEFMfQ=;
        b=Foxv/ulsdeshjVRspKTxugXrgm/vA0BW4eygg0gjmFPd5zoQNIPtPK+aZKBQWDLAjt
         muciNmDdA9iutpTK22q9dCTxBaYNl8vFVdqcKmSoubTprQjMrfkFPdpkMEA0R9v2wQhP
         qGMtQmUwfw8L6dOHYSuoTRwE8ETSO2wi1iJHC/JZUqLW7otWMxBAf1FXpcZdKzxk9Yjx
         Vok2lh6GDFqURk3aJZSnBet9gxVquXMPN0WkIvfAKUy110r2Qa+um5NVgL1XKr127n50
         y9MJi6ygF29NB9Dakba7Xu4F5PooWKKmt3pb/jWhDzXtEkQnyY5l2FfGDHH6FrdoKZxU
         /ZJw==
X-Gm-Message-State: AAQBX9etFUQaP7TqfWkP6IqxNHC2FTb1MhyZrdwzJ8S2n8xoyiHNB3QB
        UO2lcK9QIFUywaQ31AazV57E99RqZcY=
X-Google-Smtp-Source: AKy350buQaQ4LXdr6i1TSzLI4O4OaskKvM/xMjfUHF/mc+5N6N8Q4XerZElyaet3puvd3cAPmFr0ig==
X-Received: by 2002:a92:cc05:0:b0:326:2df9:3f18 with SMTP id s5-20020a92cc05000000b003262df93f18mr1180798ilp.20.1681387072413;
        Thu, 13 Apr 2023 04:57:52 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id w5-20020a056e0213e500b00326bd11f5d1sm420589ilj.11.2023.04.13.04.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:57:52 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Johnsen <chris_johnsen@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 04/12] test: doc: add test for docbook5
Date:   Thu, 13 Apr 2023 05:57:37 -0600
Message-Id: <20230413115745.116063-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230413115745.116063-1-felipe.contreras@gmail.com>
References: <20230413115745.116063-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was released 13 years ago and we still don't support it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t0600-doc-tools.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t0600-doc-tools.sh b/t/t0600-doc-tools.sh
index a80cd32cd6..e4388a54c6 100755
--- a/t/t0600-doc-tools.sh
+++ b/t/t0600-doc-tools.sh
@@ -61,7 +61,8 @@ xmltoman() {
 }
 
 build_asciidoc_py() {
-	asciidoc -f "$doc_dir/asciidoc.conf" -amanmanual='Git Manual' -amansource='Git 1.0.0' -arevdate='2005-01-01' -b docbook -d manpage \
+	backend=${2-docbook}
+	asciidoc -f "$doc_dir/asciidoc.conf" -amanmanual='Git Manual' -amansource='Git 1.0.0' -arevdate='2005-01-01' -b "$backend" -d manpage \
 		-o "$1.xml" "$1.txt" &&
 	xmltoman "$1"
 }
@@ -83,6 +84,11 @@ test_expect_success ASCIIDOC 'legacy asciidoc.py' '
 	check_manpage "git-foo"
 '
 
+test_expect_failure ASCIIDOC 'legacy asciidoc.py (docbook5)' '
+	build_asciidoc_py "git-foo" docbook5 &&
+	check_manpage "git-foo"
+'
+
 test_expect_success ASCIIDOCTOR 'modern asciidoctor (docbook5)' '
 	build_asciidoctor "git-foo" &&
 	check_manpage "git-foo"
-- 
2.40.0+fc1

