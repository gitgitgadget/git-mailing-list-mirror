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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE00C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB616102A
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhFURBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbhFURBH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:01:07 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C5EC0A887D
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:59 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id h9so8016165oih.4
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=adzs76Dq5wpoF8mOrAK6Rw6E5Il1yjpLwJz9JzUhZu4=;
        b=oZBfin6bdtMyhAi/gexC1t/FaFQXjRJ5TVmVpEwlRg1En9P+ACvvukJfjKQ33qyAr5
         kcmEC0X0z13sBtrvqVWmG2q/pRqSSHQWqYr/KPbFTMoIYSRQnVGOM4fXFoIyWdwt9dpK
         E0pvJdDDv9zH5EsCEnw8UQYiUJ/u6y7wEZg1lUKSE2N3XhqEUaS/qT8+oVfZD47xxiZf
         fP31d2F/QRiLjDjoLBX68QYXOlLcOvB/LELP4cHawgiRIwkUR7lfsP+NYcSzF3BWr95D
         WVJ59F74UN4Gep4akrbZEKl8FJWDoAOdOl7KzdKi5kOO+Q6RuUke3NAtqZu80jviSEi/
         gemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=adzs76Dq5wpoF8mOrAK6Rw6E5Il1yjpLwJz9JzUhZu4=;
        b=RbI2fas/z6mtggPwYH3iqC6IMxU1MtrzOXCmT+ANCZwQQ8E0Pr6l3kGcVOcZUdUPDN
         HnJKphURRyCic20SQg6XTbeKsRAZrzAKHJK8z9Ih6K9vRZf52gPP3kSwUFnUIqpaSCwp
         hRnrlLzVKrRqhRZgIUtTH0Hau6EG9XWUck/Su8WvzSViLF3VgaDLWTSBEpY8jhmfi82j
         gHY4GGhkM1+iEFsvq+M20kT/xN/+2l/OU4ZP0Uk3M2474DXfR5tdhBZPdSN5RzmRiUNC
         12f3Rfa1Dt6fiKQ8RMrBfBVwToPXCz+HWqYRtwaoLrIxkan8YGC6Gr2Bn5USu6OVLtcv
         hhDQ==
X-Gm-Message-State: AOAM533Mp6EkiC6KqhVa4XW4jzWZ0FrHrg92JUc/n0/7GEGA4Ri5hXnS
        76UPr1wVdbQjI/mWa2XT6qvplumK1FWDAQ==
X-Google-Smtp-Source: ABdhPJzfk2v/NJ6Ouw/xOLM7XhgYGBvAmfpW/IK+FS2Qs6JrYJ5++XUrrg1polsBPPFW/CctzteCJg==
X-Received: by 2002:aca:b509:: with SMTP id e9mr24876314oif.66.1624293118364;
        Mon, 21 Jun 2021 09:31:58 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id o20sm2826977ook.40.2021.06.21.09.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:58 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 19/23] doc: asciidoctor: add hack for xrefs
Date:   Mon, 21 Jun 2021 11:31:06 -0500
Message-Id: <20210621163110.1074145-20-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The docbook manpage stylesheets convert cross-references with format the
'section called “%t”'. I personally prefer the asciidoctor version, but
for now add a hack to minimize the diff.

Thanks to the extensibility of Ruby we can override corresponding method
in the man page converter.

This fixes doc-diffs like:

          --worktree-attributes
              Look for attributes in .gitattributes files in the working tree as
  -           well (see the section called “ATTRIBUTES”).
  +           well (see ATTRIBUTES).

This can easily be removed later once we are confortable with the
asciidoctor version.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 954acb3e7d..7561973df6 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -1,4 +1,22 @@
 require 'asciidoctor/extensions'
+require 'asciidoctor/converter/manpage'
+
+module Asciidoctor
+  class Converter::ManPageConverter
+    alias orig_convert_inline_anchor convert_inline_anchor
+    def convert_inline_anchor(node)
+      case node.type
+      when :xref
+        return node.text if node.text
+        refid = node.attributes['refid']
+        'the section called &#8220;%s&#8221;' % refid.gsub('_', ' ')
+      else
+        orig_convert_inline_anchor(node)
+      end
+    end
+    alias inline_anchor convert_inline_anchor # For old versions of asciidoctor
+  end
+end
 
 Asciidoctor::Extensions.register :git do
 
-- 
2.32.0

