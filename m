Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373F8200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 16:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755270AbcL0QXN (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:23:13 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33085 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755269AbcL0QXL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:23:11 -0500
Received: by mail-pg0-f65.google.com with SMTP id g1so12847298pgn.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Yk/IeJo8EOHKUy0Xb+frPmDKMYj4WDLGe8FPJn+pKQ0=;
        b=SN+fROHEAoMUK+g8LNlZtDo4L4Y5pHSloeqS2LJNQKw5wYCwm5M1HVO9yyuOD001zr
         xmzYLcgcb1Zp21zTQ4l+FHENv/kmlguBjrw/5Zm2rhUErhW3byyAMrUed2f6aqfb1IA8
         gXLQwuRUj0QovV6zj3Bxj/Ayqd35Ezyd8EYcmcMiNfzOZslemJbaXjPol/lSVvXX3qx/
         ojQ3F1PaKbo7JzlvcTmUgZGIXuNsUjBYcPQfAYhV6lCIDZMmVs7Hp+1hw83nsd0hbh8D
         9V20vw7VkdQ7dSYand2dK3kreLwd48Ce9B2zmowsLB7DAMuaMb46pRb40Cz4tNVumcyz
         z09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Yk/IeJo8EOHKUy0Xb+frPmDKMYj4WDLGe8FPJn+pKQ0=;
        b=Rx1psjXW6ZdQ8UQ4o4i+zqq7Mh+LAqxekePgHktdDWiFblIGV1KmfKDVEWJP4mGC7w
         EbI4l3tXHHYHaPqN9s+Bv3d7ZiOvnV9AmOxMUxUwuFJmRMOY2pAfOnsysMkYb84GnoJ3
         BjnYFTCsjb1eQMugHMPTmjGoEzcsH0yFYHCH5IZ2gs9f6cPsvCsmdKVkTa41JVYK0v8Z
         WACYGvYsTvDPLCCqU+RpIyZoLh+sy+RgeNjaz7pKjoSZqgSXYHZSjJHDqFMaFcjrwpql
         AwCuS0AWW0tFwpD5rjpyJj9GDNWhG+WXuHnlZenJ85OFr+9JB4eXrqtLmQ5FuRQWlpNj
         yPpw==
X-Gm-Message-State: AIkVDXLBoop3kXJpuiisXiLH/2bCvYutXfCnfboXCEg1QLWfcQFGQPh9wLOMdSmGAZfAfQ==
X-Received: by 10.99.94.194 with SMTP id s185mr59266354pgb.35.1482855790759;
        Tue, 27 Dec 2016 08:23:10 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:09 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v9 00/20] port branch.c to use ref-filter's printing options
Date:   Tue, 27 Dec 2016 21:53:37 +0530
Message-Id: <20161227162357.28212-1-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is part of unification of the commands 'git tag -l, git branch -l
and git for-each-ref'. This ports over branch.c to use ref-filter's
printing options.

Initially posted here: $(gmane/279226). It was decided that this series
would follow up after refactoring ref-filter parsing mechanism, which
is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).

v1 can be found here: $(gmane/288342)
v2 can be found here: $(gmane/288863)
v3 can be found here: $(gmane/290299)
v4 can be found here: $(gmane/291106)
v5b can be found here: $(gmane/292467)
v6 can be found here: http://marc.info/?l=git&m=146330914118766&w=2
v7 can be found here: http://marc.info/?l=git&m=147863593317362&w=2
v8 can be found here: http://marc.info/?l=git&m=148112502029302&w=2

Changes in this version:
1. A few formatting errors.
2. Made quote_literal_for_format() static.
3. lstrip and rstrip doesn't die on less components.

Thanks Jacob, Junio, Jeff, Ramsay for their suggestions and help.

Karthik Nayak (20):
  ref-filter: implement %(if), %(then), and %(else) atoms
  ref-filter: include reference to 'used_atom' within 'atom_value'
  ref-filter: implement %(if:equals=<string>) and
    %(if:notequals=<string>)
  ref-filter: modify "%(objectname:short)" to take length
  ref-filter: move get_head_description() from branch.c
  ref-filter: introduce format_ref_array_item()
  ref-filter: make %(upstream:track) prints "[gone]" for invalid
    upstreams
  ref-filter: add support for %(upstream:track,nobracket)
  ref-filter: make "%(symref)" atom work with the ':short' modifier
  ref-filter: introduce refname_atom_parser_internal()
  ref-filter: introduce refname_atom_parser()
  ref-filter: make remote_ref_atom_parser() use
    refname_atom_parser_internal()
  ref-filter: rename the 'strip' option to 'lstrip'
  ref-filter: Do not abruptly die when using the 'lstrip=<N>' option
  ref-filter: modify the 'lstrip=<N>' option to work with negative '<N>'
  ref-filter: add an 'rstrip=<N>' option to atoms which deal with
    refnames
  ref-filter: allow porcelain to translate messages in the output
  branch, tag: use porcelain output
  branch: use ref-filter printing APIs
  branch: implement '--format' option

 Documentation/git-branch.txt       |   7 +-
 Documentation/git-for-each-ref.txt |  86 +++++--
 builtin/branch.c                   | 290 +++++++---------------
 builtin/tag.c                      |   6 +-
 ref-filter.c                       | 490 +++++++++++++++++++++++++++++++------
 ref-filter.h                       |   7 +
 t/t3203-branch-output.sh           |  16 +-
 t/t6040-tracking-info.sh           |   2 +-
 t/t6300-for-each-ref.sh            |  88 ++++++-
 t/t6302-for-each-ref-filter.sh     |  94 +++++++
 10 files changed, 780 insertions(+), 306 deletions(-)

Interdiff:

diff --git a/builtin/branch.c b/builtin/branch.c
index 6393c3c..4051a18 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -306,9 +306,9 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 	return max;
 }

-const char *quote_literal_for_format(const char *s)
+static const char *quote_literal_for_format(const char *s)
 {
-	struct strbuf buf = STRBUF_INIT;
+	static struct strbuf buf = STRBUF_INIT;

 	strbuf_reset(&buf);
 	while (*s) {
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -76,10 +77,10 @@ static struct used_atom {
 		struct {
 			enum { RR_REF, RR_TRACK, RR_TRACKSHORT } option;
 			struct refname_atom refname;
-			unsigned int nobracket: 1;
+			unsigned int nobracket : 1;
 		} remote_ref;
@@ -1106,7 +1126,8 @@ static const char *lstrip_ref_components(const char *refname, int len)
 		const char *p = refname;

 		/* Find total no of '/' separated path-components */
-		for (i = 0; p[i]; p[i] == '/' ? i++ : *p++);
+		for (i = 0; p[i]; p[i] == '/' ? i++ : *p++)
+			;
 		/*
 		 * The number of components we need to strip is now
 		 * the total minus the components to be left (Plus one
@@ -1116,11 +1137,10 @@ static const char *lstrip_ref_components(const char *refname, int len)
 		remaining = i + len + 1;
 	}

-	while (remaining) {
+	while (remaining > 0) {
 		switch (*start++) {
 		case '\0':
-			die(_("ref '%s' does not have %d components to :lstrip"),
-			    refname, len);
+			return "";
 		case '/':
 			remaining--;
 			break;
@@ -1140,7 +1160,8 @@ static const char *rstrip_ref_components(const char *refname, int len)
 		const char *p = refname;

 		/* Find total no of '/' separated path-components */
-		for (i = 0; p[i]; p[i] == '/' ? i++ : *p++);
+		for (i = 0; p[i]; p[i] == '/' ? i++ : *p++)
+			;
 		/*
 		 * The number of components we need to strip is now
 		 * the total minus the components to be left (Plus one
@@ -1150,11 +1171,10 @@ static const char *rstrip_ref_components(const char *refname, int len)
 		remaining = i + len + 1;
 	}

-	while (remaining--) {
+	while (remaining-- > 0) {
 		char *p = strrchr(start, '/');
 		if (p == NULL)
-			die(_("ref '%s' does not have %d components to :rstrip"),
-			  refname, len);
+			return "";
 		else
 			p[0] = '\0';
 	}
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -153,16 +153,6 @@ test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
 '

-test_expect_success 'stripping refnames too far gives an error' '
-	test_must_fail git for-each-ref --format="%(refname:lstrip=3)" &&
-	test_must_fail git for-each-ref --format="%(refname:lstrip=-4)"
-'
-
-test_expect_success 'stripping refnames too far gives an error' '
-	test_must_fail git for-each-ref --format="%(refname:rstrip=3)" &&
-	test_must_fail git for-each-ref --format="%(refname:rstrip=-4)"
-'
-
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
 	git for-each-ref --format="%(authordate)" refs/heads &&
 	git for-each-ref --format="%(authordate:default) %(authordate)" refs/heads &&
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index c72baeb..81db67d 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -92,14 +95,13 @@ refname::
        The name of the ref (the part after $GIT_DIR/).
        For a non-ambiguous short name of the ref append `:short`.
        The option core.warnAmbiguousRefs is used to select the strict
-       abbreviation mode. If `lstrip=<N>` or `rstrip=<N>` option can
+       abbreviation mode. The `lstrip=<N>` or `rstrip=<N>` option can
        be appended to strip `<N>` slash-separated path components
-       from or end of the refname respectively (e.g.,
+       from the left or right of the refname respectively (e.g.,
        `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo` and
        `%(refname:rstrip=2)` turns `refs/tags/foo` into `refs`).  if
        `<N>` is a negative number, then only `<N>` path components
-       are left behind.  If a displayed ref has fewer components than
-       `<N>`, the command aborts with an error.
+       are left behind.

 objecttype::
        The type of the object (`blob`, `tree`, `commit`, `tag`).



--
2.10.2
