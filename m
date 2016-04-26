From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 15/15] clone: allow specification of submodules to be cloned
Date: Tue, 26 Apr 2016 13:50:33 -0700
Message-ID: <1461703833-10350-16-git-send-email-sbeller@google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com, Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 26 22:51:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9x4-0006iJ-KL
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbcDZUvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:51:13 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33819 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbcDZUvH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:51:07 -0400
Received: by mail-pf0-f179.google.com with SMTP id y69so11425309pfb.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 13:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=30NTVI0p05gXbDkkNDtfq7RkR8yuhNNANcKlcw9LKTY=;
        b=F5s6WjoMXtlDH9E465ufxB/NL+qCXmSLBNp8fxMvOFYPG2E0xJIdv7hFyiwt5LDIoE
         2+MwCeiXTzdbyBoo/ni25bPhM9PePEt/LKE0noUtTyLnIc3nOhgexNoNE0vkOOeZnsIm
         2Wi2Ykg4g7v9kRHuwgeEShZDSEeGMNuZolKzpar6n8WTdDhqQVouU1K3KPeaOZtCqaJq
         dZN8DtzXYIBZDWkC6osFDs2roZLSE4jGn1h5BB9nzIm8+Y73cPKoVnvzl+obLl2UJoTe
         5TYE2EOQefDnmO31K0jLT0lsc8PhT5CQnlOSjbeChJabnDIPGoIGMYtIDIFar81ZiqII
         IiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=30NTVI0p05gXbDkkNDtfq7RkR8yuhNNANcKlcw9LKTY=;
        b=EM69aOE8jTlju4jA3GAnxFOjXCD1zdeEsZVbaA46xZAHJO1HfxTM2T2tjK1KMTNcpI
         4C6hhO+yNG0oCUDE2bPQmGYSL8RH1YLFZI+tehYvLKVMrMqku2adpvJATqgYtHFro7JX
         nIscapsWMa0ieGi7pYfYCjEytA0EanpU0ULvLX07PaxvaeA3Eo2HTtDMF2lCq4z10j/w
         VAqmAlJ3rC77Gr/DiNMNJXXGqxrPMZSb9hJzz0qNjECX3/U3pfVEM0TFN8QzWkTIgMGC
         ooNlWNwnlEjriiY0jmGW57RopFxoRtrburvHsT7OwF0ZUmEuS8IXV1OIiIDRYsljcN7N
         T5hg==
X-Gm-Message-State: AOPr4FWoJfDywyRevIg96SNTpttJntG8E7Hau9puzIdonbvoM5ZFP/rX+9ObudKQQGsl1J5X
X-Received: by 10.98.64.144 with SMTP id f16mr6485075pfd.159.1461703866252;
        Tue, 26 Apr 2016 13:51:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fcb4:82e7:2d29:45d6])
        by smtp.gmail.com with ESMTPSA id d78sm470239pfb.59.2016.04.26.13.51.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 13:51:05 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.41.g8d9aeb3
In-Reply-To: <1461703833-10350-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292678>

This is in line with clone being the contraction of
    mkdir <path> && cd <path>
    git init
    git config
    git fetch
    git submodule update

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt |  6 +++
 builtin/clone.c             | 40 +++++++++++++++++--
 t/t7400-submodule-basic.sh  | 96 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 45d74be..38b1948 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -212,6 +212,12 @@ objects from the source repository into a pack in the cloned repository.
 	repository does not have a worktree/checkout (i.e. if any of
 	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
 
+--init-submodule::
+	After the repository is cloned, specified submodules are cloned.
+	It is possible to give multiple specifications by repeating the
+	argument. This option will be recorded in the repository config
+	as `submodule.defaultGroup`.
+
 --separate-git-dir=<git dir>::
 	Instead of placing the cloned repository where it is supposed
 	to be, place the cloned repository at the specified directory,
diff --git a/builtin/clone.c b/builtin/clone.c
index 6576ecf..8371bc2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -52,6 +52,22 @@ static struct string_list option_config;
 static struct string_list option_reference;
 static int option_dissociate;
 static int max_jobs = -1;
+static struct string_list init_submodules;
+
+static int init_submodules_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct string_list_item *item;
+	struct string_list sl = STRING_LIST_INIT_DUP;
+
+	if (unset)
+		return -1;
+
+	string_list_split(&sl, arg, ',', -1);
+	for_each_string_list_item(item, &sl)
+		string_list_append((struct string_list *)opt->value, item->string);
+
+	return 0;
+}
 
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
@@ -100,6 +116,8 @@ static struct option builtin_clone_options[] = {
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 			TRANSPORT_FAMILY_IPV6),
+	OPT_CALLBACK(0, "init-submodule", &init_submodules, N_("string"),
+			N_("clone specific submodules"), init_submodules_cb),
 	OPT_END()
 };
 
@@ -731,17 +749,24 @@ static int checkout(void)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive) {
+	if (err)
+		goto out;
+
+	if (option_recursive || init_submodules.nr > 0) {
 		struct argv_array args = ARGV_ARRAY_INIT;
-		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
+		argv_array_pushl(&args, "submodule", "update", NULL);
 
+		if (option_recursive) {
+			argv_array_pushf(&args, "--init");
+			argv_array_pushf(&args, "--recursive");
+		}
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
 
 		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
 		argv_array_clear(&args);
 	}
-
+out:
 	return err;
 }
 
@@ -876,6 +901,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
+	if (init_submodules.nr > 0) {
+		struct string_list_item *item;
+		struct strbuf sb = STRBUF_INIT;
+		for_each_string_list_item(item, &init_submodules) {
+			strbuf_addf(&sb, "submodule.defaultGroup=%s", item->string);
+			string_list_append(&option_config, strbuf_detach(&sb, 0));
+		}
+	}
+
 	if (!option_origin)
 		option_origin = "origin";
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index ac477b2..1fd313b 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1110,4 +1110,100 @@ test_expect_success 'submodule add records multiple labels' '
 	test_cmp expected actual
 '
 
+cat <<EOF > expected
+submodule
+EOF
+
+test_expect_success 'clone --init-submodule works' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --label labelA file://"$pwd"/example2 submodule &&
+		git submodule add file://"$pwd"/example2 submodule1 &&
+		git commit -a -m "create repository with 2 submodules, one is in a group"
+	) &&
+	git clone --recurse-submodules --init-submodule \*labelA super super_clone &&
+	(
+		cd super_clone &&
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp actual expected
+'
+
+cat <<EOF > expect
+submoduleA
+submoduleC
+submoduleE
+EOF
+
+test_expect_success 'clone with multiple --init-submodule options' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --label groupA file://"$pwd"/example2 submoduleA &&
+		git submodule add --label groupB file://"$pwd"/example2 submoduleB &&
+		git submodule add --label groupC file://"$pwd"/example2 submoduleC &&
+		git submodule add --label groupD --name submoduleE file://"$pwd"/example2 submoduleD &&
+		git submodule add --label groupE --name submoduleD file://"$pwd"/example2 submoduleE &&
+		git submodule add file://"$pwd"/example2 submodule1 &&
+		git commit -a -m "create repository with submodules groups"
+	) &&
+	git clone --recurse-submodules --init-submodule=\*groupA --init-submodule ./submoduleC --init-submodule :submoduleD super super_clone &&
+	(
+		cd super_clone &&
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp expect actual
+'
+
+cat <<EOF > expect
+submoduleA
+EOF
+
+cat <<EOF > expect2
+submoduleA
+submoduleC
+EOF
+
+test_expect_success 'clone and subsequent updates correctly auto-initialize submodules' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --label LA file://"$pwd"/example2 submoduleA &&
+		git submodule add file://"$pwd"/example2 submoduleB &&
+		git commit -a -m "create repository with submodules groups"
+	) &&
+	git clone --recurse-submodules --init-submodule=\*LA super super_clone &&
+	(
+		cd super_clone &&
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp expect actual &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --label LA file://"$pwd"/example2 submoduleC &&
+		git commit -a -m "add another labled submodule"
+	) &&
+	(
+		cd super_clone &&
+		# obtain the new superproject
+		git pull &&
+		# submoduleC should just appear as it has the label LA
+		# which was configured in git clone
+		git submodule update --init &&
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp expect2 actual
+'
+
 test_done
-- 
2.8.0.41.g8d9aeb3
