From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/8] Documentation/notes: describe content of notes blobs
Date: Sat, 8 May 2010 22:21:34 -0500
Message-ID: <20100509032134.GB7958@progeny.tock>
References: <20100509031357.GA7926@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 09 05:20:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAx4G-00018U-RF
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 05:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538Ab0EIDUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 23:20:31 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62977 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165Ab0EIDUb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 23:20:31 -0400
Received: by gyg13 with SMTP id 13so1363251gyg.19
        for <git@vger.kernel.org>; Sat, 08 May 2010 20:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7nVE0eBX3UbdKIyGiwoEK9nd6Dwu37c8PcWS+D9dId0=;
        b=RdgpAIBOYwaUT5ZdgErSaxeL94GhWrWT91qqbedFWzBODSEfX5w2PzY/Hi3HYPfz5B
         YSHVbEgfQw2dJeHaxyai8N5QexScb7wAof22psFevpto+9GRgYgVAaNRKCUnGJCfDkqT
         5ckCllPTZlIrsvb5rcLFLQ7jL4OJEHsNKCaKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oWIqAqaZXJIt7RkvFqGAcFHSD5Mjkydk8xQmPwVPPEPvgqkPeD02wmrQNxD7yL8BZu
         hzLm7cW+9swovqHWmGhsVrWGX0FM30ICH8RlbQuOpdvz2WttdBKa8Q3D+ffWrg9yKYpO
         R39jmaKvyLw2jWnmfPftNHB0PmBrxkj8pe+q8=
Received: by 10.150.187.17 with SMTP id k17mr5804051ybf.91.1273375229944;
        Sat, 08 May 2010 20:20:29 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm2573658yxe.12.2010.05.08.20.20.28
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 20:20:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100509031357.GA7926@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146693>

stripspace/text-based formatting kicks in when specifying the notes
content with -m or -F, or when an editor is used to edit the notes.
To binary-safely create notes from files, the following construct is
required:

    git notes add -C $(git hash-object -w <file>) <object>

Explain this trick (thanks, Johan!) in the manual.  Add an ordinary
example, too, to keep this esoteric one company.

Cc: Johan Herland <johan@herland.net>
Cc: Thomas Rast <trast@student.ethz.ch>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-notes.txt |   38 +++++++++++++++++++++++++++++++++++++-
 t/t3307-notes-man.sh        |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 1 deletions(-)
 create mode 100755 t/t3307-notes-man.sh

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index af12c3c..97b9d81 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -101,15 +101,20 @@ OPTIONS
 	Use the given note message (instead of prompting).
 	If multiple `-m` options are given, their values
 	are concatenated as separate paragraphs.
+	Lines starting with `#` and empty lines other than a
+	single line between paragraphs will be stripped out.
 
 -F <file>::
 --file=<file>::
 	Take the note message from the given file.  Use '-' to
 	read the note message from the standard input.
+	Lines starting with `#` and empty lines other than a
+	single line between paragraphs will be stripped out.
 
 -C <object>::
 --reuse-message=<object>::
-	Reuse the note message from the given note object.
+	Take the note message from the given blob object (for
+	example, another note).
 
 -c <object>::
 --reedit-message=<object>::
@@ -147,6 +152,37 @@ object, in which case the history of the notes can be read with
 `git log -p -g <refname>`.
 
 
+EXAMPLES
+--------
+
+You can use notes to add annotations with information that was not
+available at the time a commit was written.
+
+------------
+$ git notes add -m 'Tested-by: Johannes Sixt <j6t@kdbg.org>' 72a144e2
+$ git show -s 72a144e
+[...]
+    Signed-off-by: Junio C Hamano <gitster@pobox.com>
+
+Notes:
+    Tested-by: Johannes Sixt <j6t@kdbg.org>
+------------
+
+In principle, a note is a regular Git blob, and any kind of
+(non-)format is accepted.  You can binary-safely create notes from
+arbitrary files using 'git hash-object':
+
+------------
+$ cc *.c
+$ blob=$(git hash-object -w a.out)
+$ git notes --ref=built add -C "$blob" HEAD
+------------
+
+Of course, it doesn't make much sense to display non-text-format notes
+with 'git log', so if you use such notes, you'll probably need to write
+some special-purpose tools to do something useful with them.
+
+
 Author
 ------
 Written by Johannes Schindelin <johannes.schindelin@gmx.de> and
diff --git a/t/t3307-notes-man.sh b/t/t3307-notes-man.sh
new file mode 100755
index 0000000..3269f2e
--- /dev/null
+++ b/t/t3307-notes-man.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='Examples from the git-notes man page
+
+Make sure the manual is not full of lies.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit A &&
+	test_commit B &&
+	test_commit C
+'
+
+test_expect_success 'example 1: notes to add an Acked-by line' '
+	cat <<-\EOF >expect &&
+	    B
+
+	Notes:
+	    Acked-by: A C Ker <acker@example.com>
+	EOF
+	git notes add -m "Acked-by: A C Ker <acker@example.com>" B &&
+	git show -s B^{commit} >log &&
+	tail -n 4 log >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'example 2: binary notes' '
+	cp "$TEST_DIRECTORY"/test4012.png .
+	git checkout B &&
+	blob=$(git hash-object -w test4012.png) &&
+	git notes --ref=logo add -C "$blob" &&
+	git notes --ref=logo copy B C &&
+	git notes --ref=logo show C >actual &&
+	test_cmp test4012.png actual
+'
+
+test_done
-- 
1.7.1
