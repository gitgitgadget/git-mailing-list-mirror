From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH i18n 06/11] i18n: make warn_dangling_symref() automatically append \n
Date: Mon, 16 Apr 2012 19:49:58 +0700
Message-ID: <1334580603-11577-7-git-send-email-pclouds@gmail.com>
References: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 14:52:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJlPZ-00073u-0n
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 14:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946Ab2DPMv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 08:51:59 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52864 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774Ab2DPMv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 08:51:58 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so6309124pbc.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 05:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fWsBBmg2lDx7SAgOp+xzj7M85QEovqUnqK4/1Cc5hng=;
        b=0DpW6cfVMb9BFNwazMplOhkUDjBHS1BKUPvHQ8/uuzXZPhkGHODUf1CluicyNuv8n3
         wdnjhctTB2QfwbEA6YhDD+rQjao6pDPUtKPlXGx87aAjoBOCe6eG5tEa/TghWKg0h1Dn
         3TyrahRRz6y2bxoFlnAbPt100yi+Z8RNDjm+/h7MrXNL9roWzkhwRi6mpDL3kKMWVlpj
         XgbE51TZB3R3ak+5i5GRPN/0wZaut1qAwiHWXJG4AQv/enTpq3FQiEi7OKA4fmowhn/X
         B5bOH9Rm5260BlpN2WLhJk4fxWCMpOPnndn0ExEGoDK+h+HpcXm0Hfut05JBazBQvuCc
         d+KQ==
Received: by 10.68.225.39 with SMTP id rh7mr27658772pbc.104.1334580718415;
        Mon, 16 Apr 2012 05:51:58 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id d6sm17637993pbi.23.2012.04.16.05.51.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 05:51:57 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Apr 2012 19:51:07 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195629>

This helps remove \n from translatable strings
---
 builtin/fetch.c  |    4 ++--
 builtin/remote.c |    4 ++--
 refs.c           |    1 +
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 65f5f9b..a8c3e4c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -537,8 +537,8 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map)
 	int result = 0;
 	struct ref *ref, *stale_refs = get_stale_heads(refs, ref_count, ref_map);
 	const char *dangling_msg = dry_run
-		? _("   (%s will become dangling)\n")
-		: _("   (%s has become dangling)\n");
+		? _("   (%s will become dangling)")
+		: _("   (%s has become dangling)");
 
 	for (ref = stale_refs; ref; ref = ref->next) {
 		if (!dry_run)
diff --git a/builtin/remote.c b/builtin/remote.c
index fec92bc..1b03473 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1260,8 +1260,8 @@ static int prune_remote(const char *remote, int dry_run)
 	int result = 0, i;
 	struct ref_states states;
 	const char *dangling_msg = dry_run
-		? " %s will become dangling!\n"
-		: " %s has become dangling!\n";
+		? " %s will become dangling!"
+		: " %s has become dangling!";
 
 	memset(&states, 0, sizeof(states));
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
diff --git a/refs.c b/refs.c
index c9f6835..54b2a03 100644
--- a/refs.c
+++ b/refs.c
@@ -395,6 +395,7 @@ static int warn_if_dangling_symref(const char *refname, const unsigned char *sha
 		return 0;
 
 	fprintf(d->fp, d->msg_fmt, refname);
+	fprintf(d->fp, "\n");
 	return 0;
 }
 
-- 
1.7.3.1.256.g2539c.dirty
