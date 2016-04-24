From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2] hooks: Add ability to specify where the hook directory is
Date: Sun, 24 Apr 2016 21:18:22 +0000
Message-ID: <1461532702-4045-1-git-send-email-avarab@gmail.com>
References: <CACBZZX7jTHqSq0ADJxO0cP+1MZMWAowLMMj4J0NHkFTYOYsJiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 23:18:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auRQM-0001Co-SX
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 23:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbcDXVSf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 17:18:35 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36293 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbcDXVSe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 17:18:34 -0400
Received: by mail-wm0-f47.google.com with SMTP id v188so77169321wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ODy9rHNgM5E03aJL2VmvhFUrNv9PBBcUTbQqV3u2YSc=;
        b=qjpur7SpfnNP4DwDd3Xpotr3cHh9wnEeEh0BNDc1CXUhq1YCHDaY5iUb9oMRmqjZV6
         3yabTaZpYtM6Eg2pxBQkGeN1pup77Inz7tv4XF49Pn8bQY8K0OrAoYci7tDdlTjciA5V
         kPurIuhLYDkM8Hvic318STn5fjTn+LuIKUPfM9V8dh9/aXefXI3/CWeHRTVjlbA8lkp5
         q9RcigFCoZQ0F0bNK5XBbkvdVSLzsR12lA80R0XoHBqx90bk6/fSBkkVcUgMxdnf7L60
         s2ZC7Tha3LuifogAznbMS1XygrLacw2YoMSZzTAWU2PNHphE7R4/d2rQpF9hgG4K83TG
         U6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ODy9rHNgM5E03aJL2VmvhFUrNv9PBBcUTbQqV3u2YSc=;
        b=NonquPljZSE4VzOEBhEW0H2XiKH7ZHODEcHZzxgo3UFZ1oec+umItTX/BqxRolR5/H
         vYZxpBsI3EHDl3ruN0hH37B+TwqYjrpp/o7jFH/Q6mGh6tH7KO3P2WXW2Ds/EtVtM1bc
         xYpN0x9Pjq7f7m8nzmtqOg0ipZSk48nhXk7G3TQUz4fM60XhQNBR3cz3FiKunIE2OMhA
         pO4tSZ31t+WQb2X5LFZqwLt+bLJ8U9IcKJzJjCpxRyl7mi+CRiXoXHzL4vBsM2+XKDE0
         P54jzW4l0sghd6s4wy22oalKemkJIi29Xo4E3uP9LVRndweq2vX0eSkWTtu3OG/23cf/
         QlsQ==
X-Gm-Message-State: AOPr4FWXFhJaUJwgmVsQMOW/JjagDOw8uKEw5PMLa3SnJWgH5PCoIHrsRmcijnPzj5N7uw==
X-Received: by 10.28.232.212 with SMTP id f81mr9084459wmi.27.1461532712993;
        Sun, 24 Apr 2016 14:18:32 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a75sm15485441wme.18.2016.04.24.14.18.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Apr 2016 14:18:31 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <CACBZZX7jTHqSq0ADJxO0cP+1MZMWAowLMMj4J0NHkFTYOYsJiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292444>

Change the hardcoded lookup for .git/hooks/* to optionally lookup in
$(git config core.hooksPath)/* instead.

This is essentially a more intrusive version of the git-init ability to
specify hooks on init time via init templates.

The difference between that facility and this feature is that this can
be set up after the fact via e.g. ~/.gitconfig or /etc/gitconfig to
apply for all your personal repositories, or all repositories on the
system.

I plan on using this on a centralized Git server where users can create
arbitrary repositories under /gitroot, but I'd like to manage all the
hooks that should be run centrally via a unified dispatch mechanism.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

This is based off the githooks.txt series I just sent, I thought it
made the most sense to address the questions the previous version
raised about how we treat the working directory with unrelated
githooks.txt doc improvements.

This version also address all the other issues SZEDER G=C3=A1bor noted.

 Documentation/config.txt     | 17 +++++++++++++++++
 Documentation/githooks.txt   | 12 ++++++++----
 cache.h                      |  1 +
 config.c                     |  3 +++
 environment.c                |  1 +
 run-command.c                |  5 ++++-
 t/t1350-config-hooks-path.sh | 33 +++++++++++++++++++++++++++++++++
 7 files changed, 67 insertions(+), 5 deletions(-)
 create mode 100755 t/t1350-config-hooks-path.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 42d2b50..6a079c1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -618,6 +618,23 @@ core.attributesFile::
 	$XDG_CONFIG_HOME/git/attributes. If $XDG_CONFIG_HOME is either not
 	set or empty, $HOME/.config/git/attributes is used instead.
=20
+core.hooksPath::
+	By default Git will look for your hooks in the
+	'$GIT_DIR/hooks' directory. Set this to different path,
+	e.g. '/etc/git/hooks', and Git will try to find your hooks in
+	that directory, e.g. '/etc/git/hooks/pre-receive' instead of
+	in '$GIT_DIR/hooks/pre-receive'.
++
+The path can either be absolute or relative. In the latter case see
+the discussion in the "DESCRIPTION" section of linkgit:githooks[5]
+about what the relative path will be relative to.
++
+This configuration is useful in cases where you'd like to
+e.g. centrally configure your Git hooks instead of configuring them on
+a per-repository basis, or a more flexible and centralized alterantive
+having an `init.templateDir` where you've changed the 'hooks'
+directory.
+
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
 	messages by launching an editor uses the value of this
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d30492c..3b1591f 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -7,15 +7,19 @@ githooks - Hooks used by Git
=20
 SYNOPSIS
 --------
-$GIT_DIR/hooks/*
+$GIT_DIR/hooks/* (or `git config core.hooksPath`/*)
=20
=20
 DESCRIPTION
 -----------
=20
-Hooks are programs you can place in the `$GIT_DIR/hooks` directory to
-trigger action at certain points. Hooks that don't have the executable
-bit set are ignored.
+Hooks are programs you can place in a hooks directory to trigger actio=
n
+at certain points. Hooks that don't have the executable bit set are
+ignored.
+
+By default the hooks directory is `$GIT_DIR/hooks`, but that can be
+changed via the `core.hooksPath` configuration variable (see
+linkgit:git-config[1]).
=20
 When a hook is called in a non-bare repository the working directory
 is guaranteed to be the root of the working tree, in a bare repository
diff --git a/cache.h b/cache.h
index 2711048..4f7d222 100644
--- a/cache.h
+++ b/cache.h
@@ -654,6 +654,7 @@ extern int warn_on_object_refname_ambiguity;
 extern const char *apply_default_whitespace;
 extern const char *apply_default_ignorewhitespace;
 extern const char *git_attributes_file;
+extern const char *git_hooks_path;
 extern int zlib_compression_level;
 extern int core_compression_level;
 extern int core_compression_seen;
diff --git a/config.c b/config.c
index 10b5c95..51f80e4 100644
--- a/config.c
+++ b/config.c
@@ -717,6 +717,9 @@ static int git_default_core_config(const char *var,=
 const char *value)
 	if (!strcmp(var, "core.attributesfile"))
 		return git_config_pathname(&git_attributes_file, var, value);
=20
+	if (!strcmp(var, "core.hookspath"))
+		return git_config_pathname(&git_hooks_path, var, value);
+
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg =3D git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 57acb2f..2857e3f 100644
--- a/environment.c
+++ b/environment.c
@@ -31,6 +31,7 @@ const char *git_log_output_encoding;
 const char *apply_default_whitespace;
 const char *apply_default_ignorewhitespace;
 const char *git_attributes_file;
+const char *git_hooks_path;
 int zlib_compression_level =3D Z_BEST_SPEED;
 int core_compression_level;
 int core_compression_seen;
diff --git a/run-command.c b/run-command.c
index 8c7115a..39d7237 100644
--- a/run-command.c
+++ b/run-command.c
@@ -815,7 +815,10 @@ const char *find_hook(const char *name)
 	static struct strbuf path =3D STRBUF_INIT;
=20
 	strbuf_reset(&path);
-	strbuf_git_path(&path, "hooks/%s", name);
+	if (git_hooks_path)
+		strbuf_addf(&path, "%s/%s", git_hooks_path, name);
+	else
+		strbuf_git_path(&path, "hooks/%s", name);
 	if (access(path.buf, X_OK) < 0)
 		return NULL;
 	return path.buf;
diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.s=
h
new file mode 100755
index 0000000..31461aa
--- /dev/null
+++ b/t/t1350-config-hooks-path.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+test_description=3D'Test the core.hooksPath configuration variable'
+
+. ./test-lib.sh
+
+test_expect_success 'set up a pre-commit hook in core.hooksPath' '
+	mkdir -p .git/custom-hooks .git/hooks &&
+	write_script .git/custom-hooks/pre-commit <<EOF &&
+printf "%s" "." >>.git/PRE-COMMIT-HOOK-WAS-CALLED
+EOF
+	cat >.git/hooks/pre-commit <<EOF &&
+	write_script .git/hooks/pre-commit &&
+printf "%s" "SHOULD NOT BE CALLED" >>.git/PRE-COMMIT-HOOK-WAS-CALLED
+EOF
+	chmod +x .git/custom-hooks/pre-commit
+'
+
+test_expect_success 'Check that various forms of specifying core.hooks=
Path work' '
+	test_commit no_custom_hook &&
+	git config core.hooksPath .git/custom-hooks &&
+	test_commit have_custom_hook &&
+	git config core.hooksPath .git/custom-hooks/ &&
+	test_commit have_custom_hook_trailing_slash &&
+	git config core.hooksPath "$PWD/.git/custom-hooks" &&
+	test_commit have_custom_hook_abs_path &&
+	git config core.hooksPath "$PWD/.git/custom-hooks/" &&
+	test_commit have_custom_hook_abs_path_trailing_slash &&
+	printf "%s" "...." >.git/PRE-COMMIT-HOOK-WAS-CALLED.expect &&
+	test_cmp .git/PRE-COMMIT-HOOK-WAS-CALLED.expect .git/PRE-COMMIT-HOOK-=
WAS-CALLED
+'
+
+test_done
--=20
2.1.3
