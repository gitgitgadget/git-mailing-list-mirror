From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v9 0/3] git config cache & special querying api utilizing the cache
Date: Tue, 15 Jul 2014 07:29:29 -0700
Message-ID: <1405434571-25459-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 15 16:31:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X73lI-00017i-LX
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 16:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbaGOObR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 10:31:17 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36172 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbaGOObP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 10:31:15 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so3489908pab.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 07:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wwIkjSxIgFdss49CdncwcjfjG4VgqlUtUi72C4bur40=;
        b=zFsPupDwCGuupYvdiRHFCVO6uyeGeFq6Cwo6KxtP3Qf7yybBAEekX7y7LPVMSFFGJJ
         quLKMfpIaUam+ZAQ+LxBalB86aLNrg6qpEav5kgBipn7XVH1UnCmIXkUn8DVzbEI7tSQ
         UzMA+NfSAzc0TnG86wXilyUhiUNj/Y6Qnc3SUkBPQCd1VQcEZ2FFOhU27J60pypRJoF7
         iD7oj0sKaHZj9T7HlQIjJUEOfuI3LPQcOzL+/VEDVakHbbLMsiExgggpugyOoVyupiEo
         FOzSzzvL5cgelYjAITL1aznlPIu+dwG9YcGRnXnUa7o6J8N6irlKw0Mu8bk3aE//su85
         xwrg==
X-Received: by 10.68.78.66 with SMTP id z2mr325896pbw.71.1405434674784;
        Tue, 15 Jul 2014 07:31:14 -0700 (PDT)
Received: from localhost.localdomain ([223.226.20.20])
        by mx.google.com with ESMTPSA id z4sm946685pda.84.2014.07.15.07.31.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 07:31:13 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253562>

Hi,

[PATCH v9]: Applied most of the review comments mentioned in [11]. Mostly asthetic changes.
	test-config now clears the config_set before exiting. Most of the tests now use the
	check-config function. check_config_init() now handles return values correctly.
	Diff between v8 and v9 is at the bottom. Thanks to Junio and Matthieu for the review.

[PATCH V8]: Moved the contents of config-set.c to config.c for future convenience. Reverted
	test 'find value with misspelled key' to the one in v5. See [10] for the discussion.

[PATCH V7]: Style nits and a broken && chain corrected in `t/t1308-config-set.sh`. See
	[9] for the nits.

[PATCH V6]: Style nits and mistakes corrected. Diff between v6 and v5[8] is at the bottom.
		Thanks to Matthieu, Ramsay and Ram for their suggestions.

[PATCH V5]: `config_set` now uses a single hashmap. Corrected style nits raised in
			the thread[7]. Thanks to Junio and Matthieu for their suggestions.

[PATCH v4]: Introduced `config_set` construct which points to a ordered set of
	config-files cached as hashmaps. Added relevant API functions. For more
	details see the documentation. Rewrote the git_config_get* family to use
	`config_set` internally. Added tests for both config_set API and git_config_get
	family. Added type specific API functions which parses the found value and
	converts it into a specific type.
	Most of the changes implemented are the result of discussion in [6].
	Thanks to Eric, Ramsay, Junio, Matthieu & Karsten for their suggestions
	and review.

[PATCH v3]: Added flag for NULL values that were causing segfaults in some cases.
	Added test-config for usage examples.
	Minor changes and corrections. Refer to discussion thread[5] for more details.
	Thanks to Matthieu, Jeff and Junio for their valuable suggestions.

[PATCH v2]:Changed the string_list to a struct instead of pointer to a struct.
	Added string-list initilization functions.
	Minor mistakes corrected acoording to review comments[4]. Thanks to
	Eric and Matthieu for their review.

[PATCH V1]:Most of the invaluable suggestions by Eric Sunshine, Torsten Bogershausen and
	Jeff King has been implemented[1]. Complete rewrite of config_cache*() family
	using git_config() as hook as suggested by Jeff. Thanks for the review.

[RFC V2]: Improved according to the suggestions by Eric Sunshine and Torsten Bogershausen.
	Added cache invalidation when config file is changed.[2]
	I am using git_config_set_multivar_in_file() as an update hook.

This is patch is for this year's GSoC. My project is
"Git Config API improvements". The link of my proposal is appended below [3].

The aim of this patch series is to generate a cache for querying values from
the config files in a non-callback manner as the current method reads and
parses the config files every time a value is queried for.

The cache is generated from hooking the update_cache function to the current
parsing and callback mechanism in config.c. It is implemented as an hashmap
using the hashmap-api with variables and its corresponding values list as
its members. The values in the list are sorted in order of increasing priority.
The cache is initialised the first time when any of the new query functions is
called. It is invalidated by using git_config_set_multivar_in_file() as an
update hook.

We add two new functions to the config-api, git_config_get_string() and
git_config_get_string_multi() for querying in a non callback manner from
the cache.

[1] http://marc.info/?t=140172066200006&r=1&w=2
[2] http://git.661346.n2.nabble.com/RFC-PATCH-0-2-Git-config-cache-amp-special-querying-api-utilizing-the-cache-td7611691.html
[3] https://drive.google.com/file/d/0B4suZ-aHqDcnSUZJRXVTTnZUN1E/edit?usp=sharing
[4] http://thread.gmane.org/gmane.comp.version-control.git/251073/focus=251369
[5] http://thread.gmane.org/gmane.comp.version-control.git/251704/
[6] http://thread.gmane.org/gmane.comp.version-control.git/252329/
[7] http://marc.info/?t=140428115200001&r=1&w=2
[8] http://article.gmane.org/gmane.comp.version-control.git/252942/
[9] http://thread.gmane.org/gmane.comp.version-control.git/252959/
[10] http://article.gmane.org/gmane.comp.version-control.git/253113
[11] http://thread.gmane.org/gmane.comp.version-control.git/253248


Tanay Abhra (2):
  config set
  test-config

 .gitignore                             |   1 +
 Documentation/technical/api-config.txt | 135 ++++++++++++++++
 Makefile                               |   1 +
 cache.h                                |  31 ++++
 config.c                               | 276 +++++++++++++++++++++++++++++++++
 t/t1308-config-set.sh                  | 212 +++++++++++++++++++++++++
 test-config.c                          | 140 +++++++++++++++++
 7 files changed, 796 insertions(+)
 create mode 100755 t/t1308-config-set.sh
 create mode 100644 test-config.c

-- 
1.9.0.GIT

-- 8< --
diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index bb43830..48255a2 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -241,7 +241,8 @@ Configset API provides functions for the above mentioned work flow, including:
 `int git_configset_add_file(struct config_set *cs, const char *filename)`::
 
 	Parses the file and adds the variable-value pairs to the `config_set`,
-	dies if there is an error in parsing the file.
+	dies if there is an error in parsing the file. Returns 0 on success, or
+	-1 if the file doesnot exist or cannot be read.
 
 `int git_configset_get_value(struct config_set *cs, const char *key, const char **value)`::
 
diff --git a/config.c b/config.c
index aa58275..89e2d67 100644
--- a/config.c
+++ b/config.c
@@ -35,7 +35,7 @@ struct config_source {
 	long (*do_ftell)(struct config_source *c);
 };
 
-struct config_hash_entry {
+struct config_set_element {
 	struct hashmap_entry ent;
 	char *key;
 	struct string_list value_list;
@@ -1227,48 +1227,10 @@ int git_config(config_fn_t fn, void *data)
 	return git_config_with_options(fn, data, NULL, 1);
 }
 
-static int config_hash_add_value(const char *, const char *, struct hashmap *);
-
-static int config_hash_entry_cmp(const struct config_hash_entry *e1,
-				 const struct config_hash_entry *e2, const void *unused)
-{
-	return strcmp(e1->key, e2->key);
-}
-
-static void configset_init(struct config_set *cs)
-{
-	if (!cs->hash_initialized) {
-		hashmap_init(&cs->config_hash, (hashmap_cmp_fn)config_hash_entry_cmp, 0);
-		cs->hash_initialized = 1;
-	}
-}
-
-static int config_hash_callback(const char *key, const char *value, void *cb)
-{
-	struct config_set *cs = cb;
-	config_hash_add_value(key, value, &cs->config_hash);
-	return 0;
-}
-
-int git_configset_add_file(struct config_set *cs, const char *filename)
-{
-	int ret = 0;
-	configset_init(cs);
-	ret = git_config_from_file(config_hash_callback, filename, cs);
-	if (!ret)
-		return 0;
-	else {
-		hashmap_free(&cs->config_hash, 1);
-		cs->hash_initialized = 0;
-		return -1;
-	}
-}
-
-static struct config_hash_entry *config_hash_find_entry(const char *key,
-							struct hashmap *config_hash)
+static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
 {
-	struct config_hash_entry k;
-	struct config_hash_entry *found_entry;
+	struct config_set_element k;
+	struct config_set_element *found_entry;
 	char *normalized_key;
 	int ret;
 	/*
@@ -1282,21 +1244,21 @@ static struct config_hash_entry *config_hash_find_entry(const char *key,
 
 	hashmap_entry_init(&k, strhash(normalized_key));
 	k.key = normalized_key;
-	found_entry = hashmap_get(config_hash, &k, NULL);
+	found_entry = hashmap_get(&cs->config_hash, &k, NULL);
 	free(normalized_key);
 	return found_entry;
 }
 
-static struct string_list *configset_get_list(const char *key, struct config_set *cs)
+const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
 {
-	struct config_hash_entry *e = config_hash_find_entry(key, &cs->config_hash);
+	struct config_set_element *e = configset_find_element(cs, key);
 	return e ? &e->value_list : NULL;
 }
 
-static int config_hash_add_value(const char *key, const char *value, struct hashmap *config_hash)
+static int configset_add_value(struct config_set *cs, const char *key, const char *value)
 {
-	struct config_hash_entry *e;
-	e = config_hash_find_entry(key, config_hash);
+	struct config_set_element *e;
+	e = configset_find_element(cs, key);
 	/*
 	 * Since the keys are being fed by git_config*() callback mechanism, they
 	 * are already normalized. So simply add them without any further munging.
@@ -1307,43 +1269,28 @@ static int config_hash_add_value(const char *key, const char *value, struct hash
 		e->key = xstrdup(key);
 		memset(&e->value_list, 0, sizeof(e->value_list));
 		e->value_list.strdup_strings = 1;
-		hashmap_add(config_hash, e);
+		hashmap_add(&cs->config_hash, e);
 	}
 	string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
 
 	return 0;
 }
 
-void git_configset_init(struct config_set *cs)
-{
-	cs->hash_initialized = 0;
-}
-
-int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
+static int config_set_element_cmp(const struct config_set_element *e1,
+				 const struct config_set_element *e2, const void *unused)
 {
-	struct string_list *values = NULL;
-	/*
-	 * Follows "last one wins" semantic, i.e., if there are multiple matches for the
-	 * queried key in the files of the configset, the value returned will be the last
-	 * value in the value list for that key.
-	 */
-	values = configset_get_list(key, cs);
-
-	if (!values)
-		return 1;
-	assert(values->nr > 0);
-	*value = values->items[values->nr - 1].string;
-	return 0;
+	return strcmp(e1->key, e2->key);
 }
 
-const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
+void git_configset_init(struct config_set *cs)
 {
-	return configset_get_list(key, cs);
+	hashmap_init(&cs->config_hash, (hashmap_cmp_fn)config_set_element_cmp, 0);
+	cs->hash_initialized = 1;
 }
 
 void git_configset_clear(struct config_set *cs)
 {
-	struct config_hash_entry *entry;
+	struct config_set_element *entry;
 	struct hashmap_iter iter;
 	if (!cs->hash_initialized)
 		return;
@@ -1354,6 +1301,43 @@ void git_configset_clear(struct config_set *cs)
 		string_list_clear(&entry->value_list, 0);
 	}
 	hashmap_free(&cs->config_hash, 1);
+	cs->hash_initialized = 0;
+}
+
+static int config_hash_callback(const char *key, const char *value, void *cb)
+{
+	struct config_set *cs = cb;
+	configset_add_value(cs, key, value);
+	return 0;
+}
+
+int git_configset_add_file(struct config_set *cs, const char *filename)
+{
+	int ret = 0;
+	ret = git_config_from_file(config_hash_callback, filename, cs);
+	if (!ret)
+		return 0;
+	else {
+		git_configset_clear(cs);
+		return -1;
+	}
+}
+
+int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
+{
+	const struct string_list *values = NULL;
+	/*
+	 * Follows "last one wins" semantic, i.e., if there are multiple matches for the
+	 * queried key in the files of the configset, the value returned will be the last
+	 * value in the value list for that key.
+	 */
+	values = git_configset_get_value_multi(cs, key);
+
+	if (!values)
+		return 1;
+	assert(values->nr > 0);
+	*value = values->items[values->nr - 1].string;
+	return 0;
 }
 
 int git_configset_get_string(struct config_set *cs, const char *key, const char **dest)
@@ -1427,20 +1411,24 @@ int git_configset_get_pathname(struct config_set *cs, const char *key, const cha
 		return 1;
 }
 
-static int git_config_check_init(void)
+static void git_config_check_init(void)
 {
 	int ret = 0;
 	if (the_config_set.hash_initialized)
-		return 0;
-	configset_init(&the_config_set);
+		return;
+	git_configset_init(&the_config_set);
 	ret = git_config(config_hash_callback, &the_config_set);
 	if (ret >= 0)
-		return 0;
-	else {
-		hashmap_free(&the_config_set.config_hash, 1);
-		the_config_set.hash_initialized = 0;
-		return -1;
-	}
+		return;
+	else
+		die("Unknown error when parsing one of the configuration files.");
+}
+
+void git_config_clear(void)
+{
+	if (!the_config_set.hash_initialized)
+		return;
+	git_configset_clear(&the_config_set);
 }
 
 int git_config_get_value(const char *key, const char **value)
@@ -1455,14 +1443,6 @@ const struct string_list *git_config_get_value_multi(const char *key)
 	return git_configset_get_value_multi(&the_config_set, key);
 }
 
-void git_config_clear(void)
-{
-	if (!the_config_set.hash_initialized)
-		return;
-	git_configset_clear(&the_config_set);
-	the_config_set.hash_initialized = 0;
-}
-
 int git_config_get_string(const char *key, const char **dest)
 {
 	git_config_check_init();
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 87a29f1..94085eb 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -4,17 +4,33 @@ test_description='Test git config-set API in different settings'
 
 . ./test-lib.sh
 
-# 'check section.key value' verifies that the entry for section.key is
-# 'value'
-check() {
-	echo "$2" >expected &&
-	test-config get_value "$1" >actual 2>&1 &&
-	test_cmp expected actual
+# 'check_config get_* section.key value' verifies that the entry for
+# section.key is 'value'
+check_config () {
+	case "$1" in
+	expect_code)
+		if [ "$#" -lt 5 ];
+		then
+			>expect
+		else
+			printf "%s\n" "$5" >expect
+		fi &&
+		test_expect_code "$2" test-config "$3" "$4" >actual
+		;;
+	*)
+		op=$1 key=$2 &&
+		shift &&
+		shift &&
+		printf "%s\n" "$@" >expect &&
+		test-config "$op" "$key" >actual
+		;;
+	esac &&
+	test_cmp expect actual
 }
 
 test_expect_success 'setup default config' '
-	cat >.git/config << EOF
-	[core]
+	cat >.git/config <<\EOF
+	[case]
 		penguin = very blue
 		Movie = BadPhysics
 		UPPERCASE = true
@@ -35,7 +51,7 @@ test_expect_success 'setup default config' '
 		hi = upper-case
 	[my "foo bar"]
 		hi = lower-case
-	[core]
+	[case]
 		baz = bat
 		baz = hask
 	[lamb]
@@ -51,78 +67,74 @@ test_expect_success 'setup default config' '
 '
 
 test_expect_success 'get value for a simple key' '
-	check core.penguin "very blue"
+	check_config get_value case.penguin "very blue"
 '
 
 test_expect_success 'get value for a key with value as an empty string' '
-	check core.my ""
+	check_config get_value case.my ""
 '
 
 test_expect_success 'get value for a key with value as NULL' '
-	check core.foo "(NULL)"
+	check_config get_value case.foo "(NULL)"
 '
 
 test_expect_success 'upper case key' '
-	check core.UPPERCASE "true"
+	check_config get_value case.UPPERCASE "true" &&
+	check_config get_value case.uppercase "true"
 '
 
 test_expect_success 'mixed case key' '
-	check core.MixedCase "true"
+	check_config get_value case.MixedCase "true" &&
+	check_config get_value case.MIXEDCASE "true" &&
+	check_config get_value case.mixedcase "true"
 '
 
 test_expect_success 'key and value with mixed case' '
-	check core.Movie "BadPhysics"
+	check_config get_value case.Movie "BadPhysics"
 '
 
 test_expect_success 'key with case sensitive subsection' '
-	check "my.Foo bAr.hi" "mixed-case" &&
-	check "my.FOO BAR.hi" "upper-case" &&
-	check "my.foo bar.hi" "lower-case"
+	check_config get_value "my.Foo bAr.hi" "mixed-case" &&
+	check_config get_value "my.FOO BAR.hi" "upper-case" &&
+	check_config get_value "my.foo bar.hi" "lower-case"
 '
 
 test_expect_success 'key with case insensitive section header' '
-	check cores.baz "ball" &&
-	check Cores.baz "ball" &&
-	check CORES.baz "ball" &&
-	check coreS.baz "ball"
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
 '
 
 test_expect_success 'find value with misspelled key' '
-	echo "Value not found for \"my.fOo Bar.hi\"" >expect &&
-	test_must_fail test-config get_value "my.fOo Bar.hi" >actual &&
-	test_cmp expect actual
+	check_config expect_code 1 get_value "my.fOo Bar.hi" "Value not found for \"my.fOo Bar.hi\""
 '
 
 test_expect_success 'find value with the highest priority' '
-	check core.baz "hask"
+	check_config get_value case.baz "hask"
 '
 
 test_expect_success 'find integer value for a key' '
-	echo 65 >expect &&
-	test-config get_int lamb.chop >actual &&
-	test_cmp expect actual
+	check_config get_int lamb.chop 65
 '
 
 test_expect_success 'find integer if value is non parse-able' '
-	echo 65 >expect &&
-	test_must_fail test-config get_int lamb.head >actual &&
-	test_must_fail test_cmp expect actual
+	check_config expect_code 128 get_int lamb.head
 '
 
 test_expect_success 'find bool value for the entered key' '
-	cat >expect <<-\EOF &&
-	1
-	0
-	1
-	1
-	1
-	EOF
-	test-config get_bool goat.head >actual &&
-	test-config get_bool goat.skin >>actual &&
-	test-config get_bool goat.nose >>actual &&
-	test-config get_bool goat.horns >>actual &&
-	test-config get_bool goat.legs >>actual &&
-	test_cmp expect actual
+	check_config get_bool goat.head 1 &&
+	check_config get_bool goat.skin 0 &&
+	check_config get_bool goat.nose 1 &&
+	check_config get_bool goat.horns 1 &&
+	check_config get_bool goat.legs 1
 '
 
 test_expect_success 'find multiple values' '
@@ -131,17 +143,17 @@ test_expect_success 'find multiple values' '
 	bat
 	hask
 	EOF
-	test-config get_value_multi "core.baz">actual &&
+	test-config get_value_multi "case.baz">actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'find value from a configset' '
 	cat >config2 <<-\EOF &&
-	[core]
+	[case]
 		baz = lama
 	[my]
 		new = silk
-	[core]
+	[case]
 		baz = ball
 	EOF
 	echo silk >expect &&
@@ -151,7 +163,7 @@ test_expect_success 'find value from a configset' '
 
 test_expect_success 'find value with highest priority from a configset' '
 	echo hask > expect &&
-	test-config configset_get_value core.baz config2 .git/config  >actual &&
+	test-config configset_get_value case.baz config2 .git/config  >actual &&
 	test_cmp expect actual
 '
 
@@ -163,7 +175,37 @@ test_expect_success 'find value_list for a key from a configset' '
 	lama
 	ball
 	EOF
-	test-config configset_get_value core.baz config2 .git/config  >actual &&
+	test-config configset_get_value case.baz config2 .git/config  >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'proper error on non-existant files' '
+	echo "Error reading configuration file non-existant-file." >expect &&
+	test_expect_code 2 test-config configset_get_value foo.bar non-existant-file 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'proper error on non-accessible  files' '
+	chmod -r .git/config &&
+	test_when_finished "chmod +r .git/config" &&
+	echo "Error reading configuration file .git/config." >expect &&
+	test_expect_code 2 test-config configset_get_value foo.bar .git/config 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'proper error on error in default config files' '
+	cp .git/config .git/config.old &&
+	test_when_finished "mv .git/config.old .git/config" &&
+	echo "[" >> .git/config &&
+	echo "fatal: bad config file line 35 in .git/config" >expect &&
+	test_expect_code 128 test-config get_value foo.bar 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'proper error on error in custom config files' '
+	echo "[" >> syntax-error &&
+	echo "fatal: bad config file line 1 in syntax-error" >expect &&
+	test_expect_code 128 test-config configset_get_value foo.bar syntax-error 2>actual &&
 	test_cmp expect actual
 '
 
diff --git a/test-config.c b/test-config.c
index dc313c2..cad35f4 100644
--- a/test-config.c
+++ b/test-config.c
@@ -41,17 +41,17 @@ int main(int argc, char **argv)
 
 	if (argc < 2) {
 		fprintf(stderr, "Please, provide a command name on the command-line\n");
-		return 1;
+		goto exit1;
 	} else if (argc == 3 && !strcmp(argv[1], "get_value")) {
 		if (!git_config_get_value(argv[2], &v)) {
 			if (!v)
 				printf("(NULL)\n");
 			else
 				printf("%s\n", v);
-			return 0;
+			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			return 1;
+			goto exit1;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
 		strptr = git_config_get_value_multi(argv[2]);
@@ -63,46 +63,50 @@ int main(int argc, char **argv)
 				else
 					printf("%s\n", v);
 			}
-			return 0;
+			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			return 1;
+			goto exit1;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_int")) {
 		if (!git_config_get_int(argv[2], &val)) {
 			printf("%d\n", val);
-			return 0;
+			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			return 1;
+			goto exit1;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_bool")) {
 		if (!git_config_get_bool(argv[2], &val)) {
 			printf("%d\n", val);
-			return 0;
+			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			return 1;
+			goto exit1;
 		}
 	} else if (!strcmp(argv[1], "configset_get_value")) {
 		for (i = 3; i < argc; i++) {
-			if (git_configset_add_file(&cs, argv[i]))
-				return 2;
+			if (git_configset_add_file(&cs, argv[i])) {
+				fprintf(stderr, "Error reading configuration file %s.\n", argv[i]);
+				goto exit2;
+			}
 		}
 		if (!git_configset_get_value(&cs, argv[2], &v)) {
 			if (!v)
 				printf("(NULL)\n");
 			else
 				printf("%s\n", v);
-			return 0;
+			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			return 1;
+			goto exit1;
 		}
 	} else if (!strcmp(argv[1], "configset_get_value_multi")) {
 		for (i = 3; i < argc; i++) {
-			if (git_configset_add_file(&cs, argv[i]))
-				return 2;
+			if (git_configset_add_file(&cs, argv[i])) {
+				fprintf(stderr, "Error reading configuration file %s.\n", argv[i]);
+				goto exit2;
+			}
 		}
 		strptr = git_configset_get_value_multi(&cs, argv[2]);
 		if (strptr) {
@@ -113,13 +117,24 @@ int main(int argc, char **argv)
 				else
 					printf("%s\n", v);
 			}
-			return 0;
+			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			return 1;
+			goto exit1;
 		}
 	}
 
-	fprintf(stderr, "%s: Please check the syntax and the function name\n", argv[0]);
+	die("%s: Please check the syntax and the function name", argv[0]);
+
+exit0:
+	git_configset_clear(&cs);
+	return 0;
+
+exit1:
+	git_configset_clear(&cs);
 	return 1;
+
+exit2:
+	git_configset_clear(&cs);
+	return 2;
 }

-- 8< --
