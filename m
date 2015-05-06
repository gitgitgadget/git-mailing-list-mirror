From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 3/7] dir.c: replace home_config_paths() with xdg_config_home()
Date: Wed,  6 May 2015 16:01:00 +0800
Message-ID: <1430899264-18447-2-git-send-email-pyokagan@gmail.com>
References: <1430899264-18447-1-git-send-email-pyokagan@gmail.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 10:02:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpuHR-0007wI-CK
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 10:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbbEFICD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 04:02:03 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36191 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbbEFICB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 04:02:01 -0400
Received: by pabsx10 with SMTP id sx10so2400759pab.3
        for <git@vger.kernel.org>; Wed, 06 May 2015 01:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1TOsMO+rHKMfFianWR3Tt3gx5xn7l2eoxnEP/Afq4CM=;
        b=hRE1BTEsx65xl25+NgDfS7MzWn6XEKASKK4s3CTrk3V3iPC1/NXg7hHJPSbO80Oy4L
         Y5iF9s3yCVSgYCwAyqpzB96AIOpixdWNAQNG+NEJajxae6qx12WePIoMQObIYwZrxV+X
         xt0eIk8AfQ56VuD8wEEI0NS+1mLBz5UDKekkGOv9InRnHYjdHfSlb59U5F0hwzJ+jqCO
         9d7o8RX33YT0NfIFPurqOGM8OsdCFbxItGvDFbI5XpZoxD42yTINHeMSppdO7JSFTpuX
         ljwu8f7SdlX2UiBkhA9I8IUeT599T4WL+TO42p0XGsBS1FOeq64BNPG9ZE2ynCp48LMZ
         Bk/w==
X-Received: by 10.70.43.10 with SMTP id s10mr59189949pdl.57.1430899320567;
        Wed, 06 May 2015 01:02:00 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id cy5sm1074571pdb.85.2015.05.06.01.01.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 May 2015 01:01:59 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430899264-18447-1-git-send-email-pyokagan@gmail.com>
In-Reply-To: <20150421040627.GA5415@yoshi.chippynet.com>
References: <20150421040627.GA5415@yoshi.chippynet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268457>

Since only the xdg excludes file path is required, simplify the code by
replacing use of home_config_paths() with xdg_config_home().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Re-sending the patch series. There are no changes.

 dir.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index 0943a81..335dc7e 100644
--- a/dir.c
+++ b/dir.c
@@ -1665,14 +1665,11 @@ int remove_dir_recursively(struct strbuf *path, int flag)
 void setup_standard_excludes(struct dir_struct *dir)
 {
 	const char *path;
-	char *xdg_path;
 
 	dir->exclude_per_dir = ".gitignore";
 	path = git_path("info/exclude");
-	if (!excludes_file) {
-		home_config_paths(NULL, &xdg_path, "ignore");
-		excludes_file = xdg_path;
-	}
+	if (!excludes_file)
+		excludes_file = xdg_config_home("ignore");
 	if (!access_or_warn(path, R_OK, 0))
 		add_excludes_from_file(dir, path);
 	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
-- 
2.1.4
