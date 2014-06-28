From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH 2/4] sha1_file: use strncmp for string comparison
Date: Sat, 28 Jun 2014 17:01:05 +0200
Message-ID: <53AED8B1.4070701@web.de>
References: <53AED59B.1020209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 28 17:02:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0u9O-0005Gz-PZ
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 17:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbaF1PCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 11:02:37 -0400
Received: from mout.web.de ([212.227.17.11]:54474 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbaF1PCg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2014 11:02:36 -0400
Received: from [192.168.178.27] ([79.250.182.181]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LxODe-1WbxZ837Oc-016tlS; Sat, 28 Jun 2014 17:01:48
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53AED59B.1020209@web.de>
X-Provags-ID: V03:K0:cwAxdCGnLEbSoX6uJfvnaeJNGmZqx60hMawzsq1VCN/OhXlnKp4
 g1dt4884hmHl/hGb9Md2jBhlviXW8jkqyTAh1g0UBNUBvCoAfS/HAvlq3saH3gkgBNzhQGE
 ct3q2+9SCTPyGsqvieqPZMm3HvYBpOzWO6o0EAV4QD25k80osQ46PGzDMGxM2e0npdldV6F
 iFVpUPH+ksCWm4mHvspNQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252608>

Avoid overrunning the existing pack name (p->pack_name, a C string) in
the case that the new path is longer by using strncmp instead of memcmp
for comparing.  While at it, replace the magic constant 4 with a
strlen call to document its meaning.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 sha1_file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 0c3cada..72b8fcb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1206,7 +1206,8 @@ static void prepare_packed_git_one(char *objdir, int local)
 		if (has_extension(de->d_name, ".idx")) {
 			/* Don't reopen a pack we already have. */
 			for (p = packed_git; p; p = p->next) {
-				if (!memcmp(path.buf, p->pack_name, path.len - 4))
+				if (!strncmp(path.buf, p->pack_name,
+					     path.len - strlen(".idx")))
 					break;
 			}
 			if (p == NULL &&
-- 
2.0.0
