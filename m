Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFDBF202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 18:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966464AbdKPSIQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 13:08:16 -0500
Received: from siwi.pair.com ([209.68.5.199]:13634 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936572AbdKPSHz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 13:07:55 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C8CDE8453C;
        Thu, 16 Nov 2017 13:07:53 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2F12B84535;
        Thu, 16 Nov 2017 13:07:53 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 0/6] Partial clone part 1: object filtering
Date:   Thu, 16 Nov 2017 18:07:37 +0000
Message-Id: <20171116180743.61353-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Here is V4 of the list-object filtering, rev-list, and pack-objects.

This version addresses comments on the V3 version series.

This version replaces the code to scan and reject the filter-spec
for injection characters with a new hex-encoding technique.  The
purpose of this is only to guard against injection attacks containing
characters like semicolon, quotes, spaces, and etc. when a filter-spec
is handed to a subordinate command.  It does not eliminate the need
for the recipient to validate the contents.

This version also combines the various command line flags for
handling missing objects into a single --missing={error,print,allow-any}
flag.


Jeff Hostetler (6):
  dir: allow exclusions from blob in addition to file
  oidmap: add oidmap iterator methods
  oidset: add iterator methods to oidset
  list-objects: filter objects in traverse_commit_list
  rev-list: add list-objects filtering support
  pack-objects: add list-objects filtering

 Documentation/git-pack-objects.txt     |  12 +-
 Documentation/git-rev-list.txt         |   4 +-
 Documentation/rev-list-options.txt     |  37 +++
 Makefile                               |   2 +
 builtin/pack-objects.c                 |  64 +++++-
 builtin/rev-list.c                     | 108 ++++++++-
 dir.c                                  | 132 ++++++++---
 dir.h                                  |   3 +
 list-objects-filter-options.c          | 149 ++++++++++++
 list-objects-filter-options.h          |  57 +++++
 list-objects-filter.c                  | 401 +++++++++++++++++++++++++++++++++
 list-objects-filter.h                  |  77 +++++++
 list-objects.c                         |  95 ++++++--
 list-objects.h                         |  13 +-
 object.h                               |   1 +
 oidmap.h                               |  22 ++
 oidset.c                               |  10 +
 oidset.h                               |  36 +++
 t/t5317-pack-objects-filter-objects.sh | 375 ++++++++++++++++++++++++++++++
 t/t6112-rev-list-filters-objects.sh    | 225 ++++++++++++++++++
 20 files changed, 1770 insertions(+), 53 deletions(-)
 create mode 100644 list-objects-filter-options.c
 create mode 100644 list-objects-filter-options.h
 create mode 100644 list-objects-filter.c
 create mode 100644 list-objects-filter.h
 create mode 100755 t/t5317-pack-objects-filter-objects.sh
 create mode 100755 t/t6112-rev-list-filters-objects.sh

-- 
2.9.3

