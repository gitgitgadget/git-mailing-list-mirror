From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v4 3/4] merge: introduce per-branch-configuration helper function
Date: Thu, 10 Feb 2011 18:40:05 -0500
Message-ID: <1297381209-6377-6-git-send-email-jaredhance@gmail.com>
References: <1297381209-6377-1-git-send-email-jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 11 00:42:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Png9k-0006eN-Fx
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 00:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491Ab1BJXlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 18:41:03 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50690 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932430Ab1BJXk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 18:40:29 -0500
Received: by mail-vx0-f174.google.com with SMTP id 37so1028081vxb.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 15:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=/xgL1/69HlRAuAkL0at7VCPkxhtUP4Q5Vhnm7J58fBs=;
        b=dC22H9RBTLi4MB96CDS/bNKGGWefjq5Qpk+H9rBXVgRK/VPltoDyV3xusCl3IOO7H+
         h4adxEDvXmOtlkNzza3932Bl6BL/7Mm34/MZ0fC7aeuW6LjfifUzEzOIHmOrnk8GLy9f
         a+MU7pGj2ErKnNSyl3PyRzGz63mNMZCwcRLA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OjzbK1yGUzJlRmmzEtATHAJyhq02Gb6oWTdRm35aAf/9jYn6aMA8YSxKT9Q0J7qnUE
         MMW4Ok8iNrbaHU2goApGGnofXg7noZHCm9najNH0UDrQUGu75vjuIy/8k82HmspniDmj
         CzJyNyCJAZTXPm+BeLCN/y6KOhRvAfUViA/bc=
Received: by 10.220.178.12 with SMTP id bk12mr25884vcb.48.1297381228894;
        Thu, 10 Feb 2011 15:40:28 -0800 (PST)
Received: from localhost.localdomain (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id r7sm126736vbx.19.2011.02.10.15.40.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 15:40:28 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297381209-6377-1-git-send-email-jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166523>

Create a new function that will hold configuration code for configuration
values that are specified per branch, as suggested by Junio.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 builtin/merge.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index cd23880..71b392d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -522,8 +522,20 @@ static int per_branch_config(const char *k, const char *v, void *cb)
 		parse_options(argc, argv, NULL, builtin_merge_options,
 			      builtin_merge_usage, 0);
 		free(buf);
+
+		return 0;
 	}
 
+	return 1; /* not what I handle */
+}
+
+static int git_merge_config(const char *k, const char *v, void *cb)
+{
+	int status = per_branch_config(k, v, cb);
+
+	if (status <= 0)
+		return status;
+
 	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
 		show_diffstat = git_config_bool(k, v);
 	else if (!strcmp(k, "pull.twohead"))
-- 
1.7.4
