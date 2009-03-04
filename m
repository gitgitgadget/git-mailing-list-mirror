From: John Tapsell <johnflux@gmail.com>
Subject: [PATCH] Make the 'lock file exists' error more informative
Date: Wed,  4 Mar 2009 15:07:57 +0000
Message-ID: <1236179277-12477-1-git-send-email-johnflux@gmail.com>
Cc: John Tapsell <johnflux@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 16:09:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lesj1-0004Lg-60
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 16:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbZCDPIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 10:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbZCDPIF
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 10:08:05 -0500
Received: from ti-out-0910.google.com ([209.85.142.190]:51466 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbZCDPIE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 10:08:04 -0500
Received: by ti-out-0910.google.com with SMTP id d10so3488938tib.23
        for <git@vger.kernel.org>; Wed, 04 Mar 2009 07:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=1R3MgzTZ3OLAiopyk3rLkc/BHsmqGiqdDR3iqY88Ozw=;
        b=W+jqrGG2WxtoWXnjyY8fbc8C012xMllD+etmTrWKZG359zs4FlP54zt7nBXFXlVNZG
         eZ4pmxJl2wSKjIRX4VoUXKD+okgD+oSVooqzbug/uR2wNYvbfvCTPG2ObgL7SShpvzj3
         tbTXwepszV0uc8PHTRX/zPgHs19OBwvJ4XTzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=gq9PmbW7Dx6TsABl4YNUP8iZ1ERobz8mRCdbUpg4e2kUAMRM8HaH8OSpzBdeo+NaJx
         JueWiSgE5CDvV16vUvje+NyoH5lAkDdARRS65zfpcnaRbHTn0+rtBBbyaeTK08uRoT4W
         4OYk+jtHiFx9kzkPv54XekhC8e8wqotvTWl70=
Received: by 10.110.37.17 with SMTP id k17mr4020511tik.56.1236179281140;
        Wed, 04 Mar 2009 07:08:01 -0800 (PST)
Received: from localhost.localdomain (58-190-81-184.eonet.ne.jp [58.190.81.184])
        by mx.google.com with ESMTPS id u12sm806440tia.18.2009.03.04.07.07.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Mar 2009 07:08:00 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc2.23.g77740
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112221>

It looks like someone did 90% of the work, then forgot to actually use
the function
---
 lockfile.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 1db1a2f..3dbb2d1 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -158,7 +158,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 
 NORETURN void unable_to_lock_index_die(const char *path, int err)
 {
-	if (errno == EEXIST) {
+	if (err == EEXIST) {
 		die("Unable to create '%s.lock': %s.\n\n"
 		    "If no other git process is currently running, this probably means a\n"
 		    "git process crashed in this repository earlier. Make sure no other git\n"
@@ -184,7 +184,7 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 	fd = lock_file(lk, path, flags);
 	if (fd < 0) {
 		if (flags & LOCK_DIE_ON_ERROR)
-			die("unable to create '%s.lock': %s", path, strerror(errno));
+			unable_to_lock_index_die(path, errno);
 		return fd;
 	}
 
-- 
1.6.2.rc2.23.g77740
