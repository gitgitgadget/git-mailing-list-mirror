Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32732C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 20:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14AE16124C
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 20:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhFRUdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 16:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhFRUdL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 16:33:11 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66250C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 13:31:00 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id x196so11861334oif.10
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 13:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzQLI9w+haX995ssf+WBzRkbN6mjEsEvFToNzRTKuok=;
        b=GsGIKUyIZBbQJBi2NJezdxwcHzr+tEaNMGGkYnZ0hkQhHN8LG6jas+6RAp8VKKcNvC
         3zVYp3azteDxK/dqKo/7HIBJkdVNgI8ev87Yqu+8vEt3/LKonnNDvwklAJBNGdiQhBMX
         N4u2pYJfXw/UiNfzS7mfJRHGynOx5P/6KkOhr+65RZG5pyrLEhVZGh70oyUCdDI9pEZw
         O6bX9tlOAxV4guVmT17HWG+uDy3+9je6h8FL19/g41V7LDF1X4mgrtDi1tYLYtT7R0TF
         wFI7Tk2Y0RH22RFSQ9tToJEooVE9nMN3AxBs7iIQhRLFYSWXlDkF/vjWsM4MFe+sAOL9
         0dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzQLI9w+haX995ssf+WBzRkbN6mjEsEvFToNzRTKuok=;
        b=ARJbbFOkCo/+ifr3p8Nu3yCYR5LRuwFnrL4J/iHflaOylveInckkSmxJ8fjUpiedQh
         sT5/1LbyDlEBA/BOx22HsXaq8g5NHZehbTkaDDBsTV0DP9L9ImEKtZwUE78KK18HjNe/
         AMXobZxJroBRvI6hZV6BWqRAO3/ZWDvpk6yByRRu0H6QPUm8VxdOwyNy2gZ3d9s202bQ
         Jg2fEYZzdHvfd8MkzGUxXkaf86UJ+2+4QddVDYI3XKsP0qJ91Vx//0X6mQg/pf9fyjon
         3qRmunkhTtVuQnQfn7njOl1QDLz+iPUhRLw5pYYKOsUPBwSZNt9K3M7IkpQVycTJstg+
         QYoQ==
X-Gm-Message-State: AOAM5327qT5QfGDDPEbCQomefq9u9pT5ek7G/dzQ/tIHNMso6Mlciglh
        ENkW0ZG/36lzp4xW6k8UhsJtfFkUBOlXDw==
X-Google-Smtp-Source: ABdhPJwAqqApb7HTMPlDUVejzR+YHwfZGATX32PzCQLl7jtud5y4XlyVu+kkoVg+1+dL2Rmj2P6/Sw==
X-Received: by 2002:aca:bfc3:: with SMTP id p186mr10441093oif.109.1624048259461;
        Fri, 18 Jun 2021 13:30:59 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id z6sm2063599oiz.39.2021.06.18.13.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:30:58 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/NOPATCHv3 0/4] doc: asciidoctor: direct man page creation and fixes (brian's version)
Date:   Fri, 18 Jun 2021 15:30:53 -0500
Message-Id: <20210618203057.790320-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm sending this stub series because 1. it's still in 'seen' [1], 2. my
conflicting version is not in 'seen' [2], and 3. brian has not responded
to my constructive criticism of his version [3].

This is exactly the same as what brian sent and is in
bc/doc-asciidoctor-to-man-wo-xmlto, except I have split the first patch
into three logically separate changes, which I did suggest him to do,
but he didn't.

To be crystal clear: I am *NOT* proposing these patches to be merged,
that's why I'm marking them RFC/NOPATCH so there's no confusion.

I think these should be dropped, as my series contains these changes
already, but split logically, with better commit messages, more fixes
which reduce the doc-diff, and contains patches from both Martin Ågren
and Jeff King, as well as many cleanups.

My version has 837 less lines of doc-diff (plus has the
--to-asciidoctor-direct option), and also applies cleanly to master.

On top of these patches I'm going to comment all my objections (again).

[1] https://lore.kernel.org/git/YMvhoXVBoO08ziI1@camp.crustytoothpaste.net/
[2] https://lore.kernel.org/git/20210608090026.1737348-1-felipe.contreras@gmail.com/
[3] https://lore.kernel.org/git/609ed529e2306_431272087@natae.notmuch/

brian m. carlson (4):
  doc: add an option to have Asciidoctor build man pages directly
  doc: add linkgit macros for asciidoctor
  doc: use XML-style escapes only for HTML and XML
  doc: remove GNU_ROFF option

 Documentation/Makefile                  | 25 +++++++++++++++----------
 Documentation/asciidoctor-extensions.rb |  2 ++
 Documentation/manpage-quote-apos.xsl    | 16 ----------------
 Makefile                                |  8 ++++----
 4 files changed, 21 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/manpage-quote-apos.xsl

-- 
2.32.0

