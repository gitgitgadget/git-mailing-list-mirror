Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35349C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 04:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99C222B2C
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 04:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgLUEoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Dec 2020 23:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgLUEoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Dec 2020 23:44:16 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89212C061285
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 20:43:36 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id f132so10066559oib.12
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 20:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IoizOwkcKt+Mkughmtg5NMW/zj8GWTbnbbYgaUcEuKE=;
        b=bdjq0H8+meyRhZATJ4HxLrmjSn1nKkAborFr8Qn87bQ7oieIlV2jYrFpyCs7WRH4s5
         dhW5rU8vpXU4OhDoWqea+diYFuq8s6u1HIzQWnjh5GuFAey4ahx+75ui8M3X60LRe3vB
         CNd6QAWG1ifgLGFHFUgcrIYZpdDCqgaeRfr3vQL/rzzEgTpv7014rjlscteS2Pj4gWLV
         ugYihP5UVO/h2MbpF8a4vke6+KsEdpPcBG0beZoCtt4vV8dweJYgCG8nFDhnvklNLpOf
         Rpfhl3kyFb9boa62+3PdWYKfZGufVMuHttltbfbBrrfc06F9wSR+KMyyw4mf24tejzmo
         DEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IoizOwkcKt+Mkughmtg5NMW/zj8GWTbnbbYgaUcEuKE=;
        b=C50I2UGrKm/QuiuxDZP5KDawpNb7CMbrAIoh7Uj2WZfL3OVQTQC+GkBfMMrW2qYnMm
         pWyUUZ3L5YIjkXm4nuJQkOkVEdAX/NUPUMiL5o+Z4+LwgSwtVJelbiJcLQJazCOu7+8R
         yiIDjsc8b7FjtJ7VIMGjKGtjFgtMNF4WTvyMhvSblnALXvcQTp7CeAblrejuUT2RU69b
         dVtow39HjBtDw272CTPUbgWLRWhon1CDgUNaAYa7rmKVEkJmBQejPlOv9qH5h53fg9Wp
         N9wbFcxsG5t+ibALEnrEGp4KZ+U6O8JApSNJsEmswKZM7TsCV4m8Es7+ZieYyNHIHgFZ
         pyVw==
X-Gm-Message-State: AOAM532yuIg+0VZs7UUO6S5mtnrR5igKzuLlTkanwiBkqEiL4HHkRICM
        XfcrGXp40fCIeyPHzLGxrn6mY/Dgk8B1URcL
X-Google-Smtp-Source: ABdhPJyQGN+ta+Z4FnDgP3o6EDJPnfO+vp9zClHWuXfF25s6dl08bGN8e7Xl0SsSl6tE+y5cyd+3dA==
X-Received: by 2002:a17:90a:ab8e:: with SMTP id n14mr14149208pjq.96.1608506591482;
        Sun, 20 Dec 2020 15:23:11 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id u3sm15573728pjf.52.2020.12.20.15.23.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Dec 2020 15:23:10 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Emir SARI <bitigchi@me.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>,
        Arusekk <arek_koz@o2.pl>
Subject: [L10N] Kickoff for Git 2.30.0 round #2
Date:   Sun, 20 Dec 2020 18:23:06 -0500
Message-Id: <20201220232306.16009-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

With the release of Git v2.30.0-rc1, one message has been updated.  Let's
start a new round of git l10n based on this commit:

    l10n: git.pot: v2.30.0 round 2 (1 new, 2 removed)
    
    Generate po/git.pot from v2.30.0-rc1 for git v2.30.0 l10n round 2.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
