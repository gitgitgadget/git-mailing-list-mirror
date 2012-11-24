From: esr@thyrsus.com (Eric S. Raymond)
Subject: [PATCH] Add documentation on how to integrate commands.
Date: Sat, 24 Nov 2012 07:23:33 -0500 (EST)
Message-ID: <20121124122333.BAD7B4065F@snark.thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 13:24:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcEml-0001d3-Qg
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 13:24:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653Ab2KXMYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2012 07:24:24 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:35328
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab2KXMYY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2012 07:24:24 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id BAD7B4065F; Sat, 24 Nov 2012 07:23:33 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210322>

---
 Documentation/CommandIntegration |   69 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/CommandIntegration

diff --git a/Documentation/CommandIntegration b/Documentation/CommandIntegration
new file mode 100644
index 0000000..be248f7
--- /dev/null
+++ b/Documentation/CommandIntegration
@@ -0,0 +1,69 @@
+= Integrating new subcommands =
+
+This is how-to documentation for people who want to add extension
+commands to git.
+
+== Runtime environment ==
+
+git subcommands are standalone executables that live in the git
+execution directory, normally /usr/lib/git-core.  The git executable itself
+is a thin wrapper that sets GIT_DIR and passes command-line arguments
+to the subcommand.
+
+(If "git foo" is not found in the git execution directory, the wrapper
+will look in the rest of your $PATH for it.  Thus, it's possible
+to write local git extensions that don't live in system space.)
+
+== Implementation languages ==
+
+Most subcommands are written in C or shell.  A few are written in
+Perl.  A tiny minority are written in Python.
+
+While we strongly encourage coding in portable C for portability, these
+specific scripting languages are also acceptable. We won't accept more
+without a very strong technical case, as we don't want to broaden the
+git suite's required dependencies.
+
+C commands are normally written as single modules, named after the
+command, that link a core library called libgit.  Thus, your command
+'git-foo' would normally be implemented as a single "git-foo.c"; this
+organization makes it easy for people reading the code to find things.
+
+See the CodingGuidelines document for other guidance on what we consider
+good practice in C and shell.
+
+== What every extension command needs ==
+
+You must have a man page, written in asciidoc (this is what git help
+followed by your subcommand name will display).  Be aware that there is
+a local asciidoc configuration and macros which you should use.  It's
+often helpful to start by cloning an existing page and replacing the
+text content.
+
+You must have a test, written to report in TAP (Test Anything Protocol).
+Tests are executables (usually shell scripts) that live in the 't' 
+subdirectory of the tree.  Each test name begins with 't' and a sequence
+number that controls where in the test sequence it will be executed;
+conventionally the rest of the name stem is that of the command 
+being tested.
+
+If your test requires an example repository, create it yourself in the
+test script.  There is a test library of shell functions that assists
+wit this; when you use it, the environment is set in a predictable way
+so the author, committer and timestamps are all set to a single well
+known value, allowing git to create a commit that is reproducible on
+all platforms. A test_tick function is used in the scripts to move the
+clock, allowing different times to be used. For an example see
+t7502-commit.sh, or really any script in that directory.
+
+== Integrating a command ==
+
+Here are the things you need to do when you want to merge a new 
+subcommand into the git tree.
+
+1. Append your command name to one of the variables BUILTIN_OBJS,
+EXTRA_PROGRAMS, SCRIPT_SH, SCRIPT_PERL or SCRIPT_PYTHON.
+
+2. Drop its test in the t directory.
+
+That's all there is to it.
-- 
1.7.9.5



-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

The same applies for other kinds of long-lasting low-level pain. [...]
The body's response to being jabbed, pierced, and cut is to produce
endorphins. [...]  So here's my programme for breaking that cycle of
dependency on Windows: get left arm tattooed with dragon motif, buy a
crate of Jamaican Hot! Pepper Sauce, get nipples pierced.  With any
luck that will produce enough endorphins to make Windows completely
redundant, and I can then upgrade to Linux and get on with things.
	-- Pieter Hintjens
