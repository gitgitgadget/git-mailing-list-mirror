From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] builtin/clean.c: Fix some sparse warnings
Date: Thu, 20 Dec 2012 18:33:55 +0000
Message-ID: <50D35A13.9080605@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: zoltan.klinger@gmail.com
X-From: git-owner@vger.kernel.org Thu Dec 20 19:36:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlkyS-0007cY-5e
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 19:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194Ab2LTSfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 13:35:46 -0500
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:45475 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab2LTSfn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 13:35:43 -0500
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 6DE2A384083;
	Thu, 20 Dec 2012 18:35:40 +0000 (GMT)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id A0A0F384081;	Thu, 20 Dec 2012 18:35:39 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;	Thu, 20 Dec 2012 18:35:38 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211914>


Sparse issues two "Using plain integer as NULL pointer" warnings
(lines 41 and 47).

The first warning relates to the initializer expression in the
declaration for the 'char *dir' variable. In order to suppress
the warning, we simply replace the zero initializer with NULL.

The second warning relates to an expression, as part of an if
conditional, using the equality operator to compare the 'dir'
variable to zero. In order to suppress the warning, we replace
the 'dir == 0' expression with the more idiomatic '!dir'.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Zoltan,

If you have already updated your patch and made this redundant
(it's been a few days since I read the list or fetched git.git),
please ignore this. Otherwise, could you please squash this into
the new version of commit 16e4033e6 ("git-clean: Display more
accurate delete messages", 17-12-2012).

[BTW, in the same conditional expression you have an strncmp()
call which doesn't quite follow the style/conventions of the
existing code.]

Thanks!

ATB,
Ramsay Jones

 builtin/clean.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 1c25a75..0c603c8 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -38,13 +38,13 @@ static void print_filtered(const char *msg, struct string_list *lst)
 {
 	int i;
 	char *name;
-	char *dir = 0;
+	char *dir = NULL;
 
 	sort_string_list(lst);
 
 	for (i = 0; i < lst->nr; i++) {
 		name = lst->items[i].string;
-		if (dir == 0 || strncmp(name, dir, strlen(dir)) != 0)
+		if (!dir || strncmp(name, dir, strlen(dir)) != 0)
 			printf("%s %s\n", msg, name);
 		if (name[strlen(name) - 1] == '/')
 			dir = name;
-- 
1.8.0
