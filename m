From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/7] Revert "Documentation: always respect core.worktree if set"
Date: Thu, 11 Nov 2010 21:20:47 +0700
Message-ID: <1289485248-8966-7-git-send-email-pclouds@gmail.com>
References: <1289485248-8966-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 15:24:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGY4W-000135-3l
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 15:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956Ab0KKOYL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 09:24:11 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41498 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755358Ab0KKOYK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 09:24:10 -0500
Received: by pva4 with SMTP id 4so398420pva.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 06:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=3RS+tsaX9vaW+9IjTPBKvLtdyeRoBkv1vzwjEdIxmKU=;
        b=EITZl/PR4O0EnApXUzB786DxfxnjO3Fvoe1hPXfWqm2CucKispeM4fQbpQWQvt2ESQ
         A9lHRxsDRdyNZmWkZdUSUBBEP79tuqgJINE2b4Sn7tbyrCEkGHYdkGY6Nym+RvvPofTi
         IkKmAVoWBBYzzK+RlKpOYghCBvRxz4zs6OcWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JfxIP4p7rEgAeoSFM7nKc7jin+zUSStFJDSaMn/udWP1kzy/D9YAIuaAtQa+uRxDLe
         sx0yyeJc+MsLkTQ1RC6V51lcGo0Dxy0Pg2yxf3rDKX87Cy8+0qaNZ74fa3wli9pv+gBD
         nI/6C160muC7hCjofbYupIM3+oun53ga5eBno=
Received: by 10.142.230.20 with SMTP id c20mr638738wfh.165.1289485449902;
        Thu, 11 Nov 2010 06:24:09 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id y42sm2422757wfd.22.2010.11.11.06.24.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 06:24:09 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Nov 2010 21:22:47 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <1289485248-8966-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161260>

This reverts commit f5e025a9d5b35e24768475f6890b836ce0d5ed15.

The commit reflected what the code did. But the code did that because
it had bugs.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |   23 ++++++++---------------
 1 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 71ddb6c..be87123 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -317,24 +317,17 @@ false), while all other repositories are assumed =
to be bare (bare
 =3D true).
=20
 core.worktree::
-	Set the path to the root of the work tree.
+	Set the path to the working tree.  The value will not be
+	used in combination with repositories found automatically in
+	a .git directory (i.e. $GIT_DIR is not set).
 	This can be overridden by the GIT_WORK_TREE environment
 	variable and the '--work-tree' command line option. It can be
-	an absolute path or a relative path to the .git directory,
-	either specified by --git-dir or GIT_DIR, or automatically
-	discovered.
-	If --git-dir or GIT_DIR are specified but none of
+	a absolute path or relative path to the directory specified by
+	--git-dir or GIT_DIR.
+	Note: If --git-dir or GIT_DIR are specified but none of
 	--work-tree, GIT_WORK_TREE and core.worktree is specified,
-	the current working directory is regarded as the root of the
-	work tree.
-+
-Note that this variable is honored even when set in a configuration
-file in a ".git" subdirectory of a directory, and its value differs
-from the latter directory (e.g. "/path/to/.git/config" has
-core.worktree set to "/different/path"), which is most likely a
-misconfiguration.  Running git commands in "/path/to" directory will
-still use "/different/path" as the root of the work tree and can cause
-great confusion to the users.
+	the current working directory is regarded as the top directory
+	of your working tree.
=20
 core.logAllRefUpdates::
 	Enable the reflog. Updates to a ref <ref> is logged to the file
--=20
1.7.3.2.210.g045198
