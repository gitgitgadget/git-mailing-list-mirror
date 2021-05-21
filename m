Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7C9C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E858613D8
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhEUWqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhEUWqe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:46:34 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFC3C0613CE
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:45:09 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id j75so21076792oih.10
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ah1uZyMfekda9/51uIF9gClbdy4GBKNVOInO4OL5mhY=;
        b=ScCHMcafpRko3KSNpTfqVr7e71VxPXmbH/l9eblLMdnfHrgjN3Cb/RQS0HFcBLM5Ep
         hEt8cS1wQTbOvExsw7fBWBcWguNJw/9JR0/GNtVmdsG112k8tguI9TmVp6FYRdfHbs4B
         lFw1MJ2ekvEGc2JXRb02NT/Louj4mkjBXenS94VOyciWVgy9b6otvnVux+T8EkR5mQUL
         0hXt1OqbeRTAdth5qCxmHRlpbZWp+KMSaX46RIZWKwa3MGpFI2gJuBlPgl6sZB50P1xl
         XKtrw/afvYjE9yhYPm/6Z2zgH8QEmnxth6L5oF5Z04WLaSs51uETLPqQqkO4/KnY9EVm
         h88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ah1uZyMfekda9/51uIF9gClbdy4GBKNVOInO4OL5mhY=;
        b=E1qJE+4St65XbFJ1hC/CsBi/POxrIopUOxuL0tem7TXDIjzNBICARmq6fgoyynnA6+
         muDGdNcT8VlEJZF/NTiJDIZOTyku1Gm+uN3OnUHZkvyICG5E5heZ+JyZJAhhhpiTGS3A
         Bsc54Gi6c8+En5TV+7ImBC76UJCdGPBDpmMtoDBIBPA6s3CVKalV7Rof9P/NFEaDXYHl
         msX9SK2oMaIcGz+YsJLcm3VkfXp9u1UQjLHQ97Zp1JHiPR+OFw+idfa69DYR7ivYdJCg
         rrmezWiWf44zcbQuf7aSe9+VoedttrLna41WWB1VY1ZcA5kjhb+KWC9iGdKXhl7Lm5U4
         kTRw==
X-Gm-Message-State: AOAM530JImstiw56OvSNebF/ouJCDPdRS0VblEOvWBU15udZl0YFEpwp
        VrrIyT/Q1oPH5166xlAHmLjCetTcD+H4jA==
X-Google-Smtp-Source: ABdhPJyzHYK6Zhq5vA9+HwXhiaRKAWbVvwRV69HuhqXal5dPhvBaUsAJPR98W/EY2HFFBqdtw/7P8Q==
X-Received: by 2002:aca:1718:: with SMTP id j24mr3679150oii.81.1621637109024;
        Fri, 21 May 2021 15:45:09 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id v28sm1495945ood.27.2021.05.21.15.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:45:08 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 08/11] doc: asciidoctor: add hack to improve links
Date:   Fri, 21 May 2021 17:44:49 -0500
Message-Id: <20210521224452.530852-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521224452.530852-1-felipe.contreras@gmail.com>
References: <20210521224452.530852-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The way asciidoctor handles links is very primitive compared to docbook.
Links are simply presented in the format "#{text} <#{target}>", which
may not be all that bad for the future, but pollutes the doc-diff.

By adding another modification to convert_inline_anchor() we can present
links in a form very similar to docbook, diminishing the doc-diff.

This significantly reduces the doc-diff:

From:

        abysmal performance). These safety and performance issues cannot be
        backward compatibly fixed and as such, its use is not recommended.
        Please use an alternative history filtering tool such as git
-       filter-repo[1]. If you still need to use git filter-branch, please
-       carefully read the section called “SAFETY” (and the section called
-       “PERFORMANCE”) to learn about the land mines of filter-branch, and then
-       vigilantly avoid as many of the hazards listed there as reasonably
-       possible.
+       <https://github.com/newren/git-filter-repo/> filter-repo" . If you
+       still need to use git filter-branch, please carefully read the section
+       called “SAFETY” (and the section called “PERFORMANCE”) to learn about
+       the land mines of filter-branch, and then vigilantly avoid as many of
+       the hazards listed there as reasonably possible.

-NOTES
-        1. git filter-repo
-           https://github.com/newren/git-filter-repo/
-
-        2. filter-lamely
-           https://github.com/newren/git-filter-repo/blob/master/contrib/filter-repo-demos/filter-lamely
-

To:

 NOTES
-        1. git filter-repo
+       [1]    git filter-repo
               https://github.com/newren/git-filter-repo/

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 7561973df6..914e6f64c8 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -10,6 +10,19 @@ module Asciidoctor
         return node.text if node.text
         refid = node.attributes['refid']
         'the section called &#8220;%s&#8221;' % refid.gsub('_', ' ')
+      when :link
+        return node.target if node.text == node.target
+        doc = node.document
+
+        footnote = doc.footnotes.find { |e| e.id == node.target }
+        if !footnote
+          footnote_text = "%s\n\e.RS\n\e\\%%%s\n\e.RE" % [node.text, node.target]
+          index = doc.counter('footnote-number')
+          footnote = Document::Footnote.new(index, node.target, footnote_text)
+          doc.register(:footnotes, footnote)
+        end
+
+        "\e\\fB%s\e\\fR[%d]" % [node.text, footnote.index]
       else
         orig_convert_inline_anchor(node)
       end
-- 
2.32.0.rc0

