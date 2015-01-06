From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v2 1/2] notes: accept any ref
Date: Mon,  5 Jan 2015 22:03:52 -1000
Message-ID: <4066d4aa9a52b58b40b3abed21eaf35@74d39fa044aa309eaea14b9f57fe79c>
References: <d4509363c8f670483dacdd2a5070f5a@74d39fa044aa309eaea14b9f57fe79c>
Cc: Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 09:04:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8P7l-00035D-Tp
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 09:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105AbbAFIEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 03:04:09 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:42152 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044AbbAFIEG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 03:04:06 -0500
Received: by mail-pa0-f42.google.com with SMTP id et14so30594584pad.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 00:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XK9/LL8Yi7fK4Sb68ksa6WZ8K5uvM7myQ8NFzYLTbbc=;
        b=joGn9YSfhF58ZtyRGV1zoc3Pq170E7NLMBHVmaZ2jEoPwvu55Dx24SJ+bory6ceNFH
         sVzhV4xBmM+J/tTM5x0k0xsxDlXNjD8pFER851gTMZIjoKotaADQSmlnP0REY/FGZRM6
         dDKA6GLrE8CxzehQ30l2LCuoGbfXC+byTXo9hzngifi9vIR78uS6+6TLTxu7sBSRuVnN
         TsLwGXQzbBu1Oxnn0vAqSWvu73O73WbGgKpF42KkZqOYAYcIK/mrSkd3u/YCtbE9ZwAV
         3kS+ohdJE8Q9gmH58OgOLqa43Wg6M66ZSvRBImkFYpkvuKFDlJsT6M0PhaqmyDgiUA9X
         l8kg==
X-Received: by 10.70.37.104 with SMTP id x8mr151267613pdj.119.1420531445708;
        Tue, 06 Jan 2015 00:04:05 -0800 (PST)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ug6sm56550745pab.7.2015.01.06.00.04.04
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 00:04:05 -0800 (PST)
In-Reply-To: <d4509363c8f670483dacdd2a5070f5a@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262046>

From: Scott Chacon <schacon@gmail.com>

Currently if you try to merge notes, the notes code ensures that the
reference is under the 'refs/notes' namespace. In order to do any sort
of collaborative workflow, this doesn't work well as you can't easily
have local notes refs seperate from remote notes refs.

This patch changes the expand_notes_ref function to check for simply a
leading refs/ instead of refs/notes to check if we're being passed an
expanded notes reference. This would allow us to set up
refs/remotes-notes or otherwise keep mergeable notes references outside
of what would be contained in the notes push refspec.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---
 notes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/notes.c b/notes.c
index c763a21e..7165a33f 100644
--- a/notes.c
+++ b/notes.c
@@ -1292,7 +1292,7 @@ int copy_note(struct notes_tree *t,
 
 void expand_notes_ref(struct strbuf *sb)
 {
-	if (starts_with(sb->buf, "refs/notes/"))
+	if (starts_with(sb->buf, "refs/"))
 		return; /* we're happy */
 	else if (starts_with(sb->buf, "notes/"))
 		strbuf_insert(sb, 0, "refs/", 5);
-- 
2.1.4
