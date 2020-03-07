Return-Path: <SRS0=zTfj=4Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D381C10DCE
	for <git@archiver.kernel.org>; Sat,  7 Mar 2020 02:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BBD2070E
	for <git@archiver.kernel.org>; Sat,  7 Mar 2020 02:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvG7GL60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCGC1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 21:27:37 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:35714 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgCGC1h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 21:27:37 -0500
Received: by mail-pf1-f173.google.com with SMTP id u68so1286863pfb.2
        for <git@vger.kernel.org>; Fri, 06 Mar 2020 18:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LzOVE2pkoU4yb9XAG+I9J2cIlolekwWvRaQ+V2jKkIY=;
        b=MvG7GL60AC+Z926wqEN4ypeGEyuVK7lrqzLnukffXwsnaMxJqqkXs5f+RDu6O29wyx
         CuVOiehSiK8amawv/TZxwwIsNX2byv4LH7oq2Ua5EqXP8gEsNbN4laatiA4APa8ZKkhR
         hALMl6lWpMQ38S3CJALVPbk52jhieAmjzZutonTPjzRG13BhgNZ9Zit9xwWtmgyvX/jH
         hjghjDMXBFMw8/E7YpEvo0zCR12x3Er8XSMm33EszLKkYGu+B7tsICt1NTJGk91FS5HQ
         T7I3FdJJVYBtZf2mGy1IYrP5pZozd0peKBC7WFYVN0rraPiSUdwqV4H8NnTdBlpmVmum
         GOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LzOVE2pkoU4yb9XAG+I9J2cIlolekwWvRaQ+V2jKkIY=;
        b=CyE5qTsCEyBV7IV9atxJ4h1dls+KnTCl72fjgdWkWQ3pIw8Fu+zzgMEQc31bLbUMVB
         QxPCcfgC54Ah6vmDQA+V67flosfDma1awMPJ7VVLd19kLDg4nwh/tO9xbl9dn3asbFBB
         MkAFnk0W35rWUtufDWrspEZLahvxDS/yVDw2hz/x2ZhGNGGvCfFgVQjArNvK+LJKM6fB
         AU1e/Vx3a9yKfCTI8m8jdehbNw/CJm+PnwRROsaFrzxZ7O6JVPkoU4vfLe0PAM7yx++A
         XpXN+12JmMD9fVy5XUA9ln5EX2DPfBh6XVwRJCwDrVNbkaKVFZx7J6Y4x4ITf+fFe1KG
         m/dw==
X-Gm-Message-State: ANhLgQ1HG4BfwCiNjByvysNI3mTxbsUATk/WWMZuDXcBy7IDDGKAJcux
        u9AaappwRQA4HFhW/HG/hOOs+xXk11F2eA==
X-Google-Smtp-Source: ADFU+vtdjVtrI9fe2T5VK0AJD6I7tYdX1oDGBDsqWyEbcYSWRaQIA0MqY5Z9LSiHK6QOdqzqFy5SvQ==
X-Received: by 2002:a63:565e:: with SMTP id g30mr5957285pgm.206.1583548055831;
        Fri, 06 Mar 2020 18:27:35 -0800 (PST)
Received: from localhost.localdomain ([117.136.0.199])
        by smtp.gmail.com with ESMTPSA id y9sm1351016pgo.80.2020.03.06.18.27.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2020 18:27:34 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        =?UTF-8?q?Emir=20Sar=C4=B1?= <bitigchi@me.com>
Subject: [L10N] Kickoff for Git 2.26.0 round #1
Date:   Sat,  7 Mar 2020 10:26:44 +0800
Message-Id: <20200307022644.9949-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.26.0.rc0.5.gb02b988a14.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <worldhello.net@gmail.com>

Hi,

Git v2.26.0-rc0 has been released, and it's time to start new round of git l10n.
This time there are <<NUM>> updated messages need to be translated since last
update:

    l10n: git.pot: v2.26.0 round 1 (73 new, 38 removed)
    
    Generate po/git.pot from v2.26.0-rc0 for git v2.26.0 l10n round 1.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
