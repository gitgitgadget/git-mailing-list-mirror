From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 17/21] clone: allow ref storage backend to be set for clone
Date: Fri,  5 Feb 2016 14:44:18 -0500
Message-ID: <1454701462-3817-18-git-send-email-dturner@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Feb 05 20:45:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmJy-0001oO-7x
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476AbcBETp0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 14:45:26 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35649 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755303AbcBETpD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:45:03 -0500
Received: by mail-qk0-f179.google.com with SMTP id o6so38411881qkc.2
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uX3fgDUPOrKQybwsHMKyH7e7pef7ob4F40CLpeNRQjA=;
        b=ib2cya3q4+6NY0dfO3YbRp+VjMZmQrP6FN0Ih/fErrGbGikzz0FdsmOSBKms+OdW40
         D9Ir31m1Q4JTWoeXer1aysiQfTxu0KPxOAqhWsl1mH9o0RQDve4lJMQSnZ+aXtRwna9f
         JvMbJCYjrIhBr7VF6qPDhfoUJi1jLlg/ur5RsFFBtgBWw163OmU3jbp5hKFAGZ52qQW9
         vYnA+/ASER3oy0IeuK3pT/jaRVFBWLZiz00wgdFU9URSNwdi7bIyw9cl+A+Q2JuPpP4d
         f2KOZ+DspxcOi3pm87ZKkHOCpOGJDxA3cNCpMegdhJ/lkTneaFVMLGqkaROM6vvMEryo
         LBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=uX3fgDUPOrKQybwsHMKyH7e7pef7ob4F40CLpeNRQjA=;
        b=EgMOrW9Wmy5xJ7z0KI+R2YzkZrKZmSj0MwzqbFPNlOQIl3b88aSlv9WTFtszaS5rf9
         B4a6F/6cus1G0GFnZh2QceGq0t3ge55F4ffGfRjg+FV/GDhoWEjUYjhQpjt3Tq6B03zU
         KsiaEtEDwwZ2crv7+rIaiWpxnnv0eAqdDK2tme+ApC+zPcXs5zyHGq46UC3fql5cqXrP
         9tUHCM0rGLlKYNRpkFfTVwE24OAxPUWGXhHpEYpVSurZ7aUBiqC2HMCNC5gc8XR7zYY3
         NFG2cAdRRYBY8BIlvGdAsu1cJUQNfBKOo1ixTU8jH4eYe2ZqCNmIZeMGfST8fm4nkW/+
         jRlg==
X-Gm-Message-State: AG10YOTOKwqUv8I3/hB9pRDOvmU9WMsCeV1G27VjESkPIEktIq6E/efAv4RD26pjEqnsdg==
X-Received: by 10.55.71.143 with SMTP id u137mr18863025qka.1.1454701502132;
        Fri, 05 Feb 2016 11:45:02 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g109sm8565535qgg.40.2016.02.05.11.45.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 11:45:01 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285616>

Add a new option, --ref-storage, to allow the ref storage backend to
be set on new clones.

Submodules must use the same ref storage as the parent repository, so
we also pass the --ref-storage option option when cloning
submodules.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-clone.txt            |  5 +++++
 builtin/clone.c                        |  5 +++++
 builtin/submodule--helper.c            |  2 +-
 contrib/completion/git-completion.bash |  1 +
 git-submodule.sh                       | 13 +++++++++++++
 5 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 45d74be..68f56a7 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository=
>]
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
+	  [--ref-storage=3D<name>]
 	  [--recursive | --recurse-submodules] [--jobs <n>] [--] <repository>
 	  [<directory>]
=20
@@ -224,6 +225,10 @@ objects from the source repository into a pack in =
the cloned repository.
 	The number of submodules fetched at the same time.
 	Defaults to the `submodule.fetchJobs` option.
=20
+--ref-storage=3D<name>::
+	Type of ref storage backend. Default is to use the original files
+	based ref storage.
+
 <repository>::
 	The (possibly remote) repository to clone from.  See the
 	<<URLS,URLS>> section below for more information on specifying
diff --git a/builtin/clone.c b/builtin/clone.c
index 191f522..5ba0514 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -95,6 +95,8 @@ static struct option builtin_clone_options[] =3D {
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=3Dvalue"),
 			N_("set config inside the new repository")),
+	OPT_STRING(0, "ref-storage", &ref_storage_backend,
+		   N_("name"), N_("name of backend type to use")),
 	OPT_END()
 };
=20
@@ -733,6 +735,9 @@ static int checkout(void)
 		if (max_jobs !=3D -1)
 			argv_array_pushf(&args, "--jobs=3D%d", max_jobs);
=20
+		argv_array_pushl(&args, "--ref-storage",
+				 ref_storage_backend, NULL);
+
 		err =3D run_command_v_opt(args.argv, RUN_GIT_CMD);
 		argv_array_clear(&args);
 	}
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 689c354..879d6fb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -457,7 +457,7 @@ static int clone_submodule(const char *path, const =
char *gitdir, const char *url
 		argv_array_pushl(&cp.args, "--reference", reference, NULL);
 	if (gitdir && *gitdir)
 		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
-
+	argv_array_pushl(&cp.args, "--ref-storage", ref_storage_backend, NULL=
);
 	argv_array_push(&cp.args, url);
 	argv_array_push(&cp.args, path);
=20
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 0138d03..cb9c473 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1092,6 +1092,7 @@ _git_clone ()
 			--depth
 			--single-branch
 			--branch
+			--ref-storage=3D
 			"
 		return
 		;;
diff --git a/git-submodule.sh b/git-submodule.sh
index 6fce0dc..e7ac98b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -527,6 +527,14 @@ cmd_update()
 		--checkout)
 			update=3D"checkout"
 			;;
+		--ref-storage=3D*)
+			ref_storage=3D"$1"
+			;;
+		--ref-storage)
+			case "$2" in '') usage ;; esac
+			ref_storage=3D"$2"
+			shift
+			;;
 		--depth)
 			case "$2" in '') usage ;; esac
 			depth=3D"--depth=3D$2"
@@ -560,6 +568,11 @@ cmd_update()
 	if test -n "$init"
 	then
 		cmd_init "--" "$@" || return
+	else
+		if test -n "$ref_storage"
+		then
+			usage
+		fi
 	fi
=20
 	git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
--=20
2.4.2.749.g730654d-twtrsrc
