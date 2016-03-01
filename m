From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 26/33] clone: allow ref storage backend to be set for clone
Date: Mon, 29 Feb 2016 19:52:59 -0500
Message-ID: <1456793586-22082-27-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:54:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYa0-0007Nb-Bo
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806AbcCAAyS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 19:54:18 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34936 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532AbcCAAx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:58 -0500
Received: by mail-qk0-f174.google.com with SMTP id o6so63939257qkc.2
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t365DWi+LjXuH4EnzEr1XP6pXGvjBhL0Fa0aXSWZvE8=;
        b=WB8y/PVRe7jdrZ+Fy0trmDvMPP3eQ+WQ6N/PwsCiYe4G6YVOQ/wV0Oi4DqKdxSR6al
         ofF41xp95oR57N1zJGEldL8E+j40BpumN2GT2fSimaocxsAqNYU9tUSLIj1kbrp1lvun
         bVFYVbVrPJLDjUBRV7bTVEcaO2woDWbpd6BrzvKr5oeY6nqjysiATMB7druJmbwyxR/0
         QhyeUTzMJmX32qlAwfJzZSAGiKa6W3GqQdhjfdOGAccvEPkZ3pCTLxnsPjG9Y/Q6f1+X
         esNIMTYJBlr4HXgwyStmx6mLZUS54dAs0NWU4G4K/yGR513qxK63ZHOSW6Zc4pSMGt3A
         Usmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t365DWi+LjXuH4EnzEr1XP6pXGvjBhL0Fa0aXSWZvE8=;
        b=CDGS3ArZhzBQNfEbHOOvRkOoHi/bGVCVYrj1QGk85L0SJ2e/A+1dsFW02mYpP91Nxy
         9wE06KwjdBcmPal2En0e3DW157X54yByA1ipsYb4JwU5NzjICJam1sl22E1fmLwLFJVc
         2IQhGkcHkIvSW3uspNc8qrQGndCaepPYXGZDhWk1H5b7LrIOHlLqL6V6M/pvhPcQY4Wl
         xpaeXOZohrut4dTOWaiXdh2cLtpubqc2OTiFWEwcR6tPBpugS8HUAdty9ApRaR9X9xcN
         Oy+NoZ+7Um+On2q+W5w70OAHtx1Kz1l8qxnAewQ1zhm81iHj56kRVZeVgEWFh9T67Vpz
         6e0w==
X-Gm-Message-State: AD7BkJIOJBS9dYGLoHVslqVKEboJu3aOyNz4yrmWkZwVI2/uUrjNY+957SoI2RiGB07S3Q==
X-Received: by 10.55.73.69 with SMTP id w66mr23235297qka.39.1456793637151;
        Mon, 29 Feb 2016 16:53:57 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:56 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287966>

Add a new option, --ref-storage, to allow the ref storage backend to
be set on new clones.

Submodules must use the same ref storage as the parent repository, so
we also pass the --ref-storage option option when cloning
submodules.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-clone.txt            |  5 +++++
 builtin/clone.c                        |  5 +++++
 builtin/submodule--helper.c            |  2 +-
 contrib/completion/git-completion.bash |  1 +
 git-submodule.sh                       | 13 +++++++++++++
 5 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 9a95c6e..a5a48cb 100644
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
@@ -232,6 +233,10 @@ objects from the source repository into a pack in =
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
index d1c9bcf..ed524e9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -114,6 +114,8 @@ static struct option builtin_clone_options[] =3D {
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 			TRANSPORT_FAMILY_IPV6),
+	OPT_STRING(0, "ref-storage", &ref_storage_backend,
+		   N_("name"), N_("name of backend type to use")),
 	OPT_END()
 };
=20
@@ -752,6 +754,9 @@ static int checkout(void)
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
index ed4f60b..f8cdce9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -444,7 +444,7 @@ static int clone_submodule(const char *path, const =
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
index 850afd0..a0225f4 100644
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
index 3924bff..5562a19 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -545,6 +545,14 @@ cmd_update()
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
@@ -578,6 +586,11 @@ cmd_update()
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
 	{
--=20
2.4.2.767.g62658d5-twtrsrc
