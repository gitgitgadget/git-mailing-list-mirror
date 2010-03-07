From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/18] shortlog: use RUN_SETUP_GENTLY
Date: Sun,  7 Mar 2010 11:55:54 +0700
Message-ID: <1267937767-12504-6-git-send-email-pclouds@gmail.com>
References: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 06:00:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8b0-0000K9-53
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422Ab0CGE7q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Mar 2010 23:59:46 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49858 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab0CGE7p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 23:59:45 -0500
Received: by mail-pw0-f46.google.com with SMTP id 8so3156711pwj.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 20:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=BFpSJjYShtzIFwn4st9BFHFMLmHOiHV6rx+ncQ0yZSo=;
        b=OyVlot/SbjwmPAQShufjNrOADtwdhhOF99MujbCm1fwbwwol1Q5SpWlMkCeYJ+bPVP
         RFDvWYG3BxFszUvuaHICYY++p0pWMm9aZxJ+uy95Ew2FicOznPQr7x1FFk5dccgDUUQo
         wmUOEYXRejYDZqMaqd51T1QTsWTzQIxXGloTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=V6SOoGDhrbbl8VXWn733FA0TAKFNjaX3yQEbc3NzbdQ4gRCRkigoOpc6c7aUqdqmmI
         t7RXpGQj5WTgppDGegyijMKu+ndBrAX69pKLaSQG4YqOPIKtix4Xpx0c86Wx+LCEAxx8
         PL4FoPl3PC29swXgsmBAhnXmrReUVeN6TvA0g=
Received: by 10.141.53.12 with SMTP id f12mr2003909rvk.188.1267937985272;
        Sat, 06 Mar 2010 20:59:45 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 20sm3279051pzk.3.2010.03.06.20.59.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 20:59:44 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 11:56:29 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141650>

shortlog has USE_PAGER set. setup_pager() may read config even
setup_git_dir* is not run yet. This tries to find a repository before
the config is read.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/shortlog.c |    4 +---
 git.c              |    2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 06320f5..bdf3402 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -249,7 +249,6 @@ int cmd_shortlog(int argc, const char **argv, const=
 char *prefix)
 {
 	static struct shortlog log;
 	static struct rev_info rev;
-	int nongit;
=20
 	static const struct option options[] =3D {
 		OPT_BOOLEAN('n', "numbered", &log.sort_by_number,
@@ -265,7 +264,6 @@ int cmd_shortlog(int argc, const char **argv, const=
 char *prefix)
=20
 	struct parse_opt_ctx_t ctx;
=20
-	prefix =3D setup_git_directory_gently(&nongit);
 	git_config(git_default_config, NULL);
 	shortlog_init(&log);
 	init_revisions(&rev, prefix);
@@ -292,7 +290,7 @@ parse_done:
 	log.user_format =3D rev.commit_format =3D=3D CMIT_FMT_USERFORMAT;
=20
 	/* assume HEAD if from a tty */
-	if (!nongit && !rev.pending.nr && isatty(0))
+	if (startup_info->have_repository && !rev.pending.nr && isatty(0))
 		add_head_to_pending(&rev);
 	if (rev.pending.nr =3D=3D 0) {
 		if (isatty(0))
diff --git a/git.c b/git.c
index 2069ef3..29489e6 100644
--- a/git.c
+++ b/git.c
@@ -374,7 +374,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
 		{ "rm", cmd_rm, RUN_SETUP },
 		{ "send-pack", cmd_send_pack, RUN_SETUP },
-		{ "shortlog", cmd_shortlog, USE_PAGER },
+		{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
 		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
--=20
1.7.0.195.g637a2
