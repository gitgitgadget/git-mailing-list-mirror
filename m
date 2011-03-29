From: Johan Herland <johan@herland.net>
Subject: [PATCH 7/6] log/pretty-options: Document --[no-]notes and deprecate
 old notes options
Date: Wed, 30 Mar 2011 00:18:55 +0200
Message-ID: <201103300018.55371.johan@herland.net>
References: <e83f8b622fba5add563fc331ae3922b79a0af008.1301392999.git.git@drmicha.warpmail.net>
 <20110329205307.GA30959@sigill.intra.peff.net>
 <201103292344.26249.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 00:19:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4hFi-0004oP-Dd
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 00:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360Ab1C2WTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 18:19:00 -0400
Received: from smtp.getmail.no ([84.208.15.66]:45838 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821Ab1C2WS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 18:18:59 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIU00A2NBBLA640@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 30 Mar 2011 00:18:57 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 6B5F41EA55D2_D925AD1B	for <git@vger.kernel.org>; Tue,
 29 Mar 2011 22:18:57 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 2ED1D1EA3AF2_D925AD1F	for <git@vger.kernel.org>; Tue,
 29 Mar 2011 22:18:57 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIU005YNBBK9O20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 30 Mar 2011 00:18:57 +0200 (MEST)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.1; x86_64; ; )
In-reply-to: <201103292344.26249.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170333>

Document the behavior or the new --notes, --notes=<ref> and --no-notes
options, and list --show-notes[=<ref>] and --[no-]standard-notes options
as deprecated.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Tuesday 29 March 2011, Johan Herland wrote:
> On Tuesday 29 March 2011, Jeff King wrote:
> > Here's the series I ended up with. Getting the refactoring just right
> > turned out to be non-trivial, but between several attempts and some
> > tests, I think the end result is correct. Hopefully the breakdown of
> > the changes into small patches helps make it easy to review.
> > 
> >   [1/6]: notes: make expand_notes_ref globally accessible
> >   [2/6]: revision.c: refactor notes ref expansion
> >   [3/6]: notes: refactor display notes extra refs field
> >   [4/6]: notes: refactor display notes default handling
> >   [5/6]: revision.c: support --notes command-line option
> >   [6/6]: revision.c: make --no-notes reset --notes list
> 
> Indeed, the whole series looks good to me.
> 
> Acked-by: Johan Herland <johan@herland.net>

And here's some documentation to go on top.


Have fun! :)

...Johan

 Documentation/git-log.txt        |    4 ++--
 Documentation/pretty-options.txt |   32 ++++++++++++++++++++++----------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index ff41784..0c1c10e 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -177,9 +177,9 @@ May be an unabbreviated ref name or a glob and may be specified
 multiple times.  A warning will be issued for refs that do not exist,
 but a glob that does not match any refs is silently ignored.
 +
-This setting can be disabled by the `--no-standard-notes` option,
+This setting can be disabled by the `--no-notes` option,
 overridden by the 'GIT_NOTES_DISPLAY_REF' environment variable,
-and supplemented by the `--show-notes` option.
+and supplemented by the `--notes=<ref>` option.
 
 Author
 ------
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 50923e2..a9b399b 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -30,19 +30,31 @@ people using 80-column terminals.
 	preferred by the user.  For non plumbing commands this
 	defaults to UTF-8.
 
---no-notes::
---show-notes[=<ref>]::
+--notes[=<ref>]::
 	Show the notes (see linkgit:git-notes[1]) that annotate the
 	commit, when showing the commit log message.  This is the default
 	for `git log`, `git show` and `git whatchanged` commands when
-	there is no `--pretty`, `--format` nor `--oneline` option is
-	given on the command line.
+	there is no `--pretty`, `--format` nor `--oneline` option given
+	on the command line.
++
+By default, the notes shown are from the notes refs listed in the
+'core.notesRef' and 'notes.displayRef' variables (or corresponding
+environment overrides). See linkgit:git-config[1] for more details.
 +
-With an optional argument, add this ref to the list of notes.  The ref
-is taken to be in `refs/notes/` if it is not qualified.
+With an optional '<ref>' argument, add this notes ref to the list of
+notes refs to be shown. The ref is taken to be in `refs/notes/` if it
+is not qualified.
 
+--no-notes::
+	Do not show notes. This negates the above `--notes` option, by
+	resetting the list of notes refs from which notes are shown.
+	This can be combined with the above `--notes` option to control
+	exactly which notes refs are shown. E.g. "--notes=foo" will show
+	notes, both from the default notes ref, and from "refs/notes/foo",
+	while "--no-notes --notes=foo" will only show notes from
+	"refs/notes/foo".
+
+--show-notes[=<ref>]::
 --[no-]standard-notes::
-	Enable or disable populating the notes ref list from the
-	'core.notesRef' and 'notes.displayRef' variables (or
-	corresponding environment overrides).  Enabled by default.
-	See linkgit:git-config[1].
+	These options are deprecated. Use the above --notes/--no-notes
+	options instead.
-- 
1.7.4
