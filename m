From: Max Horn <max@quendi.de>
Subject: [PATCH 4/6] Rearrange the description of remote helper capabilities
Date: Tue, 27 Nov 2012 18:44:37 +0100
Message-ID: <1354038279-76475-5-git-send-email-max@quendi.de>
References: <1354038279-76475-1-git-send-email-max@quendi.de>
Cc: Max Horn <max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 18:45:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdPDq-0003RF-85
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 18:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728Ab2K0RpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 12:45:06 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:45256 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756647Ab2K0RpD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2012 12:45:03 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=localhost.localdomain); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1TdPDO-00080S-TQ; Tue, 27 Nov 2012 18:44:58 +0100
X-Mailer: git-send-email 1.8.0.393.gcc9701d
In-Reply-To: <1354038279-76475-1-git-send-email-max@quendi.de>
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1354038303;591c5d08;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210572>

This also remove some duplication in the descriptions
(e.g. refspec was explained twice with similar level of detail)

Signed-off-by: Max Horn <max@quendi.de>
---
 Documentation/git-remote-helpers.txt | 134 +++++++++++++++--------------------
 1 file changed, 56 insertions(+), 78 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 7eb43d7..7ac1461 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -88,81 +88,17 @@ Each remote helper is expected to support only a subset of commands.
 The operations a helper supports are declared to git in the response
 to the `capabilities` command (see COMMANDS, below).
 
-'option'::
-	For specifying settings like `verbosity` (how much output to
-	write to stderr) and `depth` (how much history is wanted in the
-	case of a shallow clone) that affect how other commands are
-	carried out.
-
-'connect'::
-	For fetching and pushing using git's native packfile protocol
-	that requires a bidirectional, full-duplex connection.
-
-'push'::
-	For listing remote refs and pushing specified objects from the
-	local object store to remote refs.
-
-'fetch'::
-	For listing remote refs and fetching the associated history to
-	the local object store.
-
-'export'::
-	For listing remote refs and pushing specified objects from a
-	fast-import stream to remote refs.
-
-'import'::
-	For listing remote refs and fetching the associated history as
-	a fast-import stream.
-
-'refspec' <refspec>::
-	This modifies the 'import' capability, allowing the produced
-	fast-import stream to modify refs in a private namespace
-	instead of writing to refs/heads or refs/remotes directly.
-	It is recommended that all importers providing the 'import'
-	capability use this.
-+
-A helper advertising the capability
-`refspec refs/heads/*:refs/svn/origin/branches/*`
-is saying that, when it is asked to `import refs/heads/topic`, the
-stream it outputs will update the `refs/svn/origin/branches/topic`
-ref.
-+
-This capability can be advertised multiple times.  The first
-applicable refspec takes precedence.  The left-hand of refspecs
-advertised with this capability must cover all refs reported by
-the list command.  If no 'refspec' capability is advertised,
-there is an implied `refspec *:*`.
-
-'bidi-import'::
-	The fast-import commands 'cat-blob' and 'ls' can be used by remote-helpers
-	to retrieve information about blobs and trees that already exist in
-	fast-import's memory. This requires a channel from fast-import to the
-	remote-helper.
-	If it is advertised in addition to "import", git establishes a pipe from
-	fast-import to the remote-helper's stdin.
-	It follows that git and fast-import are both connected to the
-	remote-helper's stdin. Because git can send multiple commands to
-	the remote-helper it is required that helpers that use 'bidi-import'
-	buffer all 'import' commands of a batch before sending data to fast-import.
-	This is to prevent mixing commands and fast-import responses on the
-	helper's stdin.
-
-'export-marks' <file>::
-	This modifies the 'export' capability, instructing git to dump the
-	internal marks table to <file> when complete. For details,
-	read up on '--export-marks=<file>' in linkgit:git-fast-export[1].
-
-'import-marks' <file>::
-	This modifies the 'export' capability, instructing git to load the
-	marks specified in <file> before processing any input. For details,
-	read up on '--import-marks=<file>' in linkgit:git-fast-export[1].
+In the following, we list all defined capabilities and for
+each we list which commands a helper with that capability
+must provide.
 
 Capabilities for Pushing
-~~~~~~~~~~~~~~~~~~~~~~~~
+^^^^^^^^^^^^^^^^^^^^^^^^
 'connect'::
 	Can attempt to connect to 'git receive-pack' (for pushing),
-	'git upload-pack', etc for communication using the
-	packfile protocol.
+	'git upload-pack', etc for communication using
+	git's native packfile protocol. This
+	requires a bidirectional, full-duplex connection.
 +
 Supported commands: 'connect'.
 
@@ -186,11 +122,12 @@ Other frontends may have some other order of preference.
 
 
 Capabilities for Fetching
-~~~~~~~~~~~~~~~~~~~~~~~~~
+^^^^^^^^^^^^^^^^^^^^^^^^^
 'connect'::
 	Can try to connect to 'git upload-pack' (for fetching),
 	'git receive-pack', etc for communication using the
-	packfile protocol.
+	git's native packfile protocol. This
+	requires a bidirectional, full-duplex connection.
 +
 Supported commands: 'connect'.
 
@@ -212,14 +149,27 @@ connecting (see the 'connect' command under COMMANDS).
 When choosing between 'fetch' and 'import', git prefers 'fetch'.
 Other frontends may have some other order of preference.
 
+Miscellaneous capabilities
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+'option'::
+	For specifying settings like `verbosity` (how much output to
+	write to stderr) and `depth` (how much history is wanted in the
+	case of a shallow clone) that affect how other commands are
+	carried out.
+
 'refspec' <refspec>::
-	This modifies the 'import' capability.
+	This modifies the 'import' capability, allowing the produced
+	fast-import stream to modify refs in a private namespace
+	instead of writing to refs/heads or refs/remotes directly.
+	It is recommended that all importers providing the 'import'
+	capability use this.
 +
-A helper advertising
+A helper advertising the capability
 `refspec refs/heads/*:refs/svn/origin/branches/*`
-in its capabilities is saying that, when it handles
-`import refs/heads/topic`, the stream it outputs will update the
-`refs/svn/origin/branches/topic` ref.
+is saying that, when it is asked to `import refs/heads/topic`, the
+stream it outputs will update the `refs/svn/origin/branches/topic`
+ref.
 +
 This capability can be advertised multiple times.  The first
 applicable refspec takes precedence.  The left-hand of refspecs
@@ -227,6 +177,34 @@ advertised with this capability must cover all refs reported by
 the list command.  If no 'refspec' capability is advertised,
 there is an implied `refspec *:*`.
 
+'bidi-import'::
+	This modifies the 'import' capability.
+	The fast-import commands 'cat-blob' and 'ls' can be used by remote-helpers
+	to retrieve information about blobs and trees that already exist in
+	fast-import's memory. This requires a channel from fast-import to the
+	remote-helper.
+	If it is advertised in addition to "import", git establishes a pipe from
+	fast-import to the remote-helper's stdin.
+	It follows that git and fast-import are both connected to the
+	remote-helper's stdin. Because git can send multiple commands to
+	the remote-helper it is required that helpers that use 'bidi-import'
+	buffer all 'import' commands of a batch before sending data to fast-import.
+	This is to prevent mixing commands and fast-import responses on the
+	helper's stdin.
+
+'export-marks' <file>::
+	This modifies the 'export' capability, instructing git to dump the
+	internal marks table to <file> when complete. For details,
+	read up on '--export-marks=<file>' in linkgit:git-fast-export[1].
+
+'import-marks' <file>::
+	This modifies the 'export' capability, instructing git to load the
+	marks specified in <file> before processing any input. For details,
+	read up on '--import-marks=<file>' in linkgit:git-fast-export[1].
+
+
+
+
 COMMANDS
 --------
 
-- 
1.8.0.393.gcc9701d
