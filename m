Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399C1C433B4
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06DAE613BB
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhEOL6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 07:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhEOL6J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 07:58:09 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258A2C061573
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:56:56 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id c3so2051845oic.8
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CYMLOVhTIDN6rp5Muq+LudJgWqB82yrroTOfrm9MdFc=;
        b=jHAmloSiehRYlwe2qOkoHkUALkdl4m85dZZx8KTwr8OCP9FrXmowFW8p7eYGw7bYvu
         RDK5sx/V5DjOH+Ye7b1iDW5dJ8z4XvrBBACB626tWgRsF5Xmky8vQQOWsBrXTGrgTQuY
         xG2ZfFFDl8oqIGM7ACuz8mriE2+UgaICMIxdygHfIPHEBLsKGfjdMlRRXrOw+eylHxlY
         e4KtTzOegg7Gi2M7E3sAqCCAlsrTHNPCzJ/AaC53y9ozsCKrIgFjyKOQJkdHb7wVLux9
         vn+pMZCtZBxffsBbiixX+3Z5rR+esBsShIFhyL7D+tgAfqsVGDS3foLmXRf998u3YX7z
         wg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CYMLOVhTIDN6rp5Muq+LudJgWqB82yrroTOfrm9MdFc=;
        b=A1OKEFS1buHCSYI87YI6UuX+wtS2Xaapqbvr05KFxYsj48Gc67k+S0uIiwD8qijN8X
         SY14+Yw7tf5viHk/7AxOZvNfz+k2xtvZ3bq0K+vINxMtuaks0AJt502vABRwhnYWgnKW
         SWvNw58NlBMXKLIOV/NB21efQH598Fx2fjyvSn8H24wp2Bh4l6kSsEIDXd1GrSn7LIbU
         J+5jhNrE5Io/Kenb1c/RfYJKik+YBKxhQkdgNPgq8gkfnU6VkfaQtMAG6N9X/ugTj5Jb
         lB09aeJHnqvbka7ICMhjwuopDZ+PFu8MoHFa/sUR+hEwH8taQ7++XOGX2BCP61g9Z2Rd
         692w==
X-Gm-Message-State: AOAM532L5C9zu7bw3TysKDovJ4lzYqwSMCcdtJufH4uCuC50wS89V6uV
        69hN+fawGpkaAnL+UoWffkS+clyP/f5ikg==
X-Google-Smtp-Source: ABdhPJzmVAMltC82QpVbHbyRsdM7zOIBOlcfsYqc73bnSuThj8jUGaQ000kriOgVu/CyQlgvQCmA2Q==
X-Received: by 2002:a05:6808:1149:: with SMTP id u9mr5310924oiu.61.1621079815207;
        Sat, 15 May 2021 04:56:55 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id m81sm1689829oig.43.2021.05.15.04.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 04:56:54 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/12] doc: cleanup old cruft and asciidoctor revamp
Date:   Sat, 15 May 2021 06:56:41 -0500
Message-Id: <20210515115653.922902-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series gets rid of old unnecessary workarounds and convoluted solutions.

Additionally it cleanups the asciidoctor-specific code so it ends up much more simpler.

This goes on top of my other cleanup patches [1].

[1] 20210514115631.503276-1-felipe.contreras@gmail.com

Felipe Contreras (12):
  doc: remove GNU troff workaround
  doc: use --stringparam in xmlto
  doc: simplify version passing
  doc: asciidoc: remove unnecessary attribute
  doc: asciidoctor: remove unnecessary require
  doc: asciidoctor: remove cruft
  doc: asciidoctor: reorganize extensions
  doc: asciidoctor: use html-prefix only for html
  doc: asciidoctor: refactor macro registration
  doc: asciidoctor: improve string handling
  doc: asciidoctor: split the format from the code
  doc: asciidoctor: specify name of our group

 Documentation/.gitignore                |  1 -
 Documentation/Makefile                  | 19 ++-------
 Documentation/asciidoc.conf             | 20 ---------
 Documentation/asciidoctor-extensions.rb | 56 ++++++++-----------------
 Documentation/manpage-base-url.xsl.in   | 10 -----
 Documentation/manpage-quote-apos.xsl    | 16 -------
 Makefile                                |  4 --
 7 files changed, 21 insertions(+), 105 deletions(-)
 delete mode 100644 Documentation/manpage-base-url.xsl.in
 delete mode 100644 Documentation/manpage-quote-apos.xsl

-- 
2.31.1

