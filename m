From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] Reset the signal being handled
Date: Sun, 25 May 2008 20:26:50 +0200
Message-ID: <20080525182650.GA17806@localhost>
References: <20080522195546.GA29911@localhost> <7vod6wr95y.fsf@gitster.siamese.dyndns.org> <20080523221723.GA4366@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 25 20:27:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0Kwd-0004gk-MZ
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 20:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbYEYS05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 14:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753258AbYEYS04
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 14:26:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:9201 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbYEYS04 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 14:26:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1018520fgg.17
        for <git@vger.kernel.org>; Sun, 25 May 2008 11:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=fcmC0IWgqzVU5wFKoQua6n4vFXou9NGtxVWimEkMCso=;
        b=MISdFr+VMCD9XwonKvbkDDoDs897fuG/Xw/gc2E0iFeNgtOZk3wt7N7/Y/wDYejKjEEXnD5rAqqgJjpg2u9DgTEEI8N4USafwGv6Jeq8LSfWw1ZBDHL6Lhbfg/Vxak6qz5c7u6nwkXueB+l63yylKtfneGV1w/07vKhH5eARffU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=OsIp426WR2e60ReGYUMFCRp8rzQBJjEcPCbyAcWsy6ELbIKkD3d317z8PGedy5eEeqk27pHxUv37YWR8gRntBvSg3luOfWnBqDO3JDf5qdp/AAb7lrwnyqt7dHq6QUGIVohN2MfXV1dZWTuPwKIp84Ng+skfGzosZmE8rTUQid8=
Received: by 10.86.31.18 with SMTP id e18mr3466455fge.41.1211740014735;
        Sun, 25 May 2008 11:26:54 -0700 (PDT)
Received: from darc.dyndns.org ( [84.154.74.129])
        by mx.google.com with ESMTPS id o11sm17923960fkf.16.2008.05.25.11.26.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 May 2008 11:26:53 -0700 (PDT)
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1K0Kvi-0001YO-8g; Sun, 25 May 2008 20:26:50 +0200
Content-Disposition: inline
In-Reply-To: <20080523221723.GA4366@localhost>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82871>

This did not cause any problems, because remove_lock_file_on_signal is
only registered for SIGINT.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 lockfile.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 663f18f..b0118d0 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -24,7 +24,7 @@ static void remove_lock_file(void)
 static void remove_lock_file_on_signal(int signo)
 {
 	remove_lock_file();
-	signal(SIGINT, SIG_DFL);
+	signal(signo, SIG_DFL);
 	raise(signo);
 }
 
-- 
1.5.5.1
