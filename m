From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5b 13/17] ref-filter: add `:dir` and `:base` options for ref printing atoms
Date: Mon, 25 Apr 2016 20:47:54 +0530
Message-ID: <1461597478-31855-13-git-send-email-Karthik.188@gmail.com>
References: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 17:18:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auiHk-0005yC-PG
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 17:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbcDYPSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 11:18:44 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35515 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932606AbcDYPSk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 11:18:40 -0400
Received: by mail-pa0-f47.google.com with SMTP id iv1so16581531pac.2
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 08:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UXiv60wS3kvi7JvpdplG/J03SKplePRs3KZZdimQunU=;
        b=FvoO+RS5Rl279Lg19kMV8f0M+M3gamKOxRB9UWKvkcp0U9NiBM9Dol4KCo7ILvQKlj
         hu1MHTjMvtzFRHTOowTB78QCm7IuPv8+PUy39LRuQTHrqqwUISbhFFUGEx+IqO430wdR
         yR8L/axJj2rWTfQv5URtcJ2F6KL6lGtZN1d4jCZjLjr9A8D7sua18fqmCfzDC7GaFTjF
         /O8KQnqwEkGHkCOjsGdp5ow9OLx/7TSrI3WnSCJq/ez4LUtSWzLP6DIbjW/tXhH8Nuuu
         GRzHooZAhKXmGjuoUn/u+nUY/Yd9Ruk5uccQBKTQ49gH9ypYKL11sCE5jRq4DrbxLBiQ
         L+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UXiv60wS3kvi7JvpdplG/J03SKplePRs3KZZdimQunU=;
        b=QUf23mK1UyTzk0zNTV1tIfk62PBS5BnoMbde45vixhHB32M/abOmdD/kjZ9u8yHeBu
         JtbIKnYUhvU97Lo0LwdXyPYRreAVtriguf8CJPU/TjlO397ZwYpHo1Ssv9UzefwjNrOJ
         UHaC7NkAzXv2udNTWEg77KS82WKZE+eDf1lH+MLSB/ebSy0JjtpYUFipWk3Osy/+PeYh
         nPOUii8cE7YYDPV5+yLp7I33icOANUixEGCadIMU5/cXJ+w47dhxMTZEmjoE7uXQue66
         +lKp5Mmt6dxshVTXjNFPO/Gkl4ZFR0a61NUbfWaOaSGLvFoM8IZZvhnrm0SGV1DqAFyl
         2LIQ==
X-Gm-Message-State: AOPr4FX/10h06cUrGzzQ49estSqYVbQClaSXOiT8tMrT7XHDnsBaTI/ensJPY2UA7qQVqA==
X-Received: by 10.66.1.99 with SMTP id 3mr48395794pal.26.1461597519894;
        Mon, 25 Apr 2016 08:18:39 -0700 (PDT)
Received: from ashley.localdomain ([106.51.234.108])
        by smtp.gmail.com with ESMTPSA id ut1sm30812527pac.46.2016.04.25.08.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 08:18:39 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292501>

Add the options `:dir` and `:base` to all ref printing ('%(refname)',
'%(symref)', '%(push)' and '%(upstream)') atoms. The `:dir` option gives
the directory (the part after $GIT_DIR/) of the ref without the
refname. The `:base` option gives the base directory of the given
ref (i.e. the directory following $GIT_DIR/refs/).

Add tests and documentation for the same.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 34 +++++++++++++++++++---------------
 ref-filter.c                       | 29 +++++++++++++++++++++++++----
 t/t6300-for-each-ref.sh            | 24 ++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 3eaf770..4a5e9ea 100644
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
@@ -114,22 +116,23 @@ objectname::
 
 upstream::
 	The name of a local ref which can be considered ``upstream''
-	from the displayed ref. Respects `:short` and `:strip` in the
-	same way as `refname` above.  Additionally respects `:track`
-	to show "[ahead N, behind M]" and `:trackshort` to show the
-	terse version: ">" (ahead), "<" (behind), "<>" (ahead and
-	behind), or "=" (in sync). `:track` also prints "[gone]"
-	whenever unknown upstream ref is encountered. Append
-	`:track,nobracket` to show tracking information without
-	brackets (i.e "ahead N, behind M").  Has no effect if the ref
-	does not have tracking information associated with it.
+	from the displayed ref. Respects `:short`, `:strip`, `:base`
+	and `:dir` in the same way as `refname` above.  Additionally
+	respects `:track` to show "[ahead N, behind M]" and
+	`:trackshort` to show the terse version: ">" (ahead), "<"
+	(behind), "<>" (ahead and behind), or "=" (in sync). `:track`
+	also prints "[gone]" whenever unknown upstream ref is
+	encountered. Append `:track,nobracket` to show tracking
+	information without brackets (i.e "ahead N, behind M").  Has
+	no effect if the ref does not have tracking information
+	associated with it.
 
 push::
 	The name of a local ref which represents the `@{push}`
 	location for the displayed ref. Respects `:short`, `:strip`,
-	`:track`, and `:trackshort` options as `upstream`
-	does. Produces an empty string if no `@{push}` ref is
-	configured.
+	`:track`, `:trackshort`, `:base` and `:dir` options as
+	`upstream` does. Produces an empty string if no `@{push}` ref
+	is configured.
 
 HEAD::
 	'*' if HEAD matches current ref (the checked out branch), ' '
@@ -166,8 +169,9 @@ if::
 
 symref::
 	The ref which the given symbolic ref refers to. If not a
-	symbolic ref, nothing is printed. Respects the `:short` and
-	`:strip` options in the same way as `refname` above.
+	symbolic ref, nothing is printed. Respects the `:short`,
+	`:strip`, `:base` and `:dir` options in the same way as
+	`refname` above.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/ref-filter.c b/ref-filter.c
index 3b42aab..97977a5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -31,7 +31,7 @@ struct if_then_else {
 };
 
 struct refname_atom {
-	enum { R_NORMAL, R_SHORT, R_STRIP } option;
+	enum { R_BASE, R_DIR, R_NORMAL, R_SHORT, R_STRIP } option;
 	unsigned int strip;
 };
 
@@ -93,7 +93,11 @@ static void refname_atom_parser_internal(struct refname_atom *atom,
 		atom->option = R_STRIP;
 		if (strtoul_ui(arg, 10, &atom->strip) || atom->strip <= 0)
 			die(_("positive value expected refname:strip=%s"), arg);
-	} 	else
+	} else if (!strcmp(arg, "dir"))
+		atom->option = R_DIR;
+	else if (!strcmp(arg, "base"))
+		atom->option = R_BASE;
+	else
 		die(_("unrecognized %%(%s) argument: %s"), name, arg);
 }
 
@@ -252,7 +256,6 @@ static void if_atom_parser(struct used_atom *atom, const char *arg)
 		die(_("unrecognized %%(if) argument: %s"), arg);
 }
 
-
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -1096,7 +1099,25 @@ static const char *show_ref(struct refname_atom *atom, const char *refname)
 		return shorten_unambiguous_ref(refname, warn_ambiguous_refs);
 	else if (atom->option == R_STRIP)
 		return strip_ref_components(refname, atom->strip);
-	else
+	else if (atom->option == R_BASE) {
+		const char *sp, *ep;
+
+		if (skip_prefix(refname, "refs/", &sp)) {
+			ep = strchr(sp, '/');
+			if (!ep)
+				return "";
+			return xstrndup(sp, ep - sp);
+		}
+		return "";
+	} else if (atom->option == R_DIR) {
+		const char *sp, *ep;
+
+		sp = refname;
+		ep = strrchr(sp, '/');
+		if (!ep)
+			return "";
+		return xstrndup(sp, ep - sp);
+	} else
 		return refname;
 }
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 7ca0a12..8ff6568 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -53,12 +53,18 @@ test_atom head refname refs/heads/master
 test_atom head refname:short master
 test_atom head refname:strip=1 heads/master
 test_atom head refname:strip=2 master
+test_atom head refname:dir refs/heads
+test_atom head refname:base heads
 test_atom head upstream refs/remotes/origin/master
 test_atom head upstream:short origin/master
 test_atom head upstream:strip=2 origin/master
+test_atom head upstream:dir refs/remotes/origin
+test_atom head upstream:base remotes
 test_atom head push refs/remotes/myfork/master
 test_atom head push:short myfork/master
 test_atom head push:strip=1 remotes/myfork/master
+test_atom head push:dir refs/remotes/myfork
+test_atom head push:base remotes
 test_atom head objecttype commit
 test_atom head objectsize 171
 test_atom head objectname $(git rev-parse refs/heads/master)
@@ -600,4 +606,22 @@ test_expect_success 'Verify usage of %(symref:strip) atom' '
 	test_cmp expected actual
 '
 
+cat >expected <<EOF
+refs/heads
+EOF
+
+test_expect_success 'Verify usage of %(symref:dir) atom' '
+	git for-each-ref --format="%(symref:dir)" refs/heads/sym > actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+heads
+EOF
+
+test_expect_success 'Verify usage of %(symref:base) atom' '
+	git for-each-ref --format="%(symref:base)" refs/heads/sym > actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.8.0
