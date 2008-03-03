From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] receive-pack: Initialize PATH to include exec-dir.
Date: Mon, 3 Mar 2008 05:08:43 +0100
Message-ID: <20080303040843.GA27185@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: srp@srparish.net, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 03 05:09:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW1zU-0002VD-6A
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 05:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757273AbYCCEIr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2008 23:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753467AbYCCEIr
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 23:08:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:44599 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757224AbYCCEIq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 23:08:46 -0500
Received: (qmail invoked by alias); 03 Mar 2008 04:08:45 -0000
Received: from i577B9B39.versanet.de (EHLO atjola.local) [87.123.155.57]
  by mail.gmx.net (mp026) with SMTP; 03 Mar 2008 05:08:45 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19sQN0k0NFs0DsDOkslKjtQOvlSn6H955bmHh0sWl
	atXYNbVg9wjgCD
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75881>

511707d (use only the $PATH for exec'ing git commands) made it a
requirement to call setup_path() to include the git exec-dir in PATH
before spawning any other git commands. git-receive-pack was not yet
adapted to do this and therefore fails to spawn git-unpack-objects if t=
hat
is not in the standard PATH.

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
 receive-pack.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index a971433..f83ae87 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -471,6 +471,8 @@ int main(int argc, char **argv)
 	if (!dir)
 		usage(receive_pack_usage);
=20
+	setup_path(NULL);
+
 	if (!enter_repo(dir, 0))
 		die("'%s': unable to chdir or not a git archive", dir);
=20
--=20
1.5.4.3.1.g3b5b4
