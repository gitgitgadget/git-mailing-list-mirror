Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24B8C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A13205CA
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPc9CS2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbgKDRrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 12:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgKDRrT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 12:47:19 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4719EC0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 09:47:19 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id i18so15370533ots.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 09:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSmsfbRk9+mw0rHxMq5DW3jYqwyh5F7RCI3ziVqqZtk=;
        b=HPc9CS2vGJDgsUwjk2qVt0w9ATQfvDO8gsV4tOKfPJSZXaPkNo5BCmOMeKNhin4gO5
         N9PpwEpamLnlT+RRGcjIwJuy3qXpTrV0EQxArG2luPVLLlR/sXLbkFV4tOGRfRQRtiad
         SzJe1jCnkUOY1XPI/zPPPt7QplAkEaJ5baf0pDMGCq7IkULA3m/qVLZGQu8LZNsoMFYB
         7FAjvqA9f8AMnWA0R1AJvnmTO4MdNj1AJehrMhnjIJdW+2HqtDI+YpPSjEYqkdrIvJgt
         XCy+/WxMyO04R7/ICpfN9gAVj/FALQbglXJBQI33saF+VelTHB8lptBKaNMCAmumKTRk
         TDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSmsfbRk9+mw0rHxMq5DW3jYqwyh5F7RCI3ziVqqZtk=;
        b=q46ewgccHY80mYQHd6ZaLz+s10o4SQKIVSuxKQtkMf++bR+AU4dP72189IBMNFyYYf
         cLftfk0blvjKbE+0qLNcUJTGeDsuskW5MkR+FqfsEJ/pVwnQb/VCyeoHudhuY3T/29xO
         7grsCy9kAZdtPJzU8tuE+44wj3Dy32j8S3esq2ycdAXN8jRxD6P/opXzzUciXclOyf6z
         UIybdp8421yvuE/ST31N/G2NuTGvqEZsp9/vDf9n6wbWf19oKuSqNLSZv9p5F+cdcL2v
         U6psSZiIpWnj6u0lbOaNUiAzRMTUWsNeWG3oZh+Crvm6PlLu8aCr0IACuFHB2tBXUX2F
         TXaA==
X-Gm-Message-State: AOAM533H0XwOhcTlkeyTjICP42dHwLKeISV4A8fmJN9YDJ2ElEQ9Zlth
        agctk0Jyn2EL70xjAKhl/L3R30UHl603Jg==
X-Google-Smtp-Source: ABdhPJxvpRTEoQR6qJHWSgZuCdsEnR0u9AQNiAWiUuPWQsrR83MfWf8joVjYut7Bb6IHAPuZMLdPYw==
X-Received: by 2002:a9d:4d09:: with SMTP id n9mr19821365otf.334.1604512038468;
        Wed, 04 Nov 2020 09:47:18 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id z49sm622889otb.23.2020.11.04.09.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 09:47:17 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/10] completion: bash: general cleanups and reorganizations
Date:   Wed,  4 Nov 2020 11:47:06 -0600
Message-Id: <20201104174716.783348-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series removes redundant code (add vs. append functions) and
reorganizes some ancient code that is only used in one place.


Felipe Contreras (10):
  test: completion: add run_func() helper
  completion: bash: remove non-append functionality
  completion: bash: get rid of _append() functions
  completion: bash: get rid of any non-append code
  completion: bash: do not modify COMP_WORDBREAKS
  completion: bash: simplify _get_comp_words_by_ref()
  completion: bash: refactor _get_comp_words_by_ref()
  completion: bash: cleanup _get_comp_words_by_ref()
  completion: bash: trivial cleanup
  completion: bash: move _get_comp_words_by_ref()

 contrib/completion/git-completion.bash | 271 +++++++++----------------
 t/t9902-completion.sh                  |  81 +++-----
 2 files changed, 129 insertions(+), 223 deletions(-)

-- 
2.29.2

