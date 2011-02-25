From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] mergetool-lib: call vim in readonly mode for diffs
Date: Fri, 25 Feb 2011 10:36:39 +0100
Message-ID: <227c6e4e11ce964a6e6898afb422d424d46a7b50.1298626494.git.git@drmicha.warpmail.net>
References: <20110224203412.29b732b9@glyph>
Cc: Junio C Hamano <gitster@pobox.com>, netuse@lavabit.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 25 10:40:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psu9e-0004J5-3X
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 10:40:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382Ab1BYJkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 04:40:00 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53242 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932377Ab1BYJj7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 04:39:59 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 55A0320260;
	Fri, 25 Feb 2011 04:39:59 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 25 Feb 2011 04:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=U98iMnGxPmGEw1UrMYxU4JjGVdQ=; b=Gp/BMmyiAMfOF+QyhEZdHP7/ngAzN8WJRuVz5N43c8zgnU8U0lFQETC7xEpinKvDtvr1DadjZwDMOHN3fBJZJHIK/rEbhbjFOxr4lt5pKSIpjUov2Gt/X158AMQknvC4sEizkKHu6PW1qp/u+04aaYenMBQoloQcqMiWzY/Tsl0=
X-Sasl-enc: TsMZk7edVKUT0EcboLapaqSDSZ9if6srxja21oBl3pyA 1298626798
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BBABC4478DD;
	Fri, 25 Feb 2011 04:39:58 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.224.gefc87
In-Reply-To: <20110224203412.29b732b9@glyph>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167893>

When [g]vimdiff is called for files which are opened already, the editor
complains about the existing swap file. But we do not want to write
anything when called from difftool. So, make difftool use "-R" for the
vim family. This

- prevents the use of a swap file and
- marks the buffers readonly.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Notes:
    It would be nice to mark all buffers but one with -R in mergemode
    but that seems to require some vim-scripting. There are no per-file command
    line options that I know of.

 git-mergetool--lib.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 77d4aee..78ce49e 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -182,7 +182,7 @@ run_merge_tool () {
 			fi
 			check_unchanged
 		else
-			"$merge_tool_path" -f -d -c "wincmd l" \
+			"$merge_tool_path" -R -f -d -c "wincmd l" \
 				"$LOCAL" "$REMOTE"
 		fi
 		;;
@@ -193,7 +193,7 @@ run_merge_tool () {
 				"$LOCAL" "$MERGED" "$REMOTE"
 			check_unchanged
 		else
-			"$merge_tool_path" -f -d -c "wincmd l" \
+			"$merge_tool_path" -R -f -d -c "wincmd l" \
 				"$LOCAL" "$REMOTE"
 		fi
 		;;
-- 
1.7.4.1.224.gefc87
