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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517DAC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 09:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF7422255
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 09:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgLOJGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 04:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbgLOJGK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 04:06:10 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD917C06179C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 01:05:30 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b5so795400pjl.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 01:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bC3U5ProjM5tWVXZVbqNpBwN6B065GgJYFYzTruVn+s=;
        b=oY5JOo83HYzW4idukSB/jdqKw2FWGzjQRBPgDkVhUgiCJPjgJDeKplhTGgL6tfqaAj
         HtBZXAW5cT1EwFraG/SMt/sKsl9LFrxi0sHW7n+3SiZHfxp04/DHzOckEdNY/HIpyJl+
         fizeGJLHNrl4g+EfAwWGGMD0ZdtK6gyGfTWL8XzE6IQDN1MHp4d5Gc2cvtTfNt8As6y9
         Ij8oIYSqGkQrvhsdl35rZYDltXLlyMYD5Ze2l1v8NJ/KeFbdtDCuYV5vEx13OKcrTBHe
         Gvr5MRUDvsr4M0diEEGIgwxp4UPERDXDnIjx9PXfFERm7XMlwFSar+drgpav7PqFbvCP
         BZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bC3U5ProjM5tWVXZVbqNpBwN6B065GgJYFYzTruVn+s=;
        b=rTrwYsWcOcWt9IAmW3phUXU0vW2Roy++0KzCkl1lxBeOtEyCEanBD2VJfVBIq8oJUu
         GRCmhcOjxaSnbr9rzPzrSdpvnfaXctqgLz2CTgWz7S9LtZpdkb+bDbpwxzAUIjlu2edR
         nKBnjYmNlOxYXkxGhH0UfqLFrDp4fwTGaoVnU/GSVV9qpZvwfMvyGFt9u7wBId9B3Pk9
         4GPu0Tm2IARdYXDxoSgPqdLaFuwmwwwuepPtLw1urthMR3OlBbRQOnhs1HNfXgACF0J7
         I4JCzzBGtbJb5ZQnKigDEP7xaDEWVjHIfFG4jMjIPbfnhIayDYM9OcSa+8zg6atviC0C
         Tpjw==
X-Gm-Message-State: AOAM533ltF94t+LBN9vRosS837jYBK1IfYVPaBeJ8e1LG23HTPIYz5h7
        TCpGZK4+HBNHM4WybG8fUTg5ZaW26uTax7UB
X-Google-Smtp-Source: ABdhPJwfYPrhZdGgMjbB76K3X/d2W6mcsmnsX2IPJQ8HSPR4MigQujEP4iU6ruVwittI2HhLedEEkQ==
X-Received: by 2002:a17:90b:4a81:: with SMTP id lp1mr29977310pjb.55.1608023130100;
        Tue, 15 Dec 2020 01:05:30 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id k11sm724928pgt.83.2020.12.15.01.05.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Dec 2020 01:05:29 -0800 (PST)
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
        <vnwildman@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: [L10N] Kickoff for Git 2.30.0 round #1
Date:   Tue, 15 Dec 2020 04:05:19 -0500
Message-Id: <20201215090519.27843-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.30.0-rc0 has been released, and it's time to start new round of
git l10n.  This time there are 70 updated messages need to be translated
since last update.  Let's start a new round of git l10n based on this
commit:

    l10n: git.pot: v2.30.0 round 1 (70 new, 45 removed)
    
    Generate po/git.pot from v2.30.0-rc0 for git v2.30.0 l10n round 1.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
