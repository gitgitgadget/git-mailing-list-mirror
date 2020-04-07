Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D18C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C8520747
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj/NsECg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgDGOLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:11:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40422 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbgDGOLs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:11:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id s8so4061017wrt.7
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=xeBlxp7Py5EhkEkLNWm86FY+7skMjMCdufHgjrR07Y4=;
        b=Qj/NsECgtJEDJ4HoO8Cv8lfpeppIDNYkcCepD6wYo1mWUh9bv6ePP26lCwqs8p+1W9
         TYU5pPPibt+X0IgUv1ysfK+kyGrVdGndfu+G7TfpEihlqRdeN7Jz/f7GPTpTi6go1qy8
         B8mAbiZi15gfs1sw29Vi7Ve2voNj0a5IX1Szlcni3ei6XK52C/KT2hRFZ6l9P9ym5AWV
         pyVF0FSLPU0m9gctpjXbDqAF27akqcgGtFSvZHmdeIsqJH5Tgf9WOXp3DlAZc3N64LYZ
         Jijtn1aAspC7mKkoqhoVHKkL1D0yhpY52Lkqx57J2ciO+Arv0UOv2CSdI/gG7Qo73VvJ
         e/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=xeBlxp7Py5EhkEkLNWm86FY+7skMjMCdufHgjrR07Y4=;
        b=F84GBJ3WF6xsgTqxEWoQn87LX7BbUQsWb666V1gcZpMOvklL/Ez/EuaNA7D6OId+Jb
         NzN9OZbf8ZYgE4dFvBN518qV7TMMj8xRwbmsgsv0HOVck/jJHKqXoDgdu6iPxQrdsO0E
         j69wUEWB4wydtZpx1fiFTAgBHGSmaOKdx+srfVv0gdqaxBNPrPsGKZhT4cqlxGF5WD4Z
         99qvMTm+GIku4hsrZU+8TWltFxPuKiv9oiGqnDJ/H3ItPecGrT+8HKeXJhdFmpn60OY6
         qJ4KVxkbi4jEvTMNYR9iiLzC2Cb06gv8qQcFsVumF/DYBTCPXC1xbLDpQnLoBeLVkj4P
         cGjA==
X-Gm-Message-State: AGi0Puay6pbSH+EAxuzwn+PWOGT411BUYrQPnO254Bpm2J+D7pt+8084
        5xOYE+fOzkPxRgRV82L8YTAgMPIL
X-Google-Smtp-Source: APiQypI9uS2m3pMO/KWrSD1+YW5hTikWaNiloarKZvOdRXLyu77D8UexU0N0tZQ1MEFWnG5LzCA7zQ==
X-Received: by 2002:adf:a308:: with SMTP id c8mr3196986wrb.302.1586268705799;
        Tue, 07 Apr 2020 07:11:45 -0700 (PDT)
Received: from localhost.localdomain (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id v16sm2492693wml.30.2020.04.07.07.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:11:45 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/6] fixup ra/rebase-i-more-options
Date:   Tue,  7 Apr 2020 15:11:19 +0100
Message-Id: <20200407141125.30872-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.26.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The tests for ra/rebase-i-more-options were not as comprehensive as
they could have been and some of the tests that we did have didn't do
a good job of testing what they purported to. This series cleans up
the tests and fixes a couple of bugs (thanks to Jonathan Nieder for
reporting one of them). The bug fix reworks the code to try and make
it clearer.

I've opted to add some cleanup commits on top of Rohit's work rather
than reworking his patches. These are based on top of 4d924528d8
("Revert "Merge branch 'ra/rebase-i-more-options'"", 2020-01-12) there
are some conflicts when merging into pu. I had a quick look at the
conflicts and they appeared to be relatively straight forward to
resolve. If that impression is wrong let me know and I can rebase onto
master or try doing the merge myself and pushing it to github.

Phillip Wood (6):
  Revert "Revert "Merge branch 'ra/rebase-i-more-options'""
  t3433: remove loops from tests
  t3433: only compare commit dates
  rebase -i: fix --committer-date-is-author-date
  Revert "sequencer: allow callers of read_author_script() to ignore
    fields"
  t3433: improve coverage

 Documentation/git-rebase.txt            |  27 +++-
 builtin/rebase.c                        |  49 ++++--
 sequencer.c                             | 109 ++++++++++++-
 sequencer.h                             |   2 +
 t/t3422-rebase-incompatible-options.sh  |   2 -
 t/t3433-rebase-options-compatibility.sh | 201 ++++++++++++++++++++++++
 7 files changed, 368 insertions(+), 25 deletions(-)
 create mode 100755 t/t3433-rebase-options-compatibility.sh

-- 
2.26.0

