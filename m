From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH] make description of "core.autocrlf" less ambiguous
Date: Wed, 14 Apr 2010 00:23:23 +0100
Message-ID: <1271201003-3413-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 14 01:23:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1pSU-0004L4-N5
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 01:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab0DMXXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 19:23:49 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:50730 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab0DMXXs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 19:23:48 -0400
Received: by wwb34 with SMTP id 34so423799wwb.19
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 16:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=fSCjYVtd31KiauH4pTyGSjwNw9DvPCxOyzZFb6r4gB4=;
        b=CGL40MLWq0TMF/gzwUtrq9I933TtbsnpgHNA3iQD7xjwV91a2F3wxn2L+uwuWjtTN2
         ORTLBvesHzrEEQmSx4o5iNtj22RtnaEj/OUot0PZeGU7ngAReqR+ruBs2ZqBDtgKBE1e
         ybV8AHL/4/qx25NoSGKCd4vGzIhhHbKK+F7V8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=jlBziE8HCuPe/WBJxoSsp75PR+u7dABYcWrNUt0eeEkzszuAFJV94n6jXwIi4PQbfA
         duKN6NZea58BDz1R52cyr5T4v22sr8WkkcreDxQStpkn507EEhZcUKUnyS9WN1OO+dFA
         YTUFCPqCafxnsJXHThDUSb6DBdJif0YJoRR4U=
Received: by 10.216.157.142 with SMTP id o14mr3806259wek.183.1271201026639;
        Tue, 13 Apr 2010 16:23:46 -0700 (PDT)
Received: from localhost.localdomain (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id z3sm4422673wbs.22.2010.04.13.16.23.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 16:23:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.248.gcefbb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144836>

The description for core.autocrlf refers to reads from / writes to the
"filesystem". While the term is used elsewhere in the config
documentation to refer to the filesystem git is hosted on, it is not
only less clear from context in the case of core.autocrlf, but can also
be plain inaccurate in many cases.

To make more clear the direction of removal / addition of CR when
core.crlf is set, as well as to account for the usage of low-level
commands such as hash-object or cat-file, we change "reading from the
filesystem" to refer instead to "writing to the object database", and
"writing to the filesystem" to "output or writing to the work tree"

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---

While I did some simple checks to ensure that my basic assumptions about
how the commands I use daily seem to interact with core.autocrlf, I'll
easily admit that I don't actually know all the places autocrlf is
referenced, so I could be completely wrong about what generalizations
can actually be made in the documentation.
I'm fine with this patch being included, but it's pretty much just me
"being bold" in order to say that I think the way it's currently
phrased is wrong and confusing.

 Documentation/config.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 626b19a..125e9d5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -198,11 +198,11 @@ core.quotepath::
 
 core.autocrlf::
 	If true, makes git convert `CRLF` at the end of lines in text files to
-	`LF` when reading from the filesystem, and convert in reverse when
-	writing to the filesystem.  The variable can be set to
-	'input', in which case the conversion happens only while
-	reading from the filesystem but files are written out with
-	`LF` at the end of lines.  A file is considered
+	`LF` when writing into the object database, and convert in reverse when
+	outputting those files or writing them to the work tree.  The variable
+	can be set to 'input', in which case the conversion happens only while
+	writing into the object database, but files are output and written to the
+	work tree with `LF` at the end of lines.  A file is considered
 	"text" (i.e. be subjected to the autocrlf mechanism) based on
 	the file's `crlf` attribute, or if `crlf` is unspecified,
 	based on the file's contents.  See linkgit:gitattributes[5].
-- 
1.7.1.rc1.248.gcefbb
