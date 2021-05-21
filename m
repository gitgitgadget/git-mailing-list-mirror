Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B31C4707A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75AAA613D8
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhEUWq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhEUWq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:46:26 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCBEC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:45:02 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id c196so12924403oib.9
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+hZftNoe2wSMaXMca7VYcDt5EqtKBAdkp7dgFYAHy4k=;
        b=NIjw0sGJy0QAdxMdl5UtTyRMWhyO+uiC7f2v8M2QEN+8/ls5pjoKfiEGpTRaWKgmNV
         mkPjP56p2t95GYA8vgg9uMP9OIfj3J7YFbR2aVU5Fs+u8ZCMnrzvyYQK1Jq2jtSRlTY/
         ShbkpIhN9labKLVT8IuLVEHM4d0eCJxuKrvXdndPNOKTm/73nqQZwB9Ri65My9KGuRmX
         l2VPO8b/93eRzrzZt++aPgpiC1NI8Mjqy1dTh8nsBikYmDZVIpvviMzqQh5S5XHaQtQy
         NMn3LRoDKm4sF5TncnlB+NJmvhBYUFFMEUZYBiQ7mNvK4wHzCDbNWmLltOSeFf0wDF6Q
         NazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+hZftNoe2wSMaXMca7VYcDt5EqtKBAdkp7dgFYAHy4k=;
        b=MnyUI3XQ0VJj+WXOAUjUT/DGZgAFIluB13H9NqFukIC5dFM3oXiE/XcowiETrPlpRz
         uaVQSwXhs9C+PPOwAtmF7JMu3kfCURixqeB4C8zruMcSoT68t9K354ey1bJe07PUt1+2
         LEoQs99+DCcirvV8U1p+5fqZYxLdgDHwxLcyj98wfhGrBy9xmraxtFOHYDXAAgincJRZ
         oX2Rzx2awt3xcfyF/rdJy8k+cZggwFDRAgCRaiTdOzHW0mWRIwUg4rfVtHeTxfY2hyjX
         FEJi8XlGFndpJN0Z7NjnwLkYeqUPnejhxhjS7srrnbTROJNKfQmwCrNorgaO1Rvyq8MK
         qkNg==
X-Gm-Message-State: AOAM530ZI0Sw9yV9vsnAtG/3gvtCTIXjvnna4uMYXlw0N54bz4k7Rddk
        ELa4ZoqqRa0mLAt3eS4N9cmLCSp3LIQ4vQ==
X-Google-Smtp-Source: ABdhPJzfs7WnxzWQOIMGIE6Mvl9kJeRTvnYm97NmVbup2m1ObBo5gHytDpGy7jRgz4AEJPNTPJBDig==
X-Received: by 2002:a05:6808:317:: with SMTP id i23mr3858888oie.50.1621637101745;
        Fri, 21 May 2021 15:45:01 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id x14sm1416704oic.3.2021.05.21.15.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:45:01 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 04/11] doc-diff: support asciidoctor man pages
Date:   Fri, 21 May 2021 17:44:45 -0500
Message-Id: <20210521224452.530852-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521224452.530852-1-felipe.contreras@gmail.com>
References: <20210521224452.530852-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

The new option enables both asciidoctor as well as its direct-to-manpage
mode that skips xmlto. This lets you view the rendered difference
between the two pipelines with something like:

  ./doc-diff --from-asciidoctor --to-asciidoctor-direct HEAD HEAD

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/doc-diff | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index 6b6bb444ac..52cf639f4d 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -17,10 +17,14 @@ f			force rebuild; do not rely on cached results
 c,clean			cleanup temporary working files
 from-asciidoc		use asciidoc with the 'from'-commit
 from-asciidoctor	use asciidoctor with the 'from'-commit
+from-asciidoctor-direct use asciidoctor without xmlto for 'from'-commit
 asciidoc		use asciidoc with both commits
 to-asciidoc		use asciidoc with the 'to'-commit
 to-asciidoctor		use asciidoctor with the 'to'-commit
+to-asciidoctor-direct   use asciidoctor without xmlto for 'to'-commit
 asciidoctor		use asciidoctor with both commits
+asciidoctor-direct      use asciidoctor without xml for both commits
+cut-footer		cut away footer
 "
 SUBDIRECTORY_OK=1
 . "$(git --exec-path)/git-sh-setup"
@@ -53,6 +57,15 @@ do
 	--asciidoc)
 		from_program=-asciidoc
 		to_program=-asciidoc ;;
+	--cut-footer)
+		cut_footer=-cut-footer ;;
+	--from-asciidoctor-direct)
+		from_program=-asciidoctor-direct ;;
+	--to-asciidoctor-direct)
+		to_program=-asciidoctor-direct ;;
+	--asciidoctor-direct)
+		from_program=-asciidoctor-direct
+		to_program=-asciidoctor-direct ;;
 	--)
 		shift; break ;;
 	*)
@@ -108,6 +121,10 @@ construct_makemanflags () {
 	elif test "$1" = "-asciidoctor"
 	then
 		echo USE_ASCIIDOCTOR=YesPlease ASCIIDOC_FLAGS='-adocdate="01/01/1970"'
+	elif test "$1" = "-asciidoctor-direct"
+	then
+		echo USE_ASCIIDOCTOR=YesPlease ASCIIDOC_FLAGS='-adocdate="01/01/1970"'
+		echo USE_ASCIIDOCTOR_MANPAGE=YesPlease
 	fi
 }
 
-- 
2.32.0.rc0

