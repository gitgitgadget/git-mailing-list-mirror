From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/2] Add file delete/create info when we overflow
 rename_limit
Date: Mon, 27 Oct 2008 13:06:16 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810271305500.3386@nehalem.linux-foundation.org>
References: <alpine.LFD.2.00.0810271256470.3386@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 21:08:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuYNZ-0006zl-8V
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 21:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbYJ0UGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 16:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752833AbYJ0UGh
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 16:06:37 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36344 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752831AbYJ0UGg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Oct 2008 16:06:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9RK6HSE014593
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Oct 2008 13:06:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9RK6GDk008264;
	Mon, 27 Oct 2008 13:06:16 -0700
In-Reply-To: <alpine.LFD.2.00.0810271256470.3386@nehalem.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.941 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99260>


When we refuse to do rename detection due to having too many files
created or deleted, let the user know the numbers.  That way there is a
reasonable starting point for setting the diff.renamelimit option.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 diffcore-rename.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 1b2ebb4..168a95b 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -493,7 +493,7 @@ void diffcore_rename(struct diff_options *options)
 	if ((num_create > rename_limit && num_src > rename_limit) ||
 	    (num_create * num_src > rename_limit * rename_limit)) {
 		if (options->warn_on_too_large_rename)
-			warning("too many files, skipping inexact rename detection");
+			warning("too many files (created: %d deleted: %d), skipping inexact rename detection", num_create, num_src);
 		goto cleanup;
 	}
 
-- 
1.6.0.3.517.g759a.dirty
