From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 12/16] ref-filter: add `:dir` and `:base` options for ref printing atoms
Date: Sat, 23 Apr 2016 00:34:03 +0530
Message-ID: <1461351847-22903-13-git-send-email-Karthik.188@gmail.com>
References: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 21:05:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atgOK-000066-6v
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 21:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbcDVTFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 15:05:16 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35115 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbcDVTFO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 15:05:14 -0400
Received: by mail-pf0-f196.google.com with SMTP id r187so10797879pfr.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 12:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UXiv60wS3kvi7JvpdplG/J03SKplePRs3KZZdimQunU=;
        b=kVpm6fExcJDsZiLDrmxfkYo+k3q8qG5w4CAmdccqFa08kuPXJColyHFFl8bsg9YxOb
         r5n0pAhJktklwgqRXbLaCf5JhETg8pMEscM5Aym9/DrglU4lp0pZY7OglypJXf2kE6Wn
         BLEpfaAtnkRXcyad4EzzxXhCDt6VISGuB+1q+gM0Sf+by1UbupdgQs4HJdn3ccH0assk
         YRMjJT+mTSRXrLWdMwU8vneV7fqftKYs5J1CQEQRjyI+N6u5UxV2/T4NDvLQirtEvwjZ
         2HBtikQhLBMKNj4RfMConXH0Sd9cTPevHDuY7n5T0aUF27OSuNFtS3ieX4uIfK15Q4PE
         MuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UXiv60wS3kvi7JvpdplG/J03SKplePRs3KZZdimQunU=;
        b=kZ6wEK0oUmMlJ6m6tzakJ6WJTsTfAa8n+9mGrDI/DaBAdZosxsXD1Tousvt0qJSmmF
         Euq0IZO5+SzU3xFDr0lqEt5BK+ZI8wl7CIGJzzyRASKJdaJhRenbP+WxhuHRSA7B6zSo
         DtTbapUZ3rBK2pTLMH2M61HWY7zs3Syn51EuDSK0OaxnnCCTGvYbgduKX5y37c2X4SAv
         ine/fQqhrtOmSiIPG+sCQc7b0v2aUEwoNO+rSE8+pbV0plMGO9w4TkCjDVXKCN1V5A5u
         VojDS3FMAdKdiECoNTvadzEfDZSQAI0dGHwQ3jgtTpCkHvqtDb3pWL4/CIcxFq4WBrrz
         fvaQ==
X-Gm-Message-State: AOPr4FVM7I3U7S91j5MSI0608/UEIDnTPMtih8iaas2ayGJlaGiX4E047qVdMjUm72Pz+A==
X-Received: by 10.98.65.215 with SMTP id g84mr30813073pfd.118.1461351913911;
        Fri, 22 Apr 2016 12:05:13 -0700 (PDT)
Received: from ashley.localdomain ([106.216.186.206])
        by smtp.gmail.com with ESMTPSA id t1sm11266470paa.17.2016.04.22.12.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 12:05:13 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292258>

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
