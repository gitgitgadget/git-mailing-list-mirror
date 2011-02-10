From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v5 3/4] merge: introduce per-branch-configuration helper function
Date: Thu, 10 Feb 2011 18:52:43 -0500
Message-ID: <1297381964-7137-4-git-send-email-jaredhance@gmail.com>
References: <1297381964-7137-1-git-send-email-jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 11 00:53:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PngKP-0006BZ-4q
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 00:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757416Ab1BJXxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 18:53:04 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53185 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757291Ab1BJXxB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 18:53:01 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so1176611qwa.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 15:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=JcUniEufKoq42UxQS79gyiWOHHf3R+ktEYO9iAJ9Esw=;
        b=X9cqy2pkjPRbcW+bx0r04VLShQhy6U6TMwJgqbGV1jI5EqHwbpBDhMGpv2dvlMAelg
         SlqBnh4QXKEcp+lcoz7ukC6XaqaN33ND+M/WrlVf1aa3ZKWx2KyumwccdmR71xIelNsr
         QcGysE5KTihphKOweunjY6F/o/uQugJAffIZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GVZufVESaavJt3BxRSuZauBwCNb+wWN19Y56DEP86B83wy28qnPl2bUv92eyho0PDU
         slfMz5tYqOZ9hnEed1chvgmfGzhpMGjZImJ+Wp/oQX36MtNPLoSk2K60QAMSVoNSMO6p
         ZGdXNF+0QU3bH6/2envhMhlOFBH5cZ35AtZVA=
Received: by 10.229.213.13 with SMTP id gu13mr14697800qcb.196.1297381981204;
        Thu, 10 Feb 2011 15:53:01 -0800 (PST)
Received: from localhost.localdomain (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id t7sm123028qcs.4.2011.02.10.15.53.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 15:53:00 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297381964-7137-1-git-send-email-jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166528>

Create a function that will hold configuration code for configuration
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
