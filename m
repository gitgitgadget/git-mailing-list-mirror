From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH]: tree-walk.h: Warning fix
Date: Tue, 19 Jun 2007 23:11:27 -0300
Organization: Mandriva
Message-ID: <20070619231127.7ffe273b@gnut>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 20 04:11:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0pfl-0002hX-Qu
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 04:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758321AbXFTCLt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 22:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758356AbXFTCLt
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 22:11:49 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:59256 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758314AbXFTCLs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 22:11:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 4187218000;
	Tue, 19 Jun 2007 23:11:47 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id hJvvaCeps0O4; Tue, 19 Jun 2007 23:11:42 -0300 (BRT)
Received: from gnut (unknown [189.4.10.162])
	by perninha.conectiva.com.br (Postfix) with ESMTP id DA89E17705;
	Tue, 19 Jun 2007 23:11:40 -0300 (BRT)
X-Mailer: Claws Mail 2.7.2 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50520>


Code that is using libgit.a, and hence including GIT's headers, may
get this warning:

"""
../tree-walk.h: In function 'tree_entry_len':
../tree-walk.h:25: warning: cast discards qualifiers from pointer target type
../tree-walk.h:25: warning: cast discards qualifiers from pointer target type
"""

This happens because the cast used in tree_entry_len() is discarding
the const qualifier (thanks to Shawn Pearce by noticing this).

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@gmail.com>

diff --git a/tree-walk.h b/tree-walk.h
index ee747ab..625198f 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -22,7 +22,7 @@ static inline const unsigned char *tree_entry_extract(struct tree_desc *desc, co
 
 static inline int tree_entry_len(const char *name, const unsigned char *sha1)
 {
-	return (char *)sha1 - (char *)name - 1;
+	return (const char *)sha1 - (const char *)name - 1;
 }
 
 void update_tree_entry(struct tree_desc *);
