From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 14/17] ref-filter: allow porcelain to translate messages in the output
Date: Sun, 15 May 2016 16:15:30 +0530
Message-ID: <1463309133-14503-15-git-send-email-Karthik.188@gmail.com>
References: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 12:46:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1tZ7-0003zV-1q
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 12:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198AbcEOKqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 06:46:22 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34663 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164AbcEOKqT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 06:46:19 -0400
Received: by mail-pa0-f65.google.com with SMTP id yl2so12072545pac.1
        for <git@vger.kernel.org>; Sun, 15 May 2016 03:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UImz9ONmK9AuIwEbC7FM5/PWOLgVddUdpDbVEiVTuNk=;
        b=kGe7sFQHzSMhD6M1Q6Efywx7JnHTBrQaOZ4Jz2M8ZawqBL+vC642LpIuigO14udjSe
         MsgBOJj/JVEeYNXNji27gdZuLkzzZM4FQGan2CZRikGTKYPKlfsAJF9OkHsH99DF/HWx
         NDG7e9HbXQF/dQQrL/CokNYVsKCq/VNihpU2YMygprwXZD1QWrt/RlHRShfM/sdJeZjt
         WJ7E5v/KdBfgAcb1AL3k4raclI+wChJ5Ynj8opwp54lOVbygQLyRDGSOKmCFtWeLGG7D
         9PfuDifBYW+UIdHUPePte0LQ1+gFns4uFqaFqLidMP4wfu7puesF1lSvgREZblLhn2Aj
         oGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UImz9ONmK9AuIwEbC7FM5/PWOLgVddUdpDbVEiVTuNk=;
        b=MgeNKPTm8ns0iqfZJcSg+oR2QdYPDL20FHEyKomu5Uzau6/kgZ09Sv0yrXczFOq8HD
         nf4qVaUZdjhPSScmpvhOtHasC+W34i/8mPu3YNg/6/36ImjHhZtICdrl5CVHHi6m1sTh
         MsjInv8jwhD/aMgy/0IG7sGP9K9K0c/vn1cfEQt+3fXJPVNuiV/RG2OlrTSJgTOlRGfQ
         3FEGDP3dCPJ3Ge5bf9Nix5Idwg0QWjLSrHiK3oVSrLCwouIzJmYCO9Bcry/VgZLnABAW
         5GqHBINZHZ+hZ2F+7/bbJ0Bw1KDRQG/WiLqjULotiJ3aW0BFobCL71Mu9Jv36ezXVGLM
         M6ew==
X-Gm-Message-State: AOPr4FXZZ4tRmjMHpGyZ6RH9RQY9ldD9/CkN0rNQhvsMiyuDh7uwZw1k+UdNYP+6Sru+ng==
X-Received: by 10.66.160.201 with SMTP id xm9mr36440497pab.68.1463309178917;
        Sun, 15 May 2016 03:46:18 -0700 (PDT)
Received: from ashley.localdomain ([106.51.133.65])
        by smtp.gmail.com with ESMTPSA id 71sm39866747pfy.32.2016.05.15.03.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 May 2016 03:46:18 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294656>

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
2.8.2
