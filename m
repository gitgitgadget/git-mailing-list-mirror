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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F74AC4707A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 748D6613D8
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhEUWi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhEUWi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:38:28 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F52C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:05 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g7-20020a9d12870000b0290328b1342b73so11592318otg.9
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSaGUKSATA0J/8fyUa8ihu0eEXgmsvBLcy1cUDmnHBI=;
        b=HowY+mLLoQKjQwC63taRMMytfQW3JCX91pg6CUkAyoHAg2/dDDr+o4b4Yj7Yuz2FBh
         fM9s65aHr0z67arop7DeyRkH3xiYnas2MV7MdO72EzGqn3dGuRWVnulqAvdvyJC9OYGj
         DbYyWXmbGckfPiXkos7B7bMPdx2VYpwqS1CWeZv1J608ufp5lgEZ61xD9GwncEWGnYWZ
         5hbuHLDMJq9oYb5KvUYphsJNTX9X/WyL8j663+Flf0+UbGLh96rAOkW8sggE91cX7MNj
         woccmyhA/QSx2NuepokWYVS+cELWvo76DE5ePiz0npezDXT9juC/WcQC7LLrB5PCWNdA
         ud7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSaGUKSATA0J/8fyUa8ihu0eEXgmsvBLcy1cUDmnHBI=;
        b=N4RdLZyRXlDu43MrOHsmWxmp8CF9EibAapLTr5xy12+kfBrIU5AmTMvkv/FYMQ/4kC
         rUL3Tq2YxDKGNfLREQ8JSIEdQMmNyEjHg/3eeJDLoEs2dRl5yAX8Rmrix/jfT86PF5Sa
         G/+aUdKjC4YHadn4YxsRY/esF2sU/oMyBG+vyEU8k//cdgQlrLx63rn3nOsjaa9kB00x
         KJgfEUjDAJ+9MsQM/ECRh1r3AHVgXJrCWOFPQL8Ibzs+a6dtMW4WLAJEJaDOimRQ/cLi
         MHXv2gLT2T6ZXvKXLmylPzve2e66bPaI7xJv4xkl/8VQ6BcCsNGVLl58AoYkJ87ax4xo
         oX7Q==
X-Gm-Message-State: AOAM530wajcvkWlzMImI+sgbLwbg5euMdAzwacOFAai1jrSXmgvvQ5P8
        wAHRMuS8s3Ov1PAxcu8joZxuyZLjK0UqFw==
X-Google-Smtp-Source: ABdhPJwLHRUAyWF+oXAJIWkaMlQ46DzJHTXrYbi7gIsHHQoJPC4yR7BivHe/l+Kbl3XYns/Y/AjfSA==
X-Received: by 2002:a9d:366:: with SMTP id 93mr10319245otv.323.1621636624323;
        Fri, 21 May 2021 15:37:04 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id i4sm922569oih.13.2021.05.21.15.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:37:03 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 01/12] doc: remove GNU troff workaround
Date:   Fri, 21 May 2021 17:36:50 -0500
Message-Id: <20210521223701.526547-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521223701.526547-1-felipe.contreras@gmail.com>
References: <20210521223701.526547-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 2007 the docbook project made the mistake of converting ' to \' for
man pages [1]. It's a problem because groff interprets \' as acute
accent which is rendered as ' in ASCII, but as ´ in utf-8.

This started a cascade of bug reports in git [2], debian [3], Arch Linux
[4], docbook itself [5], and probably many others.

A solution was to use the correct groff character: \(aq, which is always
rendered as ', but the problem is that such character doesn't work in
other troff programs.

A portable solution required the use of a conditional character that is
\(aq in groff, but ' in all others:

  .ie \n(.g .ds Aq \(aq
  .el .ds Aq '

The proper solution took time to be implemented in docbook, but in 2010
they did it [6]. So the docbook man page stylesheets were broken from
1.73 to 1.76.

Unfortunately by that point many workarounds already existed. In the
case of git GNU_ROFF was introduced, and in the case of Arch Linux
a mappig from \' to ' was added to groff's man.local. Other
distributions might have done the same, or similar workarounds.

Since 2010 there is not need for this workaround, which is fixed
elsewhere not just in docbook, but other layers as well.

Let's remove it.

Also, it's GNU troff, not GNU roff.

[1] https://github.com/docbook/xslt10-stylesheets/commit/ea2a0bac56c56eec1892ac3d9254dca89f7c5746
[2] https://lore.kernel.org/git/20091012102926.GA3937@debian.b2j/
[3] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=507673#65
[4] https://bugs.archlinux.org/task/9643
[5] https://sourceforge.net/p/docbook/bugs/1022/
[6] https://github.com/docbook/xslt10-stylesheets/commit/fb553434265906ed81edc6d5f533d0b08d200046

Inspired-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile               |  8 --------
 Documentation/manpage-quote-apos.xsl | 16 ----------------
 Makefile                             |  4 ----
 3 files changed, 28 deletions(-)
 delete mode 100644 Documentation/manpage-quote-apos.xsl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f5605b7767..bf1f66b3eb 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -178,14 +178,6 @@ MAN_BASE_URL = file://$(htmldir)/
 endif
 XMLTO_EXTRA += -m manpage-base-url.xsl
 
-# If your target system uses GNU groff, it may try to render
-# apostrophes as a "pretty" apostrophe using unicode.  This breaks
-# cut&paste, so you should set GNU_ROFF to force them to be ASCII
-# apostrophes.  Unfortunately does not work with non-GNU roff.
-ifdef GNU_ROFF
-XMLTO_EXTRA += -m manpage-quote-apos.xsl
-endif
-
 ifdef USE_ASCIIDOCTOR
 ASCIIDOC = asciidoctor
 ASCIIDOC_CONF =
diff --git a/Documentation/manpage-quote-apos.xsl b/Documentation/manpage-quote-apos.xsl
deleted file mode 100644
index aeb8839f33..0000000000
diff --git a/Makefile b/Makefile
index 3a2d3c80a8..55dbdee98e 100644
--- a/Makefile
+++ b/Makefile
@@ -278,10 +278,6 @@ all::
 # Define NO_ST_BLOCKS_IN_STRUCT_STAT if your platform does not have st_blocks
 # field that counts the on-disk footprint in 512-byte blocks.
 #
-# Define GNU_ROFF if your target system uses GNU groff.  This forces
-# apostrophes to be ASCII so that cut&pasting examples to the shell
-# will work.
-#
 # Define USE_ASCIIDOCTOR to use Asciidoctor instead of AsciiDoc to build the
 # documentation.
 #
-- 
2.32.0.rc0

