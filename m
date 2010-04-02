From: Chris Webb <chris@arachsys.com>
Subject: [PATCH 0/6] Add tab-in-indent whitespace rule
Date: Sat, 3 Apr 2010 00:36:50 +0100
Message-ID: <cover.1270250437.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 03 01:37:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxqQM-0004uc-Kp
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 01:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140Ab0DBXgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 19:36:54 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:39371 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069Ab0DBXgw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 19:36:52 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1NxqPz-0004tq-PZ; Sat, 03 Apr 2010 00:36:51 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143861>

This patch set introduces a new whitespace error/fix class for projects and
languages with a coding style where no tab character is used to indent the
lines.

To implement this feature, we need to rework ws_fix_copy() to append to a
strbuf rather than write into a fixed-size output buffer, because tabs may
be expanded into multiple spaces when tab-in-indent is applied. We also have
to change the "catch all errors known to git" to exclude tab-in-indent,
which directly conflicts with the existing indent-with-non-tab rule.


Junio C Hamano (1):
  whitespace: we cannot "catch all errors known to git" anymore

Chris Webb (5):
  whitespace: add tab-in-indent error class
  whitespace: tests for git-diff --check with tab-in-indent error class
  whitespace: replumb ws_fix_copy to take a strbuf *dst instead of char *dst
  whitespace: add tab-in-indent support for --whitespace=fix
  whitespace: tests for git-apply --whitespace=fix with tab-in-indent

 Documentation/config.txt   |    2 +
 builtin/apply.c            |   81 +++++++++++++++++++++-----------------------
 cache.h                    |    3 +-
 t/t4015-diff-whitespace.sh |   42 +++++++++++++++++++++++
 t/t4124-apply-ws-rule.sh   |   53 ++++++++++++++++-------------
 ws.c                       |   73 ++++++++++++++++++++++++++++-----------
 6 files changed, 166 insertions(+), 88 deletions(-)
