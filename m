Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF2A11F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbeGMRL6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:11:58 -0400
Received: from siwi.pair.com ([209.68.5.199]:31793 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729626AbeGMRL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:11:58 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E24A23F4010;
        Fri, 13 Jul 2018 12:56:30 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7A4C33F400D;
        Fri, 13 Jul 2018 12:56:30 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 00/25] RFC: structured logging
Date:   Fri, 13 Jul 2018 16:55:56 +0000
Message-Id: <20180713165621.52017-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This RFC patch series adds structured logging to git.  The motivation,
background, and limitations of this feature are described at the
beginning of the design document in the first commit.  The design
document also contains a section comparing this feature with the
existing GIT_TRACE feature.  So I won't go into great detail here in
the cover letter.

My primary focus in this RFC is to reach agreement on the structured
logging facility.  This includes the basic approach and the various
logging fields and timers.

This patch series also includes several example usage commits, such as
adding timers around do_{read,write}_index, that demonstrate the
capabilities of the structured logging facility.  I only added a few
examples for things that I think we'll want long-term.  I did not
attempt to instrument everything.

This patch series requires V11 of my json-writer patch series.


Jeff Hostetler (25):
  structured-logging: design document
  structured-logging: add STRUCTURED_LOGGING=1 to Makefile
  structured-logging: add structured logging framework
  structured-logging: add session-id to log events
  structured-logging: set sub_command field for branch command
  structured-logging: set sub_command field for checkout command
  structured-logging: t0420 basic tests
  structured-logging: add detail-event facility
  structured-logging: add detail-event for lazy_init_name_hash
  structured-logging: add timer facility
  structured-logging: add timer around do_read_index
  structured-logging: add timer around do_write_index
  structured-logging: add timer around wt-status functions
  structured-logging: add timer around preload_index
  structured-logging: t0420 tests for timers
  structured-logging: add aux-data facility
  structured-logging: add aux-data for index size
  structured-logging: add aux-data for size of sparse-checkout file
  structured-logging: t0420 tests for aux-data
  structured-logging: add structured logging to remote-curl
  structured-logging: add detail-events for child processes
  structured-logging: add child process classification
  structured-logging: t0420 tests for child process detail events
  structured-logging: t0420 tests for interacitve child_summary
  structured-logging: add config data facility

 Documentation/config.txt                       |   33 +
 Documentation/git.txt                          |    6 +
 Documentation/technical/structured-logging.txt |  816 ++++++++++++++++
 Makefile                                       |    8 +
 builtin/branch.c                               |    8 +
 builtin/checkout.c                             |    7 +
 compat/mingw.h                                 |    7 +
 config.c                                       |    3 +
 editor.c                                       |    1 +
 git-compat-util.h                              |    9 +
 git.c                                          |   10 +-
 name-hash.c                                    |   26 +
 pager.c                                        |    1 +
 preload-index.c                                |    6 +
 read-cache.c                                   |   14 +
 remote-curl.c                                  |   16 +-
 run-command.c                                  |   14 +-
 run-command.h                                  |    2 +
 structured-logging.c                           | 1219 ++++++++++++++++++++++++
 structured-logging.h                           |  179 ++++
 sub-process.c                                  |    1 +
 t/t0001-init.sh                                |    1 +
 t/t0420-structured-logging.sh                  |  293 ++++++
 t/t0420/parse_json.perl                        |   52 +
 t/test-lib.sh                                  |    1 +
 unpack-trees.c                                 |    4 +-
 usage.c                                        |    4 +
 wt-status.c                                    |   20 +
 28 files changed, 2757 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/technical/structured-logging.txt
 create mode 100644 structured-logging.c
 create mode 100644 structured-logging.h
 create mode 100755 t/t0420-structured-logging.sh
 create mode 100644 t/t0420/parse_json.perl

-- 
2.9.3

