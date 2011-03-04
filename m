From: Ferry Huberts <mailings@hupie.com>
Subject: [CGit] [PATCH v2 0/6] Communicate the repo name to the filter scripts
Date: Fri,  4 Mar 2011 01:31:29 +0100
Message-ID: <1299198695-23215-1-git-send-email-mailings@hupie.com>
Cc: hjemli@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 01:31:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvIvv-0005Zb-PY
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 01:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759175Ab1CDAbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 19:31:44 -0500
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:62926 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759147Ab1CDAbn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 19:31:43 -0500
Received: from paul.internal.hupie.com (paul.internal.Hupie.com [192.168.180.1])
	by mail.internal.Hupie.com (Postfix) with ESMTP id 4983958BD88;
	Fri,  4 Mar 2011 01:31:36 +0100 (CET)
X-Mailer: git-send-email 1.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168417>

From: Ferry Huberts <ferry.huberts@pelagic.nl>

Changes compared to v1:
- Rewritten to communicate the repo configuration via environment variables


This patch series fixes two bugs, does a cleanup and communicates the repo
configuration to the filter scripts.

I have a server setup in which each repo has a trac instance and
for the commit filter I really need to know with which repo I'm
dealing in order to be able to resolve the #123 ticket numbers
into hyperlinks into the correct trac instance.

Patch 0001 fixes a memory leak and can be applied regardless of the other
           patches.
Patch 0002 makes sure that all arguments for the filter are correctly
           initialised so that the argv[] list is always terminated with a NULL
           pointer, which is currently not the case for the source filter.
Patch 0003 does a cleanup by introducing an enum for the filter type so that
           the number of extra arguments can be determined in a single place.

The other patches implement my desired functionality.


Ferry Huberts (6):
  source_filter: fix a memory leak
  new_filter: correctly initialise all arguments for a new filter
  new_filter: determine extra_args from filter type
  cgit_open_filter: also take the repo as a parameter
  cgit_open_filter: hand down repo configuration to script
  filters: document environment variables in filter scripts

 cgit.c                         |   34 +++++++++---
 cgit.h                         |    6 ++-
 filters/commit-links.sh        |   11 ++++
 filters/syntax-highlighting.sh |   11 ++++
 shared.c                       |  110 +++++++++++++++++++++++++++++++++++++++-
 ui-commit.c                    |    6 +-
 ui-repolist.c                  |    2 +-
 ui-snapshot.c                  |    2 +-
 ui-summary.c                   |    2 +-
 ui-tree.c                      |    4 +-
 10 files changed, 169 insertions(+), 19 deletions(-)

-- 
1.7.4
