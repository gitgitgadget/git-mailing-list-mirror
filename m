Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22073C2D0C0
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 01:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB46206DB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 01:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki/5o+ZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfL3BsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 20:48:05 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:45781 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfL3BsF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 20:48:05 -0500
Received: by mail-pg1-f182.google.com with SMTP id b9so17279446pgk.12
        for <git@vger.kernel.org>; Sun, 29 Dec 2019 17:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nMo5JR2Ogv/V9DdihWJVMA3k6lFWKD0uc7V7jJOpMs8=;
        b=ki/5o+ZEFZsyglvexEnB/PpXXFfkitE6FRnwt3E87dazBhlBrPF5PoTCqmma+FWvX2
         Axnvjw4ESsS8mqGQ4iUnBHvJcDXSuwbhXLBddFnI6O/bTNPMp/Vlk7Otvu/7iyYe8Twy
         2GQinUhgKJK0pLdccfL3wskwKqAbzRiZL378cfo6l+jCwpgfYZbFMgbattGIfVrAKvJX
         Kzi0dyD3X7qgWuZe16JjiQvcCwQWuq8OfcnZzV1drKnOz0bYOo4qsKUp2SxLux3V9inx
         ihcaRjL3aUXs4zWDep7TpR+HUwbFiHLf2KAwKtPSyGKQh7CZHafNkc6TGIDV9gXmlEyk
         zp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nMo5JR2Ogv/V9DdihWJVMA3k6lFWKD0uc7V7jJOpMs8=;
        b=bpncD6G32H+1wijOWOvszhBOvVUCIWU1ABoSZhlCtp6tU8xXS1FM/5LnjbE4nrEMQp
         LHYRLVM+0TuPQ5hWaMuNjldaEsR511bN9Z7IZTyodLuHYHtcgBvByoLAM1nmu1EFVvXm
         HzPPLtsdkij2nxydbT9Y5mzi6gvwb78ZQ/3BLu8qK7d2OimtFXfvuJtQSkNYRaP36iW4
         NdaNP0b87P3Co8kuCi7ECOVKWgQJp7cNrncUcQkA4YDZSI2vJaoTVzJgCWcaef6gZTXb
         IzRD7DIwmF0m7oR1NCZPcG7t9s+NfiOPnCsbtraq/Vu47yJL6L0v9L0LRIDQoDtnTuwu
         4ckA==
X-Gm-Message-State: APjAAAWIWWv2r5njgJjG/bzY7HsgZPI1VnyO+qomi8T0xhZj3KCnpcI9
        DO26HiUwfeplSwh445h+Pe0brmNmeVM=
X-Google-Smtp-Source: APXvYqwTdPs8d54/ZZbKlvHzWal31+FjloUcsPTCndBlrYyc/3g3NlBTvZgRWaei9HOWTgN/S9qX9A==
X-Received: by 2002:a63:4006:: with SMTP id n6mr60876776pga.139.1577670484234;
        Sun, 29 Dec 2019 17:48:04 -0800 (PST)
Received: from localhost.localdomain ([47.89.83.2])
        by smtp.gmail.com with ESMTPSA id z4sm22166318pjn.29.2019.12.29.17.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Dec 2019 17:48:03 -0800 (PST)
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
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [L10N] Kickoff for Git 2.25.0 round #1
Date:   Mon, 30 Dec 2019 09:47:50 +0800
Message-Id: <20191230014750.98013-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.24.1.3.g88d0f1013d.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <worldhello.net@gmail.com>

Hi,

Git v2.25.0-rc0 has been released, and it's time to start new round of git l10n.
This time there are 119 updated messages need to be translated since last update:

    l10n: git.pot: v2.25.0 round 1 (119 new, 13 removed)
    
    Generate po/git.pot from v2.25.0-rc0 for git v2.25.0 l10n round 1.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
