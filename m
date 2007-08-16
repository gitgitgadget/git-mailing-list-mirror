From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] Fix an unitialized pointer in merge-recursive.c
Date: Thu, 16 Aug 2007 10:00:26 +0200
Message-ID: <e5bfff550708160100t5aa93430x6cbe83e6e7a61d73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 10:00:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILaHP-0004Nl-6A
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 10:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757711AbXHPIA2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 04:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757685AbXHPIA2
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 04:00:28 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:39517 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757124AbXHPIA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 04:00:27 -0400
Received: by wa-out-1112.google.com with SMTP id v27so197386wah
        for <git@vger.kernel.org>; Thu, 16 Aug 2007 01:00:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FFBjWuVB00dox0tecaVe3PpZGenkjRDWgdb0wpYyVfItbxEk7f4WIzIeiNQgnoNwC65K690/hXrytkQeHYWgGr6Yel1+x7XjI2E85sPkRMUebpF2evJvXDw3ktOvo8SNUBLDAiqQHMCyCpHcMdEeSpqTUax4iMlZCfQLaANEds4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AoZK9Ggh/chgWTAo4vayYLlqtbSxigjltLof8pO/6HxaXfTW6uHfyqkZUlTvzA53weT34j0/jrIYaP+8j9f5mGuFQ40Ogt0MfMCYZwWKbqZni7gUYTq5gKnoHU+vDGZbmRE1fFfRjT8rbVqHgBshd9QY73PEEtBYtimEFIfUOHk=
Received: by 10.114.176.1 with SMTP id y1mr1472336wae.1187251226663;
        Thu, 16 Aug 2007 01:00:26 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Thu, 16 Aug 2007 01:00:26 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55984>

Indeed &mrtree is passed to merge_trees() that not always
seems to set the value, so on some paths mrtree could
return uninitialized.

Spotted by a gcc 4.2.1 warning

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 16f6a0f..934b0d6 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1610,7 +1610,7 @@ static int merge(struct commit
 {
  	struct commit_list *iter;
  	struct commit *merged_common_ancestors;
-	struct tree *mrtree;
+	struct tree *mrtree = NULL;
 	int clean;

 	if (show(4)) {
-- 
1.5.3.rc4.67.gf9286
