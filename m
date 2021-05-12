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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D35C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 06:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B197F616ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 06:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhELGnr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 02:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhELGnq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 02:43:46 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503BCC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 23:42:39 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q2so17757656pfh.13
        for <git@vger.kernel.org>; Tue, 11 May 2021 23:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ma99Vjwb7pKPSlMiIJew1BqJYZmDeaYiYct3GTiqcs=;
        b=mKhZuI3iZKUumrV6JPoLWyoxUeDa7EIu9UDBgw1fCvbggC6EB8/v8eUCQQGImmaKV9
         RfRwod2eeKTkMk8Zza3JZiWNYU6IEPUOXaNeQ2RIZSAPmYFBsj/QJxCKgdOzmE4kQvD3
         Df0kebheEC+E4CaAoKi1r2qAKeuY+/CcoYP7yMxBhDBRS7UBPBNKRCEN3LYLlx8VjIYE
         8Zdhni7N2wt7NjyxgBrSbD8zmsE8mSEy3XZT+YdK3t0JhascO1cviiQ+dsjsmXZSdNER
         Z6Ob3tpT1F1qbLe+/j4mXrMxXF7nekVqBincT7LJ5caR8Jw629Bc4YnO5mZZAtYpWYDp
         MYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ma99Vjwb7pKPSlMiIJew1BqJYZmDeaYiYct3GTiqcs=;
        b=Byeg1scy3FidJ5LpSsc6B0lhzwgJFK2WJf3suHeRg2yEd0sh1dSGRpjgqiblawt5sj
         OepE/8tWuwDZsxslSNfxS+W26j8P/VWahrz6b41a466n9Iv43NwAChLnRXrpd5Mfx3n0
         uj81VGIOlXd46WqIzq+fy05sGRl6qdVSBoaZu40kwI5kjynnXZyUJbJYmFcRlwHuIIFP
         GFuOHL0XykXxOQhUZgxaMid3l0MzgNQgv2SrJFtFruY9HNBAihvWGdvBtFENz3LOsD4i
         +tBGkDGm9TcWYapKMdQhic3NEP4er3xClkKAdwbe0YIQM4iRu9A7EA8Tl+ahaXRTzS0L
         ynbQ==
X-Gm-Message-State: AOAM532sdSkjioNmNJ8RR8v1TQeWFIV8IFcVURTSioOtQ6uQO2uiyCmT
        g33qM9aauHuwL1ViCjApM8QYjElTQGgRxw==
X-Google-Smtp-Source: ABdhPJz+C+s6wuRthyY4cJQydDyLaaARvjMaMb7ygTFI33B8ZKnpTyerc3ClLJSDP3U0JGjOEbztgQ==
X-Received: by 2002:aa7:86d3:0:b029:291:cb2d:f91d with SMTP id h19-20020aa786d30000b0290291cb2df91dmr33835384pfo.57.1620801758469;
        Tue, 11 May 2021 23:42:38 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-75.three.co.id. [180.214.232.75])
        by smtp.gmail.com with ESMTPSA id j7sm3677778pjw.4.2021.05.11.23.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 23:42:38 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] INSTALL: note about make man with Asciidoctor backend
Date:   Wed, 12 May 2021 13:41:29 +0700
Message-Id: <20210512064128.15411-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"make man" can now be also done with Asciidoctor's manpage backend
instead of asciidoc+xmlto.

Update INSTALL to reflect that.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---

 This patch is based on  "doc: add an option to have Asciidoctor build
 man pages directly" series by brian m. carlson [1]. It can be added
 to that series.

 [1]:
https://lore.kernel.org/git/20210512021138.63598-1-sandals@crustytoothpaste.net/

 INSTALL | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/INSTALL b/INSTALL
index 66389ce059..89e31566c3 100644
--- a/INSTALL
+++ b/INSTALL
@@ -184,8 +184,9 @@ Issues of note:
 
    "make doc" builds documentation in man and html formats; there are
    also "make man", "make html" and "make info". Note that "make html"
-   requires asciidoc, but not xmlto. "make man" (and thus make doc)
-   requires both.
+   requires asciidoc, but not xmlto. "make man" requires either
+   Asciidoctor or asciidoc+xmlto. "make doc" requires both asciidoc
+   and xmlto.
 
    "make install-doc" installs documentation in man format only; there
    are also "make install-man", "make install-html" and "make
@@ -201,6 +202,11 @@ Issues of note:
    use Asciidoctor (requires Ruby) by passing USE_ASCIIDOCTOR=YesPlease
    to make. You need at least Asciidoctor version 1.5.
 
+   You can also do "make man" using Asciidoctor's manpage backend in
+   place of xmlto by passing USE_ASCIIDOCTOR_MANPAGE=YesPlease. Version
+   2.0 or later is highly recommended, as these version properly handle
+   apostrophes.
+
    There are also "make quick-install-doc", "make quick-install-man"
    and "make quick-install-html" which install preformatted man pages
    and html documentation. To use these build targets, you need to
-- 
2.25.1

