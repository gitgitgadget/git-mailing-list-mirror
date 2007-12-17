From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] (squashme) gitcli documentation fixups
Date: Sun, 16 Dec 2007 23:28:47 -0800
Message-ID: <7v7ijdeq4w.fsf@gitster.siamese.dyndns.org>
References: <20071213055226.GA3636@coredump.intra.peff.net>
	<20071213090604.GA12398@artemis.madism.org>
	<20071213091055.GA5674@coredump.intra.peff.net>
	<20071213093536.GC12398@artemis.madism.org>
	<20071213102636.GD12398@artemis.madism.org>
	<20071213102724.GE12398@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 08:29:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4APw-0000XG-HM
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 08:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760499AbXLQH3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 02:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760374AbXLQH3B
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 02:29:01 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758457AbXLQH26 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 02:28:58 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5349E558D;
	Mon, 17 Dec 2007 02:28:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DBA5558C;
	Mon, 17 Dec 2007 02:28:49 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68510>

This comes directly on top of gitcli documentation patch and is intended
to be squashed into it.

I looked around to see if there is a good place to add gitlink:gitcli[5]
but unfortunately I did not find any.  One possibility, once this
document is enhanced enough to be usable as "introduction to scripting
using plumbing", we could add it to near the top of git(7) where we
refer to the tutorial, user manual and the everyday document, but in the
current form it is too sketchy and does not cover enough.  But we have
to start somewhere.

I think we should add the first rule in the bulletted list.

 * avoid reinventing the wheel.

but it needs a bit more explanation.  Quite a few people seem to try to
reinvent "git rev-parse --verify HEAD" in their scripts using much
higher level "git show -s -1 --pretty=format:xxx", which is unfortunate
and disgusting at the same time.

---

 Documentation/gitcli.txt |   45 +++++++++++++++++++++++++++------------------
 Makefile                 |    1 +
 2 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 3b3f5e4..f790b78 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -3,7 +3,7 @@ gitcli(5)
 
 NAME
 ----
-gitcli - git command line interface and its usual conventions
+gitcli - git command line interface and conventions
 
 SYNOPSIS
 --------
@@ -12,31 +12,40 @@ gitcli
 
 DESCRIPTION
 -----------
-This manual intends to describe best practice in how to use git CLI.  Here are
+
+This manual describes best practice in how to use git CLI.  Here are
 the rules that you should follow when you are scripting git:
 
  * it's preferred to use the non dashed form of git commands, which means that
    you should prefer `"git foo"` to `"git-foo"`.
 
- * splitting short option switches in separate atoms (prefer `"git foo -a -b"`
+ * splitting short options to separate words (prefer `"git foo -a -b"`
    to `"git foo -ab"`, the latter may not even work).
 
- * when a command line switch takes an argument, use the 'sticked' form, which
-   means that you must prefer `"git foo -oArg"` to `"git foo -o Arg"` for short
-   option switches, and `"git foo --long-opt=Arg"` to `"git foo --long-opt Arg"`
-   for long switches.
+ * when a command line option takes an argument, use the 'sticked' form.  In
+   other words, write `"git foo -oArg"` instead of `"git foo -o Arg"` for short
+   options, and `"git foo --long-opt=Arg"` instead of `"git foo --long-opt Arg"`
+   for long options.  An option that takes optional option-argument must be
+   written in the 'sticked' form.
+
+ * when you give a revision parameter to a command, make sure the parameter is
+   not ambiguous with a name of a file in the work tree.  E.g. do not write
+   `"git log -1 HEAD"` but write `"git log -1 HEAD --"`; the former will not work
+   if you happen to have a file called `HEAD` in the work tree.
 
 
 ENHANCED CLI
 ------------
-From the git 1.5.4 series and further, git commands (not all of them at the
-time of the writing though) come with an enhanced option parser with nice
-facilities. Here is an exhaustive list of them
+From the git 1.5.4 series and further, many git commands (not all of them at the
+time of the writing though) come with an enhanced option parser.
+
+Here is an exhaustive list of the facilities provided by this option parser.
+
 
 Magic Options
 ~~~~~~~~~~~~~
 Commands which have the enhanced option parser activated all understand a
-couple of magic command line switches:
+couple of magic command line options:
 
 -h::
 	gives a pretty printed usage of the command.
@@ -54,14 +63,14 @@ usage: git-describe [options] <committish>*
 ---------------------------------------------
 
 --help-all::
-	Some git commands takes options that are only used for plumbing or that
+	Some git commands take options that are only used for plumbing or that
 	are deprecated, and such options are hidden from the default usage. This
-	switch gives the full list of options.
+	option gives the full list of options.
 
 
 Negating options
 ~~~~~~~~~~~~~~~~
-Another things to keep in mind is that long options can be negated. For
+Boolean options with long option names can be negated by prefixing `"--no-"`. For
 example, `"git branch"` has the option `"--track"` which is 'on' by default. You
 can use `"--no-track"` to override that behaviour. The same goes for `"--color"`
 and `"--no-color"`.
@@ -74,10 +83,10 @@ options. This means that you can for example use `"git rm -rf"` or
 `"git clean -fdx"`.
 
 
-Separating argument from the switch
+Separating argument from the option
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-Also for option switches that take a mandatory argument, you can separate it
-from the switch. That means that all the following uses are correct:
+You can write the mandatory option parameter to an option as a separate
+word on the command line.  That means that all the following uses work:
 
 ----------------------------
 $ git foo --long-opt=Arg
@@ -86,7 +95,7 @@ $ git foo -oArg
 $ git foo -o Arg
 ----------------------------
 
-However, this is *NOT* possible for switches with an optionnal value, where the
+However, this is *NOT* allowed for switches with an optionnal value, where the
 'sticked' form must be used:
 ----------------------------
 $ git describe --abbrev HEAD     # correct
diff --git a/Makefile b/Makefile
index 617e5f5..fd9b939 100644
--- a/Makefile
+++ b/Makefile
@@ -1172,6 +1172,7 @@ check-docs::
 		documented,gitattributes | \
 		documented,gitignore | \
 		documented,gitmodules | \
+		documented,gitcli | \
 		documented,git-tools | \
 		sentinel,not,matching,is,ok ) continue ;; \
 		esac; \
-- 
1.5.4.rc0.54.g3eb2
