From: Johannes Gilger <heipei@hackvalue.de>
Subject: [PATCH] Initialize notes trees if %N is used and no --show-notes
 given
Date: Mon, 5 Apr 2010 13:55:48 +0200
Message-ID: <20100405115548.GA19971@macbook.lan.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 05 14:37:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NylYy-0004wV-Un
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 14:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452Ab0DEMhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 08:37:48 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:56732 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386Ab0DEMhq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 08:37:46 -0400
X-Greylist: delayed 2514 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Apr 2010 08:37:46 EDT
Received: from p5082b60d.dip.t-dialin.net ([80.130.182.13]:51200 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1NykuE-0004HK-EG
	for git@vger.kernel.org; Mon, 05 Apr 2010 13:55:50 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 80.130.182.13
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143978>

Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
---
Hi list,

this bug bit me when I used 'git log --format="%N"' without adding
--show-notes, which caused git to fail an assertion:
 Assertion failed: (display_notes_trees), function format_display_notes, file notes.c, line 1186.

While this patch fixes this behaviour, I'm not sure it's at the right
place or doesn't impact performance. So this is meant more as a
bug-report.

Greetings,
Jojo

 notes.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/notes.c b/notes.c
index e425e19..83f39ae 100644
--- a/notes.c
+++ b/notes.c
@@ -1183,6 +1183,8 @@ void format_display_notes(const unsigned char *object_sha1,
 			  struct strbuf *sb, const char *output_encoding, int flags)
 {
 	int i;
+	if (!display_notes_trees)
+		init_display_notes(NULL);
 	assert(display_notes_trees);
 	for (i = 0; display_notes_trees[i]; i++)
 		format_note(display_notes_trees[i], object_sha1, sb,
-- 
1.7.0.4.360.g11766c
