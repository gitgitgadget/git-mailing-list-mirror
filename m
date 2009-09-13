From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 1/2] git-archive: add '-o' as a alias for '--output'
Date: Sun, 13 Sep 2009 21:36:46 +0400
Message-ID: <1252863407-2598-1-git-send-email-dpotapov@gmail.com>
References: <7v3a6r5znq.fsf@alter.siamese.dyndns.org>
Cc: John Tapsell <johnflux@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 19:43:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmt6y-00056Z-0p
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 19:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794AbZIMRl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 13:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbZIMRl4
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 13:41:56 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:60529 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbZIMRl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 13:41:56 -0400
Received: by bwz19 with SMTP id 19so1661485bwz.37
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Xlr+z+X0kgnKIdBIbJScxhmVzpDarmAEhxgMoe4hYFc=;
        b=WgZKoVuOJpK5cR0KV3GvvUTCLz6AgR2WQI2lv5lukMsNwjJNhRKoj6gx+bLxcgg9At
         sHiTMvJbFhTLpyE0RmmujZZhZZnYxu8VqaILUZ3gJMAJeb6sftXnoQI6bTtOkmIonjYb
         ptont3OikZJ9by6EmY+apl1zIpjycqTiugics=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YQshy2aE08g3ugCVg+Ng7GrmTibNQq6WcKkDKyWKyYDfHcs3C1jrKGORksD3wMmh1c
         m8lywp5xXFfw9ONa3WuhlVlCNLLdFSELnnWIpmij05m8BghrNya0nwJ70QwZV4mrKU2d
         uejL2XhhdFVs6pfGnAzuHo/qg6Y67CY43IOOQ=
Received: by 10.204.160.90 with SMTP id m26mr4280102bkx.63.1252863717995;
        Sun, 13 Sep 2009 10:41:57 -0700 (PDT)
Received: from localhost (ppp91-77-225-181.pppoe.mtu-net.ru [91.77.225.181])
        by mx.google.com with ESMTPS id f31sm4235566fkf.8.2009.09.13.10.41.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 10:41:57 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc1.2.g6bb993
In-Reply-To: <7v3a6r5znq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128376>

The '-o' option is commonly used in many tools to specify the output file.
Typing '--output' every time is a bit too long to be a practical alternative
to redirecting output. But specifying the output name has the advantage of
making possible to guess the desired output format by filename extension.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---

PS I resend this patch because I forgot to include the git mailing list when
I sent it before. Sorry for inconvinience...

 Documentation/git-archive.txt |    3 ++-
 archive.c                     |    2 +-
 builtin-archive.c             |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 92444dd..f7a3b95 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git archive' [--format=<fmt>] [--list] [--prefix=<prefix>/] [<extra>]
-	      [--output=<file>] [--worktree-attributes]
+	      [-o | --output=<file>] [--worktree-attributes]
 	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree-ish>
 	      [path...]
 
@@ -48,6 +48,7 @@ OPTIONS
 --prefix=<prefix>/::
 	Prepend <prefix>/ to each filename in the archive.
 
+-o::
 --output=<file>::
 	Write the archive to <file> instead of stdout.
 
diff --git a/archive.c b/archive.c
index 0bca9ca..73b8e8a 100644
--- a/archive.c
+++ b/archive.c
@@ -283,7 +283,7 @@ static int parse_archive_args(int argc, const char **argv,
 		OPT_STRING(0, "format", &format, "fmt", "archive format"),
 		OPT_STRING(0, "prefix", &base, "prefix",
 			"prepend prefix to each pathname in the archive"),
-		OPT_STRING(0, "output", &output, "file",
+		OPT_STRING('o', "output", &output, "file",
 			"write the archive to this file"),
 		OPT_BOOLEAN(0, "worktree-attributes", &worktree_attributes,
 			"read .gitattributes in working directory"),
diff --git a/builtin-archive.c b/builtin-archive.c
index f9a4bea..565314b 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -71,7 +71,7 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 	const char *output = NULL;
 	const char *remote = NULL;
 	struct option local_opts[] = {
-		OPT_STRING(0, "output", &output, "file",
+		OPT_STRING('o', "output", &output, "file",
 			"write the archive to this file"),
 		OPT_STRING(0, "remote", &remote, "repo",
 			"retrieve the archive from remote repository <repo>"),
-- 
1.6.4
