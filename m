Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75DCC43381
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 13:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0F32253A
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 13:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbhAKNPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 08:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731858AbhAKNPi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 08:15:38 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5533DC061786
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 05:14:57 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w5so16333034wrm.11
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 05:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KM7utspXX88r2BeLzSCHG9hVgbHHc7n9hps+KTXToKY=;
        b=BNvKUEYQbi2d3Lm7tEoWhfCGyZYLl+dEguXKPdP3LmLpLnOJHs6ptdwaJjOvfo15zB
         uDbSog0T4xoL8nGXmeGbmWYZc+ET5jaUb7lD9g1Ix7M8G00aRsoCYODEo4wVYOS1ue0j
         YK+nufbazVmY+eaEZuHSGpjQeMQNZjkN5KepGbNsxo5upeRaqbIkc6YuLm10wJ55udkO
         ckLpmq4/eJRoVZ3x4BAP/guK1qllmRQYCcCiHoJt7Tbhad9CUCKYohbN5LvUsycgXN9K
         okMjsNuTNxTHjK0JlT1GAbcQbcZcAY5AhlvJ19Y6sePS53vlEkoN+Zs3GdLFcBG2oxnW
         Q3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KM7utspXX88r2BeLzSCHG9hVgbHHc7n9hps+KTXToKY=;
        b=m/vTozGSPhmcHmoHYCviepMVS213MkD5Dtf9E+DgsuUT+CyfSyDil5FOrYlXi5bhKe
         GgAZCyZ5vkmN32Je8nNFOFddw2Ow1EmP0KeG0VAVtV43Y5oMDWMNVMr1a1hAgfJvXDR9
         A88ODON+2rSUn6YSJOR+Z9jjfPPfM+gGdM4LsKxB8zdxs5fR8/K08QWujo0hPyGBSp0t
         Wz/LGOQ1SETv0+sn58hNVsVG2JP6U/dFdkYFBE7zpMq00VeGRfHmsaJgx1glkcOd9cUQ
         ccBA9efN/UyNLIW2mpp/PyCLnhDtDiWW9BPnRQ3LefV4kz1+YJUQaOMOhw63umxSwmd1
         JcQA==
X-Gm-Message-State: AOAM5335s7NMcO2IB+F7OGG+avgSYbTC0LLUm6auyCVB0JHxHhZpMOHu
        i2JWiTJj/NL5LzWcSa/viQ7Lo1F7LMY=
X-Google-Smtp-Source: ABdhPJw93eEBcdszI3ridU71MDGFr0F8volKoZtJap5MpQtt5qD1YSYuGeTdyUT/FYDzLNq6vv8FQQ==
X-Received: by 2002:a5d:4882:: with SMTP id g2mr16002900wrq.273.1610370895842;
        Mon, 11 Jan 2021 05:14:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q73sm22924450wme.44.2021.01.11.05.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 05:14:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] Makefile & gettext.c: remove warning & long comment
Date:   Mon, 11 Jan 2021 14:14:49 +0100
Message-Id: <20210111131451.7084-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87pn2b6eyb.fsf@evledraar.gmail.com>
References: <87pn2b6eyb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've got a huge comment in gettext.c that nobody cares about anymore,
remove it, and an old warning in the Makefile while I'm at it.

This doesn't conflict with any other patches I'm about to submit, I
wanted to submit it separately because these are small isolated
non-contentious changes.

Ævar Arnfjörð Bjarmason (2):
  Makefile: remove a warning about old GETTEXT_POISON flag
  gettext.c: remove/reword a mostly-useless comment

 Makefile  |  3 --
 gettext.c | 94 +++++++++----------------------------------------------
 2 files changed, 15 insertions(+), 82 deletions(-)

-- 
2.29.2.222.g5d2a92d10f8

