From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 12/16] ref-filter: add support for %(refname:dir) and %(refname:base)
Date: Sun, 10 Apr 2016 00:15:11 +0530
Message-ID: <1460227515-28437-13-git-send-email-Karthik.188@gmail.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 20:46:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoxtN-0003o8-VG
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 20:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759207AbcDISpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 14:45:53 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:34475 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759100AbcDISpv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 14:45:51 -0400
Received: by mail-ig0-f195.google.com with SMTP id qu10so6553414igc.1
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=foRM2jqjUmP+b4o+YbCzyxGtcPG1uLOyb0Cp+XOAHXc=;
        b=ncxKAcyKnH2wALWLw1+c7eWB6IBOeU4hQBDZqoUQ4/FI6my2PfnOyWsNQoIx1JjJt7
         ksu5p92xelG1ceyKttzbRGmAfunDWa161zujVGRwde0fjvxa8qVU21eMD5ESr62u4bCR
         F1meRRKlThZk7NjQdaGCP+MyKMOLVNIimn+f4oGpUNqKJ6CBdMl4aympXD81gmsIdJjU
         drwtMeWCmJ/NDLWxMNPZrptfcA04xQ8R/EDgqQF8uYScNsEU8DNf0jqLdkVEy9nrWJ60
         Vvr9F+hmoKAZ+EO5fqCFc0fAnfRCs/farO0IEQqtAh9TYRkzAZusrwBN1KH7SerMn6cz
         hGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=foRM2jqjUmP+b4o+YbCzyxGtcPG1uLOyb0Cp+XOAHXc=;
        b=nNGf3o69xU9kuqecUwjSeTlWmMQqbVfSIVrvBj9Dxor4x+LetpI25BN601Tnfw8Zk/
         teLr1lj+WtjIYpaTdVDaq3Qdkzh/cxD+laNpeO/3hawk9hd2XSf/ElbEo13ZWXheoOsI
         y9/frF0geFdu+FBMJB+MHtK4YMO6fVWMR1s7DgU/eSjjZs6i+x0Apf2XsR8Fp9ZMfIV9
         x0ARaDx1Qn6Rxfo85X726zi1n7zmbpgVn4QeNMyq25KlXc27EJnRL9P2V3Retc6bdsDt
         grv/7jilw7LXRkKDeVIVZD/c4t+RgKM1nOdoQo0Lc/VAMxbsTKJAmlIicZVyNur4AdP3
         CHUw==
X-Gm-Message-State: AD7BkJKAI1/dIx1jSjvN4+4uUCwUX102I/Y3bS1UEycL1R9I1np7bsvlyNCmNCvwwpJXMg==
X-Received: by 10.50.112.98 with SMTP id ip2mr10580124igb.14.1460227550350;
        Sat, 09 Apr 2016 11:45:50 -0700 (PDT)
Received: from localhost.localdomain ([106.51.241.12])
        by smtp.gmail.com with ESMTPSA id be7sm7132351igb.1.2016.04.09.11.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Apr 2016 11:45:49 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291118>

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
2.8.0
