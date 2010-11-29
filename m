From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFD] git glossary: define pathspec
Date: Mon, 29 Nov 2010 17:13:42 +0700
Message-ID: <1291025622-15335-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 11:15:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN0lA-00023p-Uz
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 11:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899Ab0K2KOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 05:14:55 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:40694 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab0K2KOy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 05:14:54 -0500
Received: by pva4 with SMTP id 4so665804pva.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 02:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=BiIbeITfQAfnlbfyLdikbdqp6W6w11FJyATJOQzImzY=;
        b=vblHHRw/N8JvxFjsnac3fBvksUJmuv/lEXHiQ6MGd+85QniEcQ+z6f3mLtssMsE/ZD
         ufxW62MxCqW2UaGQBzgjF4OrNQgIXegghB9DfTotzCdn5dwRePI8G9V0/dpAtslDhBZl
         k+n5F8OYwFy+LnGCCH+GFwyMsOeyapJuyrNm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hKc8mYNoG2s52gFUq2CwcGnn2/vl5dRLyf3RErkkjeTWQGzMcADrXru1GwL7mjiToK
         tWxN8XOYmRxcCTUAPmHBAMOfYg25uBFZr0eOVrOR93NZT3MVCfAS+MJZl4N6YBbtWje7
         ATpufDeb4U5tV58la5U/tm+SXtB5kbcQqGa/0=
Received: by 10.142.246.16 with SMTP id t16mr5087577wfh.307.1291025692170;
        Mon, 29 Nov 2010 02:14:52 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.197.195])
        by mx.google.com with ESMTPS id x35sm7271860wfd.1.2010.11.29.02.14.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 02:14:51 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 29 Nov 2010 17:13:42 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162379>

As far as I know we have three lightly incompatible pathspec
implementations:

1. match_pathspec() in dir.c
2. tree_interesting() in tree-walk.c
3. pathspec_matches() in builtin/grep.c

What I describe here is match_pathspec(). What I want is a single
pathspec semantics that all three must follow. Or even better, all
three will become a single impl.

We need to point the differences between the three and see how to
unify them.

sure if #3 can do the same.

directories. Therefore "Documentation" can't match the directory,
while Documentation/ can. This is no problem to #2. It can be solved
with a similar approach to [1], although maybe we can just convert the
index to tree-based structure.

Any other differences?

Also rewording my poor paragraph is welcome.

[1] http://article.gmane.org/gmane.comp.version-control.git/162267
---
 Documentation/glossary-content.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 1f029f8..22da1b1 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -278,6 +278,17 @@ This commit is referred to as a "merge commit", or sometimes just a
 	of the logical predecessor(s) in the line of development, i.e. its
 	parents.
 
+[[def_pathspec]]pathspec::
+	Pathspec in its simplest form is a literal path to address a
+	file or a blob.
+	Pathspec can end with a slash. Such pathspec is considered a
+	directory prefix and will match everything under matched
+	directory.
+	Pathspec can contain wildcards such as '*', '?'... Such
+	pathspecs, after being matched literally against the entire
+	path, will be matched against the entire path using
+	fnmatch(3).
+
 [[def_pickaxe]]pickaxe::
 	The term <<def_pickaxe,pickaxe>> refers to an option to the diffcore
 	routines that help select changes that add or delete a given text
-- 
1.7.3.2.316.gda8b3
