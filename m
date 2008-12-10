From: Alexander Potashev <aspotashev@gmail.com>
Subject: [PATCH] remove unnecessary 'if'
Date: Wed, 10 Dec 2008 17:09:16 +0300
Message-ID: <1228918156-3953-1-git-send-email-aspotashev@gmail.com>
Cc: gitster@pobox.com, Alexander Potashev <aspotashev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 15:10:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAPlU-00052u-7P
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 15:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188AbYLJOIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 09:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754773AbYLJOIw
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 09:08:52 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:30618 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbYLJOIv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 09:08:51 -0500
Received: by fg-out-1718.google.com with SMTP id 19so229384fgg.17
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 06:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=rNFDELDhlp1iMH4Kfa5ZPv7Uo3kPtOLXECpPbeOjgMo=;
        b=AwRFxv95Oi52Og8agQcxlC1fJbSoaJZZ/M6M2GDTdlGLLhYQ7uiBM01BWzJi3s1M63
         3NnfV9Fw01pLe1aSpZv30L8FVGWM6BliRFyH2o+wecV1NxAhc+7hUJ8n6PN0rjkQYGZ8
         eVycmqhHCnkZa8ms79v5mwZNEJPbCg3oZNRds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CDjqGpEgoZmGWsaB/6hkpmA0eH2g8kdAJqQ89frBUmTrT5I9maDjfNzOG3d4yifDkg
         ZKnb5d8OKDlUpwR920DNLNxC5R4p3P/RZW7rtHrI0K4xKbyxfIMgX4BDUAOygxym4j5p
         daIKdxG2XuSU4SrF3A80cXNL/fiPcpOklQkfc=
Received: by 10.86.59.18 with SMTP id h18mr692368fga.35.1228918129920;
        Wed, 10 Dec 2008 06:08:49 -0800 (PST)
Received: from localhost.localdomain (ppp91-78-100-86.pppoe.mtu-net.ru [91.78.100.86])
        by mx.google.com with ESMTPS id 4sm681464fge.30.2008.12.10.06.08.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Dec 2008 06:08:48 -0800 (PST)
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102688>

'patch->is_new' is always <= 0 at this point (look at 'assert' at the
beginning of the function). In both cases ('is_new < 0' and 'is_new == 0')
the result of those two lines is zeroing of 'is_new'.

Signed-off-by: Alexander Potashev <aspotashev@gmail.com>
---
 builtin-apply.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 4c4d1e1..904a748 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2440,8 +2440,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 	if (!cached)
 		st_mode = ce_mode_from_stat(*ce, st->st_mode);
 
-	if (patch->is_new < 0)
-		patch->is_new = 0;
+	patch->is_new = 0;
 	if (!patch->old_mode)
 		patch->old_mode = st_mode;
 	if ((st_mode ^ patch->old_mode) & S_IFMT)
-- 
1.6.0.4
