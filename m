Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1E041F731
	for <e@80x24.org>; Fri,  9 Aug 2019 03:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfHIDCU (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 23:02:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41805 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbfHIDCT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 23:02:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so44209218pls.8
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 20:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5JQwDQPPcUTuXiO+twlE2opiZy8hSok0Ch/7ke2Sb6I=;
        b=RNUepgr4WnMT7LQ9yQbiruzTMJyC9NmKY4zYM3yrU3YRYejs19+lASqhZ8hnLE6rU/
         oFyNvnaeATQrNxUsHcVR2fonkr+fPPnOJ2iGSsp9AekgG3eYcsYTWkEbXCK6oj6CBi7Z
         6uiIU2COkvIHYXyG6DDzoeOr3s06YBI+lqFSy+Znarq6UvHO4PO4rNHJ9jf1vJjQxsQm
         l7AUtOftkTq7QvQgtJcqy1JC+0/HEGBTHs+t3p0eQPSkxKx50izkgKlcDuWhgNdoRxbC
         LASNJ66PISAe8cGY9NRyWib8Ot0xe9f1C9VY2+GryU8g7kjuySR7eDOsG92ShIkKAxOH
         2mWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5JQwDQPPcUTuXiO+twlE2opiZy8hSok0Ch/7ke2Sb6I=;
        b=I/rGtvSXHeR9NN9FKtntHdwrjLosn/SZ9M6D8Lr0F9xi0uZkV5brbErde9jatbTF+1
         BohTo42UU7wNCiMqxoDLuJIEp5L0Di1o7dxkjpUZQJmLhGKRQyi/Vl7kPApdfVzy+cPx
         MUVfZfLxpXWMNf98Y/aQWV0GYNcbYdQMcH8u309hLUCPWme+etQw8vgtclL7qEK/gbSs
         zRgIex6oDE9jaEeGKJzFhwBCJFHl3dzy4sACqrGhlP/T3Kr5N9i5y5bvIRtUKqarJPQF
         Ugzgk7GIfDxuQh25BpabOnwfYqy14L2XYo83k2uNg6vsVsURLoUE3ffq+yjcJ+ZytKvP
         nuSQ==
X-Gm-Message-State: APjAAAXhVJ5Zbji4bWHRqX1h0+ER1ZN7FW4QkYxElX/KISxdSvYgulp4
        V6tg4PhamB9T2MYplWh4Dcg20g2SKtk=
X-Google-Smtp-Source: APXvYqxvg2kb2Q9yhfT5yNE62jNLq9BiHQAv/S07H6a/19E2fa7oL3JeX1KRZztMmz90zoRIZZFOxA==
X-Received: by 2002:a17:902:e58b:: with SMTP id cl11mr16406371plb.24.1565319738504;
        Thu, 08 Aug 2019 20:02:18 -0700 (PDT)
Received: from localhost.localdomain ([205.209.24.227])
        by smtp.gmail.com with ESMTPSA id h1sm124965938pfo.152.2019.08.08.20.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 20:02:18 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, johannes.schindelin@gmx.de,
        l.s.r@web.de, michal.kiedrowicz@gmail.com
Subject: [RFC PATCH v5 0/3] grep: almost no more leaks, hopefully no crashes
Date:   Thu,  8 Aug 2019 20:02:07 -0700
Message-Id: <20190809030210.18353-1-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190807213945.10464-1-carenas@gmail.com>
References: <20190807213945.10464-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a candidate reroll for cb/pcre2-chartables-leakfix, that
hopefully addresses the root cause of the problem reported by Dscho in
Windows, where the PCRE2 library wasn't aware of the custom allocator and
was returning a pointer created with the system malloc but passing it to
NED's free, resulting in a segfault.

The most likely reason why it was triggered by the original leak fix is
the layering violation reported by René and that is likely exclusive to PCRE2
(hence why it hasn't been reported with PCRE1). Additional work might be
available in a future release of PCRE2 to address that as detailed in an
upstream bug[1] report.

Changes since v4 (only in patch 2):

* git log change reverted, still not sure where it will fit better and worst
  case will leak a few bytes when -P is used.
  since the users of this API are doing it indirectly it might be problematic
  long term though, but luckily since it is most of the tine a NOOP and can
  be called multiple times might be ok to do it unconditionally
* slightly better looking code

Changes since v3 (mostly in patch 2):

* git log also calls the "destructor" for grep API
* no more "bug" being triggered by make test, sorry René
* hopefully no more crashes in windows (I was expecting at most a BUG)

Future work (other than the needed refactoring explained in the
second patch) and adjacent bugs, includes:

* tracking more possible users of the grep API that might need to call
  grep_destroy()
* completely moving PCRE2 to use NED (as is done with PCRE1 and was
  proposed on the original patch[2] this is based on
* build on top of the new API so that other work could be shared
  (for example the chartables that started this whole mess)

or (hopefully not)

* ignore the original leak (maybe with an UNLEAK) as René suggested [3]
* discard this work and just use Dscho's fix (with some improvements,
  like using xmalloc)

[1] https://bugs.exim.org/show_bug.cgi?id=2429
[2] https://public-inbox.org/git/3397e6797f872aedd18c6d795f4976e1c579514b.1565005867.git.gitgitgadget@gmail.com/
[3] https://public-inbox.org/git/7ec60d57-9940-35f2-f7b5-c87d4dc7cdd5@web.de/

Carlo Marcelo Arenas Belón (3):
  grep: make PCRE1 aware of custom allocator
  grep: make PCRE2 aware of custom allocator
  grep: avoid leak of chartables in PCRE2

 Makefile       |  2 +-
 builtin/grep.c |  1 +
 grep.c         | 71 +++++++++++++++++++++++++++++++++++++++++++++++---
 grep.h         |  2 ++
 4 files changed, 72 insertions(+), 4 deletions(-)

base-commit: 51cf315870bbb7254ddf06c84fe03b41bc48eebd
-- 
2.23.0.rc1
