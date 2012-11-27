From: Max Horn <max@quendi.de>
Subject: [PATCH v2 1/6] git-remote-helpers.txt: document invocation before input format
Date: Wed, 28 Nov 2012 00:03:21 +0100
Message-ID: <1354057407-83151-2-git-send-email-max@quendi.de>
References: <1354057407-83151-1-git-send-email-max@quendi.de>
Cc: Max Horn <max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 00:04:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdUCB-0004vT-VI
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 00:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536Ab2K0XDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 18:03:47 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:53647 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754355Ab2K0XDq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2012 18:03:46 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=localhost.localdomain); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1TdUBs-0001yU-UB; Wed, 28 Nov 2012 00:03:44 +0100
X-Mailer: git-send-email 1.8.0.393.gcc9701d
In-Reply-To: <1354057407-83151-1-git-send-email-max@quendi.de>
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1354057426;4e34e524;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210612>

In the distant past, the order things were documented was
'Invocation', 'Commands', 'Capabilities', ...

Then it was decided that before giving a list of Commands, there
should be an overall description of the 'Input format', which was
a wise decision. However, this description was put as the very
first thing, with the rationale that any implementor would want
to know that first.

However, it seems an implementor would actually first need to
know how the remote helper will be invoked, so moving
'Invocation' to the front again seems logical. Moreover, we now
don't switch from discussing the input format to the invocation
style and then back to input related stuff.

Signed-off-by: Max Horn <max@quendi.de>
---
 Documentation/git-remote-helpers.txt | 62 ++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 5ce4cda..9a7e583 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -35,6 +35,37 @@ transport protocols, such as 'git-remote-http', 'git-remote-https',
 'git-remote-ftp' and 'git-remote-ftps'. They implement the capabilities
 'fetch', 'option', and 'push'.
 
+INVOCATION
+----------
+
+Remote helper programs are invoked with one or (optionally) two
+arguments. The first argument specifies a remote repository as in git;
+it is either the name of a configured remote or a URL. The second
+argument specifies a URL; it is usually of the form
+'<transport>://<address>', but any arbitrary string is possible.
+The 'GIT_DIR' environment variable is set up for the remote helper
+and can be used to determine where to store additional data or from
+which directory to invoke auxiliary git commands.
+
+When git encounters a URL of the form '<transport>://<address>', where
+'<transport>' is a protocol that it cannot handle natively, it
+automatically invokes 'git remote-<transport>' with the full URL as
+the second argument. If such a URL is encountered directly on the
+command line, the first argument is the same as the second, and if it
+is encountered in a configured remote, the first argument is the name
+of that remote.
+
+A URL of the form '<transport>::<address>' explicitly instructs git to
+invoke 'git remote-<transport>' with '<address>' as the second
+argument. If such a URL is encountered directly on the command line,
+the first argument is '<address>', and if it is encountered in a
+configured remote, the first argument is the name of that remote.
+
+Additionally, when a configured remote has 'remote.<name>.vcs' set to
+'<transport>', git explicitly invokes 'git remote-<transport>' with
+'<name>' as the first argument. If set, the second argument is
+'remote.<name>.url'; otherwise, the second argument is omitted.
+
 INPUT FORMAT
 ------------
 
@@ -173,37 +204,6 @@ advertised with this capability must cover all refs reported by
 the list command.  If no 'refspec' capability is advertised,
 there is an implied `refspec *:*`.
 
-INVOCATION
-----------
-
-Remote helper programs are invoked with one or (optionally) two
-arguments. The first argument specifies a remote repository as in git;
-it is either the name of a configured remote or a URL. The second
-argument specifies a URL; it is usually of the form
-'<transport>://<address>', but any arbitrary string is possible.
-The 'GIT_DIR' environment variable is set up for the remote helper
-and can be used to determine where to store additional data or from
-which directory to invoke auxiliary git commands.
-
-When git encounters a URL of the form '<transport>://<address>', where
-'<transport>' is a protocol that it cannot handle natively, it
-automatically invokes 'git remote-<transport>' with the full URL as
-the second argument. If such a URL is encountered directly on the
-command line, the first argument is the same as the second, and if it
-is encountered in a configured remote, the first argument is the name
-of that remote.
-
-A URL of the form '<transport>::<address>' explicitly instructs git to
-invoke 'git remote-<transport>' with '<address>' as the second
-argument. If such a URL is encountered directly on the command line,
-the first argument is '<address>', and if it is encountered in a
-configured remote, the first argument is the name of that remote.
-
-Additionally, when a configured remote has 'remote.<name>.vcs' set to
-'<transport>', git explicitly invokes 'git remote-<transport>' with
-'<name>' as the first argument. If set, the second argument is
-'remote.<name>.url'; otherwise, the second argument is omitted.
-
 COMMANDS
 --------
 
-- 
1.8.0.393.gcc9701d
