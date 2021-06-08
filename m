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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617EBC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4393F61184
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhFHJDs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 05:03:48 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:39591 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhFHJDr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 05:03:47 -0400
Received: by mail-ot1-f44.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so18554576otu.6
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 02:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MG+nHSv+dAQUSETR0CayNJHgev0YVpT7DORiYJSc43o=;
        b=jE1UHhP7QoURy2ETELexWQcMb3xVAoTPxfXCBlUKT2UNnSSVxE405LloEJI+Uss/SH
         yHzMe5G6qCs5EMQ1Apw2A03WQKY5HqP6c4WexN6Zb/7/08W1REW2APwMwzy7FpLEThqv
         B5kr2H8R8PWaRt1PVwf3kFDlLx5dLUDP4V8CT1VcDTn8uZUXxNJJ/N1aiQT5J0T/EQAU
         cGnrAbIqwMnz9sg2jyqfWFzQD0XtUU1h9RDHO5WMPzLHsoxN4sb+GEXrCgW1hXQtVHFj
         ds3m9fawv3fz2Tl3MQ6skzQlKYVmynsc+p7SRQgYQghHMkoyGYIZFzVLvRlqk79+WK3z
         tEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MG+nHSv+dAQUSETR0CayNJHgev0YVpT7DORiYJSc43o=;
        b=YmviDGGIoTR9Ao2qS8FQ3BO7GFu9CfF2tfSByiecBm3oT1KOZFLNkqGHi76wLput3J
         s8/z24+KiWtgqcJz8ggl3ey0Tn52Zwlpzckt4A91l5km1G6SmSRn1laVSYCIIbh2ryi+
         dopTjtAb7OOx2MGyMMnKZP3KxNY/mmY3JvAOiuzVk1sJ2rq4AL9PfMvPNG9khJ6/Pdx3
         qUnWe5Ou/qPqjvxA7EoOb2KsWDpnFKvFirv0KXzZYh9rLuQgLClAD8rrObV2UPZPoXoj
         D0VuwyqA1fQWCxYJ9KC0qxaoatY7nuPLeSs/2GVAv932gP/4CE05XW7TcelAnFequgMc
         TnbQ==
X-Gm-Message-State: AOAM533j7vu/68blHyJrx60oyEGkCVYagqyGREjr53Y+CZHsrFkXZ4u1
        MKkzsKkwFr1UYWPva5XO5mejpFzAfjq92w==
X-Google-Smtp-Source: ABdhPJzaOrV0X89g+57QbHsSoMf9lb3zUE4yNIEG6FrTTG2FdWYuaV7ug420IwAKs91cITGWWQCgvg==
X-Received: by 2002:a9d:542:: with SMTP id 60mr17274745otw.143.1623142847507;
        Tue, 08 Jun 2021 02:00:47 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id r1sm829379oth.19.2021.06.08.02.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:00:47 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 10/12] doc: asciidoctor: improve string handling
Date:   Tue,  8 Jun 2021 04:00:24 -0500
Message-Id: <20210608090026.1737348-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210608090026.1737348-1-felipe.contreras@gmail.com>
References: <20210608090026.1737348-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using printf style formatting (more familiar to git developers), and
also here document.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index a678704e17..3282d59a48 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -7,20 +7,20 @@ Asciidoctor::Extensions.register do
   inline_macro :linkgit do
     if doc.doctype == 'book'
       process do |parent, target, attrs|
-        "<ulink url=\"#{target}.html\">" \
-        "#{target}(#{attrs[1]})</ulink>"
+        '<ulink url="%1$s.html">%1$s(%2$s)</ulink>' % [target, attrs[1]]
       end
     elsif doc.basebackend? 'html'
       prefix = doc.attr('git-relative-html-prefix')
       process do |parent, target, attrs|
-        %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
+        %(<a href="#{prefix}%1$s.html">%1$s(%2$s)</a>) % [target, attrs[1]]
       end
     elsif doc.basebackend? 'docbook'
       process do |parent, target, attrs|
-        "<citerefentry>\n" \
-          "<refentrytitle>#{target}</refentrytitle>" \
-          "<manvolnum>#{attrs[1]}</manvolnum>\n" \
-        "</citerefentry>"
+        <<~EOF.chomp % [target, attrs[1]]
+        <citerefentry>
+        <refentrytitle>%s</refentrytitle><manvolnum>%s</manvolnum>
+        </citerefentry>
+        EOF
       end
     end
   end
-- 
2.32.0.2.g41be0a4e50

