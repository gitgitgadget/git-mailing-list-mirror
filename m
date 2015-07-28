From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/4] get_remote_group(): use skip_prefix()
Date: Tue, 28 Jul 2015 23:08:21 +0200
Message-ID: <c688744efacd01a6d85f2af983a743c15e484ab4.1438117334.git.mhagger@alum.mit.edu>
References: <cover.1438117334.git.mhagger@alum.mit.edu>
Cc: =?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 23:08:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKC79-0002zA-FL
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 23:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340AbbG1VIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 17:08:36 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42000 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753276AbbG1VId (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2015 17:08:33 -0400
X-AuditID: 12074413-f79bd6d000007ac2-b2-55b7ef507dd3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id FE.CA.31426.05FE7B55; Tue, 28 Jul 2015 17:08:32 -0400 (EDT)
Received: from michael.fritz.box (p4FC97CAD.dip0.t-ipconnect.de [79.201.124.173])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6SL8PUE021490
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 28 Jul 2015 17:08:31 -0400
X-Mailer: git-send-email 2.4.6
In-Reply-To: <cover.1438117334.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqBvwfnuowf2nehbzjy1mtui60s1k
	0dB7hdni9or5zA4sHn/ff2Dy2DnrLrvHxUvKHp83yQWwRHHbJCWWlAVnpufp2yVwZ1y40MNY
	MJu14ve/TcwNjLNYuhg5OCQETCT2TxDtYuQEMsUkLtxbz9bFyMUhJHCZUeLsvPmMEM5JJon/
	y18zgVSxCehKLOppBrNFBNQkJrYdYgEpYhZoY5S4sGYXM0hCWMBKouHPLRYQm0VAVWLy9lns
	INt4BaIkVj3yhNgmJ3Ht7FZWEJtTwELi8vcWsIOEBMwlvu31msDIu4CRYRWjXGJOaa5ubmJm
	TnFqsm5xcmJeXmqRrrlebmaJXmpK6SZGSPAI72DcdVLuEKMAB6MSD++EddtChVgTy4orcw8x
	SnIwKYnyzri3PVSILyk/pTIjsTgjvqg0J7X4EKMEB7OSCG/DQ6Acb0piZVVqUT5MSpqDRUmc
	V22Jup+QQHpiSWp2ampBahFMVoaDQ0mCl/cdUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpq
	UWJpSUY8KC7ii4GRAZLiAdqrDdLOW1yQmAsUhWg9xajLseDH7bVMQix5+XmpUuK8794CFQmA
	FGWU5sGtgKWKV4ziQB8L81aDVPEA0wzcpFdAS5iAlnj2bAFZUpKIkJJqYGSxZPurtWie4BRj
	/8ZL3+9q2PAlOwr2V8uu1BA3+JrI2j85p+Bmg82cZ8fnp6ruedsifL86orCopmNt7PSKLSEr
	K+9JsxznyZBu4gldEb8g5rhu2udH/bauf12iX07/aqJtXf9noXaclcSsFotdqdpP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274847>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bd945d0..76ca100 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -975,8 +975,7 @@ static int get_remote_group(const char *key, const char *value, void *priv)
 {
 	struct remote_group_data *g = priv;
 
-	if (starts_with(key, "remotes.") &&
-			!strcmp(key + 8, g->name)) {
+	if (skip_prefix(key, "remotes.", &key) && !strcmp(key, g->name)) {
 		/* split list by white space */
 		while (*value) {
 			size_t wordlen = strcspn(value, " \t\n");
-- 
2.4.6
