From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: [PATCH] Tell users that git protocol is not for pushing
Date: Mon, 10 Nov 2008 23:06:16 -0600
Message-ID: <1226379976-5959-1-git-send-email-nathan.panike@gmail.com>
Cc: "Nathan W. Panike" <nathan.panike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 06:07:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzlTV-0004kG-Lk
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 06:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbYKKFGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 00:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbYKKFGW
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 00:06:22 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:23646 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbYKKFGV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 00:06:21 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1100745ywe.1
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 21:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=lXsQEv63IbrX/kPMBk0FJaKAAN8sA0YwxpxJ/yhJzU0=;
        b=KEXVUdAIYt3+e6DJHTyeeZzGR/oWs8l65favc8iPhgHnyvLxV9mAXEK5LsTPf3mxU6
         3Ssdj8h1Tfm7YdF3k3hGTH3vNboTS8r0M377REv9uHEpNYDW33AmRbKMut3a8r+v9wGJ
         BHUz+qL5JhJtd52tgQFLH36ZTSNppZj84y9ak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=E2z05q1vt5Z0zbv9iYJS1V+uaMQma/fbCxPnK9ghdn5ebz7NyLpNm3/iC5HnxSdLgm
         +GwEBezsujZ62xDKlY2D/C8ySA0cgoQlycSKqM53I8jHiMnykDSaceXBxmrLJ3T259Xv
         yvOP7P9i/xN8ewOziMrKnaqnEY23EhaUZ+9iU=
Received: by 10.64.183.1 with SMTP id g1mr7354562qbf.26.1226379980149;
        Mon, 10 Nov 2008 21:06:20 -0800 (PST)
Received: from localhost (ppp-70-226-174-120.dsl.mdsnwi.ameritech.net [70.226.174.120])
        by mx.google.com with ESMTPS id k29sm12910188qba.7.2008.11.10.21.06.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Nov 2008 21:06:19 -0800 (PST)
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100615>

When one attempts to push to a git-protocol repository, one gets the
line:

fatal: The remote end hung up unexpectedly

This seems a bit obscure to me.  It is better to inform the user that git://
does not allow pushing.
---
 transport.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/transport.c b/transport.c
index 56831c5..2c1577e 100644
--- a/transport.c
+++ b/transport.c
@@ -684,7 +684,9 @@ static int git_transport_push(struct transport *transport, int refspec_nr, const
 	args.use_thin_pack = data->thin;
 	args.verbose = !!(flags & TRANSPORT_PUSH_VERBOSE);
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
-
+	if(strncmp(transport->url,"git",3)==0){
+		fprintf(stderr,"git protocol does not support push.\n");
+	}
 	return send_pack(&args, transport->url, transport->remote, refspec_nr, refspec);
 }
 
-- 
1.6.0.4
