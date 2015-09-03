From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 00/11] Make "local" orthogonal to date format
Date: Thu,  3 Sep 2015 22:48:50 +0100
Message-ID: <cover.1441316394.git.john@keeping.me.uk>
References: <cover.1441144343.git.john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 23:49:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXcNg-0008Di-1B
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 23:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbbICVtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 17:49:10 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:36466 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbbICVtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 17:49:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id D97F7CDA5E5;
	Thu,  3 Sep 2015 22:49:08 +0100 (BST)
X-Quarantine-ID: <Wog0oOhPtkv1>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Wog0oOhPtkv1; Thu,  3 Sep 2015 22:49:06 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id DEA6A866007;
	Thu,  3 Sep 2015 22:48:53 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <cover.1441144343.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277261>

Since version 2 there are four new preparatory patches which remove
lists of date formats from documentation in favour of referring to the
detailed list in git-rev-list(1) or git-log(1) (both generated from
Documentation/rev-list-options.txt) depending on whether the page in
question is plumbing/porcelain.

I've also reordered the test cleanup patches earlier so that the test
for "--date=raw" is added before the new patch that moves "local"
processing before the "raw" case.  The tests also now wrap long lines
and a missing "&&" has been added.

In patch 7 (date: check for "local" before anything else), we no longer
reject "relative-local" and "raw-local" now prints the user's local
timezone offset.  The error message for invalid formats that are
prefixed with a valid format name is now the same as that if there is no
valid prefix.

Jeff King (2):
  fast-import: switch crash-report date to iso8601
  date: make "local" orthogonal to date format

John Keeping (9):
  Documentation/blame-options: don't list date formats
  Documentation/config: don't list date formats
  Documentation/git-for-each-ref: don't list date formats
  Documentation/rev-list: don't list date formats
  t6300: introduce test_date() helper
  t6300: add test for "raw" date format
  date: check for "local" before anything else
  t6300: make UTC and local dates different
  t6300: add tests for "-local" date formats

 Documentation/blame-options.txt    |   5 +-
 Documentation/config.txt           |   4 +-
 Documentation/git-for-each-ref.txt |   5 +-
 Documentation/git-rev-list.txt     |   2 +-
 Documentation/rev-list-options.txt |  23 ++++--
 builtin/blame.c                    |   1 -
 cache.h                            |   2 +-
 date.c                             |  74 ++++++++++-------
 fast-import.c                      |   2 +-
 t/t6300-for-each-ref.sh            | 162 ++++++++++++++++++++++---------------
 10 files changed, 166 insertions(+), 114 deletions(-)

-- 
2.5.0.466.g9af26fa
