Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215C0C4743E
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B11561285
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhFHJCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 05:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhFHJCf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 05:02:35 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9105FC061787
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 02:00:29 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so19646401otl.3
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zlB4qulKTVOXvxMiKnZC0Jd6okxq3jp2xeO58izp0Io=;
        b=NqdImeyEl/Kn6kMgO7dsnIJ/ufalncV7cIB0KFnUJwtu8BfIyIvtw+7KSs5pwG1/Iy
         XidLoNFsXiTT5a2mwgkkgHGpqJgcb8UHSei665P1D57T1zkFmKBGIfjZhZBdu1MTU6q1
         9apHhz/kuCAlNkux1ykroRho9Y2+Sgq5RPFYsgye7De+EvhBk43MIqAHXlZEuldEItD8
         SmEDaUJ+T3EdXCOD13Hl7i0b1w4dFprQMbVGjSIixPup8i0Yc9nyBJ9RYLS6zPy3eLyj
         qOEMLeyTeqTVl3iSXdWxaL65zhqB73LxFv/wNYuLdpWc9ErIt0C9drEmiQIgYoPVzpAf
         UsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zlB4qulKTVOXvxMiKnZC0Jd6okxq3jp2xeO58izp0Io=;
        b=LpHYCh2ltl8eA++ESe7g9KtmuIMkES5EEAU6j/gdl22uJLSIoUy4j9wTav7xoe73rY
         F2H/iIZTqPiSPAB/IqLHGyW4cp4yFQaGVIQEFbelBYjuIB25YqGeG70Q9oYcSl8HNFrv
         MjGqlGAp5YhMePOZ+3KxNY++9PX112ip5xBiGiqXuDtgSDDoQTZvf2p5fZOTs+000opG
         C8eMNMZItEV95+Y6BadBAmYBmPGG07o6cfhBpELi1dMtciKFL4Eu7ytoyUG9oHiRbw7H
         0bzu0qi44MaexzZwX6QtzsDjE0rgjbehSVyPPTRH0jbBLtLjb4sCEMQDQ57yYk/s5U4H
         G3wA==
X-Gm-Message-State: AOAM533poCUb0FZQTd6W57NQCjNnMjUACyRWHi2axZyRcXO1VwjhUL+r
        qDrYIsBo9rE9Oi8UjhwC0lgGsFKluSlL8A==
X-Google-Smtp-Source: ABdhPJz8ediDZ1otQM7XJIomdBuaPnFKbYGcb8rIsx/+d3mgMgVyGRab3r6NZvfi8lJ/pWXqUqhkhA==
X-Received: by 2002:a05:6830:71a:: with SMTP id y26mr16728950ots.242.1623142828629;
        Tue, 08 Jun 2021 02:00:28 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id n17sm2765659oij.57.2021.06.08.02.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:00:28 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 00/12] doc: cleanup old cruft and asciidoctor revamp
Date:   Tue,  8 Jun 2021 04:00:14 -0500
Message-Id: <20210608090026.1737348-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series gets rid of old unnecessary workarounds and convoluted solutions.

Additionally it cleanups the asciidoctor-specific code so it ends up much more simpler.

This goes on top of my other cleanup patches [1] (already in seen), but conflicts with
bc/doc-asciidoctor-to-man-wo-xmlto which in my opinion should be dropped since I have better
proposal.

No changes since last version.

[1] https://lore.kernel.org/git/20210521222941.525901-1-felipe.contreras@gmail.com/

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

Range-diff against v3:
 1:  f9fe40224d =  1:  2a93d8774a doc: remove GNU troff workaround
 2:  eed7d77e1e =  2:  774603b50c doc: use --stringparam in xmlto
 3:  d8bebb37e4 =  3:  8e92e10b10 doc: simplify version passing
 4:  2df412bce6 =  4:  230b5c8ae0 doc: asciidoc: remove unnecessary attribute
 5:  3abdeada0c =  5:  2d1f79d642 doc: asciidoctor: remove unnecessary require
 6:  685cd824ea =  6:  e0b662986a doc: asciidoctor: remove cruft
 7:  7f1fb74a04 =  7:  1bdf72a856 doc: asciidoctor: reorganize extensions
 8:  bede3d2294 =  8:  8612b428ce doc: asciidoctor: use html-prefix only for html
 9:  2ecd19e4e3 =  9:  9cd9f3f317 doc: asciidoctor: refactor macro registration
10:  6c5e9142c8 = 10:  96bd66784f doc: asciidoctor: improve string handling
11:  820bc01e49 = 11:  5e293a15fc doc: asciidoctor: split the format from the code
12:  69de00c9ee = 12:  7fd97fc089 doc: asciidoctor: specify name of our group
-- 
2.32.0.2.g41be0a4e50

