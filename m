From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 2/2] submodule: port init from shell to C
Date: Fri, 22 Jan 2016 15:32:16 -0800
Message-ID: <1453505536-14895-3-git-send-email-sbeller@google.com>
References: <1453505536-14895-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, j6t@kdbg.org,
	sunshine@sunshineco.com, Jens.Lehmann@web.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 23 00:32:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMlCC-00051y-1m
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 00:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755658AbcAVXcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 18:32:36 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35849 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756620AbcAVXcc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 18:32:32 -0500
Received: by mail-pf0-f169.google.com with SMTP id n128so49402561pfn.3
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 15:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=BmdvEL6zoCp0Xy+cOfl/WUj8K55+vGgQl82CWr4YaWU=;
        b=FiMHeRNuO9u/+LHrodq9OO/RsZE03o3ceGKy1vp5Y7Nku69PUMwhaPRTTqhaMNOeg7
         S1b+UUbDRjUOg+5O+zefKo+efVQrhVuscz71/SXUEnaYvB5dQOQ+gULX4o2lVIpzuV23
         pvBKAsj2a9ekHg3hTbqlZyLXuPobY7EIUO3151WLrqNuJ5N7UcIEaNz+rsqfUs4WOdQv
         v9WL5izA+HcJviGfIFv7NbFj2GktUFDGKqR5IEsOpZMrZiyF3h0rb+2/ElScF8KVFgnd
         wy4f+ye5/CXWij8voGtL++oYUOU3+pfZ1dor3Bcy4Ub3mIpzet3WvmXBABy6M5PvH9Uc
         Hg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=BmdvEL6zoCp0Xy+cOfl/WUj8K55+vGgQl82CWr4YaWU=;
        b=lts/77H3ZJOeA709QkOQphBhB0hd6vUxjdVMONSsqbYB5GLqKXtwHBrYoiuB+d58f/
         8Mo05feE6KOsGqGt+FQoDmOkqYvgc2utw6tNvOCuQ9ly15cDuJuXvcBhSrfhIBa8iXBP
         G7wt+kOHAk5a9JVnaeFNacyEA7+YtH0acDieTwPq7enDsJT5svoj0Wtx6DdLrB78YF2s
         KfACkbDFSM5sflmFtGoWGFCtkFuPHnecXRL1rML1jl5cAFQbVYnsjBuenKO2M9XqLEDO
         X5cBBtxyNIOH4hAh+M3mT4Pie18g915iei1AzV5mTwQEZRqtvS5ynWdwI9lZQ1YzJatC
         fM7w==
X-Gm-Message-State: AG10YOTipfRKs8MvKiIeJ8n/EVWobMJeLyRxXwe9I203qQJIxQGbiqJO1RFon8VxnP9kG5is
X-Received: by 10.98.16.139 with SMTP id 11mr8296403pfq.128.1453505550947;
        Fri, 22 Jan 2016 15:32:30 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:add1:48d1:6b77:ed16])
        by smtp.gmail.com with ESMTPSA id n84sm12073662pfa.45.2016.01.22.15.32.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Jan 2016 15:32:30 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.45.g0dba895.dirty
In-Reply-To: <1453505536-14895-1-git-send-email-sbeller@google.com>
In-Reply-To: <xmqqoacdtfh3.fsf@gitster.mtv.corp.google.com>
References: <xmqqoacdtfh3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284608>

By having the `init` functionality in C, we can reference it easier
from other parts in the code.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 115 ++++++++++++++++++++++++++++++++++++++++++--
 git-submodule.sh            |  39 +--------------
 2 files changed, 111 insertions(+), 43 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 92d7d32..c9b0c05 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -212,6 +212,115 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
+static int git_submodule_config(const char *var, const char *value, void *cb)
+{
+	return parse_submodule_config_option(var, value);
+}
+
+static void init_submodule(const char *path, const char *prefix, int quiet)
+{
+	const struct submodule *sub;
+	struct strbuf sb = STRBUF_INIT;
+	char *url = NULL;
+	const char *upd = NULL;
+	const char *displaypath = relative_path(xgetcwd(), prefix, &sb);
+
+	/* Only loads from .gitmodules, no overlay with .git/config */
+	gitmodules_config();
+
+	sub = submodule_from_path(null_sha1, path);
+
+	/*
+	 * Copy url setting when it is not set yet.
+	 * To look up the url in .git/config, we must not fall back to
+	 * .gitmodules, so look it up directly.
+	 */
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "submodule.%s.url", sub->name);
+	if (git_config_get_string(sb.buf, &url)) {
+		url = xstrdup(sub->url);
+
+		if (!url)
+			die(_("No url found for submodule path '%s' in .gitmodules"),
+				displaypath);
+
+		/* Possibly a url relative to parent */
+		if (starts_with_dot_dot_slash(url) ||
+		    starts_with_dot_slash(url)) {
+			char *remoteurl;
+			char *remote = get_default_remote();
+			struct strbuf remotesb = STRBUF_INIT;
+			strbuf_addf(&remotesb, "remote.%s.url", remote);
+			free(remote);
+
+			if (git_config_get_string(remotesb.buf, &remoteurl))
+				/*
+				 * The repository is its own
+				 * authoritative upstream
+				 */
+				remoteurl = xgetcwd();
+			url = relative_url(remoteurl, url, NULL);
+			strbuf_release(&remotesb);
+		}
+
+		if (git_config_set(sb.buf, url))
+			die(_("Failed to register url for submodule path '%s'"),
+			    displaypath);
+		if (!quiet)
+			printf(_("Submodule '%s' (%s) registered for path '%s'\n"),
+				sub->name, url, displaypath);
+		free(url);
+	}
+
+	/* Copy "update" setting when it is not set yet */
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "submodule.%s.update", sub->name);
+	if (git_config_get_string_const(sb.buf, &upd) && sub->update) {
+		upd = sub->update;
+		if (strcmp(sub->update, "checkout") &&
+		    strcmp(sub->update, "rebase") &&
+		    strcmp(sub->update, "merge") &&
+		    strcmp(sub->update, "none")) {
+			fprintf(stderr, _("warning: unknown update mode '%s' suggested for submodule '%s'\n"),
+				upd, sub->name);
+			upd = "none";
+		}
+		if (git_config_set(sb.buf, upd))
+			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
+	}
+	strbuf_release(&sb);
+}
+
+static int module_init(int argc, const char **argv, const char *prefix)
+{
+	int quiet = 0;
+	int i;
+
+	struct option module_init_options[] = {
+		OPT_STRING(0, "prefix", &prefix,
+			   N_("path"),
+			   N_("alternative anchor for relative paths")),
+		OPT__QUIET(&quiet, "Suppress output for initialzing a submodule"),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper init [<path>]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_init_options,
+			     git_submodule_helper_usage, 0);
+
+	if (argc == 0)
+		die(_("Pass at least one submodule"));
+
+	for (i = 0; i < argc; i++)
+		init_submodule(argv[i], prefix, quiet);
+
+	return 0;
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -457,11 +566,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int git_submodule_config(const char *var, const char *value, void *cb)
-{
-	return parse_submodule_config_option(var, value);
-}
-
 struct submodule_update_clone {
 	/* states */
 	int count;
@@ -707,6 +811,7 @@ static struct cmd_struct commands[] = {
 	{"update-clone", update_clone},
 	{"resolve-relative-url", resolve_relative_url},
 	{"resolve-relative-url-test", resolve_relative_url_test},
+	{"init", module_init}
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 615ef9b..6fce0dc 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -398,45 +398,8 @@ cmd_init()
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-		name=$(git submodule--helper name "$sm_path") || exit
-
-		displaypath=$(relative_path "$sm_path")
-
-		# Copy url setting when it is not set yet
-		if test -z "$(git config "submodule.$name.url")"
-		then
-			url=$(git config -f .gitmodules submodule."$name".url)
-			test -z "$url" &&
-			die "$(eval_gettext "No url found for submodule path '\$displaypath' in .gitmodules")"
-
-			# Possibly a url relative to parent
-			case "$url" in
-			./*|../*)
-				url=$(git submodule--helper resolve-relative-url "$url") || exit
-				;;
-			esac
-			git config submodule."$name".url "$url" ||
-			die "$(eval_gettext "Failed to register url for submodule path '\$displaypath'")"
 
-			say "$(eval_gettext "Submodule '\$name' (\$url) registered for path '\$displaypath'")"
-		fi
-
-		# Copy "update" setting when it is not set yet
-		if upd="$(git config -f .gitmodules submodule."$name".update)" &&
-		   test -n "$upd" &&
-		   test -z "$(git config submodule."$name".update)"
-		then
-			case "$upd" in
-			checkout | rebase | merge | none)
-				;; # known modes of updating
-			*)
-				echo >&2 "warning: unknown update mode '$upd' suggested for submodule '$name'"
-				upd=none
-				;;
-			esac
-			git config submodule."$name".update "$upd" ||
-			die "$(eval_gettext "Failed to register update mode for submodule path '\$displaypath'")"
-		fi
+		git submodule--helper init ${GIT_QUIET:+--quiet} "$sm_path" || exit
 	done
 }
 
-- 
2.7.0.rc0.45.g0dba895.dirty
