From: ted@tedpavlic.com
Subject: [StGit PATCH 1/2] Modify bash completion to support help, version, and copyright.
Date: Mon, 19 Jan 2009 19:46:12 -0500
Message-ID: <1232412373-10836-1-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, Ted Pavlic <ted@tedpavlic.com>
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Tue Jan 20 01:48:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP4ma-00022g-SV
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 01:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760938AbZATAqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 19:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760736AbZATAqX
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 19:46:23 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:46798 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760163AbZATAqU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 19:46:20 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 678DB80D8038;
	Mon, 19 Jan 2009 19:40:26 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NXk7qUN3bVPR; Mon, 19 Jan 2009 19:40:26 -0500 (EST)
Received: from localhost.localdomain (cpe-76-181-62-78.columbus.res.rr.com [76.181.62.78])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 1CA8C80D8035;
	Mon, 19 Jan 2009 19:40:26 -0500 (EST)
X-Mailer: git-send-email 1.6.1.87.g15624
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106420>

From: Ted Pavlic <ted@tedpavlic.com>

"stg <tab>" lists all commands, including "help", "version", and
"copyright".

"stg he<tab>" completes "stg help "
"stg ver<tab>" completes "stg version "
"stg copy<tab>" completes "stg copyright "

"stg help <tab>" lists all commands /other than/ help, version, and
copyright.

"stg version <tab>" goes directly to shell completion.
"stg copyright <tab>" goes directly to shell completion.

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---
 stgit/completion.py |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/stgit/completion.py b/stgit/completion.py
index affc8c6..b3fd282 100644
--- a/stgit/completion.py
+++ b/stgit/completion.py
@@ -111,13 +111,19 @@ def main_switch(commands):
         ('# Complete name of subcommand if the user has not finished'
          ' typing it yet.'),
         'if test $c -eq $COMP_CWORD -a -z "$command"; then', [
-            ('COMPREPLY=($(compgen -W "$_stg_commands" --'
+            ('COMPREPLY=($(compgen -W "help version copyright $_stg_commands" --'
              ' "${COMP_WORDS[COMP_CWORD]}"))'),
             'return'],
         'fi',
         '',
         '# Complete arguments to subcommands.',
         'case "$command" in', [
+            'help) ', [
+            ('COMPREPLY=($(compgen -W "$_stg_commands" --'
+             ' "${COMP_WORDS[COMP_CWORD]}"))'),
+            'return ;;'],
+            'version) return ;;',
+            'copyright) return ;;'], [
             '%s) _stg_%s ;;' % (cmd, cmd)
             for cmd in sorted(commands.iterkeys())],
         'esac')
-- 
1.6.1.87.g15624
