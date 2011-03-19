From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 15/16] vcs-svn: microcleanup in svndiff0 window-reading code
Date: Sat, 19 Mar 2011 18:20:53 +1100
Message-ID: <1300519254-20201-16-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:22:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qUO-0007jt-K0
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575Ab1CSHV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:21:56 -0400
Received: from [119.15.97.146] ([119.15.97.146]:55519 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754159Ab1CSHV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:21:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id E6BB6C055;
	Sat, 19 Mar 2011 18:17:55 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wD6MRj+yObfG; Sat, 19 Mar 2011 18:17:48 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 91AA2C05B;
	Sat, 19 Mar 2011 18:17:43 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169406>

From: Jonathan Nieder <jrnieder@gmail.com>

Combine some ifs.  No functional change intended.

Missed this in "vcs-svn: let deltas use data from preimage"
(2010-10-13).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/svndiff.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index b7d40c8..ea727ee 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -267,11 +267,9 @@ static int apply_one_window(struct line_buffer *delta, off_t *delta_len,
 	/* "source view" offset and length already handled; */
 	if (read_length(delta, &out_len, delta_len) ||
 	    read_length(delta, &instructions_len, delta_len) ||
-	    read_length(delta, &data_len, delta_len))
-		goto error_out;
-	if (read_chunk(delta, delta_len, &ctx.instructions, instructions_len))
-		goto error_out;
-	if (read_chunk(delta, delta_len, &ctx.data, data_len))
+	    read_length(delta, &data_len, delta_len) ||
+	    read_chunk(delta, delta_len, &ctx.instructions, instructions_len) ||
+	    read_chunk(delta, delta_len, &ctx.data, data_len))
 		goto error_out;
 	strbuf_grow(&ctx.out, out_len);
 	if (apply_window_in_core(&ctx))
-- 
1.7.3.2.846.gf4b062
