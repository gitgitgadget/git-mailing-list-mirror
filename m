From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/12 v2] apply: run setup_git_directory_gently() sooner
Date: Mon, 16 Aug 2010 10:36:12 +1000
Message-ID: <1281918972-27207-1-git-send-email-pclouds@gmail.com>
References: <20100806030844.GJ22369@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>, avarab@gmail.com,
	Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 16 02:36:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oknh0-0005aY-1v
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 02:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762Ab0HPAg2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 20:36:28 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62667 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab0HPAg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 20:36:28 -0400
Received: by pvg2 with SMTP id 2so1693420pvg.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 17:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=C48Rn2Zol4VOfboEY5Pg3nuj6v6NsY0RquCG6yXoKts=;
        b=GScorNN3pGzajmCB3ecaQ4rVpbzKS4+NrgF7+bp1c7IQkTEijReV60rrIn1Maa7Le1
         l85EkqIPETkU1csyGvsEX4ZYFOzSul0u30EINrbjqT4ObF1F9uVSNZo2jjNhRlMuRN3U
         2S+TEuq+rtHxLins5y44Rtjzq61ZEz33d2xfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dJqfJaaISUj52CzG+3R+hL91tGqFVMGv0K0+0x7RRdFPSRCR9Kgyxd4i+h/qNlnc8N
         JGRJ9Ohc6NjwmWz5boDJEn5hpHwTEi+iX7r/oN2UDplkwYsQn2MSdRk1Kawb1W6Rw7at
         wVtHBxDl8z8cFG3rgqGJEkBLExB+Q4OSFQ6R0=
Received: by 10.114.74.19 with SMTP id w19mr5349909waa.143.1281918987581;
        Sun, 15 Aug 2010 17:36:27 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id s5sm11006165wak.12.2010.08.15.17.36.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Aug 2010 17:36:25 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 16 Aug 2010 10:36:19 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <20100806030844.GJ22369@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153634>

As v1.7.2~16^2 (2010-07-14) explains, without this change,
=E2=80=9Cgit --paginate apply=E2=80=9D can ignore the repository-local
=E2=80=9C[core] pager=E2=80=9D configuration.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 This is a replacement for 4ce097c (apply: run
 setup_git_directory_gently() sooner) in pu, branch jn/paginate-fix,
 which fixes prefix loss in 4ce097c.

 All tests seem to run ok for me.

 builtin/apply.c  |    6 +++---
 git.c            |    2 +-
 t/t7006-pager.sh |    3 +++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 12ef9ea..f005ba1 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3607,11 +3607,11 @@ static int option_parse_directory(const struct =
option *opt,
 	return 0;
 }
=20
-int cmd_apply(int argc, const char **argv, const char *unused_prefix)
+int cmd_apply(int argc, const char **argv, const char *prefix_)
 {
 	int i;
 	int errs =3D 0;
-	int is_not_gitdir;
+	int is_not_gitdir =3D !startup_info->have_repository;
 	int binary;
 	int force_apply =3D 0;
=20
@@ -3684,7 +3684,7 @@ int cmd_apply(int argc, const char **argv, const =
char *unused_prefix)
 		OPT_END()
 	};
=20
-	prefix =3D setup_git_directory_gently(&is_not_gitdir);
+	prefix =3D prefix_;
 	prefix_length =3D prefix ? strlen(prefix) : 0;
 	git_config(git_apply_config, NULL);
 	if (apply_default_whitespace)
diff --git a/git.c b/git.c
index 5a47bfb..38dbe70 100644
--- a/git.c
+++ b/git.c
@@ -301,7 +301,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "annotate", cmd_annotate, RUN_SETUP },
-		{ "apply", cmd_apply },
+		{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 		{ "archive", cmd_archive },
 		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP | NEED_WORK_TREE }=
,
 		{ "blame", cmd_blame, RUN_SETUP },
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index bb95335..6c86d70 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -391,4 +391,7 @@ test_no_local_config_subdir expect_success 'git sho=
rtlog'
 test_default_pager        expect_success 'git -p shortlog'
 test_core_pager_subdir    expect_success 'git -p shortlog'
=20
+test_core_pager_subdir    expect_success test_must_fail \
+					 'git -p apply </dev/null'
+
 test_done
--=20
1.7.1.rc1.69.g24c2f7
