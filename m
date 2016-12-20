Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 163D51FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 23:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754412AbcLTXTr (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 18:19:47 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33822 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753962AbcLTXTq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 18:19:46 -0500
Received: by mail-pf0-f176.google.com with SMTP id c4so30980909pfb.1
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 15:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xXGYr3Is+9nHlqXZnTt8MPF/1qOOYHJJTyo+5LuVFPc=;
        b=cgOfNq8tvinTo6JxVk+9RE5fWAMDa9sLj9JftJZ3ed3azskKen+zFuow9PzWdyjZQm
         Z2/mnv99Q1ZTTEB7LumaARu0LXEkH44X710QFQOHcOWfWYD2njztY3rWu5SUmtZE6Ss1
         B8lqjQnHXd1T/GkKO5fHp7xD2ezd7tD2CAo55QE2J3aoTIqw0jH3SlOfnXB7Y2bxleSu
         myVTH5hHP/8XsIEpdq0ltGeyaYsxiYuflwK1IMs+niuMI2k2GOwtvm1YKPUp4HddWOn0
         RA5VGxLovYrKaIsGVSrEAVEuBrEL4sJj1I11P6g261/hT8/U30oASEJwakLfkiQVeHfF
         hZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xXGYr3Is+9nHlqXZnTt8MPF/1qOOYHJJTyo+5LuVFPc=;
        b=Ful8ICGogkwbHLNaq8eiQHX7oCHsLzBBSaVXqhmSxpp73JuwwwGICaa022stNHDJ2I
         cT0buhJcER4qQ02P3RZ/dWMP8XMArJ6GfPMK3q6RF913zxpN7CJud5cOqoRPQkUw6FRd
         hUZQ72doo1syirx6oagaR7TOXfSTvSc8LxLVRpY8plLXc2EQFwET8ln81ZLHtNcY4Fpt
         U1nasf2JOtA8Luu2Rs75MXCFhfISbsFB+NxwndBD0M5ZSJaB4Q1HUHNC96DaXUNnhj53
         u8BuOvIUCQ/FVe5fHhbW5d6jjFcY+4PLpEtfdPxq+7wAE6EvLueNrPx0tC1BraKu3SF8
         hZiQ==
X-Gm-Message-State: AIkVDXKv34kjGpLWV7ilJ/3PNWNJEkHLa9KaXQIlI5bkaUHeor3cQIOwTVG/ABCJmBlWpCrY
X-Received: by 10.98.91.129 with SMTP id p123mr1492611pfb.0.1482275564380;
        Tue, 20 Dec 2016 15:12:44 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6c5b:c771:3806:a807])
        by smtp.gmail.com with ESMTPSA id k125sm15678338pga.40.2016.12.20.15.12.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Dec 2016 15:12:43 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Brandon Williams <bmwill@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        David Turner <David.Turner@twosigma.com>
Subject: [PATCHv4 0/4] git-rm absorbs submodule git directory before deletion
Date:   Tue, 20 Dec 2016 15:12:23 -0800
Message-Id: <20161220231227.14115-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.53.gb7b3fba.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4:
* removed the patch for adding {run,start,finish}_or_die
* added one more flag to the function ok_to_remove_submodule
  (if die on error is ok)
* renamed ok_to_remove_submodule to bad_to_remove_submodule to signal
  the error case better.

v3:
* removed the patch to enhance ok_to_remove_submodule to absorb the submodule
  if needed
* Removed all the error reporting from git-rm that was related to submodule
  git directories not absorbed.
* instead just absorb the git repositories or let the absorb function die
  with an appropriate error message.

v2:
* new base where to apply the patch:
  sb/submodule-embed-gitdir merged with sb/t3600-cleanup.
  I got merge conflicts and resolved them this way:
#@@@ -709,9 -687,10 +687,9 @@@ test_expect_success 'checking out a com
#          git commit -m "submodule removal" submod &&
#          git checkout HEAD^ &&
#          git submodule update &&
#-         git checkout -q HEAD^ 2>actual &&
#+         git checkout -q HEAD^ &&
#          git checkout -q master 2>actual &&
# -        echo "warning: unable to rmdir submod: Directory not empty" >expected &&
# -        test_i18ncmp expected actual &&
# +        test_i18ngrep "^warning: unable to rmdir submod:" actual &&
#          git status -s submod >actual &&
#          echo "?? submod/" >expected &&
#          test_cmp expected actual &&
#

* improved commit message in "ok_to_remove_submodule: absorb the submodule git dir"
  (David Turner offered me some advice on how to write better English off list)
* simplified code in last patch:
  -> dropped wrong comment for fallthrough
  -> moved redundant code out of both bodies of an if-clause.
* Fixed last patchs commit message to have "or_die" instead of or_dir.

v1:
The "checkout --recurse-submodules" series got too large to comfortably send
it out for review, so I had to break it up into smaller series'; this is the
first subseries, but it makes sense on its own.

This series teaches git-rm to absorb the git directory of a submodule instead
of failing and complaining about the git directory preventing deletion.

It applies on origin/sb/submodule-embed-gitdir.

Any feedback welcome!

Thanks,
Stefan

CC: Johannes Sixt <j6t@kdbg.org>
CC: Brandon Williams <bmwill@google.com>
CC: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: David Turner <David.Turner@twosigma.com>

Stefan Beller (4):
  submodule.h: add extern keyword to functions
  submodule: modernize ok_to_remove_submodule to use argv_array
  submodule: rename and add flags to ok_to_remove_submodule
  rm: absorb a submodules git dir before deletion

 builtin/rm.c  | 83 +++++++++++++++--------------------------------------------
 submodule.c   | 57 ++++++++++++++++++++++++++--------------
 submodule.h   | 59 ++++++++++++++++++++++++------------------
 t/t3600-rm.sh | 39 +++++++++++-----------------
 4 files changed, 108 insertions(+), 130 deletions(-)

-- 
2.11.0.rc2.53.gb7b3fba.dirty

