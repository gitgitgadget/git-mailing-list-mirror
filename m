From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 12/16] ref-filter: add support for %(refname:dir) and %(refname:base)
Date: Tue, 15 Mar 2016 22:17:12 +0530
Message-ID: <1458060436-1215-13-git-send-email-Karthik.188@gmail.com>
References: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 17:48:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afs8b-000108-98
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965305AbcCOQr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:47:57 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33816 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965214AbcCOQrw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:47:52 -0400
Received: by mail-pf0-f175.google.com with SMTP id x3so35801686pfb.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Jc1EZU7VXlInSQzRU6T5C6iATcru3FTxsy7xKawMVg=;
        b=e+UZeSA/u9HrHgC+EloQ767U1ZbYJxeph2oGP4te6I235dRGkq+rqu/IVGn+yCWF+A
         3rjBVnBdX820iFwTpnYRl66DmoCVcK1TRZzs7smkbYQnpy1xCUSOzCWd/RPBpxtjmzIh
         QNXXedvmnFyzQ1jQhAX9woLVLCLvKIHMJAIMvGRgrGb0z2lGsA30GqZJcyMNaLD5ef4z
         R4jQBSU5VoGk7x+8H2XgtneBUIcNc0mh46yifcOrcHn+Kibsh8g4civOuivHTl7HPu7K
         CnvarnD/PjdMbRUm7peQ2ZrJhWdyBRaChcXzkn8fHJ2E/5c1tGNsNBwf8QevlgumLVw0
         gnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Jc1EZU7VXlInSQzRU6T5C6iATcru3FTxsy7xKawMVg=;
        b=BAeMmusnQiElhwv3VAWKNzI1EZVeDwPuKH3Iegqy+dJaOBz4e6kiWLrV08qG59nmJR
         7CFuCB/KOMaM/hBLY1EYx+pmhuyGHXOWErquk6/ePOhw9grlxJu1wR9E/yTkk0E8Qs0U
         4r6pHxdh/5BpmO7Zkp+PQVNAl4CnYKfQ3UVVXWZjyRly6hAriWo46Ezonrg3yrHunX5r
         vWENtvX0HM2W+IruLcRwcBMnDGUwCQ5pfjsqcs3GEAEZqRUOA5U7NOYqloSVCOB2XG/g
         xMkfL/AvaxVdUEoG0vIlFXYrHfX14iBTVtPi8I7XmNqRMU0zfkLZVlhfbJ6gLQgGBv92
         pwIw==
X-Gm-Message-State: AD7BkJLBm2SoX2AM9xA1rbLuSUkDlKvppN+JMx45rEq9t2Msf4+naeob35BSvhpwpf9doA==
X-Received: by 10.98.80.206 with SMTP id g75mr39972046pfj.127.1458060471427;
        Tue, 15 Mar 2016 09:47:51 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.87])
        by smtp.gmail.com with ESMTPSA id i1sm40874361pfj.17.2016.03.15.09.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 09:47:50 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288875>

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
index 4e41cee..578bbd1 100644
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
2.7.3
