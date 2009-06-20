From: newren@gmail.com
Subject: [PATCH 3/7] fast-export: Make sure we show actual ref names instead of "(null)"
Date: Fri, 19 Jun 2009 22:36:59 -0600
Message-ID: <1245472623-28103-4-git-send-email-newren@gmail.com>
References: <1245472623-28103-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusambite@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 20 06:46:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHsSy-0005pM-1v
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 06:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbZFTEqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 00:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbZFTEqB
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 00:46:01 -0400
Received: from mail-pz0-f195.google.com ([209.85.222.195]:47763 "EHLO
	mail-pz0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbZFTEqA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 00:46:00 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jun 2009 00:46:00 EDT
Received: by pzk33 with SMTP id 33so119885pzk.33
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 21:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=uKSRi+w8M51KufYwyQV3FDZfZqc9yApUORGqKqkVetw=;
        b=auc88rqAB69d7ETFzHoQcHkDzmTgHRe7s2zbYR1bs5HgCk834RvkesOVUKHc9r2Ib8
         6FC11TUnfm8e1LVVLzV71IZiA3IpmHb9nGiavvf46tu0OamE//T6pcZQRYwy4N9fJV+q
         iBtNyUCGe1vmb+vLUtRvN+jY4xEdEzjYVyVHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EHUMKKQ0tXgVhYYLc047PZh7uqRV4plYd0NsU7qbDACMo045Xhqt30X1+A6JHwFyx8
         0uyHRlebPkibhpMMQrw+hgsY/M4R6QZkKWspwz8nKp+NdAJzId5NcHU3XV5GjbPQK7wP
         AkDoIMRfI2QB/MLX6BYe+qAVsPfOkOTqvakt0=
Received: by 10.142.58.20 with SMTP id g20mr1682402wfa.241.1245472770654;
        Fri, 19 Jun 2009 21:39:30 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 22sm39467wfi.32.2009.06.19.21.39.29
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Jun 2009 21:39:30 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.323.gfb84f
In-Reply-To: <1245472623-28103-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121928>

From: Elijah Newren <newren@gmail.com>

Under some cases (e.g. 'git fast-export --parents master -- COPYING' run
in git.git), the output included the lines
  reset (null)
  commit (null)
instead of
  reset refs/heads/master
  commit refs/heads/master
This simple change fixes that.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
As noted above, run 'git fast-export --parents master -- COPYING' in
git.git to see this bug triggered.

 builtin-fast-export.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 891e2d4..9aa409b 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -531,6 +531,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	get_tags_and_duplicates(&revs.pending, &extra_refs);
 
 	revs.topo_order = 1;
+	revs.show_source = 1;
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	revs.diffopt.format_callback = show_filemodify;
-- 
1.6.3.2.323.gfb84f
