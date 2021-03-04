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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E4DC433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 14:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 897F664F5B
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 14:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhCDOyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 09:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhCDOyC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 09:54:02 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F19C061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 06:53:22 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id i14so6725737pjz.4
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 06:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gw1eZTHQNZ5i6PdgJwJwmcYf5ZHbUZslZhTo2QzJMgs=;
        b=R+S8+YKYEsmrHm5ptabYlaB08C70mDlClIOJLNtV+PZ8PwSF95svkfHGpIyOmRL0rY
         jpGZuaCP1FfC6eLndnNRzqY0Xrt0UtpkeoO43QVR1ujIUrVF8PPauTz9EX7emsXE1aZt
         q1X5Lm+ax+CT2I35QSgWeQAzhmNFC/nF79IckvvP197nCMeuG/2xNglyjlVUGfv9i24C
         P17AAjmxaqXwMBzT16n31vsWQcUJ2oroaG6sNGTcfULsqNejw2yzuKA98j8Vh9K/swaE
         coY7C3u+HnVVelAK9LttIHw+iZ6EbVSE1AcWucVtvFnLky/jjyka0zNklJE+OHBDjcMl
         ZNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gw1eZTHQNZ5i6PdgJwJwmcYf5ZHbUZslZhTo2QzJMgs=;
        b=XuLyBM0SVmCC3IgHsy68OIfZVv3trM3pDio/malC+TqiOIL+VZoUYzTxFh9KWiKRCy
         mNPnFLSPYX1fthkKEGlrpJAxNI6m1IYmlX81U3g2mjDib+Gn3+w4e4NuOyyyDBLszD9I
         9cMP4g73WK/iYIdiM7K02Hdl/xpqOVo5ayDDOCREl7NAyo8HGm79m2gpHHf+g2WxMJYx
         yeIYA8TXptJokNOXYYaAhKaAvkfZABe8R4Z7ucF/o8LwmplQiU2RKp6z88Fl1ox6vG2A
         gpesJizJga/GypEuj4Iaa7XcpVMBRMHyK2MlWR6MDFWQKiYfeRYMoJsvsFi4p43QfvL3
         mi+g==
X-Gm-Message-State: AOAM533nXkgEQd5jpK2eaxXUynz5Q0RuziDMy1lpNsgcVaYKPMUawTCF
        //7ukMF8yOTxNEpLD/BLHOLKZ55U3Ijibw==
X-Google-Smtp-Source: ABdhPJxR/oLwUZm+EUV1XrJIsCRF+vu7o9X8vAzFpAaK9beLkZDGo4L75oX5hM7+lnnPv7fqNN3dGA==
X-Received: by 2002:a17:902:b601:b029:e3:7aab:704d with SMTP id b1-20020a170902b601b02900e37aab704dmr4405715pls.58.1614869601594;
        Thu, 04 Mar 2021 06:53:21 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id ml17sm11810449pjb.18.2021.03.04.06.53.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Mar 2021 06:53:20 -0800 (PST)
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
Subject: [L10N] Kickoff for Git 2.31.0 round #2
Date:   Thu,  4 Mar 2021 09:53:16 -0500
Message-Id: <20210304145316.15617-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.31.0-rc1 has been released, and introduced 9 new messages.
Let's start a new round of git l10n based on this commit:

    l10n: git.pot: v2.31.0 round 2 (9 new, 8 removed)
    
    Generate po/git.pot from v2.31.0-rc1 for git v2.31.0 l10n round 2.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
