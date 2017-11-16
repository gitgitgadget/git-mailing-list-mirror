Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E6FE201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 00:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932387AbdKPAGf (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 19:06:35 -0500
Received: from cp-27.webhostbox.net ([208.91.198.76]:56954 "EHLO
        cp-27.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933145AbdKPAGc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 19:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=unimetic.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vQ/GJzIA6of98kKSAgWgpjKLxV4+yfKHjb9XHEDWf7E=; b=Kj6ZgQO5uzwUMG//Dmb15JFDm
        VG+Td0qnFEzc/WYlKSRlmPQnxSyNi0X17sLlYG/aJR0uzapizPOvVhFaIC27Ni7co2AI2kJ1nbTEP
        j5lT2Az0yEuVM7VYJRkqYnQQMCQPs6bwbgHJiGjKfASLzuqUN6BvMzVUv94u0IZer4sRfPxst6hu3
        pjAOJ4HMkr+IYuwPaaOXDIT+1soT8MtsSO/S3mQe4NaOaZAJukVfzRma5sFw4V6nJDVVNtp7K9vX5
        S4YDTjWCHrYIdVr2o0kGggw+jAf2IVvllGmfq4n+3mMO/LuZHBqhaKeo2UrPN+mwybNimkj1+FKfD
        3CGp9+elQ==;
Received: from [94.0.241.119] (port=49702 helo=localhost)
        by cp-27.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <hsed@unimetic.com>)
        id 1eF7hO-0036dd-8m; Thu, 16 Nov 2017 00:06:31 +0000
From:   hsed@unimetic.com
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, hsed@unimetic.com
Subject: [PATCH V3] config: add --expiry-date
Date:   Thu, 16 Nov 2017 00:05:47 +0000
Message-Id: <20171116000547.3246-1-hsed@unimetic.com>
X-Mailer: git-send-email 2.15.0.165.g6fd7fc36d
In-Reply-To: <xmqqshdh2wln.fsf@gitster.mtv.corp.google.com>
References: <xmqqshdh2wln.fsf@gitster.mtv.corp.google.com>
X-Authenticated_sender: hsed@unimetic.com
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp-27.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - unimetic.com
X-Get-Message-Sender-Via: cp-27.webhostbox.net: authenticated_id: hsed@unimetic.com
X-Authenticated-Sender: cp-27.webhostbox.net: hsed@unimetic.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Haaris Mehmood <hsed@unimetic.com>

Add --expiry-date as a data-type for config files when
'git config --get' is used. This will return any relative
or fixed dates from config files  as a timestamp value.

This is useful for scripts (e.g. gc.reflogexpire) that work
with timestamps so that '2.weeks' can be converted to a format
acceptable by those scripts/functions.

Following the convention of git_config_pathname(), move
the helper function required for this feature from
builtin/reflog.c to builtin/config.c where other similar
functions exist (e.g. for --bool or --path), and match
the order of parameters with other functions (i.e. output
pointer as first parameter).

Signed-off-by: Haaris Mehmood <hsed@unimetic.com>

---
 Documentation/git-config.txt |  5 +++++
 builtin/config.c             | 10 +++++++++-
 builtin/reflog.c             | 14 ++------------
 config.c                     |  9 +++++++++
 config.h                     |  1 +
 t/helper/test-date.c         | 12 ++++++++++++
 t/t1300-repo-config.sh       | 30 ++++++++++++++++++++++++++++++
 7 files changed, 68 insertions(+), 13 deletions(-)

update v3: fix style issue

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 4edd09fc6..14da5fc15 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -180,6 +180,11 @@ See also <<FILES>>.
 	value (but you can use `git config section.variable ~/`
 	from the command line to let your shell do the expansion).
 
+--expiry-date::
+	`git config` will ensure that the output is converted from
+	a fixed or relative date-string to a timestamp. This option
+	has no effect when setting the value.
+
 -z::
 --null::
 	For all options that output values and/or keys, always
diff --git a/builtin/config.c b/builtin/config.c
index d13daeeb5..ab5f95476 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -52,6 +52,7 @@ static int show_origin;
 #define TYPE_INT (1<<1)
 #define TYPE_BOOL_OR_INT (1<<2)
 #define TYPE_PATH (1<<3)
+#define TYPE_EXPIRY_DATE (1<<4)
 
 static struct option builtin_config_options[] = {
 	OPT_GROUP(N_("Config file location")),
@@ -80,6 +81,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "int", &types, N_("value is decimal number"), TYPE_INT),
 	OPT_BIT(0, "bool-or-int", &types, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
 	OPT_BIT(0, "path", &types, N_("value is a path (file or directory name)"), TYPE_PATH),
+	OPT_BIT(0, "expiry-date", &types, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
 	OPT_GROUP(N_("Other")),
 	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
@@ -159,6 +161,11 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 				return -1;
 			strbuf_addstr(buf, v);
 			free((char *)v);
+		} else if (types == TYPE_EXPIRY_DATE) {
+			timestamp_t t;
+			if (git_config_expiry_date(&t, key_, value_) < 0)
+				return -1;
+			strbuf_addf(buf, "%"PRItime, t);
 		} else if (value_) {
 			strbuf_addstr(buf, value_);
 		} else {
@@ -273,12 +280,13 @@ static char *normalize_value(const char *key, const char *value)
 	if (!value)
 		return NULL;
 
-	if (types == 0 || types == TYPE_PATH)
+	if (types == 0 || types == TYPE_PATH || types == TYPE_EXPIRY_DATE)
 		/*
 		 * We don't do normalization for TYPE_PATH here: If
 		 * the path is like ~/foobar/, we prefer to store
 		 * "~/foobar/" in the config file, and to expand the ~
 		 * when retrieving the value.
+		 * Also don't do normalization for expiry dates.
 		 */
 		return xstrdup(value);
 	if (types == TYPE_INT)
diff --git a/builtin/reflog.c b/builtin/reflog.c
index ab31a3b6a..223372531 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -416,16 +416,6 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
 	return ent;
 }
 
-static int parse_expire_cfg_value(const char *var, const char *value, timestamp_t *expire)
-{
-	if (!value)
-		return config_error_nonbool(var);
-	if (parse_expiry_date(value, expire))
-		return error(_("'%s' for '%s' is not a valid timestamp"),
-			     value, var);
-	return 0;
-}
-
 /* expiry timer slot */
 #define EXPIRE_TOTAL   01
 #define EXPIRE_UNREACH 02
@@ -443,11 +433,11 @@ static int reflog_expire_config(const char *var, const char *value, void *cb)
 
 	if (!strcmp(key, "reflogexpire")) {
 		slot = EXPIRE_TOTAL;
-		if (parse_expire_cfg_value(var, value, &expire))
+		if (git_config_expiry_date(&expire, var, value))
 			return -1;
 	} else if (!strcmp(key, "reflogexpireunreachable")) {
 		slot = EXPIRE_UNREACH;
-		if (parse_expire_cfg_value(var, value, &expire))
+		if (git_config_expiry_date(&expire, var, value))
 			return -1;
 	} else
 		return git_default_config(var, value, cb);
diff --git a/config.c b/config.c
index 903abf953..6ded9ce98 100644
--- a/config.c
+++ b/config.c
@@ -990,6 +990,15 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
+int git_config_expiry_date(timestamp_t *timestamp, const char *var, const char *value)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	if (parse_expiry_date(value, timestamp))
+		die(_("failed to parse date_string in: '%s'"), value);
+	return 0;
+}
+
 static int git_default_core_config(const char *var, const char *value)
 {
 	/* This needs a better name */
diff --git a/config.h b/config.h
index a49d26441..fc66c5933 100644
--- a/config.h
+++ b/config.h
@@ -58,6 +58,7 @@ extern int git_config_bool_or_int(const char *, const char *, int *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
+extern int git_config_expiry_date(timestamp_t *, const char *, const char *);
 extern int git_config_set_in_file_gently(const char *, const char *, const char *);
 extern void git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set_gently(const char *, const char *);
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index f414a3ac6..ac8368797 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -5,6 +5,7 @@ static const char *usage_msg = "\n"
 "  test-date show:<format> [time_t]...\n"
 "  test-date parse [date]...\n"
 "  test-date approxidate [date]...\n"
+"  test-date timestamp [date]...\n"
 "  test-date is64bit\n"
 "  test-date time_t-is64bit\n";
 
@@ -71,6 +72,15 @@ static void parse_approxidate(const char **argv, struct timeval *now)
 	}
 }
 
+static void parse_approx_timestamp(const char **argv, struct timeval *now)
+{
+	for (; *argv; argv++) {
+		timestamp_t t;
+		t = approxidate_relative(*argv, now);
+		printf("%s -> %"PRItime"\n", *argv, t);
+	}
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	struct timeval now;
@@ -95,6 +105,8 @@ int cmd_main(int argc, const char **argv)
 		parse_dates(argv+1, &now);
 	else if (!strcmp(*argv, "approxidate"))
 		parse_approxidate(argv+1, &now);
+	else if (!strcmp(*argv, "timestamp"))
+		parse_approx_timestamp(argv+1, &now);
 	else if (!strcmp(*argv, "is64bit"))
 		return sizeof(timestamp_t) == 8 ? 0 : 1;
 	else if (!strcmp(*argv, "time_t-is64bit"))
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 364a53700..cbeb9bebe 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -901,6 +901,36 @@ test_expect_success 'get --path barfs on boolean variable' '
 	test_must_fail git config --get --path path.bool
 '
 
+test_expect_success 'get --expiry-date' '
+	rel="3.weeks.5.days.00:00" &&
+	rel_out="$rel ->" &&
+	cat >.git/config <<-\EOF &&
+	[date]
+	valid1 = "3.weeks.5.days 00:00"
+	valid2 = "Fri Jun 4 15:46:55 2010"
+	valid3 = "2017/11/11 11:11:11PM"
+	valid4 = "2017/11/10 09:08:07 PM"
+	valid5 = "never"
+	invalid1 = "abc"
+	EOF
+	cat >expect <<-EOF &&
+	$(test-date timestamp $rel)
+	1275666415
+	1510441871
+	1510348087
+	0
+	EOF
+	{
+		echo "$rel_out $(git config --expiry-date date.valid1)"
+		git config --expiry-date date.valid2 &&
+		git config --expiry-date date.valid3 &&
+		git config --expiry-date date.valid4 &&
+		git config --expiry-date date.valid5
+	} >actual &&
+	test_cmp expect actual &&
+	test_must_fail git config --expiry-date date.invalid1
+'
+
 cat > expect << EOF
 [quote]
 	leading = " test"
-- 
2.15.0.165.g6fd7fc36d

