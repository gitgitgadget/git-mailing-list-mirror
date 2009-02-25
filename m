From: Dirk Wallenstein <halsmit@t-online.de>
Subject: [PATCH 3/3] git-show-branch: avoid any column to be flagged as branch head if head is detached
Date: Wed, 25 Feb 2009 11:17:20 +0100
Message-ID: <8e3c6fcd00a6a809bf1cca383a09c8d077c945d6.1235499771.git.halsmit@t-online.de>
References: <cover.1235499771.git.halsmit@t-online.de>
Cc: Dirk Wallenstein <halsmit@t-online.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 11:39:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcHAV-0000ZS-1H
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 11:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761496AbZBYKh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 05:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbZBYKh1
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 05:37:27 -0500
Received: from mailout03.t-online.de ([194.25.134.81]:53418 "EHLO
	mailout03.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760967AbZBYKhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 05:37:25 -0500
Received: from fwd03.aul.t-online.de 
	by mailout03.sul.t-online.de with smtp 
	id 1LcGpd-0002UC-03; Wed, 25 Feb 2009 11:17:37 +0100
Received: from localhost.localdomain (Tb2f+YZJYhc8zL0w92qhKyYoj1ooyps3hfbIBL-1G78q0iss8OHAlPsOsgc43Vig-2@[84.139.85.50]) by fwd03.t-online.de
	with esmtp id 1LcGpL-0Hjvd80; Wed, 25 Feb 2009 11:17:19 +0100
X-Mailer: git-send-email 1.6.1
In-Reply-To: <cover.1235499771.git.halsmit@t-online.de>
In-Reply-To: <cover.1235499771.git.halsmit@t-online.de>
References: <cover.1235499771.git.halsmit@t-online.de>
X-ID: Tb2f+YZJYhc8zL0w92qhKyYoj1ooyps3hfbIBL-1G78q0iss8OHAlPsOsgc43Vig-2
X-TOI-MSGID: 3022bb29-afdc-444c-a99a-01d7cae820e0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111443>

For a detached head, resolve_ref() returns the argument "HEAD"
unmodified. That case is checked for and pretended to be NULL,
which consequently avoids any column to be flagged as branch head.
---
 builtin-show-branch.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 96ae3cb..b073a31 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -766,6 +766,9 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	}
 
 	head_p = resolve_ref("HEAD", head_sha1, 1, NULL);
+	if (head_p && !strcmp(head_p, "HEAD")) {
+		head_p = NULL;
+	}
 	if (head_p) {
 		head_len = strlen(head_p);
 		memcpy(head, head_p, head_len + 1);
-- 
1.6.1
