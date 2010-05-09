From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/8] Documentation/notes: document format of notes trees
Date: Sat, 8 May 2010 22:19:35 -0500
Message-ID: <20100509031935.GA7958@progeny.tock>
References: <20100509031357.GA7926@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 09 05:18:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAx2P-0000Up-TG
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 05:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410Ab0EIDSf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 May 2010 23:18:35 -0400
Received: from mail-qy0-f195.google.com ([209.85.221.195]:45338 "EHLO
	mail-qy0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab0EIDSe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 23:18:34 -0400
Received: by qyk33 with SMTP id 33so4249662qyk.24
        for <git@vger.kernel.org>; Sat, 08 May 2010 20:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wo3s3+mgrz7AFlUMfvk5hUUSJHK2M/x5NobwHI6y47E=;
        b=MyJh4ikS27oWab9f6Gft8LttUA0dGEIJTwIgT/OODtiY1s7JiZgWbDMqj4dZB1alVk
         /kBRvOclC2yOF6n53+5JR2FEpXIjdqspngKzk2Z85LvwnoEGCTrFqZmJ13CtBdqHWn+k
         +qu5+n2mZxEUbliPei8pRuesU+IpprurpL8yc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=TZ2Zz1oBwWV3j+UdBHXEhk+HE87QwG9yRrGFvZ7BAaXQrF0i5+AcNYejJh/WNdgRlf
         RxX0/wvUcyT/z68ODDqgO6G53HFn5KZwkYC7nwlhicqEigxMlPSjVBENoAtxC9J17RjJ
         q4MuV7Nmy8lfAmrk/NhDGeDRBFgwRrqwgzf9I=
Received: by 10.229.214.7 with SMTP id gy7mr1732020qcb.12.1273375113271;
        Sat, 08 May 2010 20:18:33 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f5sm2697160qcg.8.2010.05.08.20.18.31
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 20:18:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100509031357.GA7926@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146692>

Separate the specification of the notes format exposed in
git-config.1 from the description of the option; or in other
words, move the explanation for what to expect to find at
refs/notes/commits from git-config.1 to git-notes.1.

Suggested-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
How well does =E2=80=98git notes=E2=80=99 handle notes trees without a =
commit
currently?  I remembered some rumor about a commitless mode in which
the only history is the reflog, but I am not sure how much of that is
implemented yet and I did not check.

If it was only groundless rumor (read: I made it up), then the last
paragraph of the discussion should be removed.

 Documentation/config.txt    |   16 +++++-----------
 Documentation/git-notes.txt |   30 +++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8f86050..cc4bc20 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -518,18 +518,12 @@ check that makes sure that existing object files =
will not get overwritten.
=20
 core.notesRef::
 	When showing commit messages, also show notes which are stored in
-	the given ref.  This ref is expected to contain files named
-	after the full SHA-1 of the commit they annotate.  The ref
-	must be fully qualified.
+	the given ref.  The ref must be fully qualified.  If the given
+	ref does not exist, it is not an error but means that no
+	notes should be printed.
 +
-If such a file exists in the given ref, the referenced blob is read, a=
nd
-appended to the commit message, separated by a "Notes (<refname>):"
-line (shortened to "Notes:" in the case of "refs/notes/commits").  If =
the
-given ref itself does not exist, it is not an error, but means that no
-notes should be printed.
-+
-This setting defaults to "refs/notes/commits", and can be overridden b=
y
-the `GIT_NOTES_REF` environment variable.
+This setting defaults to "refs/notes/commits", and it can be overridde=
n by
+the 'GIT_NOTES_REF' environment variable.  See linkgit:git-notes[1].
=20
 core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 4e5113b..af12c3c 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -28,7 +28,7 @@ to change the commit itself. Such commit notes can be=
 shown by `git log`
 along with the original commit message. To discern these notes from th=
e
 message stored in the commit object, the notes are indented like the
 message, after an unindented line saying "Notes (<refname>):" (or
-"Notes:" for the default setting).
+"Notes:" for `refs/notes/commits`).
=20
 This command always manipulates the notes specified in "core.notesRef"
 (see linkgit:git-config[1]), which can be overridden by GIT_NOTES_REF.
@@ -122,17 +122,29 @@ OPTIONS
 	is taken to be in `refs/notes/` if it is not qualified.
=20
=20
-NOTES
------
+DISCUSSION
+----------
+
+Commit notes are blobs containing extra information about an object
+(usually information to supplement a commit's message).  These blobs
+are taken from notes refs.  A notes ref is usually a branch which
+contains "files" whose paths are the object names for the objects
+they describe, with some directory separators included for performance
+reasons footnote:[Permitted pathnames have the form
+'ab'`/`'cd'`/`'ef'`/`'...'`/`'abcdef...': a sequence of directory
+names of two hexadecimal digits each followed by a filename with the
+rest of the object ID.].
=20
 Every notes change creates a new commit at the specified notes ref.
 You can therefore inspect the history of the notes by invoking, e.g.,
-`git log -p notes/commits`.
-
-Currently the commit message only records which operation triggered
-the update, and the commit authorship is determined according to the
-usual rules (see linkgit:git-commit[1]).  These details may change in
-the future.
+`git log -p notes/commits`.  Currently the commit message only records
+which operation triggered the update, and the commit authorship is
+determined according to the usual rules (see linkgit:git-commit[1]).
+These details may change in the future.
+
+It is also permitted for a notes ref to point directly to a tree
+object, in which case the history of the notes can be read with
+`git log -p -g <refname>`.
=20
=20
 Author
--=20
1.7.1
