Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA9121F744
	for <e@80x24.org>; Sun, 26 Jun 2016 05:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbcFZF6e (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 01:58:34 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33079 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbcFZF6a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 01:58:30 -0400
Received: by mail-lf0-f66.google.com with SMTP id l188so25751481lfe.0
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 22:58:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oaIk//ShAfFi5NL7vSzgMi/2q83LU9LPD9HEg/L/lj4=;
        b=ZtpoW2sy47Tm1ChKhJa2AEfvPwdOlRVei7pQmMT5rbolWBXaD394AIac+WVlWgqWjm
         vAVI1CTgHVXIjM6RrLHDcOqeYEci4I7cs9NZw6PSlJAyAtRwOfWr8vxdWalRRuEXnuMs
         m35Qmj2UXUUqsP6rWR/degugAnnsNgAuTHQnkSenqqDP7YVBxwvIoDM+bOLdfXG444ls
         KNKmhf1aFbpbbM2q84GTdKNRxxXdhP8PQ+1TK3waSmg6oiwR2lX40hjZKQ6QPE3neWDs
         +daCHa6Js6wewMIJpmw1+fKwxcDo13W324YbkT/c7cURcHqA6MtIVLfy1+du8wNXRtcG
         50cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oaIk//ShAfFi5NL7vSzgMi/2q83LU9LPD9HEg/L/lj4=;
        b=KuxJulFXI+HjFwi5308905WvoE6xge1haMAbEPRDpeydF/yDjgxD2HBqNPthrnHohY
         2iIUq+N3H2YzJkHL6N/qaSapLNkJ/fcXp8dqBKTKapEGye3Q3QHwpQa3PIzxw2FXhrxQ
         8EjmCXcCCtrwa7MAEbUYGSo/Vi6sezk2iyoKuf26yDjTGGEhK3Q326s1KS7hA6tYpNNP
         6eeGUapdjh23WaZGZFRVEr/M+sRE0RacDrhjghPMH+o5fDDV5pIu4H7EMfX583DaHDlM
         1UtDea44RkynWOy/fmYR4PKMEw6aEwqW60F/PVZ8MCijpre3PSJiYO9UtO2nQ8z/IxQa
         JQ2Q==
X-Gm-Message-State: ALyK8tKAq8cQZYbrPyX5C5NtUjyOopuVxwDxgYdCcTD3WSD6am1BP7fo8ew5DSAqyD0jUw==
X-Received: by 10.25.206.148 with SMTP id e142mr3703994lfg.182.1466920707809;
        Sat, 25 Jun 2016 22:58:27 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g24sm2123775ljg.20.2016.06.25.22.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Jun 2016 22:58:27 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	marcnarc@xiplink.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 5/5] fetch: reduce duplicate in ref update status lines with placeholder
Date:	Sun, 26 Jun 2016 07:58:10 +0200
Message-Id: <20160626055810.26960-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160626055810.26960-1-pclouds@gmail.com>
References: <20160605031141.23513-1-pclouds@gmail.com>
 <20160626055810.26960-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In the "remote -> local" line, if either ref is a substring of the
other, the common part in the other string is replaced with "$". For
example

    abc                -> origin/abc
    refs/pull/123/head -> pull/123

become

    abc         -> origin/$
    refs/$/head -> pull/123

Activated with fetch.output=compact.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt    |  5 +++
 Documentation/git-fetch.txt |  5 +++
 builtin/fetch.c             | 75 ++++++++++++++++++++++++++++++++++++++++++++-
 t/t5510-fetch.sh            | 17 +++++++++-
 4 files changed, 100 insertions(+), 2 deletions(-)

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
index 771dde5..61e8885 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -116,6 +116,11 @@ representing the status of a single ref. Each line is of the form:
 The status of up-to-date refs is shown only if the --verbose option is
 used.
 
+In compact output mode, if either entire `<from>` or `<to>` is found
+in the other string, it will be substituted with `$` in the other
+string. or example, `master -> origin/master` becomes
+`master -> origin/$`.
+
 flag::
 	A single character indicating the status of the ref:
 (space);; for a successfully fetched fast-forward;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c42795b..9d9f4e8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -451,6 +451,7 @@ fail:
 }
 
 static int refcol_width = 10;
+static int compact_format;
 
 static void adjust_refcol_width(const struct ref *ref)
 {
@@ -462,6 +463,17 @@ static void adjust_refcol_width(const struct ref *ref)
 
 	max    = term_columns();
 	rlen   = utf8_strwidth(prettify_refname(ref->name));
+
+	if (compact_format) {
+		/*
+		 * Not precise calculation because '$' can appear in
+		 * ref->name and reduce actual length.
+		 */
+		if (refcol_width < rlen)
+			refcol_width = rlen;
+		return;
+	}
+
 	llen   = utf8_strwidth(prettify_refname(ref->peer_ref->name));
 
 	/*
@@ -480,6 +492,16 @@ static void adjust_refcol_width(const struct ref *ref)
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
@@ -491,12 +513,63 @@ static void prepare_format_display(struct ref *ref_map)
 	}
 }
 
+static void print_remote_to_local(struct strbuf *display,
+				  const char *remote, const char *local)
+{
+	strbuf_addf(display, "%-*s -> %s", refcol_width, remote, local);
+}
+
+static int dollarize(struct strbuf *haystack, const char *needle)
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
+	strbuf_splice(haystack, p - haystack->buf, nlen, "$", 1);
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
+		strbuf_addf(display, "%-*s -> $", refcol_width, remote);
+		return;
+	}
+
+	strbuf_addstr(&r, remote);
+	strbuf_addstr(&l, local);
+
+	if (!dollarize(&r, local))
+		dollarize(&l, remote);
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
index f50497e..3a92718 100755
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
+	master     -> origin/$
+	extraaa    -> $
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.8.2.526.g02eed6d

