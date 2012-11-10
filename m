From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] remote-curl.c: Fix a gcc warning
Date: Sat, 10 Nov 2012 18:34:51 +0000
Message-ID: <509E9E4B.6020705@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 19:36:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXFuW-00032R-Az
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 19:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196Ab2KJSfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 13:35:51 -0500
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:55006 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751823Ab2KJSfu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 13:35:50 -0500
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 03C7912833F;
	Sat, 10 Nov 2012 18:35:49 +0000 (GMT)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 5AACF12833A;	Sat, 10 Nov 2012 18:35:48 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Sat, 10 Nov 2012 18:35:47 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209288>


In particular, gcc complains as follows:

        CC remote-curl.o
    remote-curl.c: In function `rpc_service':
    remote-curl.c:403: warning: 'gzip_size' might be used uninitialized \
        in this function

The 'gzip_size' variable would not, in fact, be used uninitialized.
However, in order to suppress the warning, we simply initialize the
variable to zero in it's declaration.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jeff,

Could you please squash this into commit df126e108 ("remote-curl: hoist
gzip buffer size to top of post_rpc", 31-10-2012), which is part of
your 'jk/maint-http-half-auth-fetch' branch.

Thanks!

ATB,
Ramsay Jones

 remote-curl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index d8b3600..9a8b123 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -400,7 +400,7 @@ static int post_rpc(struct rpc_state *rpc)
 	struct curl_slist *headers = NULL;
 	int use_gzip = rpc->gzip_request;
 	char *gzip_body = NULL;
-	size_t gzip_size;
+	size_t gzip_size = 0;
 	int err, large_request = 0;
 
 	/* Try to load the entire request, if we can fit it into the
-- 
1.8.0
