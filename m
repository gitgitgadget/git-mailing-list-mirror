From: newren@gmail.com
Subject: [PATCH] fast-export: ensure we traverse commits in topological order
Date: Tue, 10 Feb 2009 23:03:53 -0700
Message-ID: <1234332233-10017-2-git-send-email-newren@gmail.com>
References: <1234332233-10017-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 07:06:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX8EL-0000Ba-MG
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 07:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbZBKGEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 01:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbZBKGEX
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 01:04:23 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:53362 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbZBKGEV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 01:04:21 -0500
Received: by yx-out-2324.google.com with SMTP id 8so27581yxm.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 22:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=43rxjSgrAl0Ix70chYqxUo0xeJ8Pv4ogC5/xqLlmxvQ=;
        b=lNSyyhFXGW2ePp2US9Z5O8lZgXMqa5dAdIrRHEIisXUwSgsHtXgGrFF+es4vnNx7Q0
         FtpbS+iLTIgmw8W4maSkvGHnNfvT2/a48WShh8dpngjhr0/BV+vTJ7GPGSpkTQyRwImu
         PRD7Hm8fsGhFhXiOjnxnvAgOZnKW0927R3Qfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sI4gKUcIrHuUU8SCs+cjQFcjZFMqn+hRohP/64hH8ig50VJygVDQzmVVfE3WpTaLa/
         geX5JbNGA6th6PmAW6XC/TsUx/6RvpcnPkoMYt65FFZcBQC4CfDVsWeHT1c3uNk668XR
         6fOiAfaVsPoWRWVYfaPQ6uK0zvGNSyAX4Kqno=
Received: by 10.142.241.10 with SMTP id o10mr3984059wfh.23.1234332260075;
        Tue, 10 Feb 2009 22:04:20 -0800 (PST)
Received: from localhost.localdomain (c-69-254-130-124.hsd1.nm.comcast.net [69.254.130.124])
        by mx.google.com with ESMTPS id 27sm15478089wff.28.2009.02.10.22.04.18
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Feb 2009 22:04:19 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.12.g30288
In-Reply-To: <1234332233-10017-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109379>

From: Elijah Newren <newren@gmail.com>

fast-export will only list as parents those commits which have already
been traversed (making it appear as if merges have been squashed if not
all parents have been traversed).  To avoid this silent squashing of
merge commits, we request commits in topological order.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin-fast-export.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index e9ee2c7..fdf4ae9 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -514,6 +514,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 
 	get_tags_and_duplicates(&revs.pending, &extra_refs);
 
+	revs.topo_order = 1;
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	revs.diffopt.format_callback = show_filemodify;
-- 
1.6.0.6
