From: Mostyn Bramley-Moore <mostynb@opera.com>
Subject: [PATCH/RFC 2/2] describe: add --pcre-match option
Date: Sun, 27 Dec 2015 23:59:52 +0100
Message-ID: <1451257192-5755-3-git-send-email-mostynb@opera.com>
References: <1451257192-5755-1-git-send-email-mostynb@opera.com>
Cc: Mostyn Bramley-Moore <mostynb@opera.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 00:00:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDKIe-00017m-N8
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 00:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678AbbL0XAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2015 18:00:24 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37075 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573AbbL0XAU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2015 18:00:20 -0500
Received: by mail-wm0-f42.google.com with SMTP id p187so249912558wmp.0
        for <git@vger.kernel.org>; Sun, 27 Dec 2015 15:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opera-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+ynbC3rzSokcyp0Ht89cRKAMh6M6C8isbdZniI4mV4A=;
        b=d4ThEJoyJmz8z27WLDk0EfAwj6FWOb4sl3POnpt80dCQeed5S9dKvdvMa4Zu1p6pTO
         MdMBo66Xq2X/37SO9kBPmWXyOjDRLaMWYr9pxSxT34zIYh9jC/FeGjm1zdFZmNnWFnnC
         DE3JZdwJMgN2MmuyAEfDGPlJKFua47pLWKd8mfgG8Kr6CaGTQp/yWMqK7/27k7oXeUWY
         heAmkPnJCcbuTgiZjWPwDRMy4A18hGLENJXFnj9iTKpDZlTIjWRWrB2WZp/gu7kKesPX
         mqRhUty1ssCu7lLL4wO5TO59+WAls40RW9uKYbzJfdN36NQztLlZbOxo6xjdYedSF0wK
         kvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+ynbC3rzSokcyp0Ht89cRKAMh6M6C8isbdZniI4mV4A=;
        b=DCRCe/KCZU+bSJsHYJt3qvwnKar+Ju6yRocGAhXFqKfTKqKssL1grA979WHpn3i2Uk
         GsbNtvJ431e6STR0QRmIoO9Mu/UctY96zxImgUfzFMGrVP/PsaWA1Zo2EqmIl9ntCqhV
         zkvnpKu1v49wfqRPL1Fb0hC8R1E27XmlkwUKGGQxmqnKQN2iPyrVq2ywbPsexeK4ePUJ
         Fc6KCK++WwnmlNceCIw2K2of6op6gpC54GS2PEqGhxDjcF6/q0ERB1HaaTwqDxBp2QTJ
         RIV4kHDelF5N0UVkca/BIseWaCAkGuOdDxoIuYQv1NNl/LzdNBfxx8KcU7t1CGwBvdBa
         evIQ==
X-Gm-Message-State: ALoCoQnIWwMg5EjqcP9N94+IFse52O5DRXDCr3pBZ/dBX74lXXzkPS/UuW+FhM1kFQbTimtiHbLLNHZyn6sAZkRAYmE5X9yxGA==
X-Received: by 10.28.4.139 with SMTP id 133mr27692367wme.21.1451257218897;
        Sun, 27 Dec 2015 15:00:18 -0800 (PST)
Received: from teardrop.skrumpis (h151n12-g-kt-d2.ias.bredband.telia.com. [213.64.207.151])
        by smtp.gmail.com with ESMTPSA id w17sm12929872wmw.15.2015.12.27.15.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 27 Dec 2015 15:00:17 -0800 (PST)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1451257192-5755-1-git-send-email-mostynb@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283021>

Add a perl-compatible regular expression version of the --match option,
which allows more flexible pattern matching.

Signed-off-by: Mostyn Bramley-Moore <mostynb@opera.com>
---
 Documentation/git-describe.txt |  5 +++
 builtin/describe.c             | 69 ++++++++++++++++++++++++++++++++++++++++++
 t/README                       |  3 +-
 t/t6120-describe.sh            | 29 +++++++++++++++---
 4 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index c8f28c8..f646560 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -85,6 +85,11 @@ OPTIONS
 	excluding the "refs/tags/" prefix.  This can be used to avoid
 	leaking private tags from the repository.
 
+--pcre-match <pattern>::
+	Only consider tags matching the given `PCRE` pattern,
+	excluding the "refs/tags/" prefix.  This can be used to avoid
+	leaking private tags from the repository.
+
 --always::
 	Show uniquely abbreviated commit object as fallback.
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 2386c64..7ceecd7 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -10,6 +10,10 @@
 #include "hashmap.h"
 #include "argv-array.h"
 
+#ifdef USE_LIBPCRE
+#include <pcre.h>
+#endif
+
 #define SEEN		(1u << 0)
 #define MAX_TAGS	(FLAG_BITS - 1)
 
@@ -32,6 +36,12 @@ static const char *pattern;
 static int always;
 static const char *dirty;
 
+#ifdef USE_LIBPCRE
+static pcre *regex = NULL;
+static pcre_extra *extra = NULL;
+static const char *pcre_pattern = NULL;
+#endif
+
 /* diff-index command arguments to check if working tree is dirty. */
 static const char *diff_index_args[] = {
 	"diff-index", "--quiet", "HEAD", "--", NULL
@@ -119,6 +129,47 @@ static void add_to_known_names(const char *path,
 	}
 }
 
+#ifdef USE_LIBPCRE
+static void pcre_init()
+{
+	const char *error = NULL;
+	int erroffset = -1;
+	int opts = PCRE_MULTILINE;
+
+	regex = pcre_compile(pcre_pattern, opts, &error, &erroffset, NULL);
+	if (!regex)
+		die("invalid PCRE at position %d of \'%s\': %s",
+			erroffset, pcre_pattern, error);
+
+	extra = pcre_study(regex, 0, &error);
+	if (!extra && error)
+		die("%s", error);
+}
+
+static void pcre_cleanup()
+{
+	pcre_free(regex);
+	regex = NULL;
+	pcre_free(extra);
+	extra = NULL;
+}
+
+/* return 1 on match, 0 on no match. */
+static int pcre_match(const char *pattern, const char *text)
+{
+	int ovector[30], flags = 0; // FIXME: ovector size ... ?
+	int ret = pcre_exec(regex, extra,
+	                    text, strlen(text), 0,
+	                    flags, ovector, ARRAY_SIZE(ovector));
+	if (ret < 0 && ret != PCRE_ERROR_NOMATCH)
+		die("pcre_exec failed with error code %d", ret);
+	if (ret > 0)
+		return 0; /* no match */
+
+	return 1; /* match */
+}
+#endif
+
 static int get_name(const char *path, const struct object_id *oid, int flag, void *cb_data)
 {
 	int is_tag = starts_with(path, "refs/tags/");
@@ -132,6 +183,10 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
 	/* Accept only tags that match the pattern, if given */
 	if (pattern && (!is_tag || wildmatch(pattern, path + 10, 0, NULL)))
 		return 0;
+#ifdef USE_LIBPCRE
+	if (pcre_pattern && (!is_tag || pcre_match(pcre_pattern, path + 10)))
+		return 0;
+#endif
 
 	/* Is it annotated? */
 	if (!peel_ref(path, peeled.hash)) {
@@ -406,6 +461,10 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			    N_("consider <n> most recent tags (default: 10)")),
 		OPT_STRING(0, "match",       &pattern, N_("glob"),
 			   N_("only consider tags matching <glob>")),
+#ifdef USE_LIBPCRE
+		OPT_STRING(0, "pcre-match",  &pcre_pattern, N_("regex"),
+			   N_("only consider tags matching PCRE <regex>")),
+#endif
 		OPT_BOOL(0, "always",        &always,
 			N_("show abbreviated commit object as fallback")),
 		{OPTION_STRING, 0, "dirty",  &dirty, N_("mark"),
@@ -429,6 +488,11 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	if (longformat && abbrev == 0)
 		die(_("--long is incompatible with --abbrev=0"));
 
+#ifdef USE_LIBPCRE
+	if (pcre_pattern)
+		pcre_init();
+#endif
+
 	if (contains) {
 		struct argv_array args;
 
@@ -455,6 +519,11 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	if (!names.size && !always)
 		die(_("No names found, cannot describe anything."));
 
+#ifdef USE_LIBPCRE
+	if (pcre_pattern)
+		pcre_cleanup();
+#endif
+
 	if (argc == 0) {
 		if (dirty) {
 			static struct lock_file index_lock;
diff --git a/t/README b/t/README
index 1dc908e..1495f59 100644
--- a/t/README
+++ b/t/README
@@ -798,7 +798,8 @@ use these, and "test_set_prereq" for how to define your own.
  - LIBPCRE
 
    Git was compiled with USE_LIBPCRE=YesPlease. Wrap any tests
-   that use git-grep --perl-regexp or git-grep -P in these.
+   that use git-grep --perl-regexp, git-grep -P or
+   git describe --pcre-matches in these.
 
  - CASE_INSENSITIVE_FS
 
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 85f2694..8290dea 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -12,13 +12,14 @@ test_description='test describe
 '
 . ./test-lib.sh
 
-check_describe () {
-	expect="$1"
-	shift
+_check_describe () {
+	pcre="$1"
+	expect="$2"
+	shift 2
 	R=$(git describe "$@" 2>err.actual)
 	S=$?
 	cat err.actual >&3
-	test_expect_success "describe $*" '
+	test_expect_success $pcre "describe $*" '
 	test $S = 0 &&
 	case "$R" in
 	$expect)	echo happy ;;
@@ -28,6 +29,14 @@ check_describe () {
 	'
 }
 
+check_describe() {
+	_check_describe "" $*
+}
+
+check_describe_pcre() {
+	_check_describe LIBPCRE $*
+}
+
 test_expect_success setup '
 
 	test_tick &&
@@ -175,12 +184,24 @@ test_expect_success 'set-up matching pattern tests' '
 '
 
 check_describe "test-annotated-*" --match="test-*"
+check_describe_pcre "test-annotated-*" --pcre-match="^test-"
+check_describe_pcre "test-annotated-*" --match="test-*" --pcre-match="^test-"
 
 check_describe "test1-lightweight-*" --tags --match="test1-*"
+check_describe_pcre "test1-lightweight-*" --tags --pcre-match="^test1-"
+check_describe_pcre "test1-lightweight-*" --tags --match="test1-*" \
+	--pcre-match="^test1-"
 
 check_describe "test2-lightweight-*" --tags --match="test2-*"
+check_describe_pcre "test2-lightweight-*" --tags --pcre-match="^test2-"
+check_describe_pcre "test2-lightweight-*" --tags --match="test2-*" \
+	--pcre-match="^test2-"
 
 check_describe "test2-lightweight-*" --long --tags --match="test2-*" HEAD^
+check_describe_pcre "test2-lightweight-*" --long --tags \
+	--pcre-match="^test2-" HEAD^
+check_describe_pcre "test2-lightweight-*" --long --tags --match="test2-*" \
+	--pcre-match="^test2-" HEAD^
 
 test_expect_success 'name-rev with exact tags' '
 	echo A >expect &&
-- 
2.5.0
