From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Plug a memleak in builtin-revert
Date: Tue, 28 Oct 2008 18:27:33 +0100
Message-ID: <20081028172733.GA7054@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 28 18:29:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KusNA-0002ta-3V
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 18:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbYJ1R1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 13:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752460AbYJ1R1i
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 13:27:38 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:20670 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbYJ1R1h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 13:27:37 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8A082pEts
Received: from tigra.home (Facd6.f.strato-dslnet.de [195.4.172.214])
	by post.webmailer.de (mrclete mo54) (RZmta 17.14)
	with ESMTP id N00e3ck9SGQIK2 ; Tue, 28 Oct 2008 18:27:34 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 58EEE277C8;
	Tue, 28 Oct 2008 18:27:34 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 1BF9336D27; Tue, 28 Oct 2008 18:27:34 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99307>

Probably happened when working around git_path's problem with returned
buffer being reused.

---
 builtin-revert.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 4725540..7483a7a 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -251,7 +251,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	int i, index_fd, clean;
 	char *oneline, *reencoded_message = NULL;
 	const char *message, *encoding;
-	const char *defmsg = xstrdup(git_path("MERGE_MSG"));
+	char *defmsg = xstrdup(git_path("MERGE_MSG"));
 	struct merge_options o;
 	struct tree *result, *next_tree, *base_tree, *head_tree;
 	static struct lock_file index_lock;
@@ -432,6 +432,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		return execv_git_cmd(args);
 	}
 	free(reencoded_message);
+	free(defmsg);
 
 	return 0;
 }
-- 
1.6.0.3.549.gb475d
