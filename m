From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/43] help: take note why this command is not applicable for RUN_SETUP_GENTLY
Date: Mon,  5 Apr 2010 20:41:00 +0200
Message-ID: <1270492888-26589-16-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:43:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrH0-0000ps-AB
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756058Ab0DESmc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:42:32 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62876 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756008Ab0DESmY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:42:24 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1250782fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=9xFcqXAeheQkhBnKheiPnSsExN3BkGwRYBMeZWuvBz4=;
        b=T0NsXqbzSC2sCE+QqHMryCbL6WlPawdFvjl9hTTdv6stAXQB3AqNfyL4BhGfUCCSub
         N3fjgQYYU4ELPQ36TkxY6o6ES5hRTM8i4Tt6dybHisGdkI+S2U38xeOEPzp7g9Nkc4ym
         VFy/HINodO+2eR97NCvFQ3OVm0wljJS9i6O6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=C1gEtqZiARJhxrsxQVUZeBSxcrLheZA7nGuX6YhbmHVclSpJmtyJ0T5nv8qVkYHY9D
         dKddaRuY+foJ7WELQVHHfCeZmajDLZXXQ/5aiXijf1Tb35vG9+Sn/ZNegKB2X0CQX0R7
         +9XhP0+0pHh9PQO9cY1elbn9gmPwcj52LOdt0=
Received: by 10.223.17.216 with SMTP id t24mr2336587faa.90.1270492943858;
        Mon, 05 Apr 2010 11:42:23 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 26sm26841487fks.22.2010.04.05.11.42.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:42:22 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:42:20 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144017>

=46rom: Jonathan Nieder <jrnieder@gmail.com>

"git help" calls setup_git_directory_gently(), thus a candidate for
RUN_SETUP_GENTLY. However RUN_SETUP_GENTLY should not be used for
performance reason, as follows.

In automount setups like that which prompted v1.6.0-rc0~121^2~1 (Add
support for GIT_CEILING_DIRECTORIES, 2008-05-19), if
GIT_CEILING_DIRECTORIES is unset, then probing for the Git directory
can take a long time.  Thus unnecessarily searching for a git
directory can slow down 'git help -a' (and thus bash completion).

'git help' does not use RUN_SETUP or USE_PAGER, and neither option
parsing nor producing output for plain 'git help' or 'git help -a'
requires access to the git configuration.  Therefore it is safe to not
search for the git directory early in this case.

Also add some comments to document the requirements this places on
list_commands() and list_common_cmds_help().

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/help.c |    5 +++++
 help.c         |    4 ++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 3182a2b..1626251 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -271,6 +271,11 @@ static int git_help_config(const char *var, const =
char *value, void *cb)
=20
 static struct cmdnames main_cmds, other_cmds;
=20
+/*
+ * Used for plain 'git' and 'git help'.
+ * Therefore this should not use git_config(), nor any other function
+ * that requires searching for a repository.
+ */
 void list_common_cmds_help(void)
 {
 	int i, longest =3D 0;
diff --git a/help.c b/help.c
index 7f4928e..d4c3165 100644
--- a/help.c
+++ b/help.c
@@ -221,6 +221,10 @@ void load_command_list(const char *prefix,
 	exclude_cmds(other_cmds, main_cmds);
 }
=20
+/*
+ * Used for 'git help -a'.  Therefore this should not use git_config()=
,
+ * nor any other function that requires searching for a repository.
+ */
 void list_commands(const char *title, struct cmdnames *main_cmds,
 		   struct cmdnames *other_cmds)
 {
--=20
1.7.0.rc1.541.g2da82.dirty
