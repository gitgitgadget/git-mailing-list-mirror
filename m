From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] Another reroll of sb/submodule-init
Date: Fri, 15 Apr 2016 17:50:11 -0700
Message-ID: <1460767813-25916-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, pclouds@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 02:50:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arERQ-0004WZ-L5
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 02:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbcDPAuS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Apr 2016 20:50:18 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33641 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbcDPAuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 20:50:16 -0400
Received: by mail-pf0-f176.google.com with SMTP id 184so61874683pff.0
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 17:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oi2CvJytysczlNavREJNFp5dHvyxSKPyBG2uuBNNkBY=;
        b=Rw1flNYetwY1ItTmPaPD8ocGiemYeGZFW/4FoKFmSgrAc7ec3P+YZ9T78Z09DFTVDf
         gVOxAMbTG9QHmc7ucMjreS68xPAHFii/kLJBSZqcPbQSrmPJy0/ZTluAx0ZqGXojM/gw
         wJGBT2GrglqUAEwK/jbv/TwFpjXsr5Fj/eYMpTbWePUzIrq/uUDnJ8VodJQPdC2hdzT+
         dJ3xilYw2T1YEk52AiJMXj7+NJO+WkJj2KGwoEye1AgaM5gIZ3Wb7lJX6X7D6zledoEv
         d9gwqh6Yad8YaDeV8Q4jZBkaQrzZga0CCXN8SmTdzx/2X1nEVfDQ0DSszUrEDFYKSTu8
         B/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oi2CvJytysczlNavREJNFp5dHvyxSKPyBG2uuBNNkBY=;
        b=EhEtofCoXp6PPT+G6XVdRz+AvEshBg42RkZ9dOSY9OivR1wV64UIZfT+77sOTyz46T
         fKyzaUHeJgcF82hlizopGzKrUUY5HTkWQVDhDZavo4yoxTLg68F6yli7MYRXNLM/hGOQ
         EkxYIv6TV9WFF+lZvpE2i5JPEf93azM7nI9zoQfhiaziXZjHVK1eVfpLG0sbYmKywL2/
         T5iN7wANdDWiTk8WgOH9t4ovGaVAJDMul3+2vvCAq0AXAu18PMxXfpfd3m8UhYkAAVOr
         omlHwKXUIkUKQv0c1A4ADC82kxb9GdzhNfOlaYPYm4uumRhzD1eipdWCfatOFM3/tEgb
         IgyA==
X-Gm-Message-State: AOPr4FVK1gnPbuubIxNYogdIQqR1auiDqQu9bFH8a8iLplo6P39GSu44m9SEyG4CXj+YLwZr
X-Received: by 10.98.23.201 with SMTP id 192mr26894584pfx.122.1460767815300;
        Fri, 15 Apr 2016 17:50:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c97d:dddf:ab88:e90])
        by smtp.gmail.com with ESMTPSA id p78sm7621874pfa.75.2016.04.15.17.50.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 15 Apr 2016 17:50:14 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.26.gba39a1b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291709>

* squashed the fixes from Johannes Sixt to unbreak Windows tests.
  (I had encoding issues; so I manually integrated the changes)
* fixed memleaks
* the base to apply did not change (ee30f17805f51d37 Merge branch
'sb/submodule-path-misc-bugs' into sb/submodule-init)

Thanks,
Stefan

diff to current origin/sb/submodule-init:

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ad3cba6..b6d4f27 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -309,8 +309,7 @@ static void init_submodule(const char *path, const =
char *prefix, int quiet)
 {
 	const struct submodule *sub;
 	struct strbuf sb =3D STRBUF_INIT;
-	const char *upd =3D NULL;
-	char *url =3D NULL, *displaypath;
+	char *upd =3D NULL, *url =3D NULL, *displaypath;
=20
 	/* Only loads from .gitmodules, no overlay with .git/config */
 	gitmodules_config();
@@ -340,7 +339,7 @@ static void init_submodule(const char *path, const =
char *prefix, int quiet)
 		/* Possibly a url relative to parent */
 		if (starts_with_dot_dot_slash(url) ||
 		    starts_with_dot_slash(url)) {
-			char *remoteurl;
+			char *remoteurl, *relurl;
 			char *remote =3D get_default_remote();
 			struct strbuf remotesb =3D STRBUF_INIT;
 			strbuf_addf(&remotesb, "remote.%s.url", remote);
@@ -352,9 +351,11 @@ static void init_submodule(const char *path, const=
 char *prefix, int quiet)
 				 * authoritative upstream
 				 */
 				remoteurl =3D xgetcwd();
-			url =3D relative_url(remoteurl, url, NULL);
+			relurl =3D relative_url(remoteurl, url, NULL);
 			strbuf_release(&remotesb);
 			free(remoteurl);
+			free(url);
+			url =3D relurl;
 		}
=20
 		if (git_config_set_gently(sb.buf, url))
@@ -368,14 +369,14 @@ static void init_submodule(const char *path, cons=
t char *prefix, int quiet)
 	/* Copy "update" setting when it is not set yet */
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.update", sub->name);
-	if (git_config_get_string_const(sb.buf, &upd) &&
+	if (git_config_get_string(sb.buf, &upd) &&
 	    sub->update_strategy.type !=3D SM_UPDATE_UNSPECIFIED) {
 		if (sub->update_strategy.type =3D=3D SM_UPDATE_COMMAND) {
 			fprintf(stderr, _("warning: command update mode suggested for submo=
dule '%s'\n"),
 				sub->name);
-			upd =3D "none";
+			upd =3D xstrdup("none");
 		} else
-			upd =3D submodule_strategy_to_string(&sub->update_strategy);
+			upd =3D xstrdup(submodule_strategy_to_string(&sub->update_strategy)=
);
=20
 		if (git_config_set_gently(sb.buf, upd))
 			die(_("Failed to register update mode for submodule path '%s'"), di=
splaypath);
@@ -383,6 +384,7 @@ static void init_submodule(const char *path, const =
char *prefix, int quiet)
 	strbuf_release(&sb);
 	free(displaypath);
 	free(url);
+	free(upd);
 }
=20
 static int module_init(int argc, const char **argv, const char *prefix=
)
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 2e62548..bf2deee 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -305,13 +305,16 @@ test_git_path GIT_COMMON_DIR=3Dbar config        =
           bar/config
 test_git_path GIT_COMMON_DIR=3Dbar packed-refs              bar/packed=
-refs
 test_git_path GIT_COMMON_DIR=3Dbar shallow                  bar/shallo=
w
=20
+# In the tests below, the distinction between $PWD and $(pwd) is impor=
tant:
+# on Windows, $PWD is POSIX style (/c/foo), $(pwd) has drive letter (c=
:/foo).
+
 test_submodule_relative_url "../" "../foo" "../submodule" "../../submo=
dule"
 test_submodule_relative_url "../" "../foo/bar" "../submodule" "../../f=
oo/submodule"
 test_submodule_relative_url "../" "../foo/submodule" "../submodule" ".=
=2E/../foo/submodule"
 test_submodule_relative_url "../" "./foo" "../submodule" "../submodule=
"
 test_submodule_relative_url "../" "./foo/bar" "../submodule" "../foo/s=
ubmodule"
 test_submodule_relative_url "../../../" "../foo/bar" "../sub/a/b/c" ".=
=2E/../../../foo/sub/a/b/c"
-test_submodule_relative_url "../" "$PWD/addtest" "../repo" "$PWD/repo"
+test_submodule_relative_url "../" "$PWD/addtest" "../repo" "$(pwd)/rep=
o"
 test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/sub=
module"
 test_submodule_relative_url "../" "foo" "../submodule" "../submodule"
=20
@@ -322,16 +325,16 @@ test_submodule_relative_url "(null)" "../foo" "..=
/submodule" "../submodule"
 test_submodule_relative_url "(null)" "./foo/bar" "../submodule" "foo/s=
ubmodule"
 test_submodule_relative_url "(null)" "./foo" "../submodule" "submodule=
"
 test_submodule_relative_url "(null)" "//somewhere else/repo" "../subre=
po" "//somewhere else/subrepo"
-test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../subs=
ubsuper_update_r" "$PWD/subsubsuper_update_r"
-test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subsup=
er_update_r" "$PWD/subsuper_update_r"
-test_submodule_relative_url "(null)" "$PWD/." "../." "$PWD/."
-test_submodule_relative_url "(null)" "$PWD" "./." "$PWD/."
-test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$PWD/re=
po"
-test_submodule_relative_url "(null)" "$PWD" "./=C3=A5 =C3=A4=C3=B6" "$=
PWD/=C3=A5 =C3=A4=C3=B6"
-test_submodule_relative_url "(null)" "$PWD/." "../submodule" "$PWD/sub=
module"
-test_submodule_relative_url "(null)" "$PWD/submodule" "../submodule" "=
$PWD/submodule"
-test_submodule_relative_url "(null)" "$PWD/home2/../remote" "../bundle=
1" "$PWD/home2/../bundle1"
-test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" "./.=
" "$PWD/submodule_update_repo/."
+test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../subs=
ubsuper_update_r" "$(pwd)/subsubsuper_update_r"
+test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subsup=
er_update_r" "$(pwd)/subsuper_update_r"
+test_submodule_relative_url "(null)" "$PWD/." "../." "$(pwd)/."
+test_submodule_relative_url "(null)" "$PWD" "./." "$(pwd)/."
+test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$(pwd)/=
repo"
+test_submodule_relative_url "(null)" "$PWD" "./=C3=A5 =C3=A4=C3=B6" "$=
(pwd)/=C3=A5 =C3=A4=C3=B6"
+test_submodule_relative_url "(null)" "$PWD/." "../submodule" "$(pwd)/s=
ubmodule"
+test_submodule_relative_url "(null)" "$PWD/submodule" "../submodule" "=
$(pwd)/submodule"
+test_submodule_relative_url "(null)" "$PWD/home2/../remote" "../bundle=
1" "$(pwd)/home2/../bundle1"
+test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" "./.=
" "$(pwd)/submodule_update_repo/."
 test_submodule_relative_url "(null)" "file:///tmp/repo" "../subrepo" "=
file:///tmp/subrepo"
 test_submodule_relative_url "(null)" "foo/bar" "../submodule" "foo/sub=
module"
 test_submodule_relative_url "(null)" "foo" "../submodule" "submodule"


Stefan Beller (2):
  submodule: port resolve_relative_url from shell to C
  submodule: port init from shell to C

 builtin/submodule--helper.c | 324 ++++++++++++++++++++++++++++++++++++=
+++++++-
 git-submodule.sh            | 127 +----------------
 submodule.c                 |  21 +++
 submodule.h                 |   1 +
 t/t0060-path-utils.sh       |  46 +++++++
 5 files changed, 397 insertions(+), 122 deletions(-)

--=20
2.8.0.26.gba39a1b.dirty
