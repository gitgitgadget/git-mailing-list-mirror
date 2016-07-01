Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B3192018A
	for <e@80x24.org>; Fri,  1 Jul 2016 16:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbcGAQD5 (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 12:03:57 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33192 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbcGAQDz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 12:03:55 -0400
Received: by mail-lf0-f66.google.com with SMTP id l188so11784576lfe.0
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 09:03:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4CWYXg+MctISzpUj8y4lRWVoxNPIOcxO8Y2aunroVlE=;
        b=ofZaIqZjAievl2YAOV5HxsGRJZxAf9U+MyRayNj9jeGNJ4I2W9no4plc85F1d6309w
         teMEA7qWAzGzO5skC2y3W7XfKs0XBaH8Rq9Bc80VYVlJ+l4reSJcggL5gPNjdnw1JfRq
         N/6g6z1PYUUqKSWR67dkUytnmUD9YTVZoNusb67DEh2thR+zGp8cmk0PFRNMqqyKIJPq
         H8jG3zixfqee3xXEhYVhh4ztTdp2+7ecBJawgYcG6a+Fl6Q53Xxr86e7SKGaKgIfc01P
         TIqi4Ttw7kBjYErl0ZMHzx2ljal9GQW3htqOpdLnhKpn64rgwPCGaTq8hvC1CPu3i/WE
         ZzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4CWYXg+MctISzpUj8y4lRWVoxNPIOcxO8Y2aunroVlE=;
        b=Y4lUe7j6JqiSrrY/Y3KcB7enP5T98MFQMcqmK5qlwugfHa9hHI3Cc0/fSy06d1icl3
         6xD/yqMKA/qi12AFGVWNjAk255GacqKSOMUJJnfAwifHjY/H1l1xlH+YaWh6qGQ0XAd9
         sCz1mqfHY9qqISvCwE2SX/FNT5CxGdUsLnGnwClyohMAEBE7jR+G1I6QSxEkoxse1Mx+
         NDVh2m6OswwCEX3zz5rqvH/l6JG11GJrhVdbfpCmtVhyMkfvC0kVWT8f4k7wV480mVvT
         Y+1lLD7bj3guyrgNu9D3LMLlJ2jp/GZecS5CaeNTcjE835Y9TKvcGjbvQ3qs8Sfj9k90
         C+qw==
X-Gm-Message-State: ALyK8tKrY1Cn49hJPpVOV0VrSBlGU0aXC7eemaDu7kLpREOAh4xFhC/kFZhDEqi2Y6dGjQ==
X-Received: by 10.25.206.148 with SMTP id e142mr7161943lfg.182.1467389033131;
        Fri, 01 Jul 2016 09:03:53 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id k18sm884102lfg.47.2016.07.01.09.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Jul 2016 09:03:51 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, marcnarc@xiplink.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 5/5] fetch: reduce duplicate in ref update status lines with placeholder
Date:	Fri,  1 Jul 2016 18:03:31 +0200
Message-Id: <20160701160331.29252-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.531.gd073806
In-Reply-To: <20160701160331.29252-1-pclouds@gmail.com>
References: <20160626055810.26960-1-pclouds@gmail.com>
 <20160701160331.29252-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In the "remote -> local" line, if either ref is a substring of the
other, the common part in the other string is replaced with "*". For
example

    abc                -> origin/abc
    refs/pull/123/head -> pull/123

become

    abc         -> origin/*
    refs/*/head -> pull/123

Activated with fetch.output=compact.

For the record, this output is not perfect. A single giant ref can
push all refs very far to the right and likely be wrapped around. We
may have a few options:

 - exclude these long lines smarter

 - break the line after "->", exclude it from column width calculation

 - implement a new format, { -> origin/}foo, which makes the problem
   go away at the cost of a bit harder to read

 - reverse all the arrows so we have "* <- looong-ref", again still
   hard to read.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt    |  5 +++
 Documentation/git-fetch.txt |  5 +++
 builtin/fetch.c             | 77 ++++++++++++++++++++++++++++++++++++++++++++-
 t/t5510-fetch.sh            | 17 +++++++++-
 4 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2e1b2e4..7f6e58d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1220,6 +1220,11 @@ fetch.prune::
 	If true, fetch will automatically behave as if the `--prune`
 	option was given on the command line.  See also `remote.<name>.prune`.
 
+fetch.output::
+	Control how ref update status is printed. Valid values are
+	`full` and `compact`. Default value is `full`. See section
+	OUTPUT in linkgit:git-fetch[1] for detail.
+
 format.attach::
 	Enable multipart/mixed attachments as the default for
 	'format-patch'.  The value can also be a double quoted string
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 771dde5..9e42169 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -116,6 +116,11 @@ representing the status of a single ref. Each line is of the form:
 The status of up-to-date refs is shown only if the --verbose option is
 used.
 
+In compact output mode, specified with configuration variable
+fetch.output, if either entire `<from>` or `<to>` is found in the
+other string, it will be substituted with `*` in the other string. For
+example, `master -> origin/master` becomes `master -> origin/*`.
+
 flag::
 	A single character indicating the status of the ref:
 (space);; for a successfully fetched fast-forward;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 2bc609b..0a2eed1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -451,6 +451,7 @@ fail:
 }
 
 static int refcol_width = 10;
+static int compact_format;
 
 static void adjust_refcol_width(const struct ref *ref)
 {
@@ -462,6 +463,7 @@ static void adjust_refcol_width(const struct ref *ref)
 
 	max    = term_columns();
 	rlen   = utf8_strwidth(prettify_refname(ref->name));
+
 	llen   = utf8_strwidth(prettify_refname(ref->peer_ref->name));
 
 	/*
@@ -470,10 +472,19 @@ static void adjust_refcol_width(const struct ref *ref)
 	 * anyway because we don't know if the error explanation part
 	 * will be printed in update_local_ref)
 	 */
+	if (compact_format) {
+		llen = 0;
+		max = max * 2 / 3;
+	}
 	len = 21 /* flag and summary */ + rlen + 4 /* -> */ + llen;
 	if (len >= max)
 		return;
 
+	/*
+	 * Not precise calculation for compact mode because '*' can
+	 * appear on the left hand side of '->' and shrink the column
+	 * back.
+	 */
 	if (refcol_width < rlen)
 		refcol_width = rlen;
 }
@@ -481,6 +492,16 @@ static void adjust_refcol_width(const struct ref *ref)
 static void prepare_format_display(struct ref *ref_map)
 {
 	struct ref *rm;
+	const char *format = "full";
+
+	git_config_get_string_const("fetch.output", &format);
+	if (!strcasecmp(format, "full"))
+		compact_format = 0;
+	else if (!strcasecmp(format, "compact"))
+		compact_format = 1;
+	else
+		die(_("configuration fetch.output contains invalid value %s"),
+		    format);
 
 	for (rm = ref_map; rm; rm = rm->next) {
 		if (rm->status == REF_STATUS_REJECT_SHALLOW ||
@@ -492,12 +513,66 @@ static void prepare_format_display(struct ref *ref_map)
 	}
 }
 
+static void print_remote_to_local(struct strbuf *display,
+				  const char *remote, const char *local)
+{
+	strbuf_addf(display, "%-*s -> %s", refcol_width, remote, local);
+}
+
+static int find_and_replace(struct strbuf *haystack,
+			    const char *needle,
+			    const char *placeholder)
+{
+	const char *p = strstr(haystack->buf, needle);
+	int plen, nlen;
+
+	if (!p)
+		return 0;
+
+	if (p > haystack->buf && p[-1] != '/')
+		return 0;
+
+	plen = strlen(p);
+	nlen = strlen(needle);
+	if (plen > nlen && p[nlen] != '/')
+		return 0;
+
+	strbuf_splice(haystack, p - haystack->buf, nlen,
+		      placeholder, strlen(placeholder));
+	return 1;
+}
+
+static void print_compact(struct strbuf *display,
+			  const char *remote, const char *local)
+{
+	struct strbuf r = STRBUF_INIT;
+	struct strbuf l = STRBUF_INIT;
+
+	if (!strcmp(remote, local)) {
+		strbuf_addf(display, "%-*s -> *", refcol_width, remote);
+		return;
+	}
+
+	strbuf_addstr(&r, remote);
+	strbuf_addstr(&l, local);
+
+	if (!find_and_replace(&r, local, "*"))
+		find_and_replace(&l, remote, "*");
+	print_remote_to_local(display, r.buf, l.buf);
+
+	strbuf_release(&r);
+	strbuf_release(&l);
+}
+
 static void format_display(struct strbuf *display, char code,
 			   const char *summary, const char *error,
 			   const char *remote, const char *local)
 {
 	strbuf_addf(display, "%c %-*s ", code, TRANSPORT_SUMMARY(summary));
-	strbuf_addf(display, "%-*s -> %s", refcol_width, remote, local);
+	if (!compact_format)
+		print_remote_to_local(display, remote, local);
+	else
+		print_compact(display, remote, local);
 	if (error)
 		strbuf_addf(display, "  (%s)", error);
 }
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index f50497e..6032776 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -693,7 +693,7 @@ test_expect_success 'fetch aligned output' '
 	test_commit looooooooooooong-tag &&
 	(
 		cd full-output &&
-		git fetch origin 2>&1 | \
+		git -c fetch.output=full fetch origin 2>&1 | \
 			grep -e "->" | cut -c 22- >../actual
 	) &&
 	cat >expect <<-\EOF &&
@@ -703,4 +703,19 @@ test_expect_success 'fetch aligned output' '
 	test_cmp expect actual
 '
 
+test_expect_success 'fetch compact output' '
+	git clone . compact &&
+	test_commit extraaa &&
+	(
+		cd compact &&
+		git -c fetch.output=compact fetch origin 2>&1 | \
+			grep -e "->" | cut -c 22- >../actual
+	) &&
+	cat >expect <<-\EOF &&
+	master     -> origin/*
+	extraaa    -> *
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.8.2.531.gd073806

