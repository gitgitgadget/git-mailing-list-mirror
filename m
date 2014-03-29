From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH v2] MSVC: fix t0040-parse-options crash
Date: Sat, 29 Mar 2014 23:59:58 +0400
Message-ID: <1396123198-26402-1-git-send-email-marat@slonopotamus.org>
References: <xmqq7g7eb2zv.fsf@gitster.dls.corp.google.com>
Cc: Marat Radchenko <marat@slonopotamus.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 29 21:01:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTzRA-000091-64
	for gcvg-git-2@plane.gmane.org; Sat, 29 Mar 2014 21:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbaC2UAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2014 16:00:25 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:35900 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbaC2UAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2014 16:00:25 -0400
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WTzQH-0004CM-Ry; Sun, 30 Mar 2014 00:00:10 +0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <xmqq7g7eb2zv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245439>

On 64-bit MSVC, pointers are 64 bit but `long` is only 32.
Thus, casting string to `unsigned long`, which is redundand on other
platforms, throws away important bits and when later cast to `intptr_t`
results in corrupt pointer.

This patch fixes test-parse-options by simply removing harming cast.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---

I will write verbose commit messages. I will write verbose commit messages.
I will write verbose commit messages. I will write verbose commit messages.
I will write verbose commit messages. I will write verbose commit messages.
I will write verbose commit messages. I will write verbose commit messages.
I will write verbose commit messages. I will write verbose commit messages.

Junio, thank you for your patience.

 test-parse-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test-parse-options.c b/test-parse-options.c
index 434e8b8..10da63e 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -60,7 +60,7 @@ int main(int argc, char **argv)
 		OPT_STRING('o', NULL, &string, "str", "get another string"),
 		OPT_NOOP_NOARG(0, "obsolete"),
 		OPT_SET_PTR(0, "default-string", &string,
-			"set string to default", (unsigned long)"default"),
+			"set string to default", "default"),
 		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
 		OPT_GROUP("Magic arguments"),
 		OPT_ARGUMENT("quux", "means --quux"),
-- 
1.9.0
