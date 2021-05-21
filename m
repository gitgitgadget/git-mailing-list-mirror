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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A00C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1569613D9
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhEUWqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhEUWqb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:46:31 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83D0C06138B
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:45:07 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so19451920otc.6
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xMr/M2H+/xTS3m/c7EfC9R05xf/aVqzTD3RUu/gKXgk=;
        b=gXcm9Q4zi4FOAavlbLssbx3/x9D2BRmQloO6fgs5vABOiEZ/zJAfeiJkoYfQGXE8Bo
         CCxdLzuEOVfODM69TydfQflttbSav2cVe8AQjJ63iTbBeuhwUxAVuWZs91uzot9KcFS7
         Bcuihf3fpWUcHljY1hc7WtdK44am9SDIC1k327YZfwEtqTB1bkUy1umZWzkRNFgCvPbK
         /tWVll/ZDmcty7LdeFo78zSAhZ4PrAdmTmeKEDkWZ5WeyMRHzrNKdIWzNDRn4gYq7F22
         4WRad871oX2hhEfsLJdVv4wdRzlIqJP0v4d/zPAokOsicF+OiiJu/kSLLdoPAZ5TkZEA
         /8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xMr/M2H+/xTS3m/c7EfC9R05xf/aVqzTD3RUu/gKXgk=;
        b=IYVZpQeKnQN43CEm68NM1TW8NQr1mHY2bTahlB39ax2QYnqqtoVxHuyhBcC0D0hARZ
         Sh2lewcxLLNwxFuPBxxTPS7ZnbhcDiuAUQafZ2tVoC1D/O7KlveGJdkdvCzuyCJuKdgY
         xa9MqsrdICkEjPFDFAVIcGjK1DELj+0t0tL+6iXftNKRVi3I0MFDqowSq2gHl/yUJYkN
         MAbxFhTmk22vYux4Rtwwlc6yQfDWaUzoSVFscVIlw1nl6KK//hI8yyI4d2Br24Y4BkVj
         OrLAvXS0UtJdvSLLj03ocYTd4XIh8rrNuIp/TsvqE1fkRpmqAXxWfJQZjmyrDgx77syi
         0ZWA==
X-Gm-Message-State: AOAM532ibOis4duJq/iQj2tWgYQ3qSBtvjZfz4cQQaLEj18BOzmJgm2x
        G+H7YKRAnwbtWzfARVHbZA1eDbqGligbqw==
X-Google-Smtp-Source: ABdhPJwsq533xIQoxT5ohV6j/NA6dRwHTavYrkdL9RH1YaCCYZKaezJkWX4qaNp3wSTP7uOjrU8z8Q==
X-Received: by 2002:a05:6830:1556:: with SMTP id l22mr10184373otp.34.1621637107090;
        Fri, 21 May 2021 15:45:07 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id i2sm1557414oto.66.2021.05.21.15.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:45:06 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 07/11] doc: asciidoctor: add hack for xrefs
Date:   Fri, 21 May 2021 17:44:48 -0500
Message-Id: <20210521224452.530852-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521224452.530852-1-felipe.contreras@gmail.com>
References: <20210521224452.530852-1-felipe.contreras@gmail.com>
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
2.32.0.rc0

