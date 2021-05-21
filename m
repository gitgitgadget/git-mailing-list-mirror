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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F591C4707E
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CDAB6128A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhEUWi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhEUWi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:38:28 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ACFC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:03 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id j75so21061288oih.10
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=piWny9LCA3ZUZoSgXvj6MRffNfDJ2+Ke6u2b4wq7bVo=;
        b=e3KTYW8/jw9qgTowag5K/NCRxEJCi0CAwNYDeYNVvMNR2CsJwOgsuEWAfCpDl8R3vA
         d4CQijkiaND8L/cXLN84OTbS1DTdpGATIwPZchEWIEeq8mZhMq5HXTpyZUEZPqOUUPNV
         9huPC/FaBoC9Q/r/PoExCQUkzlz2lF5EU19GdkU8Qd4dtctUBSuvfl1dgLszMjM0XF0Q
         HzfTOmszAAbC46K2rCFImYWFKud/J3J6xXhCRVbG1GTyjRbJu2CiTmfRX5861xN44WID
         NC+O9C2dzVjhhjcyLZe7hKsLzcxK9UqSJ1PFxrgywwctjPP5o9hG5EQhGn8VouhxMTKG
         Z+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=piWny9LCA3ZUZoSgXvj6MRffNfDJ2+Ke6u2b4wq7bVo=;
        b=Bo02tJUvoeshTNNJ3b5DA/kRfwzyJrwrlTTuLxkzkhR0VPCL/73G3FfigMEYn/vQOB
         cDxNd+o1NLsjMtwzgOzmlaVsc63uMh9RsRP2X7o4HZqEWCYDwwwNB34xxSVB+0zJkFXq
         6BXSZEBFwAOmKiZ2woIY9lmFSSIVV7chppUugMkk+tHJ48YJfoOtwOfGRuChtuChAPbG
         a0UWBj01Y6zYqiIzc6ZXLK9z1xTCTrP89X+bxsqdLu46mjtwDKBEfrNqAizXNbymfRzc
         lAROVPIKvXc3F/4TC+ln9jcFRZUj4jJ4H2LHyYYp0t0gm866vALGDpQzY3EjVtmQesZh
         c9yA==
X-Gm-Message-State: AOAM532j9yhuwZM6keCOZ5GGyx1Eyr+HEopzclDBrlWlW5kkIz0/DIh8
        LXGpHSKDz2YHmsu3KYk25sYv/ocmAksxhw==
X-Google-Smtp-Source: ABdhPJyhpwt42jRVMLan71vc652uZEaU07ISohK3E1MdBCgVsn1hGpCZedddV+1pTrzYAA62fqzsjg==
X-Received: by 2002:aca:484e:: with SMTP id v75mr3629245oia.149.1621636622712;
        Fri, 21 May 2021 15:37:02 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id u13sm1429409oop.40.2021.05.21.15.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:37:02 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 00/12] doc: cleanup old cruft and asciidoctor revamp
Date:   Fri, 21 May 2021 17:36:49 -0500
Message-Id: <20210521223701.526547-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series gets rid of old unnecessary workarounds and convoluted solutions.

Additionally it cleanups the asciidoctor-specific code so it ends up much more simpler.

This goes on top of my other cleanup patches [1].

Since v2 there's only one small fix that introduced an extra space after linkgit.

[2] https://lore.kernel.org/git/20210521222941.525901-1-felipe.contreras@gmail.com/

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

Range-diff against v1:
 1:  371b0ababd =  1:  f9fe40224d doc: remove GNU troff workaround
 2:  0d55f9dd09 =  2:  eed7d77e1e doc: use --stringparam in xmlto
 3:  2c2af6bade =  3:  d8bebb37e4 doc: simplify version passing
 4:  eef11180d2 =  4:  2df412bce6 doc: asciidoc: remove unnecessary attribute
 5:  573b0995b2 =  5:  3abdeada0c doc: asciidoctor: remove unnecessary require
 6:  35fceb27ea =  6:  685cd824ea doc: asciidoctor: remove cruft
 7:  2b4f696ad6 =  7:  7f1fb74a04 doc: asciidoctor: reorganize extensions
 8:  1860058908 =  8:  bede3d2294 doc: asciidoctor: use html-prefix only for html
 9:  5fc0a42cec =  9:  2ecd19e4e3 doc: asciidoctor: refactor macro registration
10:  c09718f046 ! 10:  6c5e9142c8 doc: asciidoctor: improve string handling
    @@ Documentation/asciidoctor-extensions.rb: Asciidoctor::Extensions.register do
     -          "<refentrytitle>#{target}</refentrytitle>" \
     -          "<manvolnum>#{attrs[1]}</manvolnum>\n" \
     -        "</citerefentry>"
    -+        <<~EOF % [target, attrs[1]]
    ++        <<~EOF.chomp % [target, attrs[1]]
     +        <citerefentry>
     +        <refentrytitle>%s</refentrytitle><manvolnum>%s</manvolnum>
     +        </citerefentry>
11:  f4c5c7d593 ! 11:  820bc01e49 doc: asciidoctor: split the format from the code
    @@ Documentation/asciidoctor-extensions.rb: Asciidoctor::Extensions.register do
     +      format = %(<a href="#{prefix}%1$s.html">%1$s(%2$s)</a>)
          elsif doc.basebackend? 'docbook'
     -      process do |parent, target, attrs|
    --        <<~EOF % [target, attrs[1]]
    +-        <<~EOF.chomp % [target, attrs[1]]
     -        <citerefentry>
     -        <refentrytitle>%s</refentrytitle><manvolnum>%s</manvolnum>
     -        </citerefentry>
     -        EOF
     -      end
    -+      format = <<~EOF
    ++      format = <<~EOF.chomp
     +      <citerefentry>
     +      <refentrytitle>%s</refentrytitle><manvolnum>%s</manvolnum>
     +      </citerefentry>
12:  96e981b97f = 12:  69de00c9ee doc: asciidoctor: specify name of our group
-- 
2.32.0.rc0

