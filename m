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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB2DC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 17:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A3F760C3F
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 17:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFURCM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbhFURBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:01:09 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AF3C0A8881
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:32:02 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id d19so20524801oic.7
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJdH+2c/cMeSXmSxxayx9V8AnzBDGOUVXKwxH27OgqQ=;
        b=CWpMcnf7gB+Y84AI29KlPsHoEVy0tfZx8bvz2B94b+00KW1GXgesI/hVlqHkwmeI0y
         V0/RTwt/WWVCPG8MMTdcCEK7yiHxTi8pqCfF8/fsdHeSmtdaK3tRlpV69TI9HL4mweH9
         F3IeQ/MP+I1Lu0s2JaAtu3cb51zBg/9ZcX+lIlJOO58ld+fsMw3NC+fPyWWW4thlU/9c
         pbBl2kBlSqbzA8YQJdvDq+qeHloZlUIml2RtIQThc7D2kLpeg+JnCAzvCsh9zvC6Hv5Z
         uPYOJSwKgw32sgbab2w/2cZ14gCpw8vbArIweoo+2LDesBgHLc3ij8kjFA1sHy2+bn8S
         274w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJdH+2c/cMeSXmSxxayx9V8AnzBDGOUVXKwxH27OgqQ=;
        b=rvShudmJjG0BzcrqFIOQ8I5TjKw5vYNegZkWR5SlhPp65i5L9B638vMKXsOmTZtYIv
         MlqleY0HNxubRVjdPFeFfvqp9nyDkrgCAzawz6sE+bjaZlq6lKOalWTHcQR5q892sKOm
         of5EKKElKNxAUTvoUFC6AOTt0fKh65tU3jId2CqQ0LaDCc3jhocxRi5Xi33IUV7mwn0P
         Pt9/gPyzGj7dMJgWPorjcgG/XpedlQX0DCKCi30RfsutXOxxw0X3zSS4gsDpKhD2leLG
         g2yjeCNEnBSFRFz5rpVU6a7TIstT+NfgQU6di2Otcac8vEKjO/wIHPyKn1d5RL94Ezex
         +XVw==
X-Gm-Message-State: AOAM533i75fPUZ1ao8JSSoqOs8cFh8VFD2Y1ig2411DSQ+EscYvq+INr
        c5IddG60UcfzMvCyMmbIZnCXLoSIf74dRQ==
X-Google-Smtp-Source: ABdhPJygH89oHQaawcupo/L/OBZ55mQ+47dA3kOToy/Fg6G8AXu3doCvSO0rfjxdFCb/k3Bm1hVIRQ==
X-Received: by 2002:aca:b68a:: with SMTP id g132mr26057434oif.139.1624293121573;
        Mon, 21 Jun 2021 09:32:01 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 21sm4164468otd.21.2021.06.21.09.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:32:01 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 21/23] doc: asciidoctor: add support for baseurl
Date:   Mon, 21 Jun 2021 11:31:08 -0500
Message-Id: <20210621163110.1074145-22-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So that we can present relative links correctly.

Reduces the doc-diff:

   NOTES
  -        1. “Understanding history: What is a branch?”
  -           file:///$HOME/share/doc/git-doc/user-manual.html#what-is-a-branch
  +       [1]    “Understanding history: What is a branch?”
  +              user-manual.html#what-is-a-branch

   NOTES
  -        1. “Understanding history: What is a branch?”
  +       [1]    “Understanding history: What is a branch?”
                 file:///$HOME/share/doc/git-doc/user-manual.html#what-is-a-branch

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile                  | 1 +
 Documentation/asciidoctor-extensions.rb | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index e6af1848cc..dea0f2d859 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -185,6 +185,7 @@ ASCIIDOC_DOCBOOK = docbook5
 ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
+ASCIIDOC_EXTRA += -abaseurl='$(MAN_BASE_URL)'
 ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 914e6f64c8..8856f2febd 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -16,7 +16,9 @@ module Asciidoctor
 
         footnote = doc.footnotes.find { |e| e.id == node.target }
         if !footnote
-          footnote_text = "%s\n\e.RS\n\e\\%%%s\n\e.RE" % [node.text, node.target]
+          target = node.target
+          target = doc.attributes['baseurl'] + target unless target.include? ':'
+          footnote_text = "%s\n\e.RS\n\e\\%%%s\n\e.RE" % [node.text, target]
           index = doc.counter('footnote-number')
           footnote = Document::Footnote.new(index, node.target, footnote_text)
           doc.register(:footnotes, footnote)
-- 
2.32.0

