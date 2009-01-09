From: <nathan.panike@gmail.com>
Subject: (unknown)
Date: Fri, 9 Jan 2009 14:02:59 -0500
Message-ID: <49679f61.1b068e0a.048f.70e4@mx.google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Jan 09 20:04:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLMeb-0000KT-Ad
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 20:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277AbZAITDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 14:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbZAITDA
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 14:03:00 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:44384 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbZAITC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 14:02:59 -0500
Received: by rv-out-0506.google.com with SMTP id k40so9044015rvb.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 11:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :from 65c4fed27fe9752ffd0e3b7cb6807561a4dd4601 mon sep 17 00:from
         :date:subject;
        bh=8nlx4r9xXmbpjxqDjz6EVYWclyc+BTCgwAG0/kIYIOk=;
        b=orFuqkJrXDgxVJyD2nNgjP2bcYIlUW48dPp1FIb0TLAcggae2uGqDju+JbrybHLueY
         +uoUDfj/QvNKI2G5lUQ8uV3CRoJmiRSSAjGVBazqGLqxV+QWU58cJFBKFjL+AsaYleVz
         T8SfSeXPiVgtgN+k+V6eh8myDAzJZ0c9wSt6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from65c4fed27fe9752ffd0e3b7cb6807561a4dd4601monsep1700
         :from:date:subject;
        b=a+EGUfqvafRvbw1jNqFu9l0U45ZA31OA54LRveCRA9O58bORi9ny8Dlw1fQ6T5gpDj
         rouxYJo0l+EJYI3CE33SKSq2Ii606Cide141mN8Sbp97gGDGs+HLDTT88cpzSNMWfKfK
         yTO5FLYkbtIEsEZdUzVXUtlSklE5D/Hr8gyyM=
Received: by 10.143.4.16 with SMTP id g16mr10845155wfi.124.1231527778593;
        Fri, 09 Jan 2009 11:02:58 -0800 (PST)
Received: from localhost (dyn-108-77.uwnet.wisc.edu [72.33.108.77])
        by mx.google.com with ESMTPS id 27sm54440211wff.31.2009.01.09.11.02.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jan 2009 11:02:57 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105028>

>From 65c4fed27fe9752ffd0e3b7cb6807561a4dd4601 Mon Sep 17 00: 00:00 2001
From: Nathan W. Panike <nathan.panike@gmail.com>
Date: Fri, 9 Jan 2009 11:53:43 -0600
Subject: [PATCH] Get format-patch to show first commit after root commit

Currently, the command

git format-patch -1 e83c5163316f89bfbde

in the git repository creates an empty file.  Instead, one is
forced to do

git format-patch -1 --root e83c5163316f89bfbde

This seems arbitrary.  This patch fixes this case, so that

git format-patch -1 e83c5163316f89bfbde

will produce an actual patch.
---
 builtin-log.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 4a02ee9..5e7b61f 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -977,6 +977,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		list[nr - 1] = commit;
 	}
 	total = nr;
+	if (total == 1 && !list[0]->parents)
+		rev.show_root_diff=1;
 	if (!keep_subject && auto_number && total > 1)
 		numbered = 1;
 	if (numbered)
-- 
1.6.1.76.gc123b.dirty
