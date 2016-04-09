From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 13/16] ref-filter: allow porcelain to translate messages in the output
Date: Sun, 10 Apr 2016 00:15:12 +0530
Message-ID: <1460227515-28437-14-git-send-email-Karthik.188@gmail.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 20:46:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoxtP-0003o8-Bh
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 20:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759224AbcDISp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 14:45:56 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33879 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759100AbcDISpy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 14:45:54 -0400
Received: by mail-io0-f193.google.com with SMTP id z133so20476848iod.1
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 11:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WwIrMN6ZXJq3QVDTkmSJs6my7gE56YZB+vJeJtpwkT0=;
        b=PLS0FwKq5+K4UcBdKieUqC2jn3pPysMgVugSkoR1AYhvmagAcwMqLkvvEkNCYe3jnY
         nXzpwAEbsCLWPvr1WsVhQPGIQzfhwE8q3XPXTD1GiqrGVLLGuRe+EBZ/F+SzItEXQoLx
         YyRFL4YZWl3GR6ZrJPgd6xU1eFLcJzMboYsWgCyBZFXN1cTUwWZlsS3iLVmp8bdMaANU
         XHKk0dDtFgbbuaLucsajYEsRjkssaOocK8/+miMxlM7R0e9pppH40vS4cLme2ivhQWjX
         8BkhCO6r6qhMfb/50dqh6iVIqQnWR6+Zfw7w5aK9QYuAxCz3XMhtoVblbKYvNMH+yTQE
         xt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WwIrMN6ZXJq3QVDTkmSJs6my7gE56YZB+vJeJtpwkT0=;
        b=dA0YSIRgg/VCIxqoHuxWjNLx4HVsINzW+bmnwjKv9MwxD7uzwp9FXwKjvhY5jSlRb2
         Lgn14PdopM7tv1NtPyb20zb+WeXEWQ9wYrCAGOy/JOTlhdpN4snJZZhGZr9LzEoyHJbq
         QPARRCYeya5Ck8QajkRXFD4l/Xl+rtNk536ILqwJq4bI9tZWFm0Iz+sHRvBNX3DBsrMR
         SI8wWX30uZtFrI5IMU7yg2FHQo3/q5ku36YHiFDRwetOyXbPxOlIlkBvywSxYtRB2d/4
         8+DWz/toZ28ABsKKHsWcRQcQbiV+Xd8wLafA53MvTOScijwvLDdnh9c+MFVybpkxPLre
         b4ug==
X-Gm-Message-State: AD7BkJKzJ/ORo63KWYc+QznH3YcQKtcqiyjngHod6kZDt9w68nv5z//0zgqIjamsm12QSA==
X-Received: by 10.107.8.193 with SMTP id h62mr17857187ioi.7.1460227553122;
        Sat, 09 Apr 2016 11:45:53 -0700 (PDT)
Received: from localhost.localdomain ([106.51.241.12])
        by smtp.gmail.com with ESMTPSA id be7sm7132351igb.1.2016.04.09.11.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Apr 2016 11:45:52 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291117>

Introduce setup_ref_filter_porcelain_msg() so that the messages used in
the atom %(upstream:track) can be translated if needed. This is needed
as we port branch.c to use ref-filter's printing API's.

Written-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 28 ++++++++++++++++++++++++----
 ref-filter.h |  2 ++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 73e0a7f..3435df1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -15,6 +15,26 @@
 #include "version.h"
 #include "wt-status.h"
 
+static struct ref_msg {
+	const char *gone;
+	const char *ahead;
+	const char *behind;
+	const char *ahead_behind;
+} msgs = {
+	"gone",
+	"ahead %d",
+	"behind %d",
+	"ahead %d, behind %d"
+};
+
+void setup_ref_filter_porcelain_msg(void)
+{
+	msgs.gone = _("gone");
+	msgs.ahead = _("ahead %d");
+	msgs.behind = _("behind %d");
+	msgs.ahead_behind = _("ahead %d, behind %d");
+}
+
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
 struct align {
@@ -1097,15 +1117,15 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 	else if (atom->u.remote_ref.option == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours,
 				       &num_theirs, NULL)) {
-			*s = xstrdup("gone");
+			*s = xstrdup(msgs.gone);
 		} else if (!num_ours && !num_theirs)
 			*s = "";
 		else if (!num_ours)
-			*s = xstrfmt("behind %d", num_theirs);
+			*s = xstrfmt(msgs.behind, num_theirs);
 		else if (!num_theirs)
-			*s = xstrfmt("ahead %d", num_ours);
+			*s = xstrfmt(msgs.ahead, num_ours);
 		else
-			*s = xstrfmt("ahead %d, behind %d",
+			*s = xstrfmt(msgs.ahead_behind,
 				     num_ours, num_theirs);
 		if (!atom->u.remote_ref.nobracket && *s[0]) {
 			const char *to_free = *s;
diff --git a/ref-filter.h b/ref-filter.h
index 0014b92..da17145 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -111,5 +111,7 @@ struct ref_sorting *ref_default_sorting(void);
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
 /*  Get the current HEAD's description */
 char *get_head_description(void);
+/*  Set up translated strings in the output. */
+void setup_ref_filter_porcelain_msg(void);
 
 #endif /*  REF_FILTER_H  */
-- 
2.8.0
