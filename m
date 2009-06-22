From: newren@gmail.com
Subject: [PATCH v2] fast-export: Do parent rewriting to avoid dropping relevant commits
Date: Mon, 22 Jun 2009 07:06:38 -0600
Message-ID: <1245676001-14734-4-git-send-email-newren@gmail.com>
References: <1245676001-14734-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusmabite@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 15:09:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIjGy-0004LE-L4
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 15:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbZFVNIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 09:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752875AbZFVNIy
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 09:08:54 -0400
Received: from mail-pz0-f197.google.com ([209.85.222.197]:55508 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbZFVNIw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 09:08:52 -0400
Received: by mail-pz0-f197.google.com with SMTP id 35so731490pzk.33
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NSlBxtlXDfBZLZ0hpI3YQSbaRWX8FUirUlmDf9mXLB0=;
        b=FbEWoU4EMGjrON7baxf5vQ5akloRkF3Ty/iJQZgnfEv8Lgo8kW5M4iJhB6S1VUcEeB
         zhX+TCBscSww93Ljiv/5JsrCIEOtfZUGhG81aFlTCQtbTyu09K1kEisJLyDElNKY0m63
         0H2oLfzf+fyDcKqb72K0dxd35eyHp1YJm/0g8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DBU3ELbN4LcECBnQMn+VMZ9WhHatnanR1L/xb5d01okx0R8VKUd+BWxGXLJ8NrlLTg
         1km2DDjoqY9Aham1EbJt9Rl6Df+VlNVLynS2qKWxquH309IL0e+6JmhjQT+IptSwgO/X
         DiKwak/BKFHkJpCSbWVFIYFRty95z67lhoT9M=
Received: by 10.143.7.12 with SMTP id k12mr2757085wfi.56.1245676135797;
        Mon, 22 Jun 2009 06:08:55 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 28sm675507wfd.23.2009.06.22.06.08.53
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Jun 2009 06:08:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.323.gfb84f
In-Reply-To: <1245676001-14734-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122037>

From: Elijah Newren <newren@gmail.com>

When specifying paths to export, parent rewriting must be turned on for
fast-export to output anything at all.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
(No change to this patch since the first series.)
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
1.6.0.6
