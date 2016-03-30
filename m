From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 12/16] ref-filter: add support for %(refname:dir) and %(refname:base)
Date: Wed, 30 Mar 2016 15:09:56 +0530
Message-ID: <1459330800-12525-13-git-send-email-Karthik.188@gmail.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 11:40:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alCcL-0001nn-5E
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 11:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbcC3Jkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 05:40:43 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:32875 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbcC3Jkj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 05:40:39 -0400
Received: by mail-pa0-f48.google.com with SMTP id zm5so36440555pac.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 02:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aSX50Wu932+EQ8cJ2L0ihVfIpDfK+woWgud8x7Ub8bo=;
        b=apDbm6PLTUB/7hnEE/a3OxEqo/lFyLnUDaDHfejFrweWMr2P7MqJgtEZXyQdJUBmeY
         SbExpBf0TlTln3NhaPSMzs0W9ORvHH54aMQbcQjK/69ijjvtqbP/NTYvBblX2LvvYy20
         rreZ8m+lVckjExKCW5EHkaxupm7yEZeKIl0oVvdHwQEnPZPfJHabxC+26gQWRbtSYMw4
         UGYUoNCFSMhAiAqM+2wAozLfLAClHb2m180B+X83aBebYP3RBlBRXMqdIPz/tkYJ4svg
         ck3Ep8UXJa5tjHolypuHNSeAOFsUWOrl9YbJiHs1ytoQ4YzcHzze0s1dDC1RPVaGwgrY
         WdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aSX50Wu932+EQ8cJ2L0ihVfIpDfK+woWgud8x7Ub8bo=;
        b=LegQOqOUQwXUSA2OGt3EVUMe/lz95VmSA2YuVFQym2bi8xflHhNt8zquV1b9V066d4
         bfl6KOMRsBDcPlF7sKK5EAOf+7pUFRh20H9AWzYDuiEGoGD1EWAD1M1NnUhrdABfWJwH
         oUAxETrm0M5Uzza0/hEtOVDeWSb7q8UX5xNUz5IVmUg4IWgzsaDTd6TLMpH3bLWWS4n4
         xDSfal05mtla97V9BQAg7WxRxXXdOjxVaWIX+OXnqMGYTdPRW7qLsPLgbJ6/HJWpqMTM
         mnG9IZuJgajLzsqr6TIxPHVOpWtVPePrAjwtdLiz0E0E3hilQjFV9G5IEHuvVbJtQb08
         MMzg==
X-Gm-Message-State: AD7BkJL38j7u0chtGixN3yzYIKCrfvJOzb9pVoOJtymLh5SXRV/JxdGLE9xyy00Sjl+hYw==
X-Received: by 10.67.30.163 with SMTP id kf3mr11430603pad.45.1459330838306;
        Wed, 30 Mar 2016 02:40:38 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.45])
        by smtp.gmail.com with ESMTPSA id r65sm4402606pfa.27.2016.03.30.02.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 02:40:37 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290291>

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
index be763c4..0d7d80f 100644
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
index dc1e404..73e0a7f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -64,7 +64,7 @@ static struct used_atom {
 		} objectname;
 		enum { S_FULL, S_SHORT } symref;
 		struct {
-			enum { R_NORMAL, R_SHORT, R_STRIP } option;
+			enum { R_BASE, R_DIR, R_NORMAL, R_SHORT, R_STRIP } option;
 			unsigned int strip;
 		} refname;
 	} u;
@@ -243,7 +243,11 @@ static void refname_atom_parser(struct used_atom *atom, const char *arg)
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
 
@@ -1175,7 +1179,25 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
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
2.7.4
