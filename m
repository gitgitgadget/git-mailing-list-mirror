From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/9] List commonly used (or recognized) commands
Date: Fri, 25 Jul 2008 12:45:58 -0700
Message-ID: <1217015167-4680-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:47:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMTFw-0005XG-TK
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 21:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbYGYTqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 15:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbYGYTqK
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 15:46:10 -0400
Received: from george.spearce.org ([209.20.77.23]:45922 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbYGYTqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 15:46:09 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C0A213841D; Fri, 25 Jul 2008 19:46:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C36A0383A3;
	Fri, 25 Jul 2008 19:46:07 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc0.182.gb96c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90096>

This series adds support to jgit to list commonly used subcommands
if the user just executes `jgit` with no subcommand requested:

  $ jgit
  jgit --git-dir GIT_DIR --help (-h) --show-stack-trace command [ARG ...]
  
  The most commonly used commands are:
   fetch  Update remote refs from another repository
   log    View commit history
   push   Update remote repository from local refs
   tag    Create a tag

Commands inside of the pgm.debug package are automatically given
the debug- prefix, allowing debug-show-commands to be used to show
the command table.

Commands must be listed in the META-INF/services/org...TextBuiltin
file in order to be considered for execution.  This means that we
must add (or remove) command class names from the listing each time
we introduce or remove a command line subcommand.

One advantage to this structure is additional commands can defined
in other packages, and are available so long as the classes are
reachable through the CLASSPATH.  Since jgit.sh hardcodes the
CLASSPATH to only itself this is not fully supported yet, but does
open the door for users to extend jgit's command line support.


Shawn O. Pearce (9):
  Switch jgit.pgm to J2SE-1.5 execution environment
  Remove unnecessary duplicate if (help) test inside TextBuiltin
  Create an optional documentation annotation for TextBuiltin
  Create a lightweight registration wrapper for TextBuiltin
  Create a catalog of CommandRefs for lookup and enumeration
  Document some common commands with the new Command annotation
  Include commonly used commands in main help output
  Refactor SubcommandHandler to use CommandCatalog instead of
    reflection
  Add debug-show-commands to display the command table

 org.spearce.jgit.pgm/.classpath                    |    2 +-
 .../services/org.spearce.jgit.pgm.TextBuiltin      |   14 ++
 .../src/org/spearce/jgit/pgm/Command.java          |   72 ++++++++
 .../src/org/spearce/jgit/pgm/CommandCatalog.java   |  188 ++++++++++++++++++++
 .../src/org/spearce/jgit/pgm/CommandRef.java       |  158 ++++++++++++++++
 .../src/org/spearce/jgit/pgm/Fetch.java            |    1 +
 .../src/org/spearce/jgit/pgm/Log.java              |    1 +
 .../src/org/spearce/jgit/pgm/Main.java             |   18 ++
 .../src/org/spearce/jgit/pgm/Push.java             |    1 +
 .../src/org/spearce/jgit/pgm/Tag.java              |    1 +
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |   17 +--
 .../org/spearce/jgit/pgm/debug/ShowCommands.java   |   78 ++++++++
 .../spearce/jgit/pgm/opt/SubcommandHandler.java    |   65 +------
 13 files changed, 543 insertions(+), 73 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Command.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/CommandCatalog.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/CommandRef.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowCommands.java
