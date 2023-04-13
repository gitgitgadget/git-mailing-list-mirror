Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43ACC77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjDML6D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjDML6A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:58:00 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7391E93FA
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:57:54 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id e18so1068136iow.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681387074; x=1683979074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+K0odB5lKl+0QcPtLQzsfKOBZ3BKL/tEJx6vC5skB+I=;
        b=U6JIohdOvStLZzfMMfMvRYWW5xZu+WeE7wRyQiN2AmxxYQ7CZeXJy/m4KxUi8eH+V4
         M3Is00qijWbwKI0lhT6DP09703ZbilQPpUU/+RNWrJe2VicTMOPvqw9LEIXFA4miSsIm
         6gOrnrGNuaZlK2/05KToSXPLD3BVwhfupfd2zxb1wfKi8Hf6X5dftjGifqaR2S7HSSnY
         zMseEM9eD1tSAL7bhwf51kYiKjaIF2LJMY9aWR2oGFhSF5b4cledd1e5GN8Y4mzAdSZi
         xJXUpT6qdZUGfyalqqZQ27gMO9t58IgYQChlwIPZ9LXC/Zc9aA+XJt/q0o9WFOKp6B+l
         TS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681387074; x=1683979074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+K0odB5lKl+0QcPtLQzsfKOBZ3BKL/tEJx6vC5skB+I=;
        b=J/9+OH00h1CFGD9i0sPlNnoqpiy/CyOLfBQpjwjtJkyjDo+UhaiynR5AZNJ8Pp2VN8
         wmjFRfaaV/LdcWqPQ8OHxhOgD0DgSaAFAlOeTnGr1oLmpF/pbc8ifCKwBm/pCt4kDnV2
         qp5dtrkTsYnVCovTig1PhIoyhfv8wflkn2ird79tOGfbpqPCJ651ANmR4E18M3SUsepy
         R1C3c8LXIhD5+nEQne9m8fnTss31nlvB6wZ1z6f81jFqxU6kTThu138R9Gu6xXjch99v
         e/FzFpcC0Vulk5OX/E0UPIVCGEs7Xsur0vy83GwgMCSKeqit0CLdM8mU6ZY3idmfdNtH
         dDEQ==
X-Gm-Message-State: AAQBX9fkkZRKEKvz37UaR0zK2RNgNfH+Hq9BYqc8wphDl4bM/68CMxts
        tP1jVT3oKf6v3wffYRWTt6zAC9Bpemc=
X-Google-Smtp-Source: AKy350YBOIpk10tBtgTOlYyfWF9YP0BJzs2sRdhpvq8QlPLs3MfSYozpp4zid32VoibrS9RGlrvCIw==
X-Received: by 2002:a6b:d908:0:b0:753:476f:9ff4 with SMTP id r8-20020a6bd908000000b00753476f9ff4mr1039444ioc.3.1681387073847;
        Thu, 13 Apr 2023 04:57:53 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id x16-20020a056638249000b004061d6abcd1sm401393jat.162.2023.04.13.04.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:57:53 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Johnsen <chris_johnsen@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 05/12] doc: fix support for multiple docbook backends
Date:   Thu, 13 Apr 2023 05:57:38 -0600
Message-Id: <20230413115745.116063-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230413115745.116063-1-felipe.contreras@gmail.com>
References: <20230413115745.116063-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

docbook isn't a backend, but a famliy of backends.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoc.conf | 12 ++++++------
 t/t0600-doc-tools.sh        |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 303d45dc34..356b131870 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -22,15 +22,15 @@ apostrophe=&#39;
 backtick=&#96;
 litdd=&#45;&#45;
 
-ifdef::backend-docbook[]
+ifdef::basebackend-docbook[]
 [linkgit-inlinemacro]
 {0%{target}}
 {0#<citerefentry>}
 {0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
 {0#</citerefentry>}
-endif::backend-docbook[]
+endif::basebackend-docbook[]
 
-ifdef::backend-docbook[]
+ifdef::basebackend-docbook[]
 ifdef::doctype-manpage[]
 # The following two small workarounds insert a simple paragraph after screen
 [listingblock]
@@ -49,10 +49,10 @@ ifdef::doctype-manpage[]
 {title#}</para></formalpara>
 {title%}<simpara></simpara>
 endif::doctype-manpage[]
-endif::backend-docbook[]
+endif::basebackend-docbook[]
 
 ifdef::doctype-manpage[]
-ifdef::backend-docbook[]
+ifdef::basebackend-docbook[]
 [header]
 template::[header-declarations]
 <refentry>
@@ -70,7 +70,7 @@ template::[docinfo]
   <refname>{manname}</refname>
   <refpurpose>{manpurpose}</refpurpose>
 </refnamediv>
-endif::backend-docbook[]
+endif::basebackend-docbook[]
 endif::doctype-manpage[]
 
 ifdef::backend-xhtml11[]
diff --git a/t/t0600-doc-tools.sh b/t/t0600-doc-tools.sh
index e4388a54c6..2552b0d376 100755
--- a/t/t0600-doc-tools.sh
+++ b/t/t0600-doc-tools.sh
@@ -84,7 +84,7 @@ test_expect_success ASCIIDOC 'legacy asciidoc.py' '
 	check_manpage "git-foo"
 '
 
-test_expect_failure ASCIIDOC 'legacy asciidoc.py (docbook5)' '
+test_expect_success ASCIIDOC 'legacy asciidoc.py (docbook5)' '
 	build_asciidoc_py "git-foo" docbook5 &&
 	check_manpage "git-foo"
 '
-- 
2.40.0+fc1

