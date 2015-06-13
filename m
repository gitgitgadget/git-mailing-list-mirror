From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 05/11] ref-filter: add parse_opt_merge_filter()
Date: Sun, 14 Jun 2015 01:48:20 +0530
Message-ID: <1434226706-3764-5-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZRA7jVhs-NixjP+EFqfBNwLEfU-WgEMMQzb5NC+HZDYiw@mail.gmail.com>
 <1434226706-3764-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 22:18:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3rtG-0003NG-Tn
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 22:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbbFMUSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 16:18:49 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36555 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbbFMUSs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 16:18:48 -0400
Received: by pabqy3 with SMTP id qy3so40970979pab.3
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 13:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kIjp47O4qowXcD2eqkalOYP33F44O0Nf1VN0jb0DAxw=;
        b=CCx50UvksT1jRaNy+CQIuorIxuHzW5VgAwPaQcZ9EN/Ud2+dEv6pzACkBOhFao0ljb
         wSuuIa1WXMbIBQ1KZCnLvKc4fAXauPWZx+IgKAo4n1TAL0wVjnarSySjfj2zUBZPVPUD
         BNcOOGUf/Y16prPhgFsJwdZKbEqicT+y55CykD6ulKpK5k3413rK/ZTMjrpNqK+KPP7+
         bbY3+mQLFxYVlP9t9rBJ1al5JTQx4d5+cmXzFfmRYqFH/GTf54IW6Kk7B5aUGvosoDet
         kd++24lRiTY9shGp6RNRtvOgxFZ8WCW5PWriFJutTDahPU+zBo8nY0O18WnkAeN/imHi
         qYMA==
X-Received: by 10.70.35.230 with SMTP id l6mr34745899pdj.26.1434226727357;
        Sat, 13 Jun 2015 13:18:47 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nw8sm7471590pdb.30.2015.06.13.13.18.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Jun 2015 13:18:46 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.435.g2403634.dirty
In-Reply-To: <1434226706-3764-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271580>

Add 'parse_opt_merge_filter()' to parse '--merged' and '--no-merged'
options and write MACROS for the same.

This is copied from 'builtin/branch.c' which will eventually be removed
when we port 'branch.c' to use ref-filter APIs.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c |  4 ++++
 ref-filter.c     | 21 +++++++++++++++++++++
 ref-filter.h     | 14 ++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index b42e5b6..ddd90e6 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -745,6 +745,10 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	strbuf_release(&newsection);
 }
 
+/*
+ * This function is duplicated in ref-filter. It will eventually be removed
+ * when we port branch.c to use ref-filter APIs.
+ */
 static int opt_parse_merge_filter(const struct option *opt, const char *arg, int unset)
 {
 	merge_filter = ((opt->long_name[0] == 'n')
diff --git a/ref-filter.c b/ref-filter.c
index 591e281..6502179 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1125,3 +1125,24 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
 	s->atom = parse_ref_filter_atom(arg, arg+len);
 	return 0;
 }
+
+int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
+{
+	struct ref_filter *rf = opt->value;
+	unsigned char sha1[20];
+
+	rf->merge = starts_with(opt->long_name, "no")
+		? REF_FILTER_MERGED_OMIT
+		: REF_FILTER_MERGED_INCLUDE;
+
+	if (!arg)
+		arg = "HEAD";
+	if (get_sha1(arg, sha1))
+		die(_("malformed object name %s"), arg);
+
+	rf->merge_commit = lookup_commit_reference_gently(sha1, 0);
+	if (!rf->merge_commit)
+		return opterror(opt, "must point to a commit", 0);
+
+	return 0;
+}
diff --git a/ref-filter.h b/ref-filter.h
index c2856b8..799e118 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -50,6 +50,18 @@ struct ref_filter_cbdata {
 	struct ref_filter *filter;
 };
 
+/*  Macros for checking --merged and --no-merged options */
+#define OPT_NO_MERGED(filter, h) \
+	{ OPTION_CALLBACK, 0, "no-merged", (filter), N_("commit"), (h), \
+	  PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG, \
+	  parse_opt_merge_filter, (intptr_t) "HEAD" \
+	}
+#define OPT_MERGED(filter, h) \
+	{ OPTION_CALLBACK, 0, "merged", (filter), N_("commit"), (h), \
+	  PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG, \
+	  parse_opt_merge_filter, (intptr_t) "HEAD" \
+	}
+
 /*
  * API for filtering a set of refs. Based on the type of refs the user
  * has requested, we iterate through those refs and apply filters
@@ -71,5 +83,7 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
 /*  Default sort option based on refname */
 struct ref_sorting *ref_default_sorting(void);
+/*  Function to parse --merged and --no-merged options */
+int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
 
 #endif /*  REF_FILTER_H  */
-- 
2.4.3.435.g2403634.dirty
