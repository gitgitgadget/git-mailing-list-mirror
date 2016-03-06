From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 12/15] ref-filter: allow porcelain to translate messages in the output
Date: Sun,  6 Mar 2016 17:34:59 +0530
Message-ID: <1457265902-7949-13-git-send-email-Karthik.188@gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 13:05:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acXRQ-00026H-Uk
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 13:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbcCFMFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 07:05:41 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36213 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbcCFMFe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 07:05:34 -0500
Received: by mail-pa0-f43.google.com with SMTP id fi3so59817889pac.3
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 04:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ySn5ZOmDVw5lBq1lcvjTOONhwxhK+h3fYocbdFh1dhs=;
        b=wnjfJZWwAB5iYxEWRhjBzJ9/bsfnJ7Zqkofm9+Urykh8ubnA0zZtKfh9/LQCMuVrEz
         0I14CN5CywcsnO4sAmXJ1z1G1NWUCt880wiI+t/OJSR9Vv6mngHqAkkh0fBZUQg2N/Mo
         I/l0dGHiJPNzFVurwz9oa/h8ddsJpCyH6zGLHh2wmdeN2rzXyBDOWfPCp+fBqIUGiFQt
         JpoOGobx4bwWS4J0hm0rjluZ9yl0GFNU5o2DoReP+Vg6k9VPlvNiKpszpfhjO7a+xx6d
         0HbdkMonKfJTZ/rdxtJ5/XjN0/1HjwF3ZGp9pvrc19ZfM8c7qRnqdiYds9S7YNcKTkV2
         W37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ySn5ZOmDVw5lBq1lcvjTOONhwxhK+h3fYocbdFh1dhs=;
        b=UVz0AN+n6sCc54oqSPY85pKP1NgNRZsAOf2NAMXNXSbQ/TwASUXh715tkTpoFmXl1t
         Le3PTGCMRasVdUXIxWROq04fsqtK/2sTkNm/ggflxgXO15YPq9tjw842BjE57McEMmmz
         nYVxIjZDXGE2gNJkZgfsxVX8pYtrnk/D3Y/At9kQkCT4Xkp8xgX8ZZ+dyn5b0+j9Q85Z
         KXWa5+QdO2tkdCETWCPms28CwCYfqYUgfLsVsAOyNNL0a4tRptx/7Bini6LlHY//4MZI
         yNfTlU0eNPvj3gQ9TQmy5D0Y6NfOpTSZOT0USNK3AdvgBXgYtkY8JmwZ8eGmztSfsE8j
         p9bQ==
X-Gm-Message-State: AD7BkJKl5+nhe7s9v9wfqdq/swZkf6Hs47LyWxYRKSbKhaFlP/5+DiHbotLZIHWd1N0MtQ==
X-Received: by 10.66.141.110 with SMTP id rn14mr18683531pab.104.1457265933952;
        Sun, 06 Mar 2016 04:05:33 -0800 (PST)
Received: from localhost.localdomain ([106.51.240.143])
        by smtp.gmail.com with ESMTPSA id n66sm17536850pfj.39.2016.03.06.04.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 04:05:33 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288350>

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
index 45f9d16..76ea7c3 100644
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
@@ -1088,15 +1108,15 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
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
2.7.2
