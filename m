Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E35C77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjDML5y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjDML5v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:57:51 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A70C26BC
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:57:50 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-32a249b416fso2533885ab.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681387069; x=1683979069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xes3FjJgCuGjh2JdFSJ6DWxb7d1pOy3wg+gVBpDfphc=;
        b=TqEpDI3auLtchLDfrDiR6HZM8q67UJZQ7RwXWxkVNMdtHgju5RsyiRkf9N8S39wXBm
         P2sXbd5ZTiwh4HCZbId5uTLZ6GGbu3wwbwkM30r+wRxdfarBa/pCQ1CSw9wk8oM78KtK
         M+IY6/SfV31B5HeAqZpsYXCzlDXXJhLQohE+VGv+FjlfZexH/01dVDJ/lcdrtGPv5+EE
         u8l4uMtwG2PQAd2LnOr416qe4aOToU3i1lFl8sNxTUfeOjltRnBjrPcbw59XW3QDnwbX
         o2hYpDQ4Wz6CsdQOXeu3MCUpX8Vp/05UMDl0qVBapg6IGqzB8nbfTzIevXMRFCa5Lw+f
         uHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681387069; x=1683979069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xes3FjJgCuGjh2JdFSJ6DWxb7d1pOy3wg+gVBpDfphc=;
        b=b6YG5hPEkQLHql1rOqgfKQLhFGaoyhGo+GlQYv72K3BexjddeaKWzYL+PzF9PSp5Mv
         n/01Y9EVEkEAOaBv9IpQHdw7lawAoqeRHWZZBDHEaiiFFQNa+A9xLPIFLkN+8ROLOKcT
         ZpwUYHTIJleO2ttX1MTZ/OXuJKzK2/amXv4vW/rKNxwP2JC9snWfnpGCuPGOJ8w/9oSP
         MEgusECf1p+KZ6x0s2URWlLHa1XQDGYmHzIeo0S0Xjkmm6/ENW/X5Td+Rktw3Hx0iA9A
         9sEC8C3KvA1f8iDTbpffBeCLzhV+p+ugZfLnR5gkgSUAaO8A24oqxOtGMZ8DqiTIIdWC
         NoYw==
X-Gm-Message-State: AAQBX9dieJ7pCr8p/OyDsYrcoLVaZ3xdpfeG7jN6NQhmDSvSYZ8mSU76
        4RuicdAyfomFbAmlbZ0Il9e3CiTsuPM=
X-Google-Smtp-Source: AKy350bWGCzun7WNHEyTURyOGS3KFhNNNOEoB4dQmADlSX7Z9yrdMmX0xXRgug1kiQARS67crGuLzA==
X-Received: by 2002:a92:c103:0:b0:329:5353:8575 with SMTP id p3-20020a92c103000000b0032953538575mr1397321ile.23.1681387069398;
        Thu, 13 Apr 2023 04:57:49 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id bt13-20020a056638430d00b0040907e6260asm413570jab.128.2023.04.13.04.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:57:48 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Johnsen <chris_johnsen@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 02/12] doc: add missing manpage docinfo
Date:   Thu, 13 Apr 2023 05:57:35 -0600
Message-Id: <20230413115745.116063-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230413115745.116063-1-felipe.contreras@gmail.com>
References: <20230413115745.116063-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can remove the whole hack, since asciidoc.py already does that
correctly since 2008.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoc.conf | 3 +++
 t/t0600-doc-tools.sh        | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 3e4c13971b..303d45dc34 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -56,6 +56,9 @@ ifdef::backend-docbook[]
 [header]
 template::[header-declarations]
 <refentry>
+<refentryinfo>
+template::[docinfo]
+</refentryinfo>
 <refmeta>
 <refentrytitle>{mantitle}</refentrytitle>
 <manvolnum>{manvolnum}</manvolnum>
diff --git a/t/t0600-doc-tools.sh b/t/t0600-doc-tools.sh
index 0f9a4053a9..db77db72e5 100755
--- a/t/t0600-doc-tools.sh
+++ b/t/t0600-doc-tools.sh
@@ -78,7 +78,7 @@ check_manpage() {
 	test_cmp "$1.1.expected" "$1.1.actual"
 }
 
-test_expect_failure ASCIIDOC 'legacy asciidoc.py' '
+test_expect_success ASCIIDOC 'legacy asciidoc.py' '
 	build_asciidoc_py "git-foo" &&
 	check_manpage "git-foo"
 '
-- 
2.40.0+fc1

