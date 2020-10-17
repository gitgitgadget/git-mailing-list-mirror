Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68F2C43457
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 06:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A0B920720
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 06:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic7IKIyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436970AbgJQGCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 02:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436900AbgJQGBk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 02:01:40 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BAAC0604C1
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 19:44:00 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id q9so6322789iow.6
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 19:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BWcru/SyOGnKRzjiyhz2IRU3ua+idxqbzF2TOS4nN74=;
        b=Ic7IKIyQqysma94Jh8TULM79m5SVKyXJU960aBeBOiMWiC51MbhS5QCUqyj1r4G6Rh
         aljjE/8h4h9PjeRXXHK91Y6ZmoOSOVpzyB+6XEbVNQ3/30oDE5Q12P7Gzq3L/jaoKVJL
         XS2jE9HL2Dm5pR/asRgzqU9QruR/e5RqFm0SvC1Hn023rJlKbtzU2KUwHQRvYS39meH2
         uWiRYg0qh00nhCukQXjWZgHnVTeK5zNGfWOWhRRGX74hoM9oPUEcGc4wp+zfqdokcKSH
         WuonNsEeC++DjATYaCFS3s9VHe8OAhAkV1p2VBP2bNGva9E/AZIKZEUVeDEsEQlrI1jk
         IXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BWcru/SyOGnKRzjiyhz2IRU3ua+idxqbzF2TOS4nN74=;
        b=X0xKMGnsmtBiSvPuvE7iOhnmjRUwjPrWvIry7NVBRLc39z/DHek0X5uy5bpfeiXkP5
         WvFKASMTE8PP2V/slxK+LMJ5wfAcG2gHnKDcdgLR/nBcwVGpdJuYOlH4KBOWYHat8VUO
         qg1lcnVvlRWqhBHJGCRxIF+6lneCD1iKoruHD3m6fP/fARr65Z+yfn1n7WeJ/kKFCUdv
         WyGJOvLU9OuIwg/fBgKDREXUdIx3lef5m8DRrhrvgaooH/xLQRbqYxq8+frcm88VQfed
         ZZkmICk7n2pLpLwKqgihfDmneSqDpnJuOtYFd1tLD1lF0UqPOiBSiym2MCZg0CGOEi10
         eF1g==
X-Gm-Message-State: AOAM533rVw+Nh08mV2YJYlU2qsPEzwyvudUUhYsWDFag8XI8r9c4Gk98
        hGhL74IuqkriLdcnRBfJaflMX8WbGIGGKg==
X-Google-Smtp-Source: ABdhPJyB31Z75Si/rPOnquo9F8EI60wugZzvKcNBpC1sDDs4VJGvMe+ElZOqnrFmC44IgChFU0MyDQ==
X-Received: by 2002:a6b:7f43:: with SMTP id m3mr4502709ioq.114.1602902639275;
        Fri, 16 Oct 2020 19:43:59 -0700 (PDT)
Received: from localhost.localdomain ([173.239.199.165])
        by smtp.gmail.com with ESMTPSA id w23sm3641756iod.45.2020.10.16.19.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 19:43:58 -0700 (PDT)
From:   Caleb Tillman <caleb.tillman@gmail.com>
To:     git@vger.kernel.org
Cc:     Caleb Tillman <caleb.tillman@gmail.com>
Subject: [Outreachy] [PATCH 0/1]
Date:   Sat, 17 Oct 2020 02:43:52 +0000
Message-Id: <20201017024353.189792-1-caleb.tillman@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

*** BLURB HERE ***

Caleb Tillman (1):
  Microproject - Use debug-friendly test_path_is_* functions.

 t/t0000-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1

Microproject for Outreachy. Replace test -f with test_path_is_file in t/t0000-basic.sh.
