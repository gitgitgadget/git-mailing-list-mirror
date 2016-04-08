From: Kazuki Yamaguchi <k@rhe.jp>
Subject: [PATCH 2/2] imap-send: fix CRAM-MD5 response calculation
Date: Fri, 8 Apr 2016 23:02:30 +0900
Message-ID: <20160408140229.GC13469@chikuwa.rhe.jp>
References: <cover.1460122532.git.k@rhe.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 16:02:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoWzr-0005zD-FT
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 16:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758086AbcDHOCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 10:02:37 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:35302 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758006AbcDHOCg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 10:02:36 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id 33B2C61B60;
	Fri,  8 Apr 2016 14:02:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <cover.1460122532.git.k@rhe.jp>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291035>

Remove extra + 1 from resp_len, the length of the byte sequence to be
Base64 encoded and passed to the server as the response. Or the response
incorrectly contains an extra \0.

Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 30979f0c63cc..407e46bc8c0e 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -890,7 +890,7 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 
 	/* response: "<user> <digest in hex>" */
 	response = xstrfmt("%s %s", user, hex);
-	resp_len = strlen(response) + 1;
+	resp_len = strlen(response);
 
 	response_64 = xmallocz(ENCODED_SIZE(resp_len));
 	encoded_len = EVP_EncodeBlock((unsigned char *)response_64,
-- 
2.8.1.104.g07d5700.dirty
