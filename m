From: pclouds@gmail.com
Subject: [PATCH] git.txt: document limitations on non-typical repos (and hints)
Date: Wed,  6 Oct 2010 21:23:11 +0700
Message-ID: <4cac8659.0541730a.0ef0.3ff9@mx.google.com>
References: <1286283653-22616-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: weigelt@metux.de, spearce@spearce.org, jrnieder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, raa.lkml@gmail.com,
	Junio C Hamano <gitster@pobox.com>, judge.packham@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 06 16:23:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Uu1-0003S4-0a
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 16:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312Ab0JFOXY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 10:23:24 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39160 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216Ab0JFOXX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 10:23:23 -0400
Received: by pwj5 with SMTP id 5so1713847pwj.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 07:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ShCTmGSm3h2SMDZ2VXP/TeY868nwMQYfUEw8XC7mNTQ=;
        b=w/4DO74jbn1zFcv8syh8tz3codOU46brrD5eaUgmAxohKtzBlqd3LOuTeadYZOA8ZC
         Xa/B0BzV5L5Xg9T7DsjtwI5PUtygX5BV7OAeq5OKNrMaDHqSbmD+UPLnTkEKPTERWvK4
         CACYeP883UipHp1yW0PhgJFAwdhE0PBuIAaxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=IuA376zXJzFa73KPz3QpkQojD5InJGLnIsBZ4BNoy4jcpoynDOp9Hmdo8rBRyV+187
         n/ccrw2ZD0bR03xsPG6Ws3JFaJxDvIoa2CDw5Uc62SYMH/FFAmms0tDvYKTg9/SyTETj
         GRz9Zdj6k7AjXyzbJiU8012AUfq8oiN603MrE=
Received: by 10.115.14.6 with SMTP id r6mr15543253wai.121.1286375002627;
        Wed, 06 Oct 2010 07:23:22 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.218.98])
        by mx.google.com with ESMTPS id s5sm1505313wak.0.2010.10.06.07.23.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 07:23:21 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed,  6 Oct 2010 21:23:13 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1286283653-22616-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158290>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

---
 Revised version. I dropped shallow clone because it does not really
 relate to performance.

 Documentation/git.txt |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index dd57bdc..129947f 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -729,6 +729,47 @@ The index is also capable of storing multiple entr=
ies (called "stages")
 for a given pathname.  These stages are used to hold the various
 unmerged version of a file when a merge is in progress.
=20
+Performance concerns
+--------------------
+
+Git is written with performance in mind and it works extremely well
+with its typical repositories (i.e. source code repositories, with
+a moderate number of small text files, possibly with long history).
+Non-typical repositories (a lot of files, or very large files...)
+may experience mild performance degradation. This section describes
+how Git behaves in such repositories and how to reduce impact.
+
+For repositories with a large number of files (~50k files or more),
+but you only need a few of them present in working tree, you can use
+sparse checkout (see linkgit:git-read-tree[1], section 'Sparse
+checkout'). If you need all of them present in working tree, but you
+know in advance only a few of them may be modified, please consider
+using assume-unchanged bit (see linkgit:git-update-index[1]). This
+helps reduce the number of lstat(2) calls.
+
+Git uses lstat(2) to detect changes in working tree, one call for each
+tracked file, in what is called "index refresh". A significant number =
of
+lstat(2) calls may create a small delay for many commands, especially
+on systems with slow lstat(2). In some cases you can reduce the number
+of lstat(2) calls by specifying what directories you are interested
+in, so no lstat(2) outside is needed. The following commands are
+however known to do full index refresh in some cases:
+linkgit:git-commit[1], linkgit:git-status[1], linkgit:git-diff[1],
+linkgit:git-reset[1], linkgit:git-checkout[1], linkgit:git-merge[1].
+
+Some commands need entire file content in memory to process.
+Files that have size a significant portion of physical RAM may
+affect performance. You may want to avoid using the following
+commands if possible on such large files:
+
+* All checkout commands (linkgit:git-checkout[1],
+  linkgit:git-checkout-index[1], linkgit:git-read-tree[1],
+  linkgit:git-clone[1]...)
+* All diff-related commands (linkgit:git-diff[1],
+  linkgit:git-log[1] with diff, linkgit:git-show[1] on commits...)
+* All commands that need file conversion processing (see
+  linkgit:gitattributes[5])
+
 Authors
 -------
 * git's founding father is Linus Torvalds <torvalds@osdl.org>.
--=20
1.7.0.2.445.gcbdb3
