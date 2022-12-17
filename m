Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0CBC4167B
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 13:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiLQNaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 08:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiLQNaN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 08:30:13 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39F0E0DD
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 05:30:11 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 1so7520459lfz.4
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 05:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CB24dgm+kWM+tJeOmjM6R+xFRuJgy4tRr6MqIu+pcl4=;
        b=QMwjn0ftBilFAuOcstj0RhYy0o1f9f3O1BWjLCs1omAJf3BZxpjQqZyK1j4l+4Sl9p
         W0JHGhyTBxgayaVC3TWWXFmTYzowXjtyTjZKqWqhLFPEANlRdYL1IdNo1yhxTU0d+1sa
         O6rjW4b8N4okX7s8T/gdh7EP787/VYPkgMv5yPFMbMpzEyjsMU9I87zUQxGCKiG5pqRv
         S0oQLl0QSf1PKO2Z6q1gBtSsQoAT8CbdltPxtWkJaFIALasXYvr0vSKjE5T/O4IpNpYv
         9rvaV7osf04Q5TIPLXXSEWxyOteT8DHa3KTJYIttZNusP6Pttn1cL80OILwEbo8NCApV
         CMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CB24dgm+kWM+tJeOmjM6R+xFRuJgy4tRr6MqIu+pcl4=;
        b=fLdj69jpYzUj/6cwcMYJuyntLqH2kdPqjNyuGuZMjW7WixekZolmV3TztTqR6RaG6U
         Ah8hfdcAxKJLS78r5UGGeT5Ajm1cAnzPOwbYRobxKZjqzEWyWEBHjhtmXlKEJHpB+GCW
         431lYhowCD6laBTVg6dtwMAz7ndWrffsV0dcFiuyZ1G5ahm5tocssgAzVQwNEIFenG2s
         G77LFT4xs8tqXjYnLkA623vwOWuecls1NPNMnbZqOfGBIbIisOk3Sgt7ck6cIw5dR2xZ
         i32+HQd3zex4TuZIv6Jp30ph95wZp8E1Z3HLwZtmfJmqMnWEb7Wl7ofmvFqi5cJFJCwc
         dUkg==
X-Gm-Message-State: ANoB5pmJnROHoUYfy0sQ2MHWOKU04Y1ToOac1AHBIehiiuv7SvPX/jky
        /pInyI0/33R6IOuk4gho06Y=
X-Google-Smtp-Source: AA0mqf7OrnIMsyvqRPbPfvOVRxpIbkVQQ5Zn7oF1d8MpeIDoFdpiUfLwDqtQmXzeP0w1qLVylLQUpw==
X-Received: by 2002:a05:6512:25a4:b0:4b5:87da:8b35 with SMTP id bf36-20020a05651225a400b004b587da8b35mr11555154lfb.61.1671283810149;
        Sat, 17 Dec 2022 05:30:10 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q6-20020a056512210600b004a100c21eaesm512420lfr.97.2022.12.17.05.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 05:30:09 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 1/5] diff-merges: implement [no-]hide option and log.diffMergesHide config
Date:   Sat, 17 Dec 2022 16:29:51 +0300
Message-Id: <20221217132955.108542-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221217132955.108542-1-sorganov@gmail.com>
References: <kl6lilimepli.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20221217132955.108542-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The set of diff-merges options happened to be incomplete, and failed
to implement exact semantics of -m option that hides output of diffs
for merge commits unless -p option is active as well.

The new "hide" option fixes this issue, so that now

  --diff-merges=on --diff-merges=hide

combo is the exact synonym for -m.

The log.diffMerges configuration also accepts "hide" and "no-hide"
values, and governs the default value for the hide bit. The
configuration behaves as if "--diff-merges=[no-]hide" is inserted
first in the command-line.

New log.diffMergesHide boolean configuration is implemented as well,
for the case when log.diffMerges is already in use for specifying the
format.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/config/log.txt                  |  6 +++
 Documentation/diff-options.txt                | 13 +++--
 builtin/log.c                                 |  2 +
 diff-merges.c                                 | 40 ++++++++++++--
 diff-merges.h                                 |  2 +
 t/t4013-diff-various.sh                       | 54 ++++++++++++++++++-
 ...ges=first-parent_--diff-merges=hide_master | 34 ++++++++++++
 t/t9902-completion.sh                         |  3 ++
 8 files changed, 147 insertions(+), 7 deletions(-)
 create mode 100644 t/t4013/diff.log_--diff-merges=first-parent_--diff-merges=hide_master

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index cbe34d759221..9c6be643bcf6 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -33,6 +33,12 @@ log.diffMerges::
 	Set diff format to be used when `--diff-merges=on` is
 	specified, see `--diff-merges` in linkgit:git-log[1] for
 	details. Defaults to `separate`.
++
+When used with 'hide' or 'no-hide', sets the default hiding of
+diffs for merge commits when `-p` option is not used.
+
+log.diffMergesHide::
+	`true` implies `--diff-merges=hide` option.
 
 log.follow::
 	If `true`, `git log` will act as if the `--follow` option was used when
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 3674ac48e92c..b062bdab04d9 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -34,7 +34,7 @@ endif::git-diff[]
 endif::git-format-patch[]
 
 ifdef::git-log[]
---diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc|remerge|r)::
+--diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc|remerge|r|[no-]hide)::
 --no-diff-merges::
 	Specify diff format to be used for merge commits. Default is
 	{diff-merges-default} unless `--first-parent` is in use, in which case
@@ -49,10 +49,11 @@ ifdef::git-log[]
 --diff-merges=m:::
 -m:::
 	This option makes diff output for merge commits to be shown in
-	the default format. `-m` will produce the output only if `-p`
-	is given as well. The default format could be changed using
+	the default format. The default format could be changed using
 	`log.diffMerges` configuration parameter, which default value
 	is `separate`.
++
+	`-m` is a shortcut for '--diff-merges=on --diff-merges=hide'
 +
 --diff-merges=first-parent:::
 --diff-merges=1:::
@@ -94,6 +95,12 @@ documented).
 	uninteresting hunks whose contents in the parents have only
 	two variants and the merge result picks one of them without
 	modification.  `--cc` implies `-p`.
++
+--diff-merges=hide:::
+--diff-merges=no-hide:::
+	Hide (do not hide) the diff for merge commits unless `-p` options is given
+	as well. The default `no-hide` could be changed using `log.diffMerges`
+	configuration parameter.
 
 --combined-all-paths::
 	This flag causes combined diffs (used for merge commits) to
diff --git a/builtin/log.c b/builtin/log.c
index 56e2d95e869d..e031021e53b2 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -581,6 +581,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "log.diffmerges"))
 		return diff_merges_config(value);
+	if (!strcmp(var, "log.diffmergeshide"))
+		return diff_merges_hide_config(git_config_bool(var, value));
 	if (!strcmp(var, "log.showroot")) {
 		default_show_root = git_config_bool(var, value);
 		return 0;
diff --git a/diff-merges.c b/diff-merges.c
index 85cbefa5afd7..55fe5b70c102 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -7,6 +7,7 @@ static void set_separate(struct rev_info *revs);
 
 static diff_merges_setup_func_t set_to_default = set_separate;
 static int suppress_m_parsing;
+static int hide = 0;
 
 static void suppress(struct rev_info *revs)
 {
@@ -20,10 +21,15 @@ static void suppress(struct rev_info *revs)
 	revs->remerge_diff = 0;
 }
 
+static void set_need_diff(struct rev_info *revs)
+{
+	revs->merges_need_diff = !hide;
+}
+
 static void common_setup(struct rev_info *revs)
 {
 	suppress(revs);
-	revs->merges_need_diff = 1;
+	set_need_diff(revs);
 }
 
 static void set_none(struct rev_info *revs)
@@ -31,6 +37,18 @@ static void set_none(struct rev_info *revs)
 	suppress(revs);
 }
 
+static void set_hide(struct rev_info *revs)
+{
+	hide = 1;
+	set_need_diff(revs);
+}
+
+static void set_no_hide(struct rev_info *revs)
+{
+	hide = 0;
+	set_need_diff(revs);
+}
+
 static void set_separate(struct rev_info *revs)
 {
 	common_setup(revs);
@@ -69,6 +87,10 @@ static diff_merges_setup_func_t func_by_opt(const char *optarg)
 {
 	if (!strcmp(optarg, "off") || !strcmp(optarg, "none"))
 		return set_none;
+	if (!strcmp(optarg, "hide"))
+		return set_hide;
+	if (!strcmp(optarg, "no-hide"))
+		return set_no_hide;
 	if (!strcmp(optarg, "1") || !strcmp(optarg, "first-parent"))
 		return set_first_parent;
 	if (!strcmp(optarg, "separate"))
@@ -105,7 +127,19 @@ int diff_merges_config(const char *value)
 	if (!func)
 		return -1;
 
-	set_to_default = func;
+	if (func == set_hide)
+		hide = 1;
+	else if (func == set_no_hide)
+		hide = 0;
+	else
+		set_to_default = func;
+
+	return 0;
+}
+
+int diff_merges_hide_config(int on)
+{
+	hide = on;
 	return 0;
 }
 
@@ -122,7 +156,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 
 	if (!suppress_m_parsing && !strcmp(arg, "-m")) {
 		set_to_default(revs);
-		revs->merges_need_diff = 0;
+		set_hide(revs);
 	} else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
 		revs->merges_imply_patch = 1;
diff --git a/diff-merges.h b/diff-merges.h
index 19639689bb05..e86e5381693b 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -11,6 +11,8 @@ struct rev_info;
 
 int diff_merges_config(const char *value);
 
+int diff_merges_hide_config(int hide);
+
 void diff_merges_suppress_m_parsing(void);
 
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index dfcf3a0aaae3..4fc8ba2fc59c 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -334,6 +334,7 @@ log --first-parent --diff-merges=off -p master
 log -p --first-parent master
 log -p --diff-merges=first-parent master
 log --diff-merges=first-parent master
+log --diff-merges=first-parent --diff-merges=hide master
 log -m -p --first-parent master
 log -m -p master
 log --cc -m -p master
@@ -460,7 +461,18 @@ EOF
 test_expect_success 'log -m matches pure log' '
 	git log master >result &&
 	process_diffs result >expected &&
-	git log -m >result &&
+	git log -m master >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'log --diff-merges=on matches -m only with --diff-merges=hide' '
+	git log -m master >result &&
+	process_diffs result >expected &&
+	git log --diff-merges=on master >result &&
+	process_diffs result >actual &&
+	! test_cmp expected actual &&
+	git log --diff-merges=on --diff-merges=hide master >result &&
 	process_diffs result >actual &&
 	test_cmp expected actual
 '
@@ -496,6 +508,46 @@ test_expect_success 'git config log.diffMerges first-parent vs -m' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git config log.diffMerges hide: has effect' '
+	git log --diff-merges=on master >result &&
+	process_diffs result >no-hide &&
+	test_config log.diffMerges hide &&
+	git log --diff-merges=on master >result &&
+	process_diffs result >hide &&
+	! test_cmp no-hide hide
+'
+
+test_expect_success 'git config log.diffMerges no-hide: is the default' '
+	git log --diff-merges=on master >result &&
+	process_diffs result >default &&
+	test_config log.diffMerges no-hide &&
+	git log --diff-merges=on master >result &&
+	process_diffs result >no-hide &&
+	test_cmp default no-hide
+'
+
+# As "-m" is synonym for "--diff-merges=hide --diff-merges=on", the
+# "log.diffMerges=hide" configuration should have no effect on "-m"
+test_expect_success 'git config log.diffMerges hide: has no effect on -m' '
+	git log -m master >result &&
+	process_diffs result >expected &&
+	test_config log.diffMerges hide &&
+	git log -m master >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
+# As "--cc" implies "-p", the "log.diffMerges=hide" configuration
+# should have no effect on "--cc"
+test_expect_success 'git config log.diffMerges hide: has no effect on --cc' '
+	git log --cc master >result &&
+	process_diffs result >expected &&
+	test_config log.diffMerges hide &&
+	git log --cc master >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 # -m in "git diff-index" means "match missing", that differs
 # from its meaning in "git diff". Let's check it in diff-index.
 # The line in the output for removed file should disappear when
diff --git a/t/t4013/diff.log_--diff-merges=first-parent_--diff-merges=hide_master b/t/t4013/diff.log_--diff-merges=first-parent_--diff-merges=hide_master
new file mode 100644
index 000000000000..596caec64298
--- /dev/null
+++ b/t/t4013/diff.log_--diff-merges=first-parent_--diff-merges=hide_master
@@ -0,0 +1,34 @@
+$ git log --diff-merges=first-parent --diff-merges=hide master
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:03:00 2006 +0000
+
+    Side
+
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:01:00 2006 +0000
+
+    Second
+    
+    This is the second commit.
+
+commit 444ac553ac7612cc88969031b02b3767fb8a353a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+$
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 43de868b8005..fc6b0722216a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2497,6 +2497,7 @@ test_expect_success 'git config - variable name' '
 	log.date Z
 	log.decorate Z
 	log.diffMerges Z
+	log.diffMergesHide Z
 	EOF
 '
 
@@ -2525,6 +2526,7 @@ test_expect_success 'git -c - variable name' '
 	log.date=Z
 	log.decorate=Z
 	log.diffMerges=Z
+	log.diffMergesHide=Z
 	EOF
 '
 
@@ -2547,6 +2549,7 @@ test_expect_success 'git clone --config= - variable name' '
 	log.date=Z
 	log.decorate=Z
 	log.diffMerges=Z
+	log.diffMergesHide=Z
 	EOF
 '
 
-- 
2.25.1

