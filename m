From: Ammon Riley <ammon.riley@gmail.com>
Subject: [PATCH] Fix minor memory leak in init-db
Date: Thu, 14 May 2009 15:22:24 -0700
Message-ID: <cd3664ac0905141522s3ad78411o9f015d2e7720c8b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 00:23:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4jJw-0005aY-Gk
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 00:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108AbZENWW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 18:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753127AbZENWWZ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 18:22:25 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:32279 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558AbZENWWY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 18:22:24 -0400
Received: by yw-out-2324.google.com with SMTP id 5so893497ywb.1
        for <git@vger.kernel.org>; Thu, 14 May 2009 15:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=J3tNKTadSceZgr4InM8FJffBfOebJJl2eHucn1x+zwI=;
        b=o3Xn/hztvuDOQSIbJXoBxnEoT6MBmgoy8d5NfdIUVl5OANO710cGZsS8lxzNYf9/z4
         m1f5DLM1Oz/hoPRUyLF5BAQ0DSTpZoQgYNjF/dw0UOaWWzWf1S1WcwvC5uclYb4VzWIJ
         hXIHuadvQh44TbpuzFKxvFGf1hfPq3gTn9nig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=aEyWHWbSWdloTOTMubss2QYw8OuEua9vZ8wPxC4OlIqwD+i++6CX34HMy38LaDfbNE
         4gXKxMeS09W59EAnOMbXuouGhvWHNuF1TFf++7EMy1J5cu0/pngA+WhAlp3NbSLX2z/X
         Oi96CgKgKqEMJnx/gYcpp0JLXixTXJRgsjldI=
Received: by 10.100.132.4 with SMTP id f4mr3757949and.109.1242339744839; Thu, 
	14 May 2009 15:22:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119230>

There was an xmalloc() for path, but I didn't see a corresponding free().
Does it happen somewhere else that I'm not expecting?

Signed-off-by: Ammon Riley <ammon.riley@gmail.com>
---
 builtin-init-db.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index d1fa12a..6969987 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -308,6 +308,8 @@ int init_db(const char *template_dir, unsigned int flags)
 	strcpy(path+len, "/info");
 	safe_create_dir(path, 1);

+	free(path);
+
 	if (shared_repository) {
 		char buf[10];
 		/* We do not spell "group" and such, so that
-- 
1.6.3.1.9.g95405b.dirty
