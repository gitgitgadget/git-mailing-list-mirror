Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA67AC433DF
	for <git@archiver.kernel.org>; Tue, 26 May 2020 23:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A236A206F1
	for <git@archiver.kernel.org>; Tue, 26 May 2020 23:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZChPjdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgEZXct (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 19:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgEZXct (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 19:32:49 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73777C061A0F
        for <git@vger.kernel.org>; Tue, 26 May 2020 16:32:49 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t11so10839084pgg.2
        for <git@vger.kernel.org>; Tue, 26 May 2020 16:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=knVlasSVS0nOC+QQUSJn7CE1MDmQe4+kWBiE/lPwme4=;
        b=HZChPjdhUl5wn5JpPsp5o+fuRU9hnL4o2i7Y0C7r+0VXL2E8M0BlmsJ71z/Rmd1nAM
         5oDeF4C+U5I6P4Zc+ebXXKELz9AxPxOVxYT83pp185QfhuMzBjdn/7eGECFHMo3dZ3rk
         VcBfB5Q46GeOZRlzzYa4zOsl+wKdYSOEBohJxOxI9G6uOYhDZl4z/2+d7B86PJghGY10
         DG0rZKvpD5DzHURiE8QAJcx+L/cVQnyFlxvOhFUFhPFmy3IPZf3lzQNah8ezAns/o9bI
         JieHZ13+GW5i8ryE2aAwvJ2ZXPaX2Ixve6nuxSeC52sKLMFTa+w10/XAVeM7rKpk5EV5
         RQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=knVlasSVS0nOC+QQUSJn7CE1MDmQe4+kWBiE/lPwme4=;
        b=JnoCwoY3uoIlETWRBxUrbS1aNspC3qTwXvYlOVRB2KHpR+R4QOIPk4YiQdqrW24EqQ
         eEBdt0263bnbgMO0oioGeUMkyRz2ZWs2ie7nPppg8DNuB6Ofst5AURHXPERWLS3Eho7N
         MEobqLBnLP58QYVS7sjnuLaYmG2tHtjUPRn2YY1SR+7VlJQRwysdPZChpC2UpjzcB9Mm
         dWmOdqtdBIeJjMkfQiwM3YT0IQw4MqV7tIB7oQf3MMyiSZNUTYYUzLa0gZ1chfJyF8+J
         6pC6Zl/ewyqlfcbyiTrSHhlTb9iohAsmb2AAvxqb1rNu65GLOzeyw6z45g4HJtkT75g7
         NtUQ==
X-Gm-Message-State: AOAM532rFgj0q1JNLX/GJmMr8o9kCFxWXMCdkMc4rL2yz6cSEBT6BVpU
        OKy83NBe9kWswpTqeISrvfdQlzMIRU4=
X-Google-Smtp-Source: ABdhPJxsvJuBkwRxfuNAIC5Ca97hJaZ0zAewOUdB9qQVmWRHYQo7fgm/W2cAxhLkxHbBjyJPX6pFUQ==
X-Received: by 2002:a62:1845:: with SMTP id 66mr1174226pfy.192.1590535968636;
        Tue, 26 May 2020 16:32:48 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y75sm496585pfb.212.2020.05.26.16.32.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 16:32:47 -0700 (PDT)
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
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [L10N] Kickoff for Git 2.27.0 round #2
Date:   Tue, 26 May 2020 19:32:42 -0400
Message-Id: <20200526233242.28285-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.27.0-rc2 has been released, and it's time to start new round of git l10n.
This time there are 1 new message need to be translated since last update:

    l10n: git.pot: v2.27.0 round 2 (+1)
    
    Generate po/git.pot from v2.27.0-rc2 for git v2.27.0 l10n round 2.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
