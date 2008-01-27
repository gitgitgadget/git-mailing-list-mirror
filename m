From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH] Fix off by one error in prep_exclude.
Date: Sun, 27 Jan 2008 13:55:31 -0600
Message-ID: <1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com>
References: <47975FE6.4050709@viscovery.net>
Cc: j.sixt@viscovery.net, Johannes.Schindelin@gmx.de,
	gitster@pobox.com, Shawn Bohrer <shawn.bohrer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 20:57:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJDdB-0001RQ-DN
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 20:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbYA0T46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 14:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752202AbYA0T46
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 14:56:58 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:48681 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbYA0T45 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 14:56:57 -0500
Received: by an-out-0708.google.com with SMTP id d31so306676and.103
        for <git@vger.kernel.org>; Sun, 27 Jan 2008 11:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Q2w1LyKGFWWcHvOIRd02vQ3PokdE4hinkcUnrD2L7Os=;
        b=ZNDM3ZlqGaFD0d5F6cXX2EtW6LhY/Hyke2m2OVF3gAzflMDAS2H95dsZg7N8OAd0NjuRsQ9H4ngzbhEathBBm12g8DLKy8ghsXn5m93Az853bi+3MeLi5NgTVfLfqAJBkzI0COCMCBLXJSFG3iUyAEkoxn+tgyIuredoGoJ0zqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tT3537jy0kMgpFqycEqydzrJ2v7fL2sskHLrQ5to7Emd3O+EV4BJiT3MouWHc2Ztg7fMWLincLWjVm56o/KZmjKVQkn6GK07bPDfoaJB7HjTsJ47SJHtXwlreyggVkiKdQAbc0w5LIOUsCGDrPRaIkoaLHv8y78Ja2guLZ5lWTU=
Received: by 10.100.41.16 with SMTP id o16mr9981776ano.116.1201463816368;
        Sun, 27 Jan 2008 11:56:56 -0800 (PST)
Received: from lintop ( [70.112.149.232])
        by mx.google.com with ESMTPS id j13sm7979287rne.9.2008.01.27.11.56.49
        (version=SSLv3 cipher=OTHER);
        Sun, 27 Jan 2008 11:56:53 -0800 (PST)
Received: by lintop (sSMTP sendmail emulation); Sun, 27 Jan 2008 13:55:31 -0600
X-Mailer: git-send-email 1.5.4.rc5.1.g813e
In-Reply-To: <47975FE6.4050709@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71827>

base + current already includes the trailing slash so adding
one removes the first character of the next directory.

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---

This fixes the oops part of the issue Johannes found, but doesn't
address the fact that we probably should remove files that aren't
a part of the repository at in the first place.

 dir.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dir.c b/dir.c
index 3e345c2..9e5879a 100644
--- a/dir.c
+++ b/dir.c
@@ -237,7 +237,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 			current = 0;
 		}
 		else {
-			cp = strchr(base + current + 1, '/');
+			cp = strchr(base + current, '/');
 			if (!cp)
 				die("oops in prep_exclude");
 			cp++;
-- 
1.5.4-rc2.GIT
