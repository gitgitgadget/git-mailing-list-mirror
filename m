From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add Documentation/CodingStyle
Date: Tue, 6 Nov 2007 23:17:50 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711062317330.4362@racer.site>
References: <20071106201518.GA6361@ins.uni-bonn.de> <20071106201809.GD6361@ins.uni-bonn.de>
 <20071106202600.GH6361@ins.uni-bonn.de> <7vtznzf5jb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 00:19:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpXhP-0003N2-Ht
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 00:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbXKFXSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 18:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754756AbXKFXSs
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 18:18:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:52252 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751019AbXKFXSr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 18:18:47 -0500
Received: (qmail invoked by alias); 06 Nov 2007 23:18:45 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp055) with SMTP; 07 Nov 2007 00:18:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JqUta+L0JuY4mmLr8F6U4HzV5ilvuuJ4oZEJWHo
	iXlgocurq94vRz
X-X-Sender: gene099@racer.site
In-Reply-To: <7vtznzf5jb.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63746>


Even if our code is quite a good documentation for our coding style,
some people seem to prefer a document describing it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I long resisted in adding this, as I really believe our code
	base is a very clean one, and a good description of what we
	prefer.

	But it seems that not everybody has the time to study our
	code in depth, beautiful as it is ;-)

	BTW the first to catch the allusion to a certain movie 
	wins a drink with me.

 Documentation/CodingStyle |   87 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 87 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/CodingStyle

diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
new file mode 100644
index 0000000..622b80b
--- /dev/null
+++ b/Documentation/CodingStyle
@@ -0,0 +1,87 @@
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
+ - Use tabs to increment, and interpret tabs as taking up to 8 spaces
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
+ - #include system headers in git-compat-util.h.  Some headers on some
+   systems show subtle breakages when you change the order, so it is
+   best to keep them in one place.
+
+ - if you are planning a new command, consider writing it in shell or
+   perl first, so that changes in semantics can be easily changed and
+   discussed.  Many git commands started out like that, and a few are
+   still scripts.
-- 
1.5.3.5.1597.g7191
