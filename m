From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/2] refs.c: release file descriptor on error return
Date: Thu, 16 Jul 2009 16:25:18 -0500
Message-ID: <W0GiRm9n1NEfjVB8xBotapRpIoR0jr6qkttRpkkGMPpe-bfqtvLM7YBvkMsGo7-vheQxRPBUAEU@cipher.nrlssc.navy.mil>
References: <W0GiRm9n1NEfjVB8xBotanSRY89hxjLPu3Wksn_EsZusMJjkHNIRf8JuQmUh43ny21xTKBn1Li8@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 16 23:26:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRYTQ-0001ME-Bl
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 23:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933422AbZGPVZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 17:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933395AbZGPVZp
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 17:25:45 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53024 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933396AbZGPVZo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 17:25:44 -0400
Received: by mail.nrlssc.navy.mil id n6GLPfdC017301; Thu, 16 Jul 2009 16:25:41 -0500
In-Reply-To: <W0GiRm9n1NEfjVB8xBotanSRY89hxjLPu3Wksn_EsZusMJjkHNIRf8JuQmUh43ny21xTKBn1Li8@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 16 Jul 2009 21:25:41.0223 (UTC) FILETIME=[F85EBF70:01CA065B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123426>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 refs.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index dffe395..e15880f 100644
--- a/refs.c
+++ b/refs.c
@@ -1525,8 +1525,10 @@ int for_each_recent_reflog_ent(const char *ref, each_reflog_ent_fn fn, long ofs,
 		if (fstat(fileno(logfp), &statbuf) ||
 		    statbuf.st_size < ofs ||
 		    fseek(logfp, -ofs, SEEK_END) ||
-		    fgets(buf, sizeof(buf), logfp))
+		    fgets(buf, sizeof(buf), logfp)) {
+			fclose(logfp);
 			return -1;
+		}
 	}
 
 	while (fgets(buf, sizeof(buf), logfp)) {
-- 
1.6.3.1.24.g152f4
