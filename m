From: Neil Macneale <mac4-git@theory.org>
Subject: [PATCH] Support ref logs for refs/*
Date: Thu, 8 Jan 2009 00:28:27 -0800
Message-ID: <20090108082827.GA6177@tesla.theory.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 09:40:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKqRH-0004fz-P9
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 09:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481AbZAHIjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 03:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbZAHIjD
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 03:39:03 -0500
Received: from in.theory.org ([64.147.163.250]:51613 "EHLO tesla.theory.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbZAHIjC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 03:39:02 -0500
X-Greylist: delayed 633 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jan 2009 03:39:02 EST
Received: by tesla.theory.org (Postfix, from userid 1014)
	id 1FB1324BB76; Thu,  8 Jan 2009 00:28:27 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104901>

The documentation for git update-ref seems to imply that logging of ref
updates should be done for anything in refs/, though the code looks like it
restricts changes to heads and remotes. Any reason not so support arbitrary
refs?

I don't see much point in logging for tags, so the patch ignores refs/tags.

Thanks,
Neil

Signed-off-by: Neil Macneale <mac4-git@theory.org>
---
 refs.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 33ced65..cfff22b 100644
--- a/refs.c
+++ b/refs.c
@@ -1154,9 +1154,9 @@ static int log_ref_write(const char *ref_name, const
unsigned char *old_sha1,
        git_snpath(log_file, sizeof(log_file), "logs/%s", ref_name);
 
        if (log_all_ref_updates &&
-           (!prefixcmp(ref_name, "refs/heads/") ||
-            !prefixcmp(ref_name, "refs/remotes/") ||
-            !strcmp(ref_name, "HEAD"))) {
+           (!prefixcmp(ref_name, "refs/") ||
+            !strcmp(ref_name, "HEAD")) &&
+           prefixcmp(ref_name, "refs/tags/")) {
                if (safe_create_leading_directories(log_file) < 0)
                        return error("unable to create directory for %s",
                                     log_file);
-- 
1.6.1.141.gfe98e.dirty
