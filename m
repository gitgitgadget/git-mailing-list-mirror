Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72759C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54EC26145B
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhENMQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 08:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbhENMQD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 08:16:03 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4088DC061760
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:52 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so5133192otc.12
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j6C5VscLKH4P3VgeSFZrzKB42+3X70UlrLtAL/AoQCM=;
        b=EeItupdapvZsOO9FJGBue1jLWXuPNLfJWcBrrNpw5CbjcIXh7OzLih/cRgoZtOnQJ2
         Fn9qHKEfcd8MW07Nxf+Xg9kXJXNRDI8PmSA2+gA4WCShGG4UNSF3u80C5RkTNF+R2bcw
         MAAVxPp+KXHMrsFYUY2smgxH4Q/EVnJ2tq9yntFRyXhqBcqz1u5fO59vK8Ei6t2ojZPB
         RpvTNFkxcm3YiuUCR/MAmpDytBczwBk3ADH5O6BcPK+1Ggo2tC4P5jIcfGGM14RQaeUM
         EApnzmE5GnlPqakfbwrg4m7TMGxEt6b6Qcjfy0MJU8aQyDqTVg7w5Qa3vEY5499BSqE3
         Y+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j6C5VscLKH4P3VgeSFZrzKB42+3X70UlrLtAL/AoQCM=;
        b=C98wJ1gqkjTDYNeEYUQQ0xG+Fh0z3MkC5cy9yLuqRC+PLRAw2HRkjxcf32LGKiu6BK
         yBpf19Ve+EogoyewWdSUzw2IHuEX1SPGTgn0zWUkDydvRaCGz7q9vAyCbhLpf19c27D1
         TM76dYiKV/iyCj5A54WFNiI8t6DDVPekNR+JYemP+vGUdRZDwn+6KI1o0IdFmTqhbYnw
         Z7Ugfv56peQanvL7PhDqZnlhd2eqS5fo27uuuBfe1zTy+BSTdq2gr+09TP6AbnGWS4id
         /cXuERmkr6/ATePkIQadxn8zLwEKOQvwwxswAD4LTh5U1OEm8YX/TPHY+c0Qg6oCv9qX
         JhXA==
X-Gm-Message-State: AOAM533etm0DdQZaRdG9iae/Ls7NEKJ0TOu8kp6nQdhyUY0GAQCV1iOe
        mqdndtQ5G7sMreJML1rhLER+janoSt01fg==
X-Google-Smtp-Source: ABdhPJzBfmwwCSW1vhEo15RAKkpiZEWfFayFONPSTp6vGoHOxc2MHwdchAezDQQLJ7pF55V0KEWRiA==
X-Received: by 2002:a05:6830:15c9:: with SMTP id j9mr38633342otr.73.1620994491437;
        Fri, 14 May 2021 05:14:51 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id q24sm1343487otg.81.2021.05.14.05.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:14:51 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/11] doc: asciidoctor: add hack to improve links
Date:   Fri, 14 May 2021 07:14:33 -0500
Message-Id: <20210514121435.504423-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210514121435.504423-1-felipe.contreras@gmail.com>
References: <20210514121435.504423-1-felipe.contreras@gmail.com>
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
index b2bbb318ad..42133ee6c3 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -11,6 +11,19 @@ module Asciidoctor
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
2.31.1

