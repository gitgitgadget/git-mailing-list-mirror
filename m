From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/5] vcs-svn: Avoid %z in format string
Date: Fri, 13 Aug 2010 19:03:17 -0500
Message-ID: <20100814000317.GF2153@burratino>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C63BD9B.6000608@viscovery.net>
 <20100813000848.GA8076@burratino>
 <4C65BA46.9010604@kdbg.org>
 <20100813234723.GC2153@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Aug 14 02:05:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok4FR-0001f9-PK
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 02:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191Ab0HNAFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 20:05:11 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52066 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756436Ab0HNAFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 20:05:09 -0400
Received: by vws3 with SMTP id 3so1673710vws.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 17:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zfRtYgChoPsDwQABMd7PI3/NNfW38gBPfpcAqP8pxbw=;
        b=rnDjdv4NBDOFcxet93BpJ8BJz0+NiicCYjFFPHKGGYJ2GsodNzVKa+Tw2kyx2ouOEH
         D3mQUOMsrC7xFsKbD1NHr0RWNbmquRo4zvEfv+ljzX/wvT4BlHHFQf5PaVWmpQ6Xz5Cr
         eQIqiLmv6tTuThDeArQILdxIrWHdamr+nKUnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AsHnQInkGqFaKsDAGEdSVAR3adVE6TbFBkqYbRSQbpFCieCIBYIifgftJCWL9b79OV
         Hsw9+SEcvLsp7gH4zXlRLEpouTu0kM1UPq9fWV+yUS3p1WOL2VyR7gL4Nm9yK03uNiuS
         L363GpUMo4C7jLTuWZY0RiasR1IAAUuMYY4/0=
Received: by 10.220.62.136 with SMTP id x8mr1264596vch.175.1281744308658;
        Fri, 13 Aug 2010 17:05:08 -0700 (PDT)
Received: from burratino ([64.134.175.141])
        by mx.google.com with ESMTPS id m30sm2041748vbr.9.2010.08.13.17.04.55
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 17:05:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100813234723.GC2153@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153532>

In the spirit of v1.6.4-rc0~124 (MinGW: Fix compiler warning in
merge-recursive, 2009-05-23), use a 32-bit integer instead; the
dump file parser does not support any better, anyway.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/fast_export.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 3a6156f..256a052 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -48,8 +48,9 @@ void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 		   ~author ? pool_fetch(author) : "nobody",
 		   ~author ? pool_fetch(author) : "nobody",
 		   ~uuid ? pool_fetch(uuid) : "local", timestamp);
-	printf("data %zd\n%s%s\n",
-		   strlen(log) + strlen(gitsvnline), log, gitsvnline);
+	printf("data %"PRIu32"\n%s%s\n",
+		   (uint32_t) (strlen(log) + strlen(gitsvnline)),
+		   log, gitsvnline);
 	if (!first_commit_done) {
 		if (revision > 1)
 			printf("from refs/heads/master^0\n");
-- 
1.7.2.1.544.ga752d.dirty
