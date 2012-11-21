From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] remote-curl.c: Fix a compiler warning
Date: Wed, 21 Nov 2012 19:08:51 +0000
Message-ID: <50AD26C3.2090407@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:15:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbFlS-0004jS-O1
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799Ab2KUTO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:14:59 -0500
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:51269 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755795Ab2KUTO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:14:59 -0500
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 23B566F88CE;
	Wed, 21 Nov 2012 19:14:57 +0000 (GMT)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 798F16F88CD;	Wed, 21 Nov 2012 19:14:56 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;	Wed, 21 Nov 2012 19:14:54 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210161>

In particular, gcc issues an "'gzip_size' might be used uninitialized"
warning (-Wuninitialized). However, this warning is a false positive,
since the 'gzip_size' variable would not, in fact, be used uninitialized.
In order to suppress the warning, we simply initialise the variable to
zero in it's declaration.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

This is on top of next. (commit df126e108: "remote-curl: hoist gzip
buffer size to top of post_rpc", 31-10-2012).

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
