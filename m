From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 9/9] config: run setup before commiting pager choice
Date: Mon, 12 Apr 2010 21:31:24 -0500
Message-ID: <20100413023124.GI4118@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 04:31:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1VuV-0000S6-TK
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 04:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669Ab0DMCb0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 22:31:26 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45992 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559Ab0DMCbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 22:31:25 -0400
Received: by gyg13 with SMTP id 13so3220058gyg.19
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 19:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=V4hAcWlAM9vu5t89DaTCd3GfPDzLuzm7HGIf1yeF4Bg=;
        b=P4RWnmh+WimtYkD7YaG+7FDvysJFYoKUikyqT8yoMSHwK1Eins7dMNm2pH+F6Jrp0H
         J1uFKVT4JpiRDGbNnH1Ud1ZWnnEEYfL8Upl9AG9qXxkQ34sJjH8UjyHTZ7L0LHRsyUyD
         q0x3erD3KKaIc31LsMurgn7f4pq70TyrnVeoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=NpanSg4ELoEUuQXqxLoFskILRRoujwfgVU+g4TAS01Dac9YXmKa7KNXJIrsvqdccKB
         WIiJn00FvBxWNiUK0M15OIDpobcF6ssWhBTsY0ftDyvXUGBtycVEQtCwAlf4ryiMnGI5
         YQnMyrTJeo10ArPx9PPtuGgwYutUugbTmcmQQ=
Received: by 10.151.18.10 with SMTP id v10mr4448535ybi.51.1271125883909;
        Mon, 12 Apr 2010 19:31:23 -0700 (PDT)
Received: from progeny.tock (wireless-239-104.uchicago.edu [128.135.239.104])
        by mx.google.com with ESMTPS id 21sm4514778iwn.7.2010.04.12.19.31.23
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 19:31:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100413021153.GA3978@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144788>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

=46or the pager choice (and the choice to paginate in the first place)
to reflect the current repository configuration, the repository
needs to be searched for first.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That=E2=80=99s the end of the mini-series.  I hope you enjoyed reading =
it as
much as I did adapting it.

Looking forward to your thoughts,
Jonathan

 builtin/config.c |    6 ++----
 git.c            |    4 ++--
 t/t7006-pager.sh |   16 ++++++++++------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 4bc46b1..ecc8f87 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -326,11 +326,9 @@ static int get_colorbool(int print)
 		return get_colorbool_found ? 0 : 1;
 }
=20
-int cmd_config(int argc, const char **argv, const char *unused_prefix)
+int cmd_config(int argc, const char **argv, const char *prefix)
 {
-	int nongit;
 	char *value;
-	const char *prefix =3D setup_git_directory_gently(&nongit);
=20
 	config_exclusive_filename =3D getenv(CONFIG_ENVIRONMENT);
=20
@@ -409,7 +407,7 @@ int cmd_config(int argc, const char **argv, const c=
har *unused_prefix)
 	}
 	else if (actions =3D=3D ACTION_EDIT) {
 		check_argc(argc, 0, 0);
-		if (!config_exclusive_filename && nongit)
+		if (!config_exclusive_filename && !startup_info->have_repository)
 			die("not in a git directory");
 		git_config(git_default_config, NULL);
 		launch_editor(config_exclusive_filename ?
diff --git a/git.c b/git.c
index 56e93cf..0a0d9eb 100644
--- a/git.c
+++ b/git.c
@@ -309,7 +309,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
-		{ "config", cmd_config },
+		{ "config", cmd_config, RUN_SETUP_GENTLY },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff },
@@ -366,7 +366,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "remote", cmd_remote, RUN_SETUP },
 		{ "replace", cmd_replace, RUN_SETUP },
-		{ "repo-config", cmd_config },
+		{ "repo-config", cmd_config, RUN_SETUP_GENTLY },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "reset", cmd_reset, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 237a689..e58b14d 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -80,7 +80,7 @@ test_expect_success TTY 'git rev-list uses a pager if=
 configured to' '
 git config --unset pager.rev-list
=20
 rm -f paginated.out
-test_expect_failure TTY 'git config uses a pager if configured to' '
+test_expect_success TTY 'git config uses a pager if configured to' '
 	git config pager.config true &&
 	test_terminal git config --list &&
 	test -e paginated.out
@@ -172,7 +172,7 @@ test_pager_choice() {
 	fi
=20
 	unset PAGER GIT_PAGER
-	git config --unset core.pager
+	git --no-pager config --unset core.pager
 	rm -f default_pager_used
 	test_expect_success SIMPLEPAGER "$cmd - default pager is used by defa=
ult" "
 		cat > $less <<-\EOF &&
@@ -185,7 +185,7 @@ test_pager_choice() {
 	"
=20
 	unset GIT_PAGER
-	git config --unset core.pager
+	git --no-pager config --unset core.pager
 	rm -f PAGER_used
 	test_expect_success TTY "$cmd - PAGER overrides default pager" "
 		PAGER=3D'wc > PAGER_used' &&
@@ -199,7 +199,7 @@ test_pager_choice() {
 	$test_expectation TTY "$cmd - core.pager ${used_if_wanted}" "
 		PAGER=3Dwc &&
 		export PAGER &&
-		git config core.pager 'wc > core.pager_used' &&
+		git --no-pager config core.pager 'wc > core.pager_used' &&
 		$full_cmd &&
 		${if_want_local_config}test -e core.pager_used
 	"
@@ -211,7 +211,7 @@ test_pager_choice() {
 		PAGER=3Dwc &&
 		stampname=3D\$(pwd)/core.pager_used &&
 		export PAGER stampname &&
-		git config core.pager 'wc > \"\$stampname\"' &&
+		git --no-pager config core.pager 'wc > \"\$stampname\"' &&
 		mkdir sub &&
 		(
 			cd sub &&
@@ -222,7 +222,7 @@ test_pager_choice() {
=20
 	rm -f GIT_PAGER_used
 	test_expect_success TTY "$cmd - GIT_PAGER overrides core.pager" "
-		git config core.pager wc &&
+		git --no-pager config core.pager wc &&
 		GIT_PAGER=3D'wc > GIT_PAGER_used' &&
 		export GIT_PAGER &&
 		$full_cmd &&
@@ -259,4 +259,8 @@ doesnt_paginate 'git rev-list HEAD'
 git config pager.rev-list true
 test_pager_choice 'git rev-list HEAD'
=20
+doesnt_paginate 'git config -l'
+git config pager.config true
+test_pager_choice 'git config -l'
+
 test_done
--=20
1.7.0.4
