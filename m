From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5b 14/17] ref-filter: allow porcelain to translate messages in the output
Date: Mon, 25 Apr 2016 20:47:55 +0530
Message-ID: <1461597478-31855-14-git-send-email-Karthik.188@gmail.com>
References: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 17:19:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auiHl-0005yC-HY
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 17:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbcDYPSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 11:18:49 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34295 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932682AbcDYPSn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 11:18:43 -0400
Received: by mail-pa0-f42.google.com with SMTP id r5so59652060pag.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SmsCbHKlN/fa1B11dD5M5oxZBicowKe+f+ng1CGVXvk=;
        b=cJdK+qoROuDI51FwrWRvYeyp8jogKHfI4MauoMorHt+32yHHrWkhH2okNMfVdHFvkC
         VpE/6fZKWeM5GZeKATqb4Smw6I4hkESmUsZWjxckD34f6w3xgbNlLqR4v63NfaQ9E1kL
         MZZKt9YTRhV0qg6pTJmepjWvyEUMNeYamd4JTA5lYIwJjntgLqm9udWXHUyZFlSAoyVX
         PCVsMjzRENaS+zclGi2BepYUzq4XywKntDDdvhWZL3c32uzoKiIgsRspmwUdr4uQzTq8
         9DncK2A2hfew3cVaxoTZYPL/oJQXy+kwpCdIDqGlq7jKyK1sHQmixwvEJ+LSOSxGYI2m
         lwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SmsCbHKlN/fa1B11dD5M5oxZBicowKe+f+ng1CGVXvk=;
        b=GCnO2vhPRuJfAGAZL7Ljy6gU6YkkXsxF2ntuDQLSsG3kGDvO44rMF5/TQTwgust3Hf
         5AjyTM6vNKn+vDDtq8/1AMpFq9x/aHnAO+/hNCn144WFMYf8vvJ7w7aE/n+unvOslcLa
         pnN4x2Y2onvfU4PVXK9qbvFh4ehAUGodBvoo4LHpUAg74gr2HcbWcPo48E5onCWi3wWh
         xsyH7/EiKlX4r0Lj6M6LZTjFYutmjHc2Dy1cK6rOxIkmr+ETRNVfn1CxvtWtM5me0gg9
         oOcknVYN2x7MatbfQF/R031HNK5pGkb9wdCA7F/Zz6lb4twuFPHTnHBMt8bhlde6rvUn
         asxA==
X-Gm-Message-State: AOPr4FWph3zHUGePjqgohjeizVsmgVQ2MeLG7XUJgYnKq4b1zwk9ZBlC8VhUBGG6yKbIKQ==
X-Received: by 10.66.100.228 with SMTP id fb4mr48827338pab.84.1461597522902;
        Mon, 25 Apr 2016 08:18:42 -0700 (PDT)
Received: from ashley.localdomain ([106.51.234.108])
        by smtp.gmail.com with ESMTPSA id ut1sm30812527pac.46.2016.04.25.08.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 08:18:42 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292502>

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
