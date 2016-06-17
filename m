Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C1151FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113AbcFQUb4 (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:31:56 -0400
Received: from kitenet.net ([66.228.36.95]:59132 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024AbcFQUb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:31:56 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=P4wx/8nx;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466195489; bh=sOB15VP0IzDLMMTOGYAQjBSLRaKRASX8Lat93JqE9L0=;
	h=From:To:Cc:Subject:Date:From;
	b=P4wx/8nxrVTe55cr0KDcHaWEJLU0FHm5P+GG04Hh1pEDIp2EjIzwUOolMba12p7tE
	 Pa0l/eYSniAjRqsJjFJ0wM15nNseA2uNYKM3EODUPyB4lKSgff7moRHRQXUwrtM5SU
	 n+AnICnE71rcHE3ny0c0xHleMYN3lZ8pIwjwDCus=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH v2 0/4] extend smudge/clean filters with direct file access
Date:	Fri, 17 Jun 2016 16:31:17 -0400
Message-Id: <1466195481-23209-1-git-send-email-joeyh@joeyh.name>
X-Mailer: git-send-email 2.8.1
X-Spam-Status: No, score=-93.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_RP_RNBL,
	RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,SPF_SOFTFAIL,URIBL_BLOCKED,USER_IN_WHITELIST
	autolearn=no autolearn_force=no version=3.4.1
X-Spam-Checker-Version:	SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Reroll of this patch set with changes:

* Renamed the new filter drivers for consistency with other configs.
* Improved documentation with feedback from Junio and others.
* Eliminated %p and instead append the filename to the commands
  (separated by a space).
* Fixed an FD leak and a space leak.
* Only use smudgeToFile with regular files, not symlinks.
* After running the smudgeToFile command, double-check that the
  expected file is present, in case the command was buggy and deleted it.
* Added a warning message when the new filter commands are configured
  but the old ones are not, so that the user knows it's refusing to use
  their configuration.

There's been good and helpful documentation and interface review,
but some more code review would be good! Also, git-annex has a
improved-smudge-filters branch now that demonstrates this interface.

Joey Hess (4):
  add smudgeToFile and cleanFromFile filter configs
  use cleanFromFile in git add
  use smudgeToFile in git checkout etc
  warn on unusable smudgeToFile/cleanFromFile config

 Documentation/config.txt        |  18 +++++-
 Documentation/gitattributes.txt |  37 ++++++++++++
 convert.c                       | 126 +++++++++++++++++++++++++++++++++++-----
 convert.h                       |  10 ++++
 entry.c                         |  37 +++++++++---
 sha1_file.c                     |  42 ++++++++++++--
 t/t0021-conversion.sh           |  64 ++++++++++++++++++++
 7 files changed, 304 insertions(+), 30 deletions(-)

-- 
2.8.1

