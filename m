Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F8EC48BC2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F0061042
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhFURCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbhFURBH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:01:07 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E36C0698E1
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:32:00 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u11so20511931oiv.1
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tswPKc8FuNvdzr3UTjwXr6hsa1OX0LL66S8+q7PhZ2M=;
        b=Vwaw4YaOKfM9+ntxlaEeE9Xte9N+X1IwidPVmfVFcz+F75qr31TWBsfDuZQLrlCxA6
         GhBYN7eBzVg5kmCBsf0p28CdiQDFZrzq6VkjfEROQ/99lKQCCSbWnCG1BNpg0Z4YKMtn
         M3rtGK8lMV3g7QRHdLujEgBMedrlm3joooffbfQSYFJRlbazUBP7YosssArCoBtSqV8Y
         SqfI/BspzaybzciuhBUHlguyx/VnGVmzi5zn90lC3tCPwgtvzJyY74poA1u9+SgWw48/
         WPwgd3DKezzwbSbwZZf4TgeybweaLK+OHU7QIbE9jVXI8uRWcy3AqdRU6bdMGz9NPtgQ
         BNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tswPKc8FuNvdzr3UTjwXr6hsa1OX0LL66S8+q7PhZ2M=;
        b=qPRYqAfW4AQg5MFlmDUam8iwsERlsOw4Eu35kFWXHnVFw62i7l80np65aUw3RaWIiJ
         Z5JfIwQTnfKJXfkj55D+E1GToRf0F19QewJ6bZV51Se3QXcm75U5yJRlnCn73bPIQsjT
         1RhXSz/gkg94G2e90KuUF/hl1dYnf6KdMHH5Cv6lL2LLxOEM8/nRVRjJKYkYoiCTj679
         BcH+zd5kz0/v3iTdSVCW0UDiyL3SdaleIBanl+hqDDfw+lBMuUBXJnEvR4zf/KmDTBu+
         fK2/KdRBY/5Qu1/mtbPkmLQVmqevrSmIMpXUZjTcnhQEoVcIuVHrb2OboOOZBz6BImvx
         rKyA==
X-Gm-Message-State: AOAM533bcEyKFD2E0tGZnghJoulpZVJPjGr2JEhpc+QWlS4jKpYT7B5p
        +SO51Shl3MkkvQ0/DlO0zHzEIfCVUh/sVA==
X-Google-Smtp-Source: ABdhPJyPq4uLXo/6FAOixnsMiUOUGxzMxgTeb7temhFR5LxAQylBFOOWyS4v2eIQZW65LzJcjLwp9g==
X-Received: by 2002:aca:2804:: with SMTP id 4mr17017781oix.141.1624293120032;
        Mon, 21 Jun 2021 09:32:00 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x199sm3627228oif.5.2021.06.21.09.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 20/23] doc: asciidoctor: add hack to improve links
Date:   Mon, 21 Jun 2021 11:31:07 -0500
Message-Id: <20210621163110.1074145-21-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
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
2.32.0

