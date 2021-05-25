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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C414C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3367B61423
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhEYKtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 06:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhEYKte (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 06:49:34 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D0DC061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:04 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so28139665otc.12
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=51POGb4PVz86C9No4/aSKqc39zpgVLJ7//Fnf8NHNpU=;
        b=KRNCzkdxYCvT3mx/ePRXnYai0I/Gvw24pM9xr7EykNFG8SG17S42172uKWJGncf6A6
         qOgd5mFCbDkCCWhGOJBco4EbrJ/43+M3dYlrdNdMBfI8tb1nrrjvMJWLoyxHGdAF/Dbs
         /iIBymdwJh3PlZZQ8kFebWpM5s62XYbpQ6EXVToNokjqW+lEruTTpOAEPC00Mk3QXMda
         Ch/QhVOSqZTpM+LDXkEB4icAb9EGLmuiDQrAR7wES7ryqlAQJyWu9v5g6mB1hhA65nNp
         YDibkqqt0czfqqgGENrBXRrnsQgxMBrzW3BYYOfqbYXJWTy1xctYYgN6XXBsC2P2NUqV
         3Sig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=51POGb4PVz86C9No4/aSKqc39zpgVLJ7//Fnf8NHNpU=;
        b=NZUWGgh5PYAsj5346I9V2XysRqHLGn944blnzkVKHS2Ydf+9ComcKq7NQHaVfyJvJP
         MgzdS0R4o1TK3oZYwLXBwqhNt4q0ZcqTe6OS7ZNtkdg6/aj3wXzLHTzVifTU2xDU/k+P
         PGfK9RAxiHp9I6iK5TMMuVBDCehyZ8njzbIF9ZpCqK7yzWzsJYZP6Eh3WrhfQlZ+Fixn
         6H5A5VKW1GIgqIoiWYzdSVFYKKmfD25VOk9v7UH/waqPcxLfiwokwU4nU74cKy8Z/yWs
         C94Jj/6cpr9V++m1CrGfT9nkmI+pDNKnihlDDi4pYi+t3Qc0UjBG5QOeujcN8jooY6/H
         5Big==
X-Gm-Message-State: AOAM532qNtP2IE8nDWMN7WmeW+feHyg+Wpx2cAyv2lrt1m2bZemF7cDn
        wntq6SsTLyDpH76AKXT+ZdMHgK4Sm7/qVg==
X-Google-Smtp-Source: ABdhPJzvHw9m9rknxGRUJwzY7heRLuojHfm7HYBuCijRg8pNtfutYPkvorWfet6JHK2yFGd8uSkkvA==
X-Received: by 2002:a9d:366:: with SMTP id 93mr22938684otv.323.1621939683569;
        Tue, 25 May 2021 03:48:03 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id l8sm3396623ooo.13.2021.05.25.03.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:48:03 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 00/12] doc: cleanup old cruft and asciidoctor revamp
Date:   Tue, 25 May 2021 05:47:50 -0500
Message-Id: <20210525104802.158336-1-felipe.contreras@gmail.com>
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

Nothing changed since v2 except the patches are now generated without `git format-patch -D`.

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

Range-diff against v2:
 1:  f9fe40224d =  1:  f9fe40224d doc: remove GNU troff workaround
 2:  eed7d77e1e =  2:  eed7d77e1e doc: use --stringparam in xmlto
 3:  d8bebb37e4 =  3:  d8bebb37e4 doc: simplify version passing
 4:  2df412bce6 =  4:  2df412bce6 doc: asciidoc: remove unnecessary attribute
 5:  3abdeada0c =  5:  3abdeada0c doc: asciidoctor: remove unnecessary require
 6:  685cd824ea =  6:  685cd824ea doc: asciidoctor: remove cruft
 7:  7f1fb74a04 =  7:  7f1fb74a04 doc: asciidoctor: reorganize extensions
 8:  bede3d2294 =  8:  bede3d2294 doc: asciidoctor: use html-prefix only for html
 9:  2ecd19e4e3 =  9:  2ecd19e4e3 doc: asciidoctor: refactor macro registration
10:  6c5e9142c8 = 10:  6c5e9142c8 doc: asciidoctor: improve string handling
11:  820bc01e49 = 11:  820bc01e49 doc: asciidoctor: split the format from the code
12:  69de00c9ee = 12:  69de00c9ee doc: asciidoctor: specify name of our group
-- 
2.32.0.rc0

