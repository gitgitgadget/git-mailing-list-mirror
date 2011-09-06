From: Wang Hui <Hui.Wang@windriver.com>
Subject: [PATCH v2 2/5] sha1_file: remove a buggy value setting
Date: Tue, 6 Sep 2011 18:24:02 +0800
Message-ID: <1315304645-12009-3-git-send-email-Hui.Wang@windriver.com>
References: <1315304645-12009-1-git-send-email-Hui.Wang@windriver.com>
 <1315304645-12009-2-git-send-email-Hui.Wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
To: <gitster@pobox.com>, <git@vger.kernel.org>, <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue Sep 06 12:24:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0sp5-0003wz-Rf
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 12:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044Ab1IFKYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 06:24:03 -0400
Received: from mail.windriver.com ([147.11.1.11]:61490 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299Ab1IFKYB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 06:24:01 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p86ANqXn005023
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 6 Sep 2011 03:23:52 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.220) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.1.255.0; Tue, 6 Sep 2011 03:23:52 -0700
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1315304645-12009-2-git-send-email-Hui.Wang@windriver.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180786>

From: Hui Wang <Hui.Wang@windriver.com>

The ent->base[] is a character array, it has pfxlen characters from
position 0 to (pfxlen-1) to contain an alt object dir name, the
position pfxlen should be the string terminating character '\0' and
is deliberately set to '\0' at the previous code line. The position
(pfxlen+1) is given to ent->name.

>From above analysis, there is no reason to set ent->base[pfxlen] to
'/' at the end of this function, first it doesn't make sense to append
a '/' at the end of a dir name, second if you are not lucky that the
ent->base[pfxlen+1] is not 0, you will get a wrong alt object dir
name.

Signed-off-by: Hui Wang <Hui.Wang@windriver.com>
---
 sha1_file.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d12a675..5940d84 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -304,8 +304,6 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 	/* recursively add alternates */
 	read_info_alternates(ent->base, depth + 1);
 
-	ent->base[pfxlen] = '/';
-
 	return 0;
 }
 
-- 
1.6.3.1
