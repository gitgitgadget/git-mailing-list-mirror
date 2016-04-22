From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 13/16] ref-filter: allow porcelain to translate messages in the output
Date: Sat, 23 Apr 2016 00:34:04 +0530
Message-ID: <1461351847-22903-14-git-send-email-Karthik.188@gmail.com>
References: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 21:05:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atgOQ-0000E9-6y
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 21:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbcDVTFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 15:05:23 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33160 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbcDVTFS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 15:05:18 -0400
Received: by mail-pf0-f195.google.com with SMTP id e190so10571529pfe.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 12:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SmsCbHKlN/fa1B11dD5M5oxZBicowKe+f+ng1CGVXvk=;
        b=uvlUjf/bOWRdgLXqzavxQuusTNyfN3qVwI8sgiTwyPOiaW/elQW4dhrlV8FRoswnLe
         uA5OV2dwKX9AzMGgyd1MN0rjAeXepPURS8ZS+T+YUCxRIUGer0Mo1NrrsOgBY41iI5yX
         Sv4a9D4LRnm3P627a76rI58YXREk+ifHXLu90N9+8F0IqoDpXkKwMKB1pMSUsSKtIRHt
         lz8ciOOCJ0yfng+oLPVbxoLpyyHCn/sBLAolkXRMdYlLj/yIV/+gs0U2jf29Bc4pUTBf
         6OgsyynGvjuw0XuANFl2RJCrRgNBCTDGmkUDQ/KOIWwPg4jBUw/J6RppN+KhIeDhSWl6
         ggDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SmsCbHKlN/fa1B11dD5M5oxZBicowKe+f+ng1CGVXvk=;
        b=hgfFYpon5UT1S5A3x2tCflcF24OXmyLJF3u/8BUwQ1Sno+F4kVsrDNOstlNgmrLWsk
         IoMIRCDDr/34MK7gR1FJLe+zYD7epZu5dynK/ktuljcdSIqXxGVfCbxeMT7jPxQK83/g
         hou8KJtg8xUhZ63qZh06+CPLbNSQ9kZIcX87hsvVNYJalWiqxHSHbbGqip/NDVn3MQXN
         4Ydm+wCJeDIFtXXNFsvJHm6nug4KzfztcKYLrxD2HOPhA0Jd5wVmpyEgz5GL8UDYoDtz
         XovvhUf6rc8FF0i+j/E3tjHpVxOa3IRgkLWrYjqq8OIbtiBoB304+Nm20PTFYtIRDtVx
         R0Pg==
X-Gm-Message-State: AOPr4FV9uuPC3vYnJWVllU9JxIR0U8R8xrgmQdNjB+ujhJm50U+svSc9AjvNBddqZSQ0Dw==
X-Received: by 10.98.80.10 with SMTP id e10mr30662286pfb.141.1461351917921;
        Fri, 22 Apr 2016 12:05:17 -0700 (PDT)
Received: from ashley.localdomain ([106.216.186.206])
        by smtp.gmail.com with ESMTPSA id t1sm11266470paa.17.2016.04.22.12.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 12:05:17 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292259>

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
index 97977a5..74c4869 100644
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
@@ -1130,15 +1150,15 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
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
