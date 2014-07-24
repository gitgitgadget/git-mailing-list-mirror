From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v12 2/2] test-config: add tests for the config_set API
Date: Thu, 24 Jul 2014 20:39:45 +0530
Message-ID: <53D121B9.2020103@gmail.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com> <xmqqiomnda1y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 17:10:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAKea-0008Ru-SJ
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 17:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759341AbaGXPJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 11:09:53 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:55389 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759075AbaGXPJw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 11:09:52 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so4092927pad.36
        for <git@vger.kernel.org>; Thu, 24 Jul 2014 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Ky6PGoxRlTsj6myt2oGvvZ46Dz/9uxXlwX+P8u/LNQs=;
        b=rkGpbeKh5RWOd5V1E7/hvYYdJAlqhh2dES98PdEiaDt0VeSxwKPG4P85VDPA1IFcNr
         lqkDoOj3tLLxcUda0obCKa0fzlPS6rRxhte4kgWmt+JZ+gMz5/oirSmojeDg8KkEWmts
         PFUN6pstLPwTB8ww0eqkxqP60GAIP7MhrHf2ZqpcYSwtoPMc/JkxRhU0qYM8BptQwf5D
         DKdHwrxn96uwu17tSe/OndtQJ9n86NlMmRrBK6n/iVMElLicWeOnsQ2y9jLyLGbnijlP
         heL2JwSWP+zTw9/bqwze26vtZsieSDRxb8o6QmQO1+Q4zAMsg2+wgxjKyMQGcevuXvNj
         Meng==
X-Received: by 10.66.234.202 with SMTP id ug10mr11069927pac.109.1406214591743;
        Thu, 24 Jul 2014 08:09:51 -0700 (PDT)
Received: from [127.0.0.1] ([117.96.50.136])
        by mx.google.com with ESMTPSA id fm5sm1522210pbd.23.2014.07.24.08.09.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 08:09:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqiomnda1y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254162>

Expose the `config_set` C API as a set of simple commands in order to
facilitate testing. Add tests for the `config_set` API as well as for
`git_config_get_*()` family for the usual config files.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 .gitignore            |   1 +
 Makefile              |   1 +
 t/t1308-config-set.sh | 200 ++++++++++++++++++++++++++++++++++++++++++++++++++
 test-config.c         | 142 +++++++++++++++++++++++++++++++++++
 4 files changed, 344 insertions(+)
 create mode 100755 t/t1308-config-set.sh
 create mode 100644 test-config.c

diff --git a/.gitignore b/.gitignore
index 81e12c0..5bfb234 100644
--- a/.gitignore
+++ b/.gitignore
@@ -178,6 +178,7 @@
 /gitweb/static/gitweb.min.*
 /test-chmtime
 /test-ctype
+/test-config
 /test-date
 /test-delta
 /test-dump-cache-tree
diff --git a/Makefile b/Makefile
index 2320de5..b7462e3 100644
--- a/Makefile
+++ b/Makefile
@@ -551,6 +551,7 @@ PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))

 TEST_PROGRAMS_NEED_X += test-chmtime
 TEST_PROGRAMS_NEED_X += test-ctype
+TEST_PROGRAMS_NEED_X += test-config
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
new file mode 100755
index 0000000..7fdf840
--- /dev/null
+++ b/t/t1308-config-set.sh
@@ -0,0 +1,200 @@
+#!/bin/sh
+
+test_description='Test git config-set API in different settings'
+
+. ./test-lib.sh
+
+# 'check_config get_* section.key value' verifies that the entry for
+# section.key is 'value'
+check_config () {
+	if test "$1" = expect_code
+	then
+		expect_code="$2" && shift && shift
+	else
+		expect_code=0
+	fi &&
+	op=$1 key=$2 && shift && shift &&
+	if test $# != 0
+	then
+		printf "%s\n" "$@"
+	fi >expect &&
+	test_expect_code $expect_code test-config "$op" "$key" >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'setup default config' '
+	cat >.git/config <<\EOF
+	[case]
+		penguin = very blue
+		Movie = BadPhysics
+		UPPERCASE = true
+		MixedCase = true
+		my =
+		foo
+		baz = sam
+	[Cores]
+		WhatEver = Second
+		baz = bar
+	[cores]
+		baz = bat
+	[CORES]
+		baz = ball
+	[my "Foo bAr"]
+		hi = mixed-case
+	[my "FOO BAR"]
+		hi = upper-case
+	[my "foo bar"]
+		hi = lower-case
+	[case]
+		baz = bat
+		baz = hask
+	[lamb]
+		chop = 65
+		head = none
+	[goat]
+		legs = 4
+		head = true
+		skin = false
+		nose = 1
+		horns
+	EOF
+'
+
+test_expect_success 'get value for a simple key' '
+	check_config get_value case.penguin "very blue"
+'
+
+test_expect_success 'get value for a key with value as an empty string' '
+	check_config get_value case.my ""
+'
+
+test_expect_success 'get value for a key with value as NULL' '
+	check_config get_value case.foo "(NULL)"
+'
+
+test_expect_success 'upper case key' '
+	check_config get_value case.UPPERCASE "true" &&
+	check_config get_value case.uppercase "true"
+'
+
+test_expect_success 'mixed case key' '
+	check_config get_value case.MixedCase "true" &&
+	check_config get_value case.MIXEDCASE "true" &&
+	check_config get_value case.mixedcase "true"
+'
+
+test_expect_success 'key and value with mixed case' '
+	check_config get_value case.Movie "BadPhysics"
+'
+
+test_expect_success 'key with case sensitive subsection' '
+	check_config get_value "my.Foo bAr.hi" "mixed-case" &&
+	check_config get_value "my.FOO BAR.hi" "upper-case" &&
+	check_config get_value "my.foo bar.hi" "lower-case"
+'
+
+test_expect_success 'key with case insensitive section header' '
+	check_config get_value cores.baz "ball" &&
+	check_config get_value Cores.baz "ball" &&
+	check_config get_value CORES.baz "ball" &&
+	check_config get_value coreS.baz "ball"
+'
+
+test_expect_success 'key with case insensitive section header & variable' '
+	check_config get_value CORES.BAZ "ball" &&
+	check_config get_value cores.baz "ball" &&
+	check_config get_value cores.BaZ "ball" &&
+	check_config get_value cOreS.bAz "ball"
+'
+
+test_expect_success 'find value with misspelled key' '
+	check_config expect_code 1 get_value "my.fOo Bar.hi" "Value not found for \"my.fOo Bar.hi\""
+'
+
+test_expect_success 'find value with the highest priority' '
+	check_config get_value case.baz "hask"
+'
+
+test_expect_success 'find integer value for a key' '
+	check_config get_int lamb.chop 65
+'
+
+test_expect_success 'find integer if value is non parse-able' '
+	check_config expect_code 128 get_int lamb.head
+'
+
+test_expect_success 'find bool value for the entered key' '
+	check_config get_bool goat.head 1 &&
+	check_config get_bool goat.skin 0 &&
+	check_config get_bool goat.nose 1 &&
+	check_config get_bool goat.horns 1 &&
+	check_config get_bool goat.legs 1
+'
+
+test_expect_success 'find multiple values' '
+	check_config get_value_multi case.baz sam bat hask
+'
+
+test_expect_success 'find value from a configset' '
+	cat >config2 <<-\EOF &&
+	[case]
+		baz = lama
+	[my]
+		new = silk
+	[case]
+		baz = ball
+	EOF
+	echo silk >expect &&
+	test-config configset_get_value my.new config2 .git/config >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'find value with highest priority from a configset' '
+	echo hask >expect &&
+	test-config configset_get_value case.baz config2 .git/config >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'find value_list for a key from a configset' '
+	cat >except <<-\EOF &&
+	sam
+	bat
+	hask
+	lama
+	ball
+	EOF
+	test-config configset_get_value case.baz config2 .git/config >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'proper error on non-existent files' '
+	echo "Error (-1) reading configuration file non-existent-file." >expect &&
+	test_expect_code 2 test-config configset_get_value foo.bar non-existent-file 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success POSIXPERM,SANITY 'proper error on non-accessible files' '
+	chmod -r .git/config &&
+	test_when_finished "chmod +r .git/config" &&
+	echo "Error (-1) reading configuration file .git/config." >expect &&
+	test_expect_code 2 test-config configset_get_value foo.bar .git/config 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'proper error on error in default config files' '
+	cp .git/config .git/config.old &&
+	test_when_finished "mv .git/config.old .git/config" &&
+	echo "[" >>.git/config &&
+	echo "fatal: bad config file line 35 in .git/config" >expect &&
+	test_expect_code 128 test-config get_value foo.bar 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'proper error on error in custom config files' '
+	echo "[" >>syntax-error &&
+	echo "fatal: bad config file line 1 in syntax-error" >expect &&
+	test_expect_code 128 test-config configset_get_value foo.bar syntax-error 2>actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/test-config.c b/test-config.c
new file mode 100644
index 0000000..9dd1b22
--- /dev/null
+++ b/test-config.c
@@ -0,0 +1,142 @@
+#include "cache.h"
+#include "string-list.h"
+
+/*
+ * This program exposes the C API of the configuration mechanism
+ * as a set of simple commands in order to facilitate testing.
+ *
+ * Reads stdin and prints result of command to stdout:
+ *
+ * get_value -> prints the value with highest priority for the entered key
+ *
+ * get_value_multi -> prints all values for the entered key in increasing order
+ *		     of priority
+ *
+ * get_int -> print integer value for the entered key or die
+ *
+ * get_bool -> print bool value for the entered key or die
+ *
+ * configset_get_value -> returns value with the highest priority for the entered key
+ * 			from a config_set constructed from files entered as arguments.
+ *
+ * configset_get_value_multi -> returns value_list for the entered key sorted in
+ * 				ascending order of priority from a config_set
+ * 				constructed from files entered as arguments.
+ *
+ * Examples:
+ *
+ * To print the value with highest priority for key "foo.bAr Baz.rock":
+ * 	test-config get_value "foo.bAr Baz.rock"
+ *
+ */
+
+
+int main(int argc, char **argv)
+{
+	int i, val;
+	const char *v;
+	const struct string_list *strptr;
+	struct config_set cs;
+	git_configset_init(&cs);
+
+	if (argc < 2) {
+		fprintf(stderr, "Please, provide a command name on the command-line\n");
+		goto exit1;
+	} else if (argc == 3 && !strcmp(argv[1], "get_value")) {
+		if (!git_config_get_value(argv[2], &v)) {
+			if (!v)
+				printf("(NULL)\n");
+			else
+				printf("%s\n", v);
+			goto exit0;
+		} else {
+			printf("Value not found for \"%s\"\n", argv[2]);
+			goto exit1;
+		}
+	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
+		strptr = git_config_get_value_multi(argv[2]);
+		if (strptr) {
+			for (i = 0; i < strptr->nr; i++) {
+				v = strptr->items[i].string;
+				if (!v)
+					printf("(NULL)\n");
+				else
+					printf("%s\n", v);
+			}
+			goto exit0;
+		} else {
+			printf("Value not found for \"%s\"\n", argv[2]);
+			goto exit1;
+		}
+	} else if (argc == 3 && !strcmp(argv[1], "get_int")) {
+		if (!git_config_get_int(argv[2], &val)) {
+			printf("%d\n", val);
+			goto exit0;
+		} else {
+			printf("Value not found for \"%s\"\n", argv[2]);
+			goto exit1;
+		}
+	} else if (argc == 3 && !strcmp(argv[1], "get_bool")) {
+		if (!git_config_get_bool(argv[2], &val)) {
+			printf("%d\n", val);
+			goto exit0;
+		} else {
+			printf("Value not found for \"%s\"\n", argv[2]);
+			goto exit1;
+		}
+	} else if (!strcmp(argv[1], "configset_get_value")) {
+		for (i = 3; i < argc; i++) {
+			int err;
+			if ((err = git_configset_add_file(&cs, argv[i]))) {
+				fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
+				goto exit2;
+			}
+		}
+		if (!git_configset_get_value(&cs, argv[2], &v)) {
+			if (!v)
+				printf("(NULL)\n");
+			else
+				printf("%s\n", v);
+			goto exit0;
+		} else {
+			printf("Value not found for \"%s\"\n", argv[2]);
+			goto exit1;
+		}
+	} else if (!strcmp(argv[1], "configset_get_value_multi")) {
+		for (i = 3; i < argc; i++) {
+			int err;
+			if ((err = git_configset_add_file(&cs, argv[i]))) {
+				fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
+				goto exit2;
+			}
+		}
+		strptr = git_configset_get_value_multi(&cs, argv[2]);
+		if (strptr) {
+			for (i = 0; i < strptr->nr; i++) {
+				v = strptr->items[i].string;
+				if (!v)
+					printf("(NULL)\n");
+				else
+					printf("%s\n", v);
+			}
+			goto exit0;
+		} else {
+			printf("Value not found for \"%s\"\n", argv[2]);
+			goto exit1;
+		}
+	}
+
+	die("%s: Please check the syntax and the function name", argv[0]);
+
+exit0:
+	git_configset_clear(&cs);
+	return 0;
+
+exit1:
+	git_configset_clear(&cs);
+	return 1;
+
+exit2:
+	git_configset_clear(&cs);
+	return 2;
+}
-- 
1.9.0.GIT
