From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 2/2] submodule: port init from shell to C
Date: Tue, 19 Jan 2016 18:03:16 -0800
Message-ID: <1453255396-31942-3-git-send-email-sbeller@google.com>
References: <xmqqa8o188i0.fsf@gitster.mtv.corp.google.com>
 <1453255396-31942-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, j6t@kdbg.org,
	sunshine@sunshineco.com, Jens.Lehmann@web.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 20 03:03:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLi7T-0008AP-Ob
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 03:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934190AbcATCDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 21:03:31 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36781 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933035AbcATCD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 21:03:26 -0500
Received: by mail-pf0-f179.google.com with SMTP id n128so185228675pfn.3
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 18:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AEUZc1ZrOMADW5YDRiP6oKM7VfYyvAIw2twS+srP6UQ=;
        b=jfwnj4HZlfKOJY4awEnVlxZO2P6Jgci+gdgHXiiEPw0yKkOIa3RhU0LUrh9frDLzeR
         QCqs5QUNnFd2OhXykKiB9nwE5vNn6rqEwpE9Gj2PI7W3entYNrvfiFk6LKQbEWNNX3oz
         kh4QOwPiJCGLUXLssumHHKu/x4wWTLDSxe2TyA2UMzZjgANYDde1aCYO/MCHynAYAg4N
         wO3nZTjnlZa4SrNPDXks/f58SUzAT6b/DaG1DAfysqC+qMAiTPdpja/mCDXGce5APh07
         f6GQczSwjE9VpL4Z2QHmBbfMVlZsNipmC5PUxCJo5LfqWcjA3jjCpi2LgHKNXbZ87GIR
         G4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AEUZc1ZrOMADW5YDRiP6oKM7VfYyvAIw2twS+srP6UQ=;
        b=leph9oMG2M766WUBzaJNwiNUYRZVLDTbjEbd1SpPMWCefw1tNa7bNRxPsF4zJmx3GP
         53qWeYNYQx5ZKvxTuQg3ObHnzbdUX+e6ssHuXZVSj7rrU5wzqkjY/4yiea4/m76qtfzH
         j3mcW0oKATcaGcHfefIV8WIWZkQtxStsWD6cvZ1XRI+bDNxWMTTrZMZeZMPBsvCv2zo6
         BMPrfID8iC/ShE6tmChF2CDCIBUQRz85c5kLVmP81joAd0ZMhFQkDyHsy+KAWQVV9aM3
         1RaSdUs8juD6j9suNOjMzeGRiIZcYBWjWUboJuDVDyTIaBb9T0AxT9IiY/rdDXgg1Scw
         UjkQ==
X-Gm-Message-State: ALoCoQmA+DD7aTfbefancqoR+Iy3JUvHJ6apqrAhcrRgK7+MuSNGsikuHgsp/iXi/JtUis4G1SNuxi1Y/lMPsTPjChC5fXk7rQ==
X-Received: by 10.98.1.203 with SMTP id 194mr49762780pfb.10.1453255405618;
        Tue, 19 Jan 2016 18:03:25 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:25db:c0:235a:551d])
        by smtp.gmail.com with ESMTPSA id m70sm44278052pfi.90.2016.01.19.18.03.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 18:03:24 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.44.g6033384.dirty
In-Reply-To: <1453255396-31942-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284415>

By having the `init` functionality in C, we can reference it easier
from other parts in the code.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 115 ++++++++++++++++++++++++++++++++++++++++++--
 git-submodule.sh            |  39 +--------------
 2 files changed, 111 insertions(+), 43 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1484b36..fecc9aa 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -221,6 +221,115 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
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
+	const char *displaypath = relative_path(xgetcwd(), prefix, &sb);;
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
+		url = xstrdup(sub->url); // as overlayed by .gitmodules
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
+			fprintf(stderr, _("Submodule '%s' (%s) registered for path '%s'\n"),
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
@@ -466,11 +575,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
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
@@ -716,6 +820,7 @@ static struct cmd_struct commands[] = {
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
2.7.0.rc0.44.g6033384.dirty
