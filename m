From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 19/25] try_merge_strategy(): remove redundant lock_file allocation
Date: Mon, 14 Apr 2014 15:54:49 +0200
Message-ID: <1397483695-10888-20-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:56:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhMx-0001Pi-MB
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237AbaDNNzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:55:42 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:63326 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754857AbaDNNzj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:39 -0400
X-AuditID: 12074414-f79d96d000002d2b-d9-534be8db4d70
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 11.63.11563.BD8EB435; Mon, 14 Apr 2014 09:55:39 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt09J010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:37 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqHv7hXewQed2PouuK91MFg29V5gt
	Vv6ssbi9Yj6zxa/DT9gtfrT0MFucedPIaNHZ8ZXRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/F
	D7w8Pm+S87j7fyeTx+1n21gCOKK4bZISS8qCM9Pz9O0SuDNad+1iLzjKXnHq2iamBsYJbF2M
	nBwSAiYSK+9MYoWwxSQu3FsPFOfiEBK4zCixblUrO4RzkkliY1cbM0gVm4CuxKKeZiYQW0RA
	TWJi2yEWkCJmgXYmiUM7esESwgKhEl9/TAazWQRUJY7vuAa2glfAVeJF4ykmiHVyEiePTQaK
	c3BwAsUXfsgCCQsJuEjc/TKFdQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuhZ6uZkl
	eqkppZsYIcEosoPxyEm5Q4wCHIxKPLwdc7yDhVgTy4orcw8xSnIwKYnyZtwACvEl5adUZiQW
	Z8QXleakFh9ilOBgVhLhdd0KlONNSaysSi3Kh0lJc7AoifN+W6zuJySQnliSmp2aWpBaBJOV
	4eBQkuDd+hyoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UG/HFwOgASfEA7U0C
	aectLkjMBYpCtJ5iVJQS5y0BSQiAJDJK8+DGwlLMK0ZxoC+Fee+DVPEA0xNc9yugwUxAg1na
	wQaXJCKkpBoYVeub9x4IjV4e3Nwvpr3awyzzkI3PxHkhBspr3/K3Fypt9Hx8U1Lv83zzHUly
	S89NCZsrtUWs/OrML6yJrWeCWFzfr/nrzHM/jLOn/J212d3l7K0u4tNvh04w1zF9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246236>

By the time the "if" block is entered, the lock_file instance from the
main function block is no longer in use, so re-use that one instead of
allocating a second one.

Note that the "lock" variable in the "if" block shadowed the "lock"
variable at function scope, so the only change needed is to remove the
inner definition.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/merge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 66d8843..9b7e7cb 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -671,7 +671,6 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
 		int clean, x;
 		struct commit *result;
-		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 		int index_fd;
 		struct commit_list *reversed = NULL;
 		struct merge_options o;
-- 
1.9.1
