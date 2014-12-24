From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] transport: simplify duplicating a substring in transport_get()
 using xmemdupz()
Date: Wed, 24 Dec 2014 01:18:31 +0100
Message-ID: <549A0657.6010509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 01:19:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3ZfK-00051c-DP
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 01:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756653AbaLXAS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 19:18:56 -0500
Received: from mout.web.de ([212.227.15.4]:51812 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297AbaLXASz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 19:18:55 -0500
Received: from [192.168.178.27] ([79.253.147.237]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M2dt7-1XnYNO0TDh-00sOXD; Wed, 24 Dec 2014 01:18:39
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
X-Provags-ID: V03:K0:nhr/+yorUebFJSwUFbluo2gu9MkJcoGeXYfYeUDTlZyFUPhEp8Q
 n8KL0nuw3ZRHVqhJ5Yzgnlx88bWetwr8/oPN8UH5hGTkm+AF5L4QGp7UFJEVvqkCPiHrfqN
 yuROxxhYMGAbYSi18gpDexBexorqnXaR4Sy1wUaWpmd5jfw9gmbFxcvRjksRxIvlSQ1H9It
 BfGdI0VGRrJC/OesJVxXg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261784>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 transport.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/transport.c b/transport.c
index 70d38e4..08bcd3a 100644
--- a/transport.c
+++ b/transport.c
@@ -971,9 +971,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	} else {
 		/* Unknown protocol in URL. Pass to external handler. */
 		int len = external_specification_len(url);
-		char *handler = xmalloc(len + 1);
-		handler[len] = 0;
-		strncpy(handler, url, len);
+		char *handler = xmemdupz(url, len);
 		transport_helper_init(ret, handler);
 	}
 
-- 
2.2.1
