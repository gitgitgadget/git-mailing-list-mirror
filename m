Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9F0B20281
	for <e@80x24.org>; Wed, 24 May 2017 05:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969117AbdEXFQR (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:16:17 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33508 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969095AbdEXFQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:16 -0400
Received: by mail-oi0-f66.google.com with SMTP id h4so31065671oib.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TcvyveuhQTETlVFMIj+Awi4RM9Hf+Z5uHXyrDHf4kYc=;
        b=fzeR8YT0fIF7EkOIOLIc2xfnxHQM/Pb7vX+16/g9+1eAm0vQY+mZiiIw8Yk6r3/QCa
         /RAiIyRQwxczm3AAMe+AB/RrZ/eCZODoKc/lhnvi2g17p9o5xNtyodDiRui+vw37O3zA
         J9poAvcVaJyH02nttDDcMZHKxLcd451A5JdSP5kcIYsqr6QoQjnThhijhhBOFcaPIt25
         d/reRby3VG+ySv9io8iRFjCwcuEE/dbefwzP2fBI8hFYXJZGQLSh9eanhE1PIJ3IFWNW
         eDE5wsvmxpiBI4yXlz3hB59P95AFWPJZeSGapdLMU/tFR62G7FiBpba5BZpTqMohQJrT
         zpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TcvyveuhQTETlVFMIj+Awi4RM9Hf+Z5uHXyrDHf4kYc=;
        b=U62Onaov4zoUUJbF41W0ye3i62P6HvDKsz7+t/zyEChMrTfuDFellTzqdcSbnUzWpT
         iJjWyYw9YPewzsve5P8hHrrQ5fwW1bxhXy1DxSIM7JfZLl0Xee+WWTTE/ceZSMIm0fc1
         lrLUE8H6ZPKrJgQ7NhwpQjd0tJN+aLySZV0j+Lzb2q5kfz9IA9NaRK1f7L7MOXiDoY0H
         pIQgc9vq1b+GLAKAyfE7op6HZ26lQ2tymIrqpYe6+ZqDxu5Ynjqf6APJA8WyG2yJk7wG
         1EUPfutvfJ4Hbbr1fCtbQ8AmCcGmIDbUO6iqaKAFnvC9ki3GivrTt55yWAKYNIFHzORH
         t/LA==
X-Gm-Message-State: AODbwcCqCcX7RHMt+4U3n6p+7Wgk//nCwlyyHTvqh+z/eKibpeJcyVs7
        EjR0dApVCvIw+Q==
X-Received: by 10.157.11.166 with SMTP id 35mr4159588oth.51.1495602975675;
        Tue, 23 May 2017 22:16:15 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:14 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 00/29] Add blame to libgit
Date:   Wed, 24 May 2017 00:15:08 -0500
Message-Id: <20170524051537.29978-1-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than duplicate large portions of builtin/blame.c in cgit, it
would be better to shift its core functionality into libgit.a.  The
functionality left in builtin/blame.c mostly relates to terminal
presentation.

Since RFC v2 patchset:
  Rebased (merged in timestamp_t changes)
  Reorganized to split out and group 'mechanical' changes

Jeff Smith (29):
  blame: remove unneeded dependency on blob.h
  blame: move textconv_object with related functions
  blame: remove unused parameters
  blame: rename origin structure to blame_origin
  blame: rename scoreboard structure to blame_scoreboard
  blame: rename origin-related functions
  blame: rename coalesce function
  blame: rename ent_score function
  blame: rename nth_line function
  blame: move stat counters to scoreboard
  blame: move copy/move thresholds to scoreboard
  blame: move contents_from to scoreboard
  blame: move reverse flag to scoreboard
  blame: move show_root flag to scoreboard
  blame: move xdl_opts flags to scoreboard
  blame: move no_whole_file_rename flag to scoreboard
  blame: make sanity_check use a callback in scoreboard
  blame: move progess updates to a scoreboard callback
  blame: wrap blame_sort and compare_blame_final
  blame: rework methods that determine 'final' commit
  blame: create scoreboard init function
  blame: create scoreboard setup function
  blame: create entry prepend function
  blame: move core structures to header
  blame: move origin-related methods to libgit
  blame: move fake-commit-related methods to libgit
  blame: move scoreboard-related methods to libgit
  blame: move scoreboard setup to libgit
  blame: move entry prepend to libgit

 Makefile           |    1 +
 blame.c            | 1863 +++++++++++++++++++++++++++++++++++++++++++++
 blame.h            |  175 +++++
 builtin.h          |    2 -
 builtin/blame.c    | 2130 ++--------------------------------------------------
 builtin/cat-file.c |    1 +
 diff.c             |   23 +
 diff.h             |    7 +
 8 files changed, 2143 insertions(+), 2059 deletions(-)
 create mode 100644 blame.c
 create mode 100644 blame.h

-- 
2.9.3

