From: Scott Chacon <schacon@gmail.com>
Subject: [PATCH] added a built-in alias for 'stage' to the 'add' command
Date: Mon, 1 Dec 2008 09:29:02 -0800
Message-ID: <20081201172902.GA41963@agadorsparticus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 18:30:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7CbM-0000Ha-VL
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 18:30:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbYLAR3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 12:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbYLAR3J
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 12:29:09 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:10811 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbYLAR3H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 12:29:07 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1223276wah.21
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 09:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=bUvSkAyYjCr7wc5vYVIYW/Jdqs0+60liu23MF03xGQ0=;
        b=gV2HH6dwJo6ENB8MjW+AH4/Bul+VVbG1qE6XpJ4kkbW6Cjhtn7NwRA7BJKh/RCm1fC
         M0W8BWJjaXFtgi+WVMDMZqk8+GIyIpRVlIwS7nyC5Ut0F+CXFjhy/54O0LDzpfREtnqv
         BobFgVOvZ9UNnmYXPVDAfkTIaf5vIdDw1cqB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=g4vaOPLByATtUUcLl+cU61ACJ2UJaW6I3xA3xoQ6aiq57yXXwakLjya0Ef5OMBdqk3
         LipTnQn7rteXorOZaK/6kyhXQuo2VWFg8luOyMBLJn7hnf2rdFTM17OPqSuGcBPdfhRW
         mtHzaxFkXztR80dXb4DzblU6p5CDpq+Swva+A=
Received: by 10.115.108.1 with SMTP id k1mr6665290wam.0.1228152545736;
        Mon, 01 Dec 2008 09:29:05 -0800 (PST)
Received: from @ (adsl-76-254-71-52.dsl.pltn13.sbcglobal.net [76.254.71.52])
        by mx.google.com with ESMTPS id y11sm3707920pod.5.2008.12.01.09.29.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 09:29:05 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102065>

this comes from conversation at the GitTogether where we thought it would
be helpful to be able to teach people to 'stage' files because it tends
to cause confusion when told that they have to keep 'add'ing them.

This continues the movement to start referring to the index as a
staging area (eg: the --staged alias to 'git diff'). Also added a
doc file for 'git stage' that basically points to the docs for
'git add'.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---
 Documentation/git-stage.txt |   21 +++++++++++++++++++++
 git.c                       |    1 +
 2 files changed, 22 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-stage.txt

diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
new file mode 100644
index 0000000..0640198
--- /dev/null
+++ b/Documentation/git-stage.txt
@@ -0,0 +1,21 @@
+git-stage(1)
+==============
+
+NAME
+----
+git-stage - Add file contents to the staging area
+
+
+SYNOPSIS
+--------
+[verse]
+'git stage' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
+	  [--all | [--update | -u]] [--intent-to-add | -N]
+	  [--refresh] [--ignore-errors] [--] <filepattern>...
+
+
+DESCRIPTION
+-----------
+
+This is a synonym for linkgit:git-add[1].  Please refer to the
+documentation of that command.
diff --git a/git.c b/git.c
index 89feb0b..9e5813c 100644
--- a/git.c
+++ b/git.c
@@ -266,6 +266,7 @@ static void handle_internal_command(int argc, const char **argv)
 	const char *cmd = argv[0];
 	static struct cmd_struct commands[] = {
 		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "annotate", cmd_annotate, RUN_SETUP },
 		{ "apply", cmd_apply },
 		{ "archive", cmd_archive },
-- 
1.6.0.8.gc9c8
