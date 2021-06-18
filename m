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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9077EC48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 20:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 718FD6124C
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 20:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhFRUdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 16:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhFRUdO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 16:33:14 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA67C06175F
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 13:31:03 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso10912899otu.10
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 13:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Na2Pfgw7GEo8towg7xd9U4gTnvSsL575TGx4e6jDyYc=;
        b=kZD5hF6spXfYfDQjg/Jby79wQD6xOqy/hq+4Hz7o11w8PXFC4csuQYLbNU/ilWluwL
         v54T2rT3dnh656dAngYZMzowBCDUXh97PW2HaLej93pPyd1ejPC29SLrwk/GT1nAcbri
         YJkHRArO59HdVIyeN3EspmGdjSZdtpcY4KnmIzYu/qYb+ARWh8qx3Qf5jD+CJseh1YRT
         s7dYQ4Qalk3q5FMXLAvazlx2qaTswJDGkjVIFDhNbTlliKA0GU31fpFCzyiZsF7Be9Up
         LciyFSpgRYdQ8HwEGvSrYGC4QhESnaGJx9f0xBGdKWNF4nl1FgdcDw6Cdrl/3OvkizGL
         lXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Na2Pfgw7GEo8towg7xd9U4gTnvSsL575TGx4e6jDyYc=;
        b=UenyBIUKW8eEaZLwvqtDQ23luzzxyipOFKTAmmd/txYGDl105Ie/FeDxUE5u9wHNQv
         PWwNY+oZw2n23YOS9HvqPJnav//dbZVw2u2gseDZJ3Ykgu19FT6lZdDk32NlrNZlmEZ2
         tFvUqG4iqbMBYSxFrlJEq1O19S+BkCcbGyEvYBjp8drIkQzbJpuPjAqwhdXnhdWFEHg1
         ObzFe9y2teExV5bfKpl0ePdnVK4g9gFfKpPV5IxMG0a5OftF2Te5J1ctGs88/BquAs1b
         D77f6GCVm6j1ysoDfiZnaHHgcpRmIdBCv04u4b6RX8BxdpdldB5K9YmAluuql6u0MiIz
         TvJA==
X-Gm-Message-State: AOAM5338H71dGHkG3RSIiNynu84Hlsd8ROsticaHkb10ClkF9ssLti6O
        M99OERlvl0iJbC3FgK+lkonJL42PNzlk5w==
X-Google-Smtp-Source: ABdhPJyIptcsMOkbQsJWz7W6sXF7SxqQOXa4PsxvQknGMMRkKsbzNWJUWe4W7AkzzlQoEomY9USJeA==
X-Received: by 2002:a9d:aa5:: with SMTP id 34mr8190756otq.183.1624048262646;
        Fri, 18 Jun 2021 13:31:02 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id h2sm2041688oog.16.2021.06.18.13.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:31:02 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC/NOPATCHv3 2/4] doc: add linkgit macros for asciidoctor
Date:   Fri, 18 Jun 2021 15:30:55 -0500
Message-Id: <20210618203057.790320-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618203057.790320-1-felipe.contreras@gmail.com>
References: <20210618203057.790320-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

We also need to update the code that tells Asciidoctor how to format our
linkgit macros so that it can output proper code for man pages.  Be
careful to reset the font to the previous after the change.  In order to
do so, we must reset to the previous after each font change so the
previous state at the end is the state before our inserted text, since
troff only remembers one previous font.  We insert \e before each
font-change backslash so Asciidoctor doesn't convert them into \*(rs,
the reverse solidus character, and instead leaves them as we wanted
them.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/asciidoctor-extensions.rb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index d906a00803..620b3d7a88 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -15,6 +15,8 @@ module Git
           "#{target}(#{attrs[1]})</ulink>"
         elsif parent.document.basebackend? 'html'
           %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
+        elsif parent.document.basebackend? 'manpage'
+          %(\e\\fB#{target}\e\\fP\e\\fR(#{attrs[1]})\e\\fP)
         elsif parent.document.basebackend? 'docbook'
           "<citerefentry>\n" \
             "<refentrytitle>#{target}</refentrytitle>" \
-- 
2.32.0

