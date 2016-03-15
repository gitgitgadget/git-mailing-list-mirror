From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 13/16] ref-filter: allow porcelain to translate messages in the output
Date: Tue, 15 Mar 2016 22:17:13 +0530
Message-ID: <1458060436-1215-14-git-send-email-Karthik.188@gmail.com>
References: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 17:48:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afs8j-0001AN-JQ
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965331AbcCOQsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:48:04 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36425 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965293AbcCOQsA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:48:00 -0400
Received: by mail-pf0-f181.google.com with SMTP id u190so35751532pfb.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5hW27sE/JeY5aT+i0DbWfiZ7J5ARRz223DT5NUAYaBQ=;
        b=XhD4JB8nL0IjyumzvEPmgKtTS+HkD/mLtCnFgNy18CDxRCe7YBgK+vPJsG4Gvys1BR
         zgmzzZU5iPcD0S1gkzayBNfSrdMhac8iZiw6+Mp8UbJiXLLqteTYOc8Lebhco3PeoaQl
         3hhkwKmge5339OziXivcqKjj0vYpXS0xOVskiQiPF2by+hoqTYCLlGa5vj1NPyaVi5gx
         Yn6a9SHXhhXwqRU1jXNqnG0tx2NNfMdJ+9vU6TRtapR1PV+Tiwdx4o4yAbg0pOrV54zZ
         iGIUl2Tb/XkKh+McxEGogORzs6R4dZyGAnQb3CilPt6+wTOCZdZV9i/bloiEQh1uNsVB
         iMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5hW27sE/JeY5aT+i0DbWfiZ7J5ARRz223DT5NUAYaBQ=;
        b=MkEmSXFWxQw7Phh7/uKhhriF9q5Ug8h8/GOsdAO2N51Bi5NCN342oLT3244zJsFs8o
         r2fJ1i689MwXIolk8gVhzcala7sseUm4XCaBQ3UPFDNFWnycFV7xca1fxwjxch4Gz5A7
         zDrdJXIZx1QnVxRDTXTjvcDuhcvZ6r8cUqMuPnEsdjzDSYCMc2VykSz3rNErhX8d/49b
         HpI01Pkxz6a7TOu071pnl+KavJcMsZmV0Vs4hv2ysFgca/JTjdLnO35jg27hEUrMvZfD
         OuwFFNR2qDYCbihsdshNin7hBI055TGnplVKi+ea4fmRr2GjmVnpZzVsyATAKp+thfTi
         acSA==
X-Gm-Message-State: AD7BkJIJZVtZGb+E54PFXKuu4b5pWJJHkMWl1yyLfPkbQ1PJteFXhbibSoxxkg97WeQ5Yw==
X-Received: by 10.98.40.4 with SMTP id o4mr40597923pfo.76.1458060474180;
        Tue, 15 Mar 2016 09:47:54 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.87])
        by smtp.gmail.com with ESMTPSA id i1sm40874361pfj.17.2016.03.15.09.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 09:47:53 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288876>

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
2.7.3
