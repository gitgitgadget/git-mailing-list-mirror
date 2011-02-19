From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 07/72] gettextize: git-clone "Cloning into" message
Date: Sat, 19 Feb 2011 19:23:50 +0000
Message-ID: <1298143495-3681-8-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:26:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsRL-00021o-8g
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853Ab1BSTZy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:25:54 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41634 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484Ab1BSTZy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:25:54 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2346667eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=/9mTW/Fw+UMgxQaSdgcM5gYC6LCoScAQI1tnCOksVIQ=;
        b=HsybVhUNjecKNt0l98M6aj3das1D8RF897zA06+8uGRYAEY3AQb2uC+jnPi3it72qJ
         JQcKZRsVwf92x38d9Ck9BfYXAXrOTZm2g/2Q4KYSOjQXpGa0tVKPsoypX8blX6abm0jx
         RubjZsbmjTca6N+FhjQzrXnSwlSSQrZkU0SOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=TyvQpVFDuflcgqXfx4IUBdRH4aRG6TKPs74IdtS7/eixQ/hEpdVFCkTJ7BSgG0Dezo
         QZyWlaKPBk/l4paxFfrKvyITk/McWbv1UE9dDwXJjNEBTj7uJFJ9rlFgdl5vCD7B+Io6
         SLMCt3SuH1D/vadDgIfoEIMjL4L5pickP7MJU=
Received: by 10.14.120.142 with SMTP id p14mr2426351eeh.13.1298143553363;
        Sat, 19 Feb 2011 11:25:53 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.25.52
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:25:52 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167314>

Split up the "Cloning into %s" and "Cloning into bare repository %s"
messages to make them easier to translate.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/clone.c  |    9 ++++++---
 t/t5601-clone.sh |    2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f46d09b..dffcf80 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -468,9 +468,12 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		die(_("could not create leading directories of '%s'"), git_dir);
 	set_git_dir(make_absolute_path(git_dir));
=20
-	if (0 <=3D option_verbosity)
-		printf("Cloning into %s%s...\n",
-		       option_bare ? "bare repository " : "", dir);
+	if (0 <=3D option_verbosity) {
+		if (option_bare)
+			printf(_("Cloning into bare repository %s\n"), dir);
+		else
+			printf(_("Cloning into %s\n"), dir);
+	}
 	init_db(option_template, INIT_DB_QUIET);
=20
 	/*
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 987e0c8..ecb499d 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -31,7 +31,7 @@ test_expect_success 'clone with excess parameters (2)=
' '
=20
 '
=20
-test_expect_success 'output from clone' '
+test_expect_success NO_GETTEXT_POISON 'output from clone' '
 	rm -fr dst &&
 	git clone -n "file://$(pwd)/src" dst >output &&
 	test $(grep Clon output | wc -l) =3D 1
--=20
1.7.2.3
