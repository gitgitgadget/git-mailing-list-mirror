Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEBAC433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 14:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3289664F35
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 14:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhBZOfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 09:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhBZOfI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 09:35:08 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3D2C061574
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 06:34:28 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id i14so4486290pjz.4
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 06:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F9JRQ+qFyKYSis4G8EzvRrZ7dfrub21bMe2OAWXqRMY=;
        b=Q++5SW3H8yV7PPIlxeMxS1229IrRW2kPxx67mBeQlRzXZtrIrxOXCBfGX7fxqXBG3c
         ZtU7G49bVZupnZIGP/m+b7T1M8z0ysPQ6Eu39ydXAkGz2KIJBigQIoD/cYKk6zaki0n2
         rNa8HG74s57NiJjHqE5eTd90h3/aRrdhB+UvyGgJYtwtULkyAUwJUSaxSzFY5DQxZrS8
         ZzJ0XYbJS1IJPAmUlnrlKnL3oj8RWE78hUJIMRvTD+9py3m0tybuxByHUOu5XTANDJx0
         Yd6LjmNP2iHINf8eKCBhfkuybDWq4B8+4xWmpInPAy1hAKjKkVtvqh2Sp73UDGHQ5V1d
         FPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F9JRQ+qFyKYSis4G8EzvRrZ7dfrub21bMe2OAWXqRMY=;
        b=pcyYqnVk7UF2Uxcm3bPcB+XLUdGhZ82FcQ2sD8+IBBgegzH9bnfs1wxXOgZJ2Gco7b
         o4eQkiVwCYj/Nb1dAgoGzPFQ5Jdu3R27ZOc6Od4um7V3uKaMMB6usvCH7h06+fSeMK6B
         VMjU4gZbQ78MUr2DPTpw76cmk78W+XzlvurNWMD7fxTQWWPwAK8irwgEZ5JOnsxve6co
         WM6XuhJ55hKLOdmNsZQRd5t2voeUoe9zdU1JvvADYuFRfZNz3xS81F8xzKHOowMRmYcv
         GzBvfrWeWY2We3MPZIF/bi6gh5x1KRqm06bAzat7c/vDy6Te+lVbuebdlPqNHwx5h95J
         l4YQ==
X-Gm-Message-State: AOAM532a/BAF9VW5C6AplUbuoYKsWtBjowzEQ5MhvSJvV7cMCWaPwtBo
        23kWRldXtla3QCBYIZ/v/pXWbYkFDQg3CQ==
X-Google-Smtp-Source: ABdhPJwkkW5ZdTl4DfgWknQprvVpVZBiHk4InvdQh85bM40ksuJD7G3MwB2uO/zBi0PaQbemr5dXVw==
X-Received: by 2002:a17:902:9894:b029:e3:7aa3:a499 with SMTP id s20-20020a1709029894b02900e37aa3a499mr3313763plp.11.1614350067755;
        Fri, 26 Feb 2021 06:34:27 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id k11sm9224208pfc.22.2021.02.26.06.34.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2021 06:34:27 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [L10N] Kickoff for Git 2.31.0 round #1
Date:   Fri, 26 Feb 2021 09:34:09 -0500
Message-Id: <20210226143409.21107-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.31.0-rc0 has been released, and it's time to start new round of
git l10n.  This time there are 155 updated messages need to be translated
since last update.  Let's start a new round of git l10n based on this
commit:


    l10n: git.pot: v2.31.0 round 1 (155 new, 89 removed)
    
    Generate po/git.pot from v2.31.0-rc0 for git v2.31.0 l10n round 1.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
