From: Thomas Adam <thomas@xteddy.org>
Subject: [RFC PATCH 1/1] status: Allow for short-form via config option
Date: Sun, 11 Nov 2012 22:53:03 +0000
Message-ID: <1352674383-23654-2-git-send-email-thomas@xteddy.org>
References: <1352674383-23654-1-git-send-email-thomas@xteddy.org>
Cc: Thomas Adam <thomas@xteddy.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 23:53:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXgPP-0003jt-TB
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 23:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288Ab2KKWx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 17:53:27 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:57704 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab2KKWx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 17:53:27 -0500
Received: by mail-we0-f174.google.com with SMTP id t9so2556124wey.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 14:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=l7SBtqvUbizYBx0lwhb02cMxiiBFGy5KMgAqyAn8gmA=;
        b=ZQQ39cogoareEwEPoLD9bj2eRfFqkKs4FELdOcIKXJjA7wX4b78N7daN43PXcDt19Z
         6q0dWJO0fQsfYYn+AJhEkYY2erghJzIW47KD0QtzpyBMgfFZ7px0Q9HZvN3eh/ydFUm0
         oHr0Ia3Y3IkZGDlgJSmpDjtjRMC2kVNjL7/RCMC24LPMTeWF1KT1BPf4KiSyuFXIiDb4
         pzmZQjTeE44IQcyxeqOlVmbEG80LHkzmC9eHgFYkmstaSrBnNiswArfwO5mOu2QZpQn4
         TVkcHUcF5WGkZfjq142bumjT7edfWBy0/uyOC7BmOAARj258DUlTE/JDOOCh4vE9Fm+c
         mjPA==
Received: by 10.216.145.9 with SMTP id o9mr7028508wej.107.1352674405589;
        Sun, 11 Nov 2012 14:53:25 -0800 (PST)
Received: from freebsd.my.domain (cpc2-fare6-2-0-cust935.6-1.cable.virginmedia.com. [213.104.227.168])
        by mx.google.com with ESMTPS id ea9sm867018wib.11.2012.11.11.14.53.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 14:53:24 -0800 (PST)
X-Mailer: git-send-email 1.7.11.4
In-Reply-To: <1352674383-23654-1-git-send-email-thomas@xteddy.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209454>

It is currently not possible to use the short-form output of git status
without declaring an alias to do so.

This isn't always desirable therfore, define a git config option which can
be set to display the short-form:  status.shortwithbranch

Signed-off-by: Thomas Adam <thomas@xteddy.org>
---
 builtin/commit.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index a17a5df..552a9f1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1142,6 +1142,18 @@ static int git_status_config(const char *k, const char *v, void *cb)
 			return error(_("Invalid untracked files mode '%s'"), v);
 		return 0;
 	}
+
+	if (!strcmp(k, "status.shortwithbranch")) {
+		if (git_config_bool(k, v)) {
+			if (!v)
+				return config_error_nonbool(k);
+			else if(!strcmp(v, "true")) {
+				status_format = STATUS_FORMAT_SHORT;
+				s->show_branch = 1;
+			}
+			return 0;
+		}
+	}
 	return git_diff_ui_config(k, v, NULL);
 }
 
-- 
1.7.11.4
