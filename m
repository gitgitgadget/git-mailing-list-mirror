From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] for-each-ref: remove multiple xstrdup() in get_short_ref()
Date: Tue,  7 Apr 2009 09:33:19 +0200
Message-ID: <1239089599-24760-1-git-send-email-bert.wesarg@googlemail.com>
References: <20090407070254.GA2870@coredump.intra.peff.net>
Cc: git@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 07 09:36:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr5qm-0001Cv-D0
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 09:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbZDGHdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 03:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752523AbZDGHdq
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 03:33:46 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:10353 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbZDGHdp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 03:33:45 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2826582qwh.37
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 00:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=F/aEHQzKuPgrYP32RHKmxa29Xs6xrGgFmi27CN3KaQk=;
        b=QiqDZD0KI7h4bO+H40v7zbgaf46ai1lsIyn8MYCXgWyiovn4qcv5F8Hl8E2i7T/Oax
         ak6iTPqqL8zMsnQFUSTGMKGPxSC5y1sL61sKBsXZxLP0SOAjY/HMrE1cehOfXbmRRGhv
         rv9zOJsMadQSzzGJBm9WJjyfLW/SM+PFrZnDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uYBJMtn9oHPvfAWqTeLh+8B8k0jVUTt94acUlHVe9+38S7MY2pyinYrVgrH8cbxVVU
         jsym4v9L+1REh9dF14GxZEusoR1NBcDPZnRxtz5mPNQwmYPV1hKBU7jNRJYeIHYEVTFW
         ByW/+D9luiL/v1T21wqMFn/tCEOQGgQ1K3eg8=
Received: by 10.220.45.79 with SMTP id d15mr5002912vcf.48.1239089623073;
        Tue, 07 Apr 2009 00:33:43 -0700 (PDT)
Received: from localhost (p5B0F52B2.dip.t-dialin.net [91.15.82.178])
        by mx.google.com with ESMTPS id 4sm2176529yxq.3.2009.04.07.00.33.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 00:33:42 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.419.g2f285
In-Reply-To: <20090407070254.GA2870@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115918>

Now that get_short_ref() always return an malloced string, consolidate to
one xstrcpy() call.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
Also an 

Acked-by: Bert Wesarg <bert.wesarg@googlemail.com>

for Jeffs patch.

 builtin-for-each-ref.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 4aaf75c..108c128 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -596,13 +596,13 @@ static char *get_short_ref(const char *ref)
 		}
 	}
 
-	/* bail out if there are no rules */
-	if (!nr_rules)
-		return xstrdup(ref);
-
 	/* buffer for scanf result, at most ref must fit */
 	short_name = xstrdup(ref);
 
+	/* bail out if there are no rules */
+	if (!nr_rules)
+		return short_name;
+
 	/* skip first rule, it will always match */
 	for (i = nr_rules - 1; i > 0 ; --i) {
 		int j;
@@ -641,8 +641,7 @@ static char *get_short_ref(const char *ref)
 			return short_name;
 	}
 
-	free(short_name);
-	return xstrdup(ref);
+	return strcpy(short_name, ref);
 }
 
 
-- 
tg: (e9786d7..) bw/ammend-jk/refactor-get_short_ref (depends on: jk/refactor-get_short_ref)
