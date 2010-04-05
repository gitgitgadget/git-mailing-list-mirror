From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/43] shortlog: use RUN_SETUP_GENTLY
Date: Mon,  5 Apr 2010 20:40:50 +0200
Message-ID: <1270492888-26589-6-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:42:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrFd-0005ZJ-OD
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898Ab0DESly convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:41:54 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:56613 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755864Ab0DESlw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:41:52 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1459660qwh.37
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=NYxBK/qjDMfYmpT7kA3WErBhv7h0Lh0GcAG5l+my8N0=;
        b=JDPVOrenSsoYUBQdrjlyUcWZ89f6WZL1nguury14X/65k5ar0A510qIJNUQ9wgnP3D
         HxF303eLl+hzoG2Et9KVuM71noTCeDweUSm+jTGTR9XdOSAmfnz6mHKSMTzf8Spt6+zv
         6pvj4/d+2kFzySRBLWTXTr+m55/7OVXefR38s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UkFHLtgylHKuIl0DHC/4zMVXXCHn7R4lonaI6k+3ZczqF0LxSm4eW+EVzIDFJqoJb1
         dtLZbjt18w7oEfCY2CSZSrRdJvD8tcYczOwlFfyVF0y1887aOtQdcW5o91/nYNiiRrOI
         e2yl6Ngc2zRYWaW5nd+N+CXjFGOm+N77f4JQY=
Received: by 10.224.80.69 with SMTP id s5mr2163045qak.97.1270492911010;
        Mon, 05 Apr 2010 11:41:51 -0700 (PDT)
Received: from dektop ([72.14.241.40])
        by mx.google.com with ESMTPS id 21sm7188973qyk.13.2010.04.05.11.41.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:41:50 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:41:46 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144003>

shortlog has USE_PAGER set. setup_pager() may read config even
setup_git_dir* is not run yet. This tries to find a repository before
the config is read.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.7.0.rc1.541.g2da82.dirty
