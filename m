From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 1/3] doc/fast-import: clarify notemodify command
Date: Wed, 13 Jul 2011 23:10:53 +0600
Message-ID: <1310577055-6347-1-git-send-email-divanorama@gmail.com>
References: <1310483428-29833-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 19:10:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh2xJ-0005uQ-Qq
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 19:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332Ab1GMRKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 13:10:32 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60819 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932230Ab1GMRKb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 13:10:31 -0400
Received: by eyx24 with SMTP id 24so2176367eyx.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=H3nQV4qJXws0V+HrNGNAQ29zt4vANsZTQt5F+On+sRw=;
        b=ZXigFCPUQW83doZHJfP+3Lx1E+LT4iLTLdBSFdnfkqe6u9/WLwXb2uHfjxoXPvkXHQ
         mpM8L7pN6aAdnUvz0eUBGcP9Q1fiWKW2MRaYTtOSSWPd2g0TJnlog8Gcc8P7gUaSNQbN
         UIu7kWMxIJckJ8PtGO4YN8zNCSedwPWXny/vk=
Received: by 10.213.108.147 with SMTP id f19mr455726ebp.34.1310577029820;
        Wed, 13 Jul 2011 10:10:29 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id z14sm9432354eef.13.2011.07.13.10.10.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 10:10:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310483428-29833-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177061>

The "notemodify" fast-import command was introduced in commit a8dd2e7
(fast-import: Add support for importing commit notes, 2009-10-09)
The commit log has slightly different description than the added
documentation. The latter is somewhat confusing. "notemodify" is a
subcommand of "commit" command used to add a note for some commit.
Does this note annotate the commit produced by the "commit" command
or a commit given by it's committish parameter? Which notes tree
does it write notes to?

The exact meaning could be deduced with old description and some
notes machinery knowledge. But let's make it more obvious. This
command is used in a context like "commit refs/notes/test" to
add or rewrite an annotation for a committish parameter. So the
advised way to add notes in a fast-import stream is:
1) import some commits (optional)
2) prepare a "commit" to the notes tree:
2.1) choose notes ref, committer, log message, etc.
2.2) create annotations with "notemodify", where each can refer to
a commit being annotated via a branch name, import mark reference,
sha1 and other expressions specified in the Documentation.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
Just added a bit more metadata of a8dd2e7.

 Documentation/git-fast-import.txt |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 249249a..3f5b912 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -648,9 +648,14 @@ paths for a commit are encouraged to do so.
 
 `notemodify`
 ^^^^^^^^^^^^
-Included in a `commit` command to add a new note (annotating a given
-commit) or change the content of an existing note.  This command has
-two different means of specifying the content of the note.
+Included in a `commit` `<notes_ref>` command to add a new note
+annotating a `<committish>` or change this annotation contents.
+Internally it is similar to filemodify 100644 on `<committish>`
+path (maybe split into subdirectories). It's not advised to
+use any other commands to write to the `<notes_ref>` tree except
+`filedeleteall` to delete all existing notes in this tree.
+This command has two different means of specifying the content
+of the note.
 
 External data format::
 	The data content for the note was already supplied by a prior
-- 
1.7.3.4
