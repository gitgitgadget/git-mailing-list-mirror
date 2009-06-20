From: newren@gmail.com
Subject: [PATCH 4/7] fast-export: Do parent rewriting to avoid dropping relevant commits
Date: Fri, 19 Jun 2009 22:37:00 -0600
Message-ID: <1245472623-28103-5-git-send-email-newren@gmail.com>
References: <1245472623-28103-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusambite@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 20 06:44:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHsRe-0005Kf-HZ
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 06:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbZFTEoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 00:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbZFTEoj
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 00:44:39 -0400
Received: from mail-px0-f202.google.com ([209.85.216.202]:36261 "EHLO
	mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbZFTEoj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 00:44:39 -0400
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jun 2009 00:44:38 EDT
Received: by pxi40 with SMTP id 40so336660pxi.33
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 21:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WZS6IYduxiRhNsPsgTtoVeTXkyVQORJVsHE3vQFfEas=;
        b=g0gt2wrJBu//1WL9h2xPctnYhKUdGH6/M6OQXrvtmH/+ji7uUl/xWoAsMg5yFqVHco
         fMVJmnWbNJZkxyRY5PxA5RQAB29eXG54ofIW5eGmmlDXCbDVA7fcPnEAvIPkeBE9QpBP
         1PVHZaX4XzA2O0SHcReOogzQ6V7cvN0IYaJrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=srTQWlv2oB4Fmcl7QVYzOj6FbMT5O2w8cgjPZwKQvdzZ4WIuxaEwDfkAeioiAKp+pf
         dP2kh6M7e8cbsf10BQp2+v4llWObK3BY/V2vSCbfT0Eclu/tzuozA5lL8urh2Kb1IhRK
         TjN4cM3h664loeuEN/ZkXrjvf0Gl62WUiGOyk=
Received: by 10.143.158.5 with SMTP id k5mr1646849wfo.279.1245472772429;
        Fri, 19 Jun 2009 21:39:32 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 22sm39467wfi.32.2009.06.19.21.39.30
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Jun 2009 21:39:31 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.323.gfb84f
In-Reply-To: <1245472623-28103-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121927>

From: Elijah Newren <newren@gmail.com>

When specifying paths to export, parent rewriting must be turned on for
fast-export to output anything at all.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Try 'git fast-export master -- COPYING' in git.git and notice how there
is no output at all (whereas 'git rev-list master -- COPYING' does show
some existing revisions).  This simple patch restores the missing file
and commit in the fast-export output.

 builtin-fast-export.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 9aa409b..b60a97e 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -532,6 +532,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 
 	revs.topo_order = 1;
 	revs.show_source = 1;
+	revs.rewrite_parents = 1;
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	revs.diffopt.format_callback = show_filemodify;
-- 
1.6.3.2.323.gfb84f
