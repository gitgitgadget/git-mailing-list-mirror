From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] git-remote-testpy: fix patch hashing on Python 3
Date: Sat, 26 Jan 2013 23:32:42 +0000
Message-ID: <20130126233242.GM7498@serenity.lan>
References: <cover.1358686905.git.john@keeping.me.uk>
 <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk>
 <20130126175158.GK7498@serenity.lan>
 <7vwquzzkiw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 00:33:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzFFf-0000EJ-M5
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 00:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743Ab3AZXcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 18:32:50 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:35240 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728Ab3AZXct (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 18:32:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id E80766064C7;
	Sat, 26 Jan 2013 23:32:48 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eKmiBw6z5pll; Sat, 26 Jan 2013 23:32:48 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 566096064A8;
	Sat, 26 Jan 2013 23:32:43 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vwquzzkiw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214644>

When this change was originally made (0846b0c - git-remote-testpy: hash bytes
explicitly , I didn't realised that the "hex" encoding we chose is a "bytes to
bytes" encoding so it just fails with an error on Python 3 in the same way as
the original code.

Since we want to convert a Unicode string to bytes, UTF-8 really is the best
option here.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Sat, Jan 26, 2013 at 01:44:55PM -0800, Junio C Hamano wrote:
> Ahh.  I think it is already in "next", so this needs to be turned
> into an incremental to flip 'hex' to 'utf-8', with the justification
> being these five lines above.

Here it is, based on next obviously.

 git-remote-testpy.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-remote-testpy.py b/git-remote-testpy.py
index c7a04ec..4713363 100644
--- a/git-remote-testpy.py
+++ b/git-remote-testpy.py
@@ -45,7 +45,7 @@ def get_repo(alias, url):
     repo.get_head()
 
     hasher = _digest()
-    hasher.update(repo.path.encode('hex'))
+    hasher.update(repo.path.encode('utf-8'))
     repo.hash = hasher.hexdigest()
 
     repo.get_base_path = lambda base: os.path.join(
-- 
1.8.1.1
