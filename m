From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] use isxdigit() for checking if a character is a hexadecimal
 digit
Date: Mon, 09 Mar 2015 23:46:54 +0100
Message-ID: <54FE22DE.8090007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 23:47:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV6Sd-0003nu-4U
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 23:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416AbbCIWr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 18:47:26 -0400
Received: from mout.web.de ([212.227.17.11]:61605 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532AbbCIWrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 18:47:25 -0400
Received: from [192.168.178.27] ([79.253.131.164]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LgpVS-1XhB6N41zC-00oEgN; Mon, 09 Mar 2015 23:47:22
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
X-Provags-ID: V03:K0:Y85o24Wq6BV3GSbshbZXokJgckqLEcJhi2bnO/JO1yltyBnNI2F
 indlUiw8q8O9joEr21+WpbdgbagaIZvYpuRsuPt0Y2q64QdAL7tZ6BGL19xOTGcQsZVuXya
 HGLYe6MJi5KmztwCYQZZ+0zXan/5/XPYkHpgzdvu2uz6odcaLk5GLaRpbWCvIR0p6hl5kS8
 hUK1Cywe+zOYdMMLU3NAA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265200>

Use the standard function isxdigit() to make the intent clearer and
avoid using magic constants.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 sha1_name.c | 2 +-
 transport.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 95f9f8f..6d10f05 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -757,7 +757,7 @@ static int get_describe_name(const char *name, int len, unsigned char *sha1)
 
 	for (cp = name + len - 1; name + 2 <= cp; cp--) {
 		char ch = *cp;
-		if (hexval(ch) & ~0377) {
+		if (!isxdigit(ch)) {
 			/* We must be looking at g in "SOMETHING-g"
 			 * for it to be describe output.
 			 */
diff --git a/transport.c b/transport.c
index 0694a7c..00f39d9 100644
--- a/transport.c
+++ b/transport.c
@@ -117,7 +117,7 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 			return;
 		}
 
-		if (hexval(buffer[0]) > 0xf)
+		if (!isxdigit(buffer[0]))
 			continue;
 		len = strlen(buffer);
 		if (len && buffer[len - 1] == '\n')
-- 
2.3.1
