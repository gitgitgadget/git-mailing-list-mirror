From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix git init --shared=all on FreeBSD 4.11
Date: Tue, 4 Mar 2008 00:44:06 +0100
Message-ID: <20080303234406.GA28158@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 00:44:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWKKt-0004i3-EV
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 00:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbYCCXoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 18:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbYCCXoL
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 18:44:11 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:28877 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbYCCXoK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 18:44:10 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTSg3Lc=
Received: from tigra.home (Fa8a4.f.strato-dslnet.de [195.4.168.164])
	by post.webmailer.de (klopstock mo37) (RZmta 16.8)
	with ESMTP id 403f96k23LYt0Y ; Tue, 4 Mar 2008 00:44:07 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E509C277BD;
	Tue,  4 Mar 2008 00:44:06 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 46DA556D24; Tue,  4 Mar 2008 00:44:06 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75999>

At least FreeBSD 4.11p2 does not allow changing SUID/GUID bits to
a non-root user.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

I seem to get really weird systems lately...

 path.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/path.c b/path.c
index af27161..4865e98 100644
--- a/path.c
+++ b/path.c
@@ -265,6 +265,7 @@ int adjust_shared_perm(const char *path)
 		return 0;
 	if (lstat(path, &st) < 0)
 		return -1;
+	st.st_mode &= 07777 & ~(S_ISUID|S_ISGID);
 	mode = st.st_mode;
 	if (mode & S_IRUSR)
 		mode |= (shared_repository == PERM_GROUP
-- 
1.5.4.3.469.gf84e2

