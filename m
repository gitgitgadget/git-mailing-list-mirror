From: Beat Bolli <bbolli@ewanet.ch>
Subject: [PATCH] cherry-pick -x: always insert an empty line
Date: Sat, 18 Feb 2012 22:14:50 +0100
Message-ID: <1329599690-9152-1-git-send-email-bbolli@ewanet.ch>
Cc: Beat Bolli <bbolli@ewanet.ch>, Eric Raible <raible@nextest.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 22:23:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ryrl7-0001hX-Hq
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 22:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505Ab2BRVXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Feb 2012 16:23:01 -0500
Received: from smtp2.mail.fcom.ch ([212.60.46.171]:46003 "EHLO
	smtp2.mail.fcom.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352Ab2BRVW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2012 16:22:58 -0500
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Feb 2012 16:22:58 EST
Received: from smtp2.mail.fcom.ch (localhost [127.0.0.1])
	by smtp2 (Postfix) with ESMTP id 558372D4BF;
	Sat, 18 Feb 2012 22:15:15 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on smtp2.mail.fcom.ch
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_DUL,
	RDNS_DYNAMIC autolearn=no version=3.2.5
Received: from drbeat.li (228-101-204-62-pool.cable.fcom.ch [62.204.101.228])
	by smtp2 (Postfix) with ESMTPS id 0FDA92D4B9;
	Sat, 18 Feb 2012 22:15:12 +0100 (CET)
Received: by drbeat.li (Postfix, from userid 1000)
	id A1BBF17F1A; Sat, 18 Feb 2012 22:15:11 +0100 (CET)
X-Mailer: git-send-email 1.7.9
X-AV-Checked: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191012>

When cherry-picking a commit that has only a summary, the -x option
creates an invalid commit message because it puts the hash of the commit
being picked on the second line which should be left empty.

This patch fixes this buglet by always inserting an empty line before
the added line.

Aside from that, even with a non-trivial commit the generated note
"(cherry picked from commit 555c9864971744abb558796aea28e12a1ac20839)"
seems abrupt when appended directly.

Cc: Eric Raible <raible@nextest.com>
Signed-off-by: Beat Bolli <bbolli@ewanet.ch>
---
 sequencer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5fcbcb8..63fd589 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -382,7 +382,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 
 		if (opts->record_origin) {
-			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
+			strbuf_addstr(&msgbuf, "\n(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
-- 
1.7.9
