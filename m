Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2861BECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 20:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJaUrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 16:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiJaUrP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 16:47:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18BB13F1F
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 13:47:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sc25so32378432ejc.12
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 13:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzI7xr2/Ek68x4aoJ0O1VCoQrC78Hwo9TrdTaEDxLaA=;
        b=M+kNo0AHHUbLmDTMmVs2C1S/LWElKLrLUGtVjNwUI4zV9eau0LdqtUP1D39c7QHemr
         NOmeCNZZsoPws6Gr2DP/QTWsaODgkM5C97ilpKAbZNsOI8+cCqUcDFzX3e0VDyiNKD9N
         +O8tWFrryB8cVV6Pp0p9Dyf7hcR5DrB3jd3G2MPlZHLHYB5jSg7Nzepl6AAnBSAo7r+p
         YVrDYFj7r68E5jSBkEp2vIlNTLSXGTeqiXD2VTHYI5y18HentVumnY18Ucr8Enj3lFD5
         w0KVJZ8jiSri0nzHQRrxFK8lvWxncNdiaNvByLsmvQoMQb26IhoRLHeFlhR+oHcKwCAF
         Jllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzI7xr2/Ek68x4aoJ0O1VCoQrC78Hwo9TrdTaEDxLaA=;
        b=U1AQxpAEHhGIQV62G4ND/a6/5ogc74t0tM29TP8TZilc6DO3cxI5BtCqqr9vx4IHKn
         pr4u9mg2Gh4Py6vwGi5DQaGjhE/q1L+GcYZ6LOr5tNie5bS2B7alXlenqPsh9wC9CkXA
         ZvbA2P69vCn493DYKKuNKu8jxb7YDQM0lFUFovfZRopk+O3ZQPaTgORefpKzkdro8ZU/
         DZGeMgq0MYQiUhg40gXrj2B+PMifkpjDkCS1xNF0CpMF+S6Yykt4w5tbo+/APE6DaoWn
         4nkbK0T1ZFd/uULub/a6egDVa6179GOo4fxxvO3aCxG++a3/uxpj7jcpDdP+NK71Lhg7
         BzKA==
X-Gm-Message-State: ACrzQf33vRLhxMoZof+IS2UsSZXYD00LJXZzJqZwC/1ynmThjG2FriO5
        m0IlDK/nmzJLuUU1GwkoJpaZYfcy9J9/8w==
X-Google-Smtp-Source: AMsMyM53QP6leOsM14pjPz9wVMB1vwj/pvPjy3nTDPuHGaOOF6uA81iEqlByHMRIs27cdaz60sxyDQ==
X-Received: by 2002:a17:907:5c2:b0:77e:def7:65d8 with SMTP id wg2-20020a17090705c200b0077edef765d8mr15225545ejb.487.1667249232052;
        Mon, 31 Oct 2022 13:47:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b007add62dafb7sm1360304ejc.5.2022.10.31.13.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:47:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH] fetch: stop emitting duplicate transfer.credentialsInUrl=warn warnings
Date:   Mon, 31 Oct 2022 21:47:08 +0100
Message-Id: <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
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

[Grabbing a quote from
https://lore.kernel.org/git/98fa5270cb720f2f038c4bb9571c7d306ff5d759.1667245639.git.gitgitgadget@gmail.com/
for a reply]

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> It is unclear as to _why_, but under certain circumstances the warning
> about credentials being passed as part of the URL seems to be swallowed
> by the `git remote-https` helper in the Windows jobs of Git's CI builds.

I think this should fix the root cause of the issue you're seeing. I
have a larger local branch to fix various issues with this
credentialsInUrl facility that I hadn't gotten around to submitting:

	https://github.com/git/git/compare/master...avar:avar/fix-cred-in-url-warnings-2

This is a cherry-pick of 7/* of that (the first were doc changes,
missing test coverage etc).

> Since it is not actually important how many times Git prints the
> warning/error message, as long as it prints it at least once, let's just
> make the test a bit more lenient and test for the latter instead of the
> former, which works around these CI issues.

That being said your change is obviously smaller, so if we'd prefer
that in first as a band-aid I'm fine with that.

But I'd really like to object to the "it is not actually important how
many...", it's crappy UX to spew duplicate output at the user, and we
should avoid it.

So it does matter, and we get it wrong not just in this but also some
other cases.

 builtin/clone.c       |  5 +++-
 builtin/fetch.c       |  4 ++++
 builtin/push.c        |  6 ++++-
 remote.c              | 53 ++++++++++++++++++++++++++++++++-----------
 remote.h              | 14 ++++++++++++
 t/t5516-fetch-push.sh |  2 +-
 t/t5601-clone.sh      |  2 +-
 7 files changed, 69 insertions(+), 17 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 547d6464b3c..da219b74e43 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -903,12 +903,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
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
index b06e454cbdd..34a10e1927f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2110,9 +2110,13 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
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
index f0329c62a2d..a4890b1586d 100644
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
index 60869beebe7..a35da349629 100644
--- a/remote.c
+++ b/remote.c
@@ -615,24 +615,42 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push)
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
-		die(_("unrecognized value transfer.credentialsInUrl: '%s'"), value);
+		die(_("unrecognized value transfer.credentialsInURL: '%s'"), value);
+
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
 
 	for (i = 0; i < remote->url_nr; i++) {
 		struct url_info url_info = { 0 };
@@ -647,16 +665,25 @@ static void validate_remote_url(struct remote *remote)
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
index 1c4621b414b..5a2da13b4cb 100644
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
@@ -445,4 +447,16 @@ void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
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
index 79dc470c014..d01f5cd349f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1860,7 +1860,7 @@ test_expect_success LIBCURL 'fetch warns or fails when using username:password'
 
 	test_must_fail git -c transfer.credentialsInUrl=warn fetch https://username:password@localhost 2>err &&
 	grep "warning: $message" err >warnings &&
-	test_line_count = 3 warnings &&
+	test_line_count = 1 warnings &&
 
 	test_must_fail git -c transfer.credentialsInUrl=die fetch https://username:password@localhost 2>err &&
 	grep "fatal: $message" err >warnings &&
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 45f0803ed4d..37adfd9f83b 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -78,7 +78,7 @@ test_expect_success LIBCURL 'clone warns or fails when using username:password'
 
 	test_must_fail git -c transfer.credentialsInUrl=warn clone https://username:password@localhost attempt2 2>err &&
 	grep "warning: $message" err >warnings &&
-	test_line_count = 2 warnings &&
+	test_line_count = 1 warnings &&
 
 	test_must_fail git -c transfer.credentialsInUrl=die clone https://username:password@localhost attempt3 2>err &&
 	grep "fatal: $message" err >warnings &&
-- 
2.38.0.1280.g8136eb6fab2

