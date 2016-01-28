From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 2/2] submodule: port init from shell to C
Date: Wed, 27 Jan 2016 18:30:37 -0800
Message-ID: <1453948237-9860-3-git-send-email-sbeller@google.com>
References: <xmqqtwm1e0ps.fsf@gitster.mtv.corp.google.com>
 <1453948237-9860-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, Jens.Lehmann@web.de,
	sunshine@sunshineco.com, j6t@kdbg.org
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 28 03:30:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOcMI-0004QF-7Z
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 03:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967455AbcA1Cat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 21:30:49 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34740 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966722AbcA1Cap (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 21:30:45 -0500
Received: by mail-pf0-f170.google.com with SMTP id o185so10294684pfb.1
        for <git@vger.kernel.org>; Wed, 27 Jan 2016 18:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ycOAuiCL/YRKYCVFtv3PZG/ShrcMnEu6mFss7GHLsSA=;
        b=cWYIxiGjRxsknJ8BO4BPEy+JPQKD0Cl7ZOQvVmOJj41i0QueMRiLjeA6eFkpOuJ9mW
         RHVeFzxGDSjQoeEMv8yOLja26gjac4ruKZ5oJ+WetEcuJ2CGQc/wxSr82Ux+y8dKw1sc
         Go+RdSLYSZrXfnL6A3OA3WrGfSTnTyBvOt98jGENtt5GFdhzMILi9nSFVQfLYpzsmY9J
         VFY8ptz7MH++WUaOVT8AwkthQ8+iQrLEaI7XLDvkhWq21epZi0mN/9QbPFM6p4MIlPbg
         nl8uo7QJ1aMQcNgoNzuZ4sPKLUaTrmK2tWhiMybWXOoTwtMpsaeYB9xEOQvFQc/bZOyC
         tPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ycOAuiCL/YRKYCVFtv3PZG/ShrcMnEu6mFss7GHLsSA=;
        b=F4nSQ4R6USeIvyolD66959uPw7IX3HkYBgewFsKDgQLSyRyTRcvDHluwAH7MYTKU88
         CP0fO2j/GgFu40idVtJeqFo5hjrUzW3tlYrQzEPF0oIUrE8+Ac8EA8iOat9AtLiduxWb
         jNukkZCQ6Llo28WYka1aL0xvBjOdvU2MvYjjsDtXXPxkWYTXkEbxaszyS/Kry6Fm5QQY
         4W2U+oKe0tc2F70wIfhPLvJ8KfpFUXBiQnZ/47jZVmfcLTk5txmuGUpzk9De5x8RYWai
         jWx+7BsPZEQe2EtxrcDsqJvNH4wAOpsnWYp0MtFv0eTnAVVY8wQxNuvzATZ10NZLRT8r
         6vag==
X-Gm-Message-State: AG10YOTzs2u6pt9L2QC9mA8+3FWYdwS1C3fJiJiJaEqa3TLqWuUKNnWkgywHIC9fD9J3qTQf
X-Received: by 10.98.31.8 with SMTP id f8mr867264pff.71.1453948245293;
        Wed, 27 Jan 2016 18:30:45 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:3c3b:fb4a:fb7e:e6b6])
        by smtp.gmail.com with ESMTPSA id n84sm11908417pfa.45.2016.01.27.18.30.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Jan 2016 18:30:44 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.42.ge5f5e2d
In-Reply-To: <1453948237-9860-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284974>

By having the `init` functionality in C, we can reference it easier
from other parts in the code.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 119 ++++++++++++++++++++++++++++++++++++++++++--
 git-submodule.sh            |  39 +--------------
 2 files changed, 115 insertions(+), 43 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 13583d9..689c354 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -214,6 +214,119 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
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
+	char *upd = NULL;
+	char *cwd = xgetcwd();
+	const char *displaypath = relative_path(cwd, prefix, &sb);
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
+			free(remoteurl);
+		}
+
+		if (git_config_set(sb.buf, url))
+			die(_("Failed to register url for submodule path '%s'"),
+			    displaypath);
+		if (!quiet)
+			printf(_("Submodule '%s' (%s) registered for path '%s'\n"),
+				sub->name, url, displaypath);
+	}
+
+	/* Copy "update" setting when it is not set yet */
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "submodule.%s.update", sub->name);
+	if (git_config_get_string(sb.buf, &upd) && sub->update) {
+		upd = xstrdup(sub->update);
+		if (strcmp(sub->update, "checkout") &&
+		    strcmp(sub->update, "rebase") &&
+		    strcmp(sub->update, "merge") &&
+		    strcmp(sub->update, "none")) {
+			fprintf(stderr, _("warning: unknown update mode '%s' suggested for submodule '%s'\n"),
+				upd, sub->name);
+			upd = xstrdup("none");
+		}
+		if (git_config_set(sb.buf, upd))
+			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
+	}
+	strbuf_release(&sb);
+	free(cwd);
+	free(upd);
+	free(url);
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
@@ -459,11 +572,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
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
@@ -709,6 +817,7 @@ static struct cmd_struct commands[] = {
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
2.7.0.rc0.42.ge5f5e2d
