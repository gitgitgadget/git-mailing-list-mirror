From: Johan Herland <johan@herland.net>
Subject: [PATCH 7/6] log/pretty-options: Document --[no-]notes and deprecate
 old notes options
Date: Wed, 30 Mar 2011 02:57:19 +0200
Message-ID: <201103300257.19921.johan@herland.net>
References: <e83f8b622fba5add563fc331ae3922b79a0af008.1301392999.git.git@drmicha.warpmail.net>
 <201103300018.55371.johan@herland.net>
 <20110330002206.GB1161@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 02:57:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4jj3-00073D-34
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 02:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309Ab1C3A51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 20:57:27 -0400
Received: from smtp.getmail.no ([84.208.15.66]:50181 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755201Ab1C3A50 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 20:57:26 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIU008F3INO4160@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 30 Mar 2011 02:57:24 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id DC8ED1EEEC9B_D927FF3B	for <git@vger.kernel.org>; Wed,
 30 Mar 2011 00:57:23 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id DBA811EEEC6D_D927FF0F	for <git@vger.kernel.org>; Wed,
 30 Mar 2011 00:57:20 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIU008O1INK0000@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 30 Mar 2011 02:57:20 +0200 (MEST)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.1; x86_64; ; )
In-reply-to: <20110330002206.GB1161@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170345>

Document the behavior or the new --notes, --notes=<ref> and --no-notes
options, and list --show-notes[=<ref>] and --[no-]standard-notes options
as deprecated.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Wednesday 30 March 2011, Jeff King wrote:
> On Wed, Mar 30, 2011 at 12:18:55AM +0200, Johan Herland wrote:
> > And here's some documentation to go on top.
> [...]
> This example is wrong. "--notes=foo" will show _only_ foo. A few
> examples:
> 
>   --notes=foo ;# only foo
>   --notes --notes=foo ;# foo and default
>   --notes=foo --notes=bar --notes --no-notes --notes=foo ;# only foo
> 
> Make sense?

Yeah, I really screwed that up. Hope this version is better. :)

...Johan


 Documentation/git-log.txt        |    4 ++--
 Documentation/pretty-options.txt |   35 +++++++++++++++++++++++++----------
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index ff41784..ab3757b 100644
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
+and overridden by the `--notes=<ref>` option.
 
 Author
 ------
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 50923e2..d5c9772 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -30,19 +30,34 @@ people using 80-column terminals.
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
++
+With an optional '<ref>' argument, show this notes ref instead of the
+default notes ref(s). The ref is taken to be in `refs/notes/` if it
+is not qualified.
 +
-With an optional argument, add this ref to the list of notes.  The ref
-is taken to be in `refs/notes/` if it is not qualified.
+Multiple --notes options can be combined to control which notes are
+being displayed. Examples: "--notes=foo" will show only notes from
+"refs/notes/foo"; "--notes=foo --notes" will show both notes from
+"refs/notes/foo" and from the default notes ref(s).
 
+--no-notes::
+	Do not show notes. This negates the above `--notes` option, by
+	resetting the list of notes refs from which notes are shown.
+	Options are parsed in the order given on the command line, so e.g.
+	"--notes --notes=foo --no-notes --notes=bar" will only show notes
+	from "refs/notes/bar".
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
