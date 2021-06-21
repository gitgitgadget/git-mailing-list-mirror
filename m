Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6886DC48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF7560FE3
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhFURBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbhFURAp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:00:45 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC523C0219A7
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:18 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id s23so20511207oiw.9
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pu4LeKPFxDDyT7B+zsmhVK3ww/DH8xjZsIBcVFBiWnY=;
        b=V+8g9JjqMvcBdnNe6Lr0JIrVB+cpCLGG4Ky1O1vCPBnGLIGfFx8fMH3ALsIS3W96Qo
         rzpYtWgCNSdRD1Fd77CJNUpLWqipInBDkBLHLbmnBsVoAtjo4UduMjBKL6v0MLP9ukqX
         r7EZR0lzFVa7gf+WK4mlwhAJ4fj+QsYxx2yl6OMUvlP7IQGEsJuxiBamEHWVOP757aaS
         vlzla8nD/imDWnihx4HZWCNyM/zW6UwhukX36Z+nGLosRoRWJ0yBIuQcDCJtR+i21V5x
         sEwvQmofQmZDbtSKHJDf4JnQ+ppg7503Q+ktxZq5eyc8vfiJQ6zCStAq/aI0dnqow9K3
         0Agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pu4LeKPFxDDyT7B+zsmhVK3ww/DH8xjZsIBcVFBiWnY=;
        b=hlQr7n51aEIc1OU7pEx8PRKRhOtOByeJyZadtjjvpjbpcHrRsZfGE0gJMNOo9GILsK
         hu+Z+b8HqoIv7s5h3Mj2BsNiSEqw7K3CNnwZH3RZqcyO1xsiLP7yjA0MyH4KL446y/4+
         8Dq2tjMBk2QfyCi0LjoLyzHaNsnKZYM4YX9kjZ7mJNBYrxN6l7eywfZNiy8Dmhd3OwxQ
         xzKp8HFy2GfHfwH9zrDjrdGy+jgJqAbzguhgbo8S1GIDSQfP4CDmGV2IETKj2vyKZeD8
         b7yBhuQGReTKFozbyvbaKFxc1RcjlN2mtYDD3t8uVC24WrW8wjKPFj4pVG6wYotXLrLr
         u2LA==
X-Gm-Message-State: AOAM530a7T2Gis2qTkefOLRt6da4+Sp/GRZth4/Vj2MhTfHsRjBFudII
        T5QTkS1Dq3OPlhwTJJg6J4ZDtQCHKYyfuA==
X-Google-Smtp-Source: ABdhPJwAq/o6MzuyKTqMEme/VJpwB4ASSBb1+x1Gi4L4n/jGMjxS601g+LH+xJy3KmR9qwC4h07TRA==
X-Received: by 2002:aca:4795:: with SMTP id u143mr24928061oia.165.1624293077770;
        Mon, 21 Jun 2021 09:31:17 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id w12sm3357573oor.35.2021.06.21.09.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:17 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/23] doc: cleanups and asciidoctor direct man pages
Date:   Mon, 21 Jun 2021 11:30:47 -0500
Message-Id: <20210621163110.1074145-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I already sent the first part of this series separately multiple times,
the last one is 4 simple obviously correct patches [1], but since the
maintainer has admitted he has no problem ignoring valid work
entirely due to personal animus [2], I'm sending the whole chain.

There's no point in carefully selecting multiple series of patches to be
merged one by one when all of them are going to be ignored. So I'm
sending all 3 series at once.

Hopefully by sending it all at once some people will be able to realize
that:

 1. They are valid
 2. They are helpful
 3. They make the code more maintainable
 4. They enable new features
 5. They enable the new features to be easily tested
 6. They reduce the doc-diff of the new feature, as well as others
 7. They are superior to the competing series currently in seen
 8. They include work of multiple contributors

Any fair and impartial maintainer would attempt to pick them up.

Cheers.

[1] https://lore.kernel.org/git/20210618215231.796592-1-felipe.contreras@gmail.com/
[2] https://lore.kernel.org/git/xmqqmtrmjpa8.fsf@gitster.g/

Felipe Contreras (21):
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
  doc: doc-diff: set docdate manually
  doc: use asciidoctor to build man pages directly
  doc: asciidoctor: add linkgit macros in man pages
  doc: add man pages workaround for asciidoctor
  doc: asciidoctor: add hack for xrefs
  doc: asciidoctor: add hack to improve links
  doc: asciidoctor: add support for baseurl
  doc: asciidoctor: cleanup man page hack
  doc: asciidoctor: add hack for old versions

Jeff King (1):
  doc-diff: support asciidoctor man pages

Martin Ågren (1):
  doc-diff: drop --cut-footer switch

 Documentation/.gitignore                |   1 -
 Documentation/Makefile                  |  32 ++++----
 Documentation/asciidoc.conf             |  20 -----
 Documentation/asciidoctor-extensions.rb | 103 +++++++++++++++---------
 Documentation/doc-diff                  |  38 ++++-----
 Documentation/manpage-base-url.xsl.in   |  10 ---
 Documentation/manpage-quote-apos.xsl    |  16 ----
 Makefile                                |   8 +-
 8 files changed, 104 insertions(+), 124 deletions(-)
 delete mode 100644 Documentation/manpage-base-url.xsl.in
 delete mode 100644 Documentation/manpage-quote-apos.xsl

-- 
2.32.0

