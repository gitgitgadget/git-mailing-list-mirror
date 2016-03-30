From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 13/16] ref-filter: allow porcelain to translate messages in the output
Date: Wed, 30 Mar 2016 15:09:57 +0530
Message-ID: <1459330800-12525-14-git-send-email-Karthik.188@gmail.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 11:41:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alCcr-00022C-D8
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 11:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbcC3JlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 05:41:11 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32915 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbcC3Jkl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 05:40:41 -0400
Received: by mail-pa0-f46.google.com with SMTP id zm5so36441425pac.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 02:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jOW9zMBPIRQ5y6V78zSWi7APv2cWk/RZsuASL96Bpug=;
        b=OZoFLCJDZBWiwoXyjmB6TJNOo4+uUbRiF7z959VNF2nCzclIv/wsxUtaJVnxuQ2ktx
         nQ4lhzNCiw4L2u3gnDuEx7h74TRAJBlzym6QRlLx+y8ISyl4KmkcZQAQVekelzAbQCYT
         SIhwmFHKpAw7zW5AOYS3g5M30dOUH0g6b8TuxIJY5yCiMHrNhSwVZGCcAtHERjxFOs31
         w/f4RMOkPADptcuvQgIYoB8Zg5+XfYT8xq+uWAQNI5ZWCxNAyR2heJkocp/zvkcRF0N9
         5iKovMuoMG1/msOy3bk/TGYJeoBfdFvkRsP6+YHRNgrmyupTiWxhyT70U7rxCArZA3wC
         W19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jOW9zMBPIRQ5y6V78zSWi7APv2cWk/RZsuASL96Bpug=;
        b=lZvGhpjlI1Q6J6cSNvs3xvAt6UZ8eR5+rmBetDMAfaPIUZ5ctmJpdcMjML8oGfD0F4
         TUHkjVa3nMhMB/vyS8Yp7IBlCnUQ8liPTBxT/44HF7w7eAAwqBrdzC5b0kkWK05VAJH3
         efC4fNkkLFLwzzbfTUjNTHieeq3o0tYFvHbRMvrx7Mut89WrhoAswB5+74yu6bhQapfG
         nlPJGdBdKgjt6sAHBAw0fa3QIJOErLKrnkuH1hfPtnF+6AMXtGErAm+ZPjaDa9Z1rfLF
         QWLsX4o2ElpH45nwtWvSJRT5VgmWmZsvs6g94i8i4A8QCZjH6Ig7QJgr4OmYmzQUsATd
         sq4Q==
X-Gm-Message-State: AD7BkJLKiH6rioqfaM9s/VnPk8iTT2iITamhDeopuFi0yQq89MDT6kuyOB7kDSfTITIIPg==
X-Received: by 10.66.129.130 with SMTP id nw2mr11467738pab.80.1459330840831;
        Wed, 30 Mar 2016 02:40:40 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.45])
        by smtp.gmail.com with ESMTPSA id r65sm4402606pfa.27.2016.03.30.02.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 02:40:40 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290296>

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
2.7.4
