From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Wed, 11 Jun 2008 16:29:56 -0500
Message-ID: <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 23:32:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6XuQ-00040z-Tn
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 23:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbYFKVaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 17:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbYFKVaK
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 17:30:10 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43688 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbYFKVaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 17:30:09 -0400
Received: by mail.nrlssc.navy.mil id m5BLTuTU023329; Wed, 11 Jun 2008 16:29:56 -0500
In-Reply-To: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 11 Jun 2008 21:29:56.0312 (UTC) FILETIME=[4B2E3D80:01C8CC0A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84665>

The stash makes use of git's reflog mechanism, but it is not a reflog
in the traditional sense. Each entry is a state that the user explicitly
requested git to remember. The stash is generally short-lived, but the
user probably expects that a stash will continue to exist until it is
explicitly deleted. So we should not expire stash entries.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin-gc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index f5625bb..5cb74ec 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -30,7 +30,7 @@ static char *prune_expire = "2.weeks.ago";
 
 #define MAX_ADD 10
 static const char *argv_pack_refs[] = {"pack-refs", "--all", "--prune", NULL};
-static const char *argv_reflog[] = {"reflog", "expire", "--all", NULL};
+static const char *argv_reflog[] = {"reflog", "expire", "--all", "--exclude=refs/stash", NULL};
 static const char *argv_repack[MAX_ADD] = {"repack", "-d", "-l", NULL};
 static const char *argv_prune[] = {"prune", "--expire", NULL, NULL};
 static const char *argv_rerere[] = {"rerere", "gc", NULL};
-- 
1.5.5.3
