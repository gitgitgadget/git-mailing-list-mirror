Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D12C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 10:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347596AbiFOKxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 06:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347341AbiFOKxo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 06:53:44 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A4A5131F
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:53:42 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so898817wms.3
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rNuJBJk0kuZ0YTdaqNN/twXud/ys9gqFrv3KnoKAgx8=;
        b=XK047C+j6hb4mNg+CxfI4Zs4SpuF+NmCJ18Z3Cv5Xqf/kb6ydQ8jLWePOwl98os6gU
         ckF07QoGJQ8u0Az41+hiZCXa2KrPU4S89pKrk/LG6K+9ht4ILu7xdVPpLcEIRuvGW8W6
         9FHW2Al5KWoeogSX6MpUOBEzyxEj9OPrXCNbFCgRQX3PPaGLpk1V/gQp1dp+gqrqVHHF
         hMTnBpyxhqn9aomPeNljQWjQK6aONzGWCxCqB812zK+zSrslAU1MURxV+G7hgO69ZxO1
         ZUt0C09Hhe19rQvStNcbPkSQVGffck3uukvgrDCmpGhEN1VQOpTTeJZaU3969LekvpqZ
         b3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rNuJBJk0kuZ0YTdaqNN/twXud/ys9gqFrv3KnoKAgx8=;
        b=nfn72KQpuLjH7hBjIAiR/6jn6dQTjBP+A8XBfBnNmSOWw9Vfzo7YVyq8TIpP5tHeHB
         sV47Z/02O1+Ko5gqjxevIMcyQZqTjbaNwLZDVDT79smIBzRLiC25WLnbJSocE4rnVWRv
         m5jv8HcMSuLVfMvBuWd9bx16hi9FiKQRjXKfY1jQFjq7O4Sm+NS3iJnZDHjqzhzDdcjn
         7Xxc0J53KczocLy2uDlDO5RE9Alckv5y/+H70/OkbYa3p9t4C2mL1edhk717yfFXG5sP
         f4FaVwkxjrPcn/kaub5grJAqTsSAul0ukq8XwH8rVRMSbMZPeYjT2QXy5nP+3l4b4B08
         rs3w==
X-Gm-Message-State: AOAM533pTD+8avABQf6Pu15qZ7YoTFqa2kudIr5L9ua6+mLrYKHlmrOy
        irc5uuxqjcasEcLsIzrMNEPKOQyYVyS6zw==
X-Google-Smtp-Source: ABdhPJzb+pchfhD8YhoXmZww5H5VmCb3Whx2g8H9ol/Cpd6Xyi7/bzdFkaI453rt4pJhBINPdZqUiw==
X-Received: by 2002:a05:600c:3505:b0:39c:93d4:5eec with SMTP id h5-20020a05600c350500b0039c93d45eecmr9067385wmq.179.1655290421186;
        Wed, 15 Jun 2022 03:53:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g12-20020a7bc4cc000000b0039bc95cf4b2sm1786747wmk.11.2022.06.15.03.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:53:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 4/5] fetch: stop emitting duplicate transfer.credentialsInUrl=warn warnings
Date:   Wed, 15 Jun 2022 12:53:31 +0200
Message-Id: <RFC-patch-4.5-3861546bd84-20220615T104503Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <RFC-cover-0.5-00000000000-20220615T104503Z-avarab@gmail.com>
References: <RFC-cover-0.5-00000000000-20220615T104503Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve on 6dcbdc0d661 (remote: create fetch.credentialsInUrl config,
2022-06-06) by fixing the cases where we emit duplicate warnings,
which were:

 * In the same process, as we'd get the same "struct remote *"
   again. We could probably save ourselves more work in those scenarios,
   but adding a flag to the "struct remote" indicating that we've validated
   the URLs will fix those issues.

 * When we invoke e.g. "git-remote-https" (aka. "git-remote-curl")
   from "git fetch". For those cases let's pass down the equivalent of a
   "-c transfer.credentialsInUrl=allow", since we know that we've already
   inspected our remotes in the parent process.

   See 7390f05a3c6 (fetch: after refetch, encourage auto gc repacking,
   2022-03-28) for prior use of git_config_push_parameter() for this
   purpose, i.e. to push config parameters before invoking a
   sub-process.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c       |  5 ++++-
 builtin/fetch.c       |  4 ++++
 builtin/push.c        |  6 ++++-
 remote.c              | 51 +++++++++++++++++++++++++++++++++----------
 remote.h              | 14 ++++++++++++
 t/t5516-fetch-push.sh |  6 ++---
 t/t5601-clone.sh      |  2 +-
 7 files changed, 70 insertions(+), 18 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 89a91b00177..96a94621a09 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -886,12 +886,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int err = 0, complete_refs_before_fetch = 1;
 	int submodule_progress;
 	int filter_submodules = 0;
-
+	enum credentials_in_url cred_in_url_cfg = get_credentials_in_url();
 	struct transport_ls_refs_options transport_ls_refs_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
 
 	packet_trace_identity("clone");
 
+	if (cred_in_url_cfg == CRED_IN_URL_WARN)
+		git_config_push_parameter("transfer.credentialsInUrl=allow");
+
 	git_config(git_clone_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ac29c2b1ae3..bf67ef8c3d8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2101,9 +2101,13 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	struct remote *remote = NULL;
 	int result = 0;
 	int prune_tags_ok = 1;
+	enum credentials_in_url cred_in_url_cfg = get_credentials_in_url();
 
 	packet_trace_identity("fetch");
 
+	if (cred_in_url_cfg == CRED_IN_URL_WARN)
+		git_config_push_parameter("transfer.credentialsInUrl=allow");
+
 	/* Record the command line for the reflog */
 	strbuf_addstr(&default_rla, "fetch");
 	for (i = 1; i < argc; i++) {
diff --git a/builtin/push.c b/builtin/push.c
index 86b44f8aa71..6dd1b20dda0 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -576,7 +576,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	struct string_list *push_options;
 	const struct string_list_item *item;
 	struct remote *remote;
-
+	enum credentials_in_url cred_in_url_cfg = get_credentials_in_url();
 	struct option options[] = {
 		OPT__VERBOSITY(&verbosity),
 		OPT_STRING( 0 , "repo", &repo, N_("repository"), N_("repository")),
@@ -619,6 +619,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	};
 
 	packet_trace_identity("push");
+
+	if (cred_in_url_cfg == CRED_IN_URL_WARN)
+		git_config_push_parameter("transfer.credentialsInUrl=allow");
+
 	git_config(git_push_config, &flags);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 	push_options = (push_options_cmdline.nr
diff --git a/remote.c b/remote.c
index 42c891d44fd..61add35be2f 100644
--- a/remote.c
+++ b/remote.c
@@ -616,25 +616,43 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push)
 	return NULL;
 }
 
-static void validate_remote_url(struct remote *remote)
+static enum credentials_in_url cred_in_url = CRED_IN_URL_UNKNOWN;
+enum credentials_in_url get_credentials_in_url(void)
 {
-	int i;
+	enum credentials_in_url new = CRED_IN_URL_ALLOW;
 	const char *value;
-	struct strbuf redacted = STRBUF_INIT;
-	int warn_not_die;
+
+	if (cred_in_url != CRED_IN_URL_UNKNOWN)
+		return cred_in_url;
 
 	if (git_config_get_string_tmp("transfer.credentialsinurl", &value))
-		return;
+		goto done;
 
 	if (!strcmp("warn", value))
-		warn_not_die = 1;
+		new = CRED_IN_URL_WARN;
 	else if (!strcmp("die", value))
-		warn_not_die = 0;
+		new = CRED_IN_URL_DIE;
 	else if (!strcmp("allow", value))
-		return;
+		goto done;
 	else
 		die(_("unrecognized value transfer.credentialsInURL: '%s'"), value);
 
+done:
+	cred_in_url = new;
+	return cred_in_url;
+}
+
+static void validate_remote_url(struct remote *remote)
+{
+	int i;
+	struct strbuf redacted = STRBUF_INIT;
+	enum credentials_in_url cfg = get_credentials_in_url();
+
+	if (remote->validated_urls)
+		goto done;
+	if (cfg == CRED_IN_URL_ALLOW)
+		goto done;
+
 	for (i = 0; i < remote->url_nr; i++) {
 		struct url_info url_info = { 0 };
 
@@ -648,16 +666,25 @@ static void validate_remote_url(struct remote *remote)
 		strbuf_addstr(&redacted,
 			      url_info.url + url_info.passwd_off + url_info.passwd_len);
 
-		if (warn_not_die)
+		switch (cfg) {
+		case CRED_IN_URL_WARN:
 			warning(_("URL '%s' uses plaintext credentials"), redacted.buf);
-		else
+			break;
+		case CRED_IN_URL_DIE:
 			die(_("URL '%s' uses plaintext credentials"), redacted.buf);
-
-loop_cleanup:
+			break;
+		case CRED_IN_URL_ALLOW:
+		case CRED_IN_URL_UNKNOWN:
+			BUG("unreachable");
+			break;
+		}
+	loop_cleanup:
 		free(url_info.url);
 	}
 
 	strbuf_release(&redacted);
+done:
+	remote->validated_urls = 1;
 }
 
 static struct remote *
diff --git a/remote.h b/remote.h
index dd4402436f1..4ef359e4d4a 100644
--- a/remote.h
+++ b/remote.h
@@ -98,6 +98,8 @@ struct remote {
 	int prune;
 	int prune_tags;
 
+	int validated_urls;
+
 	/**
 	 * The configured helper programs to run on the remote side, for
 	 * Git-native protocols.
@@ -441,4 +443,16 @@ void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
 char *relative_url(const char *remote_url, const char *url,
 		   const char *up_path);
 
+enum credentials_in_url {
+	CRED_IN_URL_UNKNOWN,
+	CRED_IN_URL_ALLOW,
+	CRED_IN_URL_WARN,
+	CRED_IN_URL_DIE,
+};
+
+/**
+ * Get the transfer.credentialsInUrl config setting as an "enum
+ * credentials_in_url".
+ */
+enum credentials_in_url get_credentials_in_url(void);
 #endif
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 51d695e475a..c7a21d7cfb5 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1841,7 +1841,7 @@ test_expect_success 'fetch warns or fails when using username:password' '
 
 	test_must_fail git -c transfer.credentialsInUrl=warn fetch https://username:password@localhost 2>err &&
 	grep "warning: $message" err >warnings &&
-	test_line_count = 3 warnings &&
+	test_line_count = 1 warnings &&
 
 	test_must_fail git -c transfer.credentialsInUrl=die fetch https://username:password@localhost 2>err &&
 	grep "fatal: $message" err >warnings &&
@@ -1864,7 +1864,7 @@ test_expect_success CURL 'fetch warns or fails when using username:password in c
 
 	test_must_fail git -C repo -c transfer.credentialsInUrl=warn fetch pwd-url 2>err &&
 	grep "warning: $message" err >warnings &&
-	test_line_count = 3 warnings &&
+	test_line_count = 1 warnings &&
 
 	git -C repo remote set-url --push pwd-url https://username:password@localhost &&
 	git -C repo remote set-url pwd-url https://localhost &&
@@ -1899,7 +1899,7 @@ test_expect_success CURL 'push warns or fails when using username:password in co
 
 	test_must_fail git -C repo -c transfer.credentialsInUrl=warn push pwd-url HEAD:refs/heads/branch 2>err &&
 	grep "warning: $message" err >warnings &&
-	test_line_count = 2 warnings &&
+	test_line_count = 1 warnings &&
 
 	git -C repo remote set-url --push pwd-url https://username:password@localhost &&
 	git -C repo remote set-url pwd-url https://localhost &&
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index e6a248bbdcc..e449ccb54e3 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -78,7 +78,7 @@ test_expect_success 'clone warns or fails when using username:password' '
 
 	test_must_fail git -c transfer.credentialsInUrl=warn clone https://username:password@localhost attempt2 2>err &&
 	grep "warning: $message" err >warnings &&
-	test_line_count = 2 warnings &&
+	test_line_count = 1 warnings &&
 
 	test_must_fail git -c transfer.credentialsInUrl=die clone https://username:password@localhost attempt3 2>err &&
 	grep "fatal: $message" err >warnings &&
-- 
2.36.1.1239.gfba91521d90

