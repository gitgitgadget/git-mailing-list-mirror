From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Add Documentation/CodingStyle
Date: Wed, 7 Nov 2007 14:59:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711071456440.4362@racer.site>
References: <20071106201518.GA6361@ins.uni-bonn.de> <20071106201809.GD6361@ins.uni-bonn.de>
 <20071106202600.GH6361@ins.uni-bonn.de> <7vtznzf5jb.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711062317330.4362@racer.site> <7v640ega5q.fsf@gitster.siamese.dyndns.org>
 <47317CD7.5040506@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 07 16:00:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpmOD-0000Gy-S9
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 16:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758493AbXKGO77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 09:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758311AbXKGO77
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 09:59:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:55746 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758267AbXKGO76 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 09:59:58 -0500
Received: (qmail invoked by alias); 07 Nov 2007 14:59:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 07 Nov 2007 15:59:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/hiMszBtzhEGl6REeH077Gd1u1vPUdbux1F+8nNq
	0CHUKZDXqEXOMd
X-X-Sender: gene099@racer.site
In-Reply-To: <47317CD7.5040506@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63815>


Even if our code is quite a good documentation for our coding style,
some people seem to prefer a document describing it.

The part about the shell scripts is clearly just copied from one of
Junio's helpful mails, and some parts were added from comments by
Junio and Andreas Ericsson.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 7 Nov 2007, Andreas Ericsson wrote:

	> Perhaps with this addendum?
	> 
	> - Think very, very hard before introducing a new dependency into git. This
	>  means you should stay away from scripting languages not already used in
	>  the git core command set unless your command is clearly separate from it,
	>  such as an importer to convert random-scm-X repositories to git.

	I edited it minimally.

 Documentation/CodingStyle |  103 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 103 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/CodingStyle

diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
new file mode 100644
index 0000000..38a3d9f
--- /dev/null
+++ b/Documentation/CodingStyle
@@ -0,0 +1,103 @@
+As a popular project, we also have some guidelines to keep to the
+code.  For git in general, two rough rules are:
+
+ - Most importantly, we never say "It's in POSIX; we'll happily
+   screw your system that does not conform."  We live in the
+   real world.
+
+ - However, we often say "Let's stay away from that construct,
+   it's not even in POSIX".
+
+ - In spite of the above two rules, we sometimes say "Although
+   this is not in POSIX, it (is so convenient | makes the code
+   much more readable | has other good characteristics) and
+   practically all the platforms we care about support it, so
+   let's use it".  Again, we live in the real world, and it is
+   sometimes a judgement call, decided based more on real world
+   constraints people face than what the paper standard says.
+
+
+As for more concrete guidelines, just imitate the existing code
+(this is a good guideline, no matter which project you are contributing
+to...).  But if you must have some list of rules, here they are.
+
+For shell scripts specifically (not exhaustive):
+
+ - We prefer $( ... ) for command substitution; unlike ``, it
+   properly nests.  It should have been the way Bourne spelled
+   it from day one, but unfortunately isn't.
+
+ - We use ${parameter-word} and its [-=?+] siblings, and their
+   colon'ed "unset or null" form.
+
+ - We use ${parameter#word} and its [#%] siblings, and their
+   doubled "longest matching" form.
+
+ - We use Arithmetic Expansion $(( ... )).
+
+ - No "Substring Expansion" ${parameter:offset:length}.
+
+ - No shell arrays.
+
+ - No strlen ${#parameter}.
+
+ - No regexp ${parameter/pattern/string}.
+
+ - We do not use Process Substitution <(list) or >(list).
+
+ - We prefer "test" over "[ ... ]".
+
+ - We do not write noiseword "function" in front of shell
+   functions.
+
+For C programs:
+
+ - Use tabs to indent, and interpret tabs as taking up to 8 spaces
+
+ - Try to keep to 80 characters per line
+
+ - When declaring pointers, the star sides with the variable name, i.e.
+   "char *string", not "char* string" or "char * string".  This makes
+   it easier to understand "char *string, c;"
+
+ - Do not use curly brackets unnecessarily.  I.e.
+
+	if (bla) {
+		x = 1;
+	}
+
+   is frowned upon.  A gray area is when the statement extends over a
+   few lines, and/or you have a lengthy comment atop of it.
+
+ - Try to make your code understandable.  You may put comments in, but
+   comments invariably tend to stale out when the code they were
+   describing changes.  Often splitting a function into two makes the
+   intention of the code much clearer.
+
+   Double negation is often harder to understand than no negation at
+   all.
+
+   Some clever tricks, like using the !! operator with arithmetic
+   constructs, can be extremely confusing to others.  Avoid them,
+   unless there is a compelling reason to use them.
+
+ - Use the API.  No, really.  We have a strbuf (variable length string),
+   several arrays with the ALLOC_GROW() macro, a path_list for sorted
+   string lists, a hash map (mapping struct objects) named
+   "struct decorate", amongst other things.
+
+ - When you come up with an API, document it.
+
+ - #include system headers in git-compat-util.h.  Some headers on some
+   systems show subtle breakages when you change the order, so it is
+   best to keep them in one place.
+
+ - if you are planning a new command, consider writing it in shell or
+   perl first, so that changes in semantics can be easily changed and
+   discussed.  Many git commands started out like that, and a few are
+   still scripts.
+
+ - Avoid introducing a new dependency into git. This means you usually
+   should stay away from scripting languages not already used in the git
+   core command set (unless your command is clearly separate from it,
+   such as an importer to convert random-scm-X repositories to git).
-- 
1.5.3.5.1597.g7191
