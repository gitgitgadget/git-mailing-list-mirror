Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04856C77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjDML5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjDML5t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:57:49 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C70526BC
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:57:47 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id y187so2134955iof.4
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681387066; x=1683979066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X2ftnUV4VElWc3TnRSoeEO6c3ag6PTkC6wXG0vRje2U=;
        b=MT0EGH5SFkfK5DCm13EM5X2pGXqEbus5y5Z2tqai8qP2c5tK/fAnzHyOTOHPp2XwXx
         1P0JVtjTli8ITTOG2hWCzGj9H9mPWxrOwc2XHhurw70nIUuBUfxF8wKPhduNVP9HWx8d
         QY+5jQLmvk8vumcolZmL5VBCFJJXxfWqDgsi2vEcK9tGtjo1MhaJbWenzLWOKKd3NF7l
         CbdfNIgTagWZnI3mjm14VBQBVbHTIUVwkCJGELMWD9tpzK3W5HqYoUHvfIwxwdoSt2H1
         PMK3QoKpp4Bz/28oNuUsZob/tXQkJc9kBoFHEPqFH7OMz5XfW4IbAnvpcYJH2Plj+XjW
         Wmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681387066; x=1683979066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2ftnUV4VElWc3TnRSoeEO6c3ag6PTkC6wXG0vRje2U=;
        b=Y00j8uyDmIpO9NVsClOOXjU3YMF4SoHvtPDMLSMmaMXw2qYP2fpPTG8U9aAtNNXiPA
         gDavmZB6cPoTQ0RkUcpw3N5KUG1/mpQx1ET7d7ywhxCWHissgINIB+KrZbedPZFHLL0W
         +iZK0Fco4PpvuAVY0HD42UxJIv93oF46x5Ms59JuAadBwvdrSJ0qlBTGqIuudJ4ngDKv
         Ct5qJmoCUW1LVVOZRq6NJmPD7CXC5CYJe2NMwCzbcDwR24Zi15V1E+BgXHJF58xaleAW
         GsJEIvg9MJDDh4Xm0qKkuAqaOe9uFu6RCnwxyMCzxH5b23wFY/ZBnMNQtVf1UQB26N+Z
         Munw==
X-Gm-Message-State: AAQBX9fzS2e7x5DXyYxQrI9eQ+xvEiptKSTixPQWremfyeOG5IgbjVQI
        34vv331zGXTb9zmb4RobMPaey+/BP9s=
X-Google-Smtp-Source: AKy350aW2BIw2/rebwXAKoSXnjw2t+RkxhXRjYuXNfuzFjKEuqw7jlTdSJMX2JVU/06kOsBNRTm03Q==
X-Received: by 2002:a5e:9501:0:b0:75f:f6eb:aaf8 with SMTP id r1-20020a5e9501000000b0075ff6ebaaf8mr1060229ioj.2.1681387066486;
        Thu, 13 Apr 2023 04:57:46 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id v41-20020a05663835a900b0040bd9a328bdsm416498jal.65.2023.04.13.04.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:57:46 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Johnsen <chris_johnsen@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 00/12] doc: add tests and reimplement xmlto
Date:   Thu, 13 Apr 2023 05:57:33 -0600
Message-Id: <20230413115745.116063-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's never clear what a single change does in the myriad of
{asciidoc.py,asciidoctor}{docbook45,docbook5,manpage} tools, not to mention
xmlto and docbook-xsl.

So I decided to create a very simple test to generate a manpage in different
tools, and the result is that nothing works correctly.

Once the test was running correctly I decided to investigate why xmlto wasn't
able to verify docbook5 documents, and it turns out it's just not supported,
and neither it is in xmllint.

While doing so I realized xmlto doesn't do anything for us, so I wrote a simple
script that does the same thing.

Moving all the old hacks to this gen-stylesheet script, I realized a hack from
2006 is not necessary anymore, and DocBook Stylesheets already generate much
better output.

Getting rid of this generates nice aligment for callouts:

     $ git diff            (1)
     $ git diff --cached   (2)
     $ git diff HEAD       (3)

  1. Changes in the working tree not yet staged for the next
     commit.
  2. Changes between the index and your last commit; what you
     would be committing if you run git commit without -a
     option.
  3. Changes in the working tree since your last commit; what
     you would be committing if you run git commit -a

There's a lot of changes not explored in detail, so this is only an RFC but I
think it's clear something like this is the direction to go.

Felipe Contreras (12):
  doc: add test for doc tools output
  doc: add missing manpage docinfo
  doc: remove unnecessary hack for asciidoctor
  test: doc: add test for docbook5
  doc: fix support for multiple docbook backends
  doc: add gen-stylesheet helper
  doc: get rid of xmlto dependency
  test: doc: use temporary stylesheet
  doc: remove references to xmlto
  doc: stylesheet: move all the xslt templates
  test: doc: add check for callouts
  doc: manpage: remove callout hack

 Documentation/.gitignore               |   1 +
 Documentation/Makefile                 |  19 ++--
 Documentation/asciidoc.conf            |  15 +--
 Documentation/gen-stylesheet           |  28 +++++
 Documentation/manpage-bold-literal.xsl |  16 ---
 Documentation/manpage-normal.xsl       |  26 -----
 Documentation/manpage.xsl              |   3 -
 INSTALL                                |   4 +-
 ci/install-dependencies.sh             |   2 +-
 shared.mak                             |   3 +-
 t/t0600-doc-tools.sh                   | 135 +++++++++++++++++++++++++
 11 files changed, 184 insertions(+), 68 deletions(-)
 create mode 100755 Documentation/gen-stylesheet
 delete mode 100644 Documentation/manpage-bold-literal.xsl
 delete mode 100644 Documentation/manpage-normal.xsl
 delete mode 100644 Documentation/manpage.xsl
 create mode 100755 t/t0600-doc-tools.sh

-- 
2.40.0+fc1

