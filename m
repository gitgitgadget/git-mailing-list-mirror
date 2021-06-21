Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7BDC48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8F660C3F
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFURBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbhFURBF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:01:05 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CFBC0A8877
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:53 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id v11-20020a9d340b0000b0290455f7b8b1dcso5390054otb.7
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CNe4Tu/LfesvBcgPmg2eiXan5qxMAM7HUqGAMV1ctA0=;
        b=DbW7KixylDpBWeMPznYhxiYdlmLo2cxrCfl/7yv4Qrwv1jQ1b4P8cGEz6rfD2iocTl
         ajPmBiRJMIH10Pg76MvewzncTzHSD1ZA+37cskq0MYOoL4K31vUq4ex+a+7Iq3aa9jMW
         UV0wL+2YifuSu6dSKNC8pMfqi1P+RAOgmbT5Y43VXJW9TyCIAuc8v24h/+OFTI+VBgMf
         QJnMNUs60CoEjNiA/cyuPHo3KrFd8J4FeccdJmgn23/1ZDBujhuRmOZGmk6qtNnp+Ohs
         VF91VxHx0qApTnd+W9ApZYQUDXUG8d19nqJx5AUOlGVHpZ/xYSWJXLL2miq+/oRK5j5v
         8KGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNe4Tu/LfesvBcgPmg2eiXan5qxMAM7HUqGAMV1ctA0=;
        b=itbfsPHSe8Zj7E12ulAKVR0i3hMrpcw8ijwXTc+3JTr8O83bdELz7rjBk90V/HVZVa
         HBSrFqkCCS3adA7+wwnXLnKWiIP1eAgsKmUOwWRpyRNDpBFtkU4ePiuh9ZMSBLxl6IW5
         e7hHyZV9KbVY44NT+7BNE90pOkf0wu2O1zh6momJJYlkF9fxsDDOlscoKap8+58cEEZu
         mgwbWHa21KYwsRoVPQJUhL3ZGcWZfxD9VbzYgvd08ZUA5X0pKxkDPgkm9x9ugDnpOhRH
         3wuV9k4Y32t4GL51ogI/rCxGzXJwlisdELIwwnE5hhlP4J1sZWic+d05eE0aixYDCAgI
         0B4A==
X-Gm-Message-State: AOAM531MDZuURQeol1WZx9IiLvD+7S+PK0MVkKwgR2IDT7Wuc48jueP8
        Iy/tagSivYMUHPWCeW2teUkKuNBTIHKg0A==
X-Google-Smtp-Source: ABdhPJzg+gaUyyQkd1hrWu08s8Ce3V/yoVtwdJdqlEhYiaWQptX1ue9TrTl/IkUJgoUxqOG8WtBfNQ==
X-Received: by 2002:a9d:6303:: with SMTP id q3mr22085134otk.197.1624293113077;
        Mon, 21 Jun 2021 09:31:53 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id e10sm4053849otr.5.2021.06.21.09.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:52 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 16/23] doc-diff: support asciidoctor man pages
Date:   Mon, 21 Jun 2021 11:31:03 -0500
Message-Id: <20210621163110.1074145-17-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
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
 Documentation/doc-diff | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index 6b6bb444ac..bbfeaa213b 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -17,10 +17,13 @@ f			force rebuild; do not rely on cached results
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
 "
 SUBDIRECTORY_OK=1
 . "$(git --exec-path)/git-sh-setup"
@@ -53,6 +56,13 @@ do
 	--asciidoc)
 		from_program=-asciidoc
 		to_program=-asciidoc ;;
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
@@ -108,6 +118,10 @@ construct_makemanflags () {
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
2.32.0

