From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 2/2] parseopt: Add a gitcli(5) man page.
Date: Thu, 13 Dec 2007 11:27:24 +0100
Message-ID: <20071213102724.GE12398@artemis.madism.org>
References: <20071213055226.GA3636@coredump.intra.peff.net> <20071213090604.GA12398@artemis.madism.org> <20071213091055.GA5674@coredump.intra.peff.net> <20071213093536.GC12398@artemis.madism.org> <20071213102636.GD12398@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 11:27:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2lIF-0005z6-PN
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 11:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761412AbXLMK11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 05:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761340AbXLMK11
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 05:27:27 -0500
Received: from pan.madism.org ([88.191.52.104]:48898 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760668AbXLMK1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 05:27:25 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id CF3C019737;
	Thu, 13 Dec 2007 11:27:24 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 065DEDFF4; Thu, 13 Dec 2007 11:27:24 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20071213102636.GD12398@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68140>

This page should hold every information about the git ways to parse command
lines, and best practices to be used for scripting.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 Documentation/Makefile   |    2 +-
 Documentation/gitcli.txt |  104 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/gitcli.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 37ec355..f58f947 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -2,7 +2,7 @@ MAN1_TXT= \
 	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt)) \
 	gitk.txt
-MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt
+MAN5_TXT=gitattributes.txt gitignore.txt gitcli.txt gitmodules.txt
 MAN7_TXT=git.txt
 
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
new file mode 100644
index 0000000..3b3f5e4
--- /dev/null
+++ b/Documentation/gitcli.txt
@@ -0,0 +1,104 @@
+gitcli(5)
+=========
+
+NAME
+----
+gitcli - git command line interface and its usual conventions
+
+SYNOPSIS
+--------
+gitcli
+
+
+DESCRIPTION
+-----------
+This manual intends to describe best practice in how to use git CLI.  Here are
+the rules that you should follow when you are scripting git:
+
+ * it's preferred to use the non dashed form of git commands, which means that
+   you should prefer `"git foo"` to `"git-foo"`.
+
+ * splitting short option switches in separate atoms (prefer `"git foo -a -b"`
+   to `"git foo -ab"`, the latter may not even work).
+
+ * when a command line switch takes an argument, use the 'sticked' form, which
+   means that you must prefer `"git foo -oArg"` to `"git foo -o Arg"` for short
+   option switches, and `"git foo --long-opt=Arg"` to `"git foo --long-opt Arg"`
+   for long switches.
+
+
+ENHANCED CLI
+------------
+From the git 1.5.4 series and further, git commands (not all of them at the
+time of the writing though) come with an enhanced option parser with nice
+facilities. Here is an exhaustive list of them
+
+Magic Options
+~~~~~~~~~~~~~
+Commands which have the enhanced option parser activated all understand a
+couple of magic command line switches:
+
+-h::
+	gives a pretty printed usage of the command.
++
+---------------------------------------------
+$ git describe -h
+usage: git-describe [options] <committish>*
+
+    --contains            find the tag that comes after the commit
+    --debug               debug search strategy on stderr
+    --all                 use any ref in .git/refs
+    --tags                use any tag in .git/refs/tags
+    --abbrev [<n>]        use <n> digits to display SHA-1s
+    --candidates <n>      consider <n> most recent tags (default: 10)
+---------------------------------------------
+
+--help-all::
+	Some git commands takes options that are only used for plumbing or that
+	are deprecated, and such options are hidden from the default usage. This
+	switch gives the full list of options.
+
+
+Negating options
+~~~~~~~~~~~~~~~~
+Another things to keep in mind is that long options can be negated. For
+example, `"git branch"` has the option `"--track"` which is 'on' by default. You
+can use `"--no-track"` to override that behaviour. The same goes for `"--color"`
+and `"--no-color"`.
+
+
+Aggregating short options
+~~~~~~~~~~~~~~~~~~~~~~~~~
+Commands that support the enhanced option parser allow you to aggregate short
+options. This means that you can for example use `"git rm -rf"` or
+`"git clean -fdx"`.
+
+
+Separating argument from the switch
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Also for option switches that take a mandatory argument, you can separate it
+from the switch. That means that all the following uses are correct:
+
+----------------------------
+$ git foo --long-opt=Arg
+$ git foo --long-opt Arg
+$ git foo -oArg
+$ git foo -o Arg
+----------------------------
+
+However, this is *NOT* possible for switches with an optionnal value, where the
+'sticked' form must be used:
+----------------------------
+$ git describe --abbrev HEAD     # correct
+$ git describe --abbrev=10 HEAD  # correct
+$ git describe --abbrev 10 HEAD  # NOT WHAT YOU MEANT
+----------------------------
+
+
+Documentation
+-------------
+Documentation by Pierre Habouzit.
+
+GIT
+---
+Part of the gitlink:git[7] suite
-- 
1.5.3.7.2249.g89c99-dirty
