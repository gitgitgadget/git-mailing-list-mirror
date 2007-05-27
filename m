From: Johan Herland <johan@herland.net>
Subject: [PATCH 02/15] git-note: (Documentation) Add git-note manual page
Date: Sun, 27 May 2007 16:10:20 +0200
Message-ID: <200705271610.20927.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
 <200705271608.02122.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 16:10:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsJS4-0006fo-FJ
	for gcvg-git@gmane.org; Sun, 27 May 2007 16:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbXE0OK1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 10:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752689AbXE0OK1
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 10:10:27 -0400
Received: from smtp.getmail.no ([84.208.20.33]:61542 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999AbXE0OK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 10:10:26 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIP0040BE1EUN00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:10:26 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP00GQ7E19R040@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:10:21 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP0008LE18JB50@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:10:21 +0200 (CEST)
In-reply-to: <200705271608.02122.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48542>

The manual page describes the operation of the git-note command, as well
as some discussion around the design and usage of git notes.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-note.txt |   95 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 95 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-note.txt

diff --git a/Documentation/git-note.txt b/Documentation/git-note.txt
new file mode 100644
index 0000000..077d526
--- /dev/null
+++ b/Documentation/git-note.txt
@@ -0,0 +1,95 @@
+git-note(1)
+===========
+
+NAME
+----
+git-note - Create, list or delete git note objects
+
+
+SYNOPSIS
+--------
+[verse]
+'git-note' [-m <msg> | -F <file>] [<head>]
+'git-note' -l [<name>...]
+'git-note' -d <name>...
+
+
+DESCRIPTION
+-----------
+Adds a 'note' in `.git/refs/notes/` on an existing git object.
+
+A 'note' is an annotation associated with an existing git object.
+The note is similar in form to a commit message.
+
+Unless `-l` or `-d` is passed, the command creates a 'note' object,
+and requires the note message.  Unless `-m <msg>` or `-F <file>` is
+given, an editor is started for the user to type in the note message.
+
+`-l [<name>...]` lists notes associated with the given <name>s. If no
+<name> is given, all notes are listed. The given <name> may itself be
+a note object, in which case it is listed along with its associated
+notes (if any).
+
+`-d <name>...` deletes the notes associated with the given <name>s.
+The given <name> may itself be a note object, in which case it is
+deleted along with its associated notes (if any).
+
+
+OPTIONS
+-------
+-d <name>...::
+	Delete existing notes associated with the given name(s).
+
+-l [<name>...]::
+	List notes associated with the given name(s). List all notes id no
+	name is given.
+
+-m <msg>::
+	Use the given note message (instead of prompting)
+
+-F <file>::
+	Take the note message from the given file (instead of prompting).
+	Use '-' to read the message from the standard input.
+
+
+DISCUSSION
+----------
+A git note provides an after-the-fact text annotation associated with an
+exiting object in the git object database. The note itself is also stored
+in the database (as a special case of a tag object). Note object are therefore
+-- as all other objects in the database -- immutable, i.e. once added they
+cannot be edited, although they can be deleted.
+
+As with regular tag objects, notes are useless unless they have a
+corresponding reference stored in `.git/refs`. For notes, these references
+are stored in a hierarchy under `.git/refs/notes`. For each object that has
+one or more associated notes, there is a subdirectory under
+`.git/refs/notes` named after the object identifier (SHA1 sum). The
+object's subdirectory contains one file per note associated with that object.
+The end result is that notes are easily accessible from the name/identifier
+of the object they are associated with.
+
+Note that deleting a note with `git-note -d` only deletes the reference to
+the note. The note itself is still present in the object database, but will
+be considered unreachable by gitlink:git-fsck[1], and may be removed with
+gitlink:git-prune[1].
+
+
+USE CASE
+--------
+Notes may be used to add any kind of extra information to existing git
+objects that may not become apparent until 'after' the original object is
+created. A common use case is to add -- for example -- information on bugs
+to existing commit objects. E.g. making notes like "This commit closes
+bug #123", or "This commit opens bug #456". These messages may then be
+parsed by custom tools that interoperate with a bug tracker, etc.
+
+
+Author
+------
+Written by Johan Herland <johan@herland.net>.
+
+
+GIT
+---
+Part of the gitlink:git[7] suite
-- 
1.5.2.101.gee49f
