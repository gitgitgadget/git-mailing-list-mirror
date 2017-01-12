Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1405F1FEB3
	for <e@80x24.org>; Fri, 13 Jan 2017 00:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbdAMAAu (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 19:00:50 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34466 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdAMAAt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 19:00:49 -0500
Received: by mail-pf0-f181.google.com with SMTP id 127so20484105pfg.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 16:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2BrbpYPXhLP4yB18CLB2Kh7w1anr5krBaE/nKJN/Kc8=;
        b=cMvuM8imVggj9P0Ps0DfOkPvN1q3ARe2Cd4DFlbU6xaglsSZ37VzQeabmS50utzvn3
         cEoBMD7jRUoZ5jVNgR4Mm/t+9LT9YNv/uIO2PWoHgmDhdlthHV9CI6sVF/Vou4Kjd2aR
         Tq9Nn8Cud48QjCm88aBpmbDZjfhWfO+poQKUilpgbBRWneYQt6QgzHiWFXj1D48O+b+p
         J+cf//OkrHYStlr6eK/f6VnhPkS5ahQSyOCIOlXQrGAcb3UzIziimfdtX2Z8DnIiWl/T
         27l74NiVZZzaaSsR8IJPCUnU2VTIOPf4RIDN5peVfXTISIISrVReJp7dPPoou+UkCePc
         o03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2BrbpYPXhLP4yB18CLB2Kh7w1anr5krBaE/nKJN/Kc8=;
        b=bwkCFViaz6kcixEay0hvDzoNRYguSXg85UOgHMo3sSaizVBp/JhkI0wP1eyz5RXUeO
         q7D+5qj2RLi332PENRudzODqb6a+tFwjQDGjEzaxOsnmhqZw9x2cdYzk5EUUbEDLuu+m
         rZD13lhXckPqiKTtwBI0i3swUhQPNSLIw6x8UIuWgiXbkJ7KhHv9RkRE/1Q8uGy+wX1w
         DTGGlNz9ZQ/bfDomQ00eAYlFX/+MT/1b5fRZCd28QVjjRT+3/ZvUHa3Np3F5GXGSeo/P
         rl8Le0lKQTyZlga1SQxHcankD/5IRitNW8mrQKpFCfkI2wscB9c94OUnzVmMWeknBOHw
         n4qw==
X-Gm-Message-State: AIkVDXL9wwHqC9iTnlJasJfZ3WhlOddY5kjqtg9ac1cnAg699r2aey5YIAbBvuyjlcO55DEh
X-Received: by 10.84.178.195 with SMTP id z61mr25637880plb.176.1484265242070;
        Thu, 12 Jan 2017 15:54:02 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:00 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        pclouds@gmail.com, sbeller@google.com
Subject: [PATCH 00/27] Revamp the attribute system; another round
Date:   Thu, 12 Jan 2017 15:53:27 -0800
Message-Id: <20170112235354.153403-1-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series has been bounced around a bit (from Junio to Stefan) and finally
landed in my lap.  The end result of Stefan's attempt at the series still had a
couple of things that needed more tweaking.  It also has a few patches on top
which added functionality to pathspecs to be able to query into the attribute
system, which I've dropped from this series due to this series' length.

As a reminder the intent of this series is to revamp the attribute system so
that it can be thread-safe as well as a couple of other quality of life
changes.  This entailed removing dependencies on writing global data structures
during the attribute collection process.  Major changes are as follows:

 * The global array used to collect attributes needed to be made local and as a
   result was pushed out to the attr_check structure the caller prepares before
   querying the attribute system.

 * As it turns out the attribute stack ends up being used as a read-only
   structure during the collection process and as such parts of the attribute
   stack can be shared between different threads calling into the system.  To
   enable this sharing the attribute stack frames are stored in a hashmap and
   can be read out (or created and stored in the hashmap) based on the
   directory name of the path being queried.  This is possible because if a
   particular stack frame is included in the overall stack for a particular
   query, all of the frames underneath it will be the same for all queries that
   use this frame (only exception is the info frame which is handled special
   case, see the patch for details).

I took many of the first patches of this series as is from the series Stefan
prepared as as such may only need a cursory glace.  I did modify and change
some of the later patches authored by Junio to address a couple of naming
changes and to redistribute some code between patches so those patches would
need a closer look.

Thanks again to all the work Junio and Stefan put into this before I got a hold
of it.

Any comments are appreciated!

Thanks,
Brandon Williams

Brandon Williams (8):
  attr: pass struct attr_check to collect_some_attrs
  attr: use hashmap for attribute dictionary
  attr: eliminate global check_all_attr array
  attr: remove maybe-real, maybe-macro from git_attr
  attr: tighten const correctness with git_attr and match_attr
  attr: store attribute stacks in hashmap
  attr: push the bare repo check into read_attr()
  attr: reformat git_attr_set_direction() function

Junio C Hamano (17):
  commit.c: use strchrnul() to scan for one line
  attr.c: use strchrnul() to scan for one line
  attr.c: update a stale comment on "struct match_attr"
  attr.c: explain the lack of attr-name syntax check in parse_attr()
  attr.c: complete a sentence in a comment
  attr.c: mark where #if DEBUG ends more clearly
  attr.c: simplify macroexpand_one()
  attr.c: tighten constness around "git_attr" structure
  attr.c: plug small leak in parse_attr_line()
  attr.c: add push_stack() helper
  attr.c: outline the future plans by heavily commenting
  attr: rename function and struct related to checking attributes
  attr: (re)introduce git_check_attr() and struct attr_check
  attr: convert git_all_attrs() to use "struct attr_check"
  attr: convert git_check_attrs() callers to use the new API
  attr: retire git_check_attrs() API
  attr: change validity check for attribute names to use positive logic

Nguyễn Thái Ngọc Duy (1):
  attr: support quoting pathname patterns in C style

Stefan Beller (1):
  Documentation: fix a typo

 Documentation/gitattributes.txt               |  10 +-
 Documentation/technical/api-gitattributes.txt |  86 ++-
 archive.c                                     |  24 +-
 attr.c                                        | 932 +++++++++++++++++---------
 attr.h                                        |  50 +-
 builtin/check-attr.c                          |  66 +-
 builtin/pack-objects.c                        |  19 +-
 commit.c                                      |   3 +-
 common-main.c                                 |   3 +
 convert.c                                     |  25 +-
 ll-merge.c                                    |  33 +-
 t/t0003-attributes.sh                         |  26 +
 userdiff.c                                    |  19 +-
 ws.c                                          |  19 +-
 14 files changed, 834 insertions(+), 481 deletions(-)

-- 
2.11.0.390.gc69c2f50cf-goog

