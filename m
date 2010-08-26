From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 3/8] Document pre-condition for tree_entry_interesting
Date: Thu, 26 Aug 2010 00:21:46 -0600
Message-ID: <1282803711-10253-4-git-send-email-newren@gmail.com>
References: <1282803711-10253-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 26 08:20:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoVpU-0002cj-Jt
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 08:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab0HZGUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 02:20:32 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55234 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab0HZGU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 02:20:29 -0400
Received: by gxk23 with SMTP id 23so508771gxk.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 23:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YIVcDFTbrcMOhK2dhThoDDLNGr8+UoeaeWHOTZPbQHU=;
        b=c39VYH0jbXl/pTun1tGIo1DE6Kx6fZqPHv4YHAEnLmVpc7/qQDc1/lNXugqr60JEXu
         u2bEVjLq33hRPsUEDx6adETAHSG7KSOMrMC6AzVzBE550asp5gw0vTYgJ7AeEfIZJJPe
         M4Mh1uLyx9BLz9UlVfzjLo0o9XU8F2EW3iGdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hZzZIUIzD14nMcuCO1UwBiQK1VYc6dADGnqfSsiMyJm/gMkdmZPCofHOmoMg3ApeGH
         MPsKyHT7Or/dhVDNx4LUZNtTveX1I8L47k0qSxwADw9P1kct8p7y1FKN5xXKmd4Tw3Fm
         iVh57K8matjBCNrVyUCmmuOm6eFHzZY1O+Nak=
Received: by 10.150.68.39 with SMTP id q39mr10210356yba.207.1282803628711;
        Wed, 25 Aug 2010 23:20:28 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id t20sm7160156ybm.5.2010.08.25.23.20.26
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 23:20:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.45.ga60f
In-Reply-To: <1282803711-10253-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154520>

tree_entry_interesting will fail to find appropriate matches if the base
directory path is not terminated with a slash.  Knowing this earlier would
have saved me some debugging time.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 tree-diff.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 2fb670b..75b1480 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -85,6 +85,8 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
 /*
  * Is a tree entry interesting given the pathspec we have?
  *
+ * Pre-condition: baselen == 0 || base[baselen-1] == '/'
+ *
  * Return:
  *  - 2 for "yes, and all subsequent entries will be"
  *  - 1 for yes
-- 
1.7.2.2.45.ga60f
