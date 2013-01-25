From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 9/7] mergetool--lib: fix path lookup in guess_merge_tool
Date: Fri, 25 Jan 2013 22:04:42 +0000
Message-ID: <20130125220442.GG7498@serenity.lan>
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
X-From: git-owner@vger.kernel.org Fri Jan 25 23:05:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyrOZ-00066F-4c
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 23:05:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371Ab3AYWEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 17:04:50 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:41310 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145Ab3AYWEt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 17:04:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 037D7CDA58B;
	Fri, 25 Jan 2013 22:04:49 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vsd6qHBqtFIv; Fri, 25 Jan 2013 22:04:48 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 5FD68CDA510;
	Fri, 25 Jan 2013 22:04:43 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130125220222.GE7498@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214588>

guess_merge_tool calls translate_merge_tool_path in order to get the
correct name of the tool to check whether it can be found on the user's
system.  But this function is designed to be overridden by tool
scriptlets so it does nothing if the relevant scriptlet has not been
sourced.

Fix this by calling setup_tool before doing anything.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-mergetool--lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index c6bd8ba..46860c5 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -219,6 +219,7 @@ guess_merge_tool () {
 	# Loop over each candidate and stop when a valid merge tool is found.
 	for i in $tools
 	do
+		setup_tool "$i" 2>&1 || continue
 		merge_tool_path="$(translate_merge_tool_path "$i")"
 		if type "$merge_tool_path" >/dev/null 2>&1
 		then
-- 
1.8.1
