From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH] Avoid ambiguous error message if pack.idx header is wrong
Date: Tue, 14 Aug 2007 16:42:37 -0300
Organization: Mandriva
Message-ID: <20070814164237.20aa54c9@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 21:43:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL2If-0001U7-Fo
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 21:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933365AbXHNTnC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 15:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934912AbXHNTnB
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 15:43:01 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:53401 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934785AbXHNTm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 15:42:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 9251B1AB40;
	Tue, 14 Aug 2007 16:42:56 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id StgLokedUMQM; Tue, 14 Aug 2007 16:42:50 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id F39601AB4D;
	Tue, 14 Aug 2007 16:42:40 -0300 (BRT)
X-Mailer: Claws Mail 2.10.0 (GTK+ 2.11.6; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55850>


Print the index version when an error occurs so the user
knows what type of header (and size) we thought the index
should have had.

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
---
 sha1_file.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index aca741b..b219d4d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -497,7 +497,7 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 		 */
 		if (idx_size != 4*256 + nr * 24 + 20 + 20) {
 			munmap(idx_map, idx_size);
-			return error("wrong index file size in %s", path);
+			return error("wrong index v1 file size in %s", path);
 		}
 	} else if (version == 2) {
 		/*
@@ -519,7 +519,7 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 			max_size += (nr - 1)*8;
 		if (idx_size < min_size || idx_size > max_size) {
 			munmap(idx_map, idx_size);
-			return error("wrong index file size in %s", path);
+			return error("wrong index v2 file size in %s", path);
 		}
 		if (idx_size != min_size) {
 			/* make sure we can deal with large pack offsets */
-- 
1.5.3.GIT



-- 
Luiz Fernando N. Capitulino
