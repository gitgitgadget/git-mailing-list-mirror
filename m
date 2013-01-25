From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 8/7] mergetool--lib: don't call "exit" in setup_tool
Date: Fri, 25 Jan 2013 22:03:59 +0000
Message-ID: <20130125220359.GF7498@serenity.lan>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
 <1359107034-14606-8-git-send-email-davvid@gmail.com>
 <20130125195446.GA7498@serenity.lan>
 <20130125200807.GB7498@serenity.lan>
 <7vpq0t2f2t.fsf@alter.siamese.dyndns.org>
 <20130125204619.GC7498@serenity.lan>
 <7vlibh2d8a.fsf@alter.siamese.dyndns.org>
 <20130125211601.GD7498@serenity.lan>
 <7vbocd2auo.fsf@alter.siamese.dyndns.org>
 <20130125220222.GE7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 23:04:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyrO1-0005rK-E4
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 23:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367Ab3AYWEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 17:04:15 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:41082 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab3AYWEI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 17:04:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 6B72ACDA5D2;
	Fri, 25 Jan 2013 22:04:08 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zwhvP98It3iD; Fri, 25 Jan 2013 22:04:06 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 32E4BCDA510;
	Fri, 25 Jan 2013 22:04:06 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 28620161E279;
	Fri, 25 Jan 2013 22:04:06 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bkxkG9aGYcnB; Fri, 25 Jan 2013 22:04:06 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id BE5AE161E20D;
	Fri, 25 Jan 2013 22:04:01 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130125220222.GE7498@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214587>

This will make it easier to use setup_tool in places where we expect
that the selected tool will not support the current mode.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-mergetool--lib.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 4c1e129..c6bd8ba 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -67,11 +67,11 @@ setup_tool () {
 	if merge_mode && ! can_merge
 	then
 		echo "error: '$tool' can not be used to resolve merges" >&2
-		exit 1
+		return 1
 	elif diff_mode && ! can_diff
 	then
 		echo "error: '$tool' can only be used to resolve merges" >&2
-		exit 1
+		return 1
 	fi
 	return 0
 }
@@ -100,7 +100,7 @@ run_merge_tool () {
 	status=0
 
 	# Bring tool-specific functions into scope
-	setup_tool "$1"
+	setup_tool "$1" || return
 
 	if merge_mode
 	then
-- 
1.8.1
