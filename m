From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 11/15] ref-filter: add support for %(refname:dir) and %(refname:base)
Date: Sun,  6 Mar 2016 17:34:58 +0530
Message-ID: <1457265902-7949-12-git-send-email-Karthik.188@gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 13:05:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acXRY-0002Bg-Sz
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 13:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbcCFMFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 07:05:43 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36419 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbcCFMFc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 07:05:32 -0500
Received: by mail-pf0-f171.google.com with SMTP id 63so62817027pfe.3
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 04:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=paRm7JvQoL/D8XV96PFacFxgkfkBnXpqg6kVboA25SM=;
        b=mMlpNiMMaJBEwdfzQjN6dfEm1ErzTL6pEV9KwQojDIqCn6t4KL+pvtnG6TLcNY1hzk
         TKhib9OwuNN1AvB2EKC6bdFt94pWFVx0Uhn057ETz8PFJEcvpTRCVYgg9BAoM3Q68r7u
         NfvxefqdC+DHCM73KT0XGaiVlv+Kgzx4g8JYAv6kC4nwXPFkUZSs201QWPS8AZH8uhGO
         QGjXRufa/w7g6d7qilob74cka9r6wFYTtX/EYxZfdayhd9V9GoDFGDpDrhAVjl4qmINQ
         acYW7GAxfA/pM5hcjVSiAc9gCmP5m5QlfeJWT40ILk8DV1pAtNrbqh9Oxr6Yb5gZqNXe
         FVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=paRm7JvQoL/D8XV96PFacFxgkfkBnXpqg6kVboA25SM=;
        b=g9WRsRNn4UfY2AICld4NocUFUjH4qoerY/9UFj4AEXDVYnlh4OkwAkZR56qu4M/iEc
         2+wdOa7dK4GzTn7PaiWCuxDevtQVtFpsbytr7t8SVnUGQk71KuGm6lcdDb9D70pKbji5
         4NJzuy3NC3TG2RDKW6cZQzJx3bL/MDQu06dC7LOKQWM4O+MpYBb3UqRQSWw0SvEqMPeM
         tqRZ/+pgkC1URf2yuUs/aNmAKV8lTvmE3+QahiFOTE2bu3JmHc3IiFA+wJtdsCxGX+94
         6m54Ed6GJH6+Onmil3s41r2SmEaWq4PC7jw4quIcP/y3xv7DdXw2uLxPb52hKDGym+5o
         vB1g==
X-Gm-Message-State: AD7BkJLuAHc6sT7nXQ/HoaYAIR9WGbHsUlhajvKuAbkl54OeIzfGr/mQQ3hvftw6DLzAXQ==
X-Received: by 10.98.9.92 with SMTP id e89mr26055884pfd.34.1457265931601;
        Sun, 06 Mar 2016 04:05:31 -0800 (PST)
Received: from localhost.localdomain ([106.51.240.143])
        by smtp.gmail.com with ESMTPSA id n66sm17536850pfj.39.2016.03.06.04.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 04:05:31 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288353>

Add the options `:dir` and `:base` to the %(refname) atom. The `:dir`
option gives the directory (the part after $GIT_DIR/) of the ref without
the refname. The `:base` option gives the base directory of the given
ref (i.e. the directory following $GIT_DIR/refs/).

Add tests and documentation for the same.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  4 +++-
 ref-filter.c                       | 28 +++++++++++++++++++++++++---
 t/t6300-for-each-ref.sh            |  2 ++
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 0658c3f..193e99e 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -96,7 +96,9 @@ refname::
 	slash-separated path components from the front of the refname
 	(e.g., `%(refname:strip=2)` turns `refs/tags/foo` into `foo`.
 	`<N>` must be a positive integer.  If a displayed ref has fewer
-	components than `<N>`, the command aborts with an error.
+	components than `<N>`, the command aborts with an error. For the base
+	directory of the ref (i.e. foo in refs/foo/bar/boz) append
+	`:base`. For the entire directory path append `:dir`.
 
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
diff --git a/ref-filter.c b/ref-filter.c
index 2393800..45f9d16 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -60,7 +60,7 @@ static struct used_atom {
 		} objectname;
 		enum { S_FULL, S_SHORT } symref;
 		struct {
-			enum { R_NORMAL, R_SHORT, R_STRIP } option;
+			enum { R_BASE, R_DIR, R_NORMAL, R_SHORT, R_STRIP } option;
 			unsigned int strip;
 		} refname;
 	} u;
@@ -227,7 +227,11 @@ static void refname_atom_parser(struct used_atom *atom, const char *arg)
 		if (strtoul_ui(arg, 10, &atom->u.refname.strip) ||
 			atom->u.refname.strip <= 0)
 			die(_("positive value expected refname:strip=%s"), arg);
-	} else
+	} else if (!strcmp(arg, "dir"))
+		atom->u.contents.option = R_DIR;
+	else if (!strcmp(arg, "base"))
+		atom->u.contents.option = R_BASE;
+	else
 		die(_("unrecognized %%(refname) argument: %s"), arg);
 }
 
@@ -1166,7 +1170,25 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
 		return shorten_unambiguous_ref(ref->refname, warn_ambiguous_refs);
 	else if (atom->u.refname.option == R_STRIP)
 		return strip_ref_components(ref->refname, atom->u.refname.strip);
-	else
+	else if (atom->u.refname.option == R_BASE) {
+		const char *sp, *ep;
+
+		if (skip_prefix(ref->refname, "refs/", &sp)) {
+			ep = strchr(sp, '/');
+			if (!ep)
+				return "";
+			return xstrndup(sp, ep - sp);
+		}
+		return "";
+	} else if (atom->u.refname.option == R_DIR) {
+		const char *sp, *ep;
+
+		sp = ref->refname;
+		ep = strrchr(sp, '/');
+		if (!ep)
+			return "";
+		return xstrndup(sp, ep - sp);
+	} else
 		return ref->refname;
 }
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index b06ea1c..36d32d7 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -53,6 +53,8 @@ test_atom head refname refs/heads/master
 test_atom head refname:short master
 test_atom head refname:strip=1 heads/master
 test_atom head refname:strip=2 master
+test_atom head refname:dir refs/heads
+test_atom head refname:base heads
 test_atom head upstream refs/remotes/origin/master
 test_atom head upstream:short origin/master
 test_atom head push refs/remotes/myfork/master
-- 
2.7.2
