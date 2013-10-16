From: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
Subject: [PATCH] status: allow branch info color customization
Date: Wed, 16 Oct 2013 10:22:53 +0200
Message-ID: <1381911773-9564-1-git-send-email-1zeeky@gmail.com>
Cc: Steffen Prohaska <prohaska@zib.de>,
	Alexander Hirsch <1zeeky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 16 10:22:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWMNU-0003Td-Fl
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 10:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757547Ab3JPIWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 04:22:40 -0400
Received: from mail-ea0-f170.google.com ([209.85.215.170]:44954 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab3JPIWi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 04:22:38 -0400
Received: by mail-ea0-f170.google.com with SMTP id q10so140019eaj.29
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 01:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=GJRFZo5GdjBtwBZb7bIzIwDN2V56wiavuSCxm09DrhU=;
        b=yqy+5uu/oVu6rBqoagcUqXdjU/G8meApveww46AYmiGXuMR836K0fqQOxJsDcZKjFj
         VM1DjIMcD4iTQ6gB0NQSs8Tm1BqgE9gp3o7Pu3AEbYD65utQOBnawpSGeqKP3RLZ6ChD
         s9me1aeNHJh3JTsBVBYq6NelhUkbVPNXf2MbKNzfW8b9dCw51W7GB7sB9oVKXy46iTGo
         BF7p2MrEjiLjcHT5A3G8YxZ1TOBc+thsQZHh5Em4c5wfjURxIIQnlSFkeZKfje1N9d2+
         Zjb8MVm1e1L1lxVT2nM9KocIWHW4OyYTqXQYza22+llgjGz0RHH2uXuckZSBidDQR62/
         3WYQ==
X-Received: by 10.15.53.70 with SMTP id q46mr2698105eew.48.1381911756839;
        Wed, 16 Oct 2013 01:22:36 -0700 (PDT)
Received: from mobileblarch.fritz.box (dslb-084-059-154-117.pools.arcor-ip.net. [84.59.154.117])
        by mx.google.com with ESMTPSA id f49sm176690749eec.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Oct 2013 01:22:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236237>

From: Alexander Hirsch <1zeeky@gmail.com>

git status -bs (--branch --short) does not seem to allow customization of the
colors for the local and remote branch.
This patch adds these via the color.status.local and color.status.remote
config variables.

Given the trivial nature of this patch I did not write a test for it. I did a
small check that it's working so, to be on the safe side.

Signed-off-by: Alexander Hirsch <1zeeky@gmail.com>
---
 Documentation/config.txt | 7 +++++--
 builtin/commit.c         | 4 ++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d4d93c9..261fc99 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -904,9 +904,12 @@ color.status.<slot>::
 	`added` or `updated` (files which are added but not committed),
 	`changed` (files which are changed but not added in the index),
 	`untracked` (files which are not tracked by Git),
-	`branch` (the current branch), or
+	`branch` (the current branch),
 	`nobranch` (the color the 'no branch' warning is shown in, defaulting
-	to red). The values of these variables may be specified as in
+	to red),
+	`local` (the local branch when showing branch info), or
+	`remote` (the remote-tracked branch when showing branch info).
+	The values of these variables may be specified as in
 	color.branch.<slot>.
 
 color.ui::
diff --git a/builtin/commit.c b/builtin/commit.c
index 6ab4605..43365b4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1165,6 +1165,10 @@ static int parse_status_slot(const char *var, int offset)
 		return WT_STATUS_HEADER;
 	if (!strcasecmp(var+offset, "branch"))
 		return WT_STATUS_ONBRANCH;
+	if (!strcasecmp(var+offset, "local"))
+		return WT_STATUS_LOCAL_BRANCH;
+	if (!strcasecmp(var+offset, "remote"))
+		return WT_STATUS_REMOTE_BRANCH;
 	if (!strcasecmp(var+offset, "updated")
 		|| !strcasecmp(var+offset, "added"))
 		return WT_STATUS_UPDATED;
-- 
1.8.4.1
