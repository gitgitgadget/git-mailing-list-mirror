Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8682C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A346142C
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhEYKuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 06:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhEYKts (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 06:49:48 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8096C061345
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:16 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t24so14339556oiw.3
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EmDs9Vqb5zhFDtU71E+DNwzSqZWSR1qVPgovOloFuMw=;
        b=e52JML0fiTDihhMfJljpg+XRr4AHBsvdRHHBuwcL/OcaisHdV2sL5uPoUTSWCKNNn6
         NWSiZmkgww+/eMYJi5S91OIOoN69q8LsBL5c7gTmaO16a6hzTo1P3LTEdv3Nx2yP0ivB
         i715palBnhK8mt3xVpGWVZ+T2WY+pgGovYbQCimGsU3GSIhcEu3SNwW8HT+jXzAyvWPu
         0NhmEP8pbBf9eWcTV/rxz+5WOU6CZexDXw4cyI/TSecql2XMQIe4VIzVFYc0zC3hSudh
         9aspOhsiR3p7gg0FpX8svksoqk1dVbIPLrF6+LPc9GGHiJJi21oMdHrKkWCueQblh9No
         PVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EmDs9Vqb5zhFDtU71E+DNwzSqZWSR1qVPgovOloFuMw=;
        b=uOzad7PqJMUDryFDkAis67Di3qm9vQ3jRcKD3A6okcEXnzB2k6IUcbHqYrDCQmxfXH
         a2h9rOBy27hLO59nhG9pJ/X4/nvhh5bt/TBCATK11wfkQMmk/b6RGK9M/AjMFh1IQFGM
         gAK9JvL8R2G6t0l4w38cYzxprKB6c/nFCUUdlEzQzPCE774XlyCL2akWZND7PPZNbiic
         k9Id8Af/nEuY55CZ+MFmbYZNaEFHUeWyrZnqwenwDEaxKqVRRpWMFHLIxYhOKmGQfww5
         i9E6kPz/6IcCHv+Elw4b8mxx6MIx9OWxdB7muO1Ot9WXA7q8aFmX8VO3A+hRtoEvbNJi
         iMOA==
X-Gm-Message-State: AOAM531VtNApLhSIns7Yesu8VuqSF9DiEm6ALynndvy+/NrOw8RKsunB
        1MJD81fk1uZr0Na0oFfrftBBGDm5nSuqzA==
X-Google-Smtp-Source: ABdhPJw/nd174Ziy2v+SJp4W6YP6imG7f5arFE9PtC5x9jRuSvmwMCmmvMkjAuZ86b04N6f5EG6v7w==
X-Received: by 2002:a54:4e81:: with SMTP id c1mr14294113oiy.119.1621939695967;
        Tue, 25 May 2021 03:48:15 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id v19sm3716569otk.22.2021.05.25.03.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:48:15 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 08/12] doc: asciidoctor: use html-prefix only for html
Date:   Tue, 25 May 2021 05:47:58 -0500
Message-Id: <20210525104802.158336-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210525104802.158336-1-felipe.contreras@gmail.com>
References: <20210525104802.158336-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is what asciidoc.conf does.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index f998a42249..c77b6de350 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -4,11 +4,11 @@ Asciidoctor::Extensions.register do
 
   inline_macro :linkgit do
     process do |parent, target, attrs|
-      prefix = parent.document.attr('git-relative-html-prefix')
       if parent.document.doctype == 'book'
-        "<ulink url=\"#{prefix}#{target}.html\">" \
+        "<ulink url=\"#{target}.html\">" \
         "#{target}(#{attrs[1]})</ulink>"
       elsif parent.document.basebackend? 'html'
+        prefix = parent.document.attr('git-relative-html-prefix')
         %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
       elsif parent.document.basebackend? 'docbook'
         "<citerefentry>\n" \
-- 
2.32.0.rc0

