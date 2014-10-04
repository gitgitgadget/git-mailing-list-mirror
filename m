From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] mailsplit: remove unnecessary unlink(2) call
Date: Sat, 04 Oct 2014 10:41:13 +0200
Message-ID: <542FB2A9.3020705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 04 10:42:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaKvC-00036q-Lm
	for gcvg-git-2@plane.gmane.org; Sat, 04 Oct 2014 10:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbaJDIm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2014 04:42:28 -0400
Received: from mout.web.de ([212.227.15.4]:50306 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbaJDImT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2014 04:42:19 -0400
Received: from [192.168.178.27] ([79.253.146.81]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0Md4le-1XrS3p2vEA-00IEib; Sat, 04 Oct 2014 10:42:15
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
X-Provags-ID: V03:K0:YkDQ71zpxPy5lnWGfNDEpgcZnXayyIonfy9YndKiENTKZnbKI2v
 PopMWZxL2rF8lpqB8159S3J5jjhyCPD2ohwGbs1x8OU9gqRjgbfk2T+3CDzaTQb/BdyiCEF
 vsV8K+jqhs2q9X3J2VSVLJTRqmyR+0ryUk/5Mj3nTAVxZwW6KWDlfTPiRzaATEumGbBLCNN
 OFS6xQ9VRixWML+TJE9fw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257888>

The output file hasn't been created at this point, yet, so there is no
need to delete it when exiting early.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Original thread: http://thread.gmane.org/gmane.comp.version-control.git/255140

 builtin/mailsplit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 763cda0..8e02ea1 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -59,7 +59,6 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 	int is_bare = !is_from_line(buf.buf, buf.len);
 
 	if (is_bare && !allow_bare) {
-		unlink(name);
 		fprintf(stderr, "corrupt mailbox\n");
 		exit(1);
 	}
-- 
2.1.2
