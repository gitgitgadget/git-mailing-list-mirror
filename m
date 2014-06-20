From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v5 1/2] name-hash.c: replace cache_name_compare() with memcmp()
Date: Thu, 19 Jun 2014 19:06:43 -0700
Message-ID: <1403230004-11034-2-git-send-email-jmmahler@gmail.com>
References: <1403230004-11034-1-git-send-email-jmmahler@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 04:07:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxoEc-0001AD-LC
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 04:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbaFTCHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 22:07:13 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:60409 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739AbaFTCHL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 22:07:11 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so2549328pab.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 19:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IDS82oG/41YB7oSo1BYGOfhDLWL55AfQ6BVJ78MSmTw=;
        b=J+ij4pfbKJhv1nhfAk17auSXr127KpuAXok/Hpg23vkiPTv9k1UbsaLAqU+dJfoj/m
         Sn21sPb5WtkJGCH1/0fb1Et78d0hPVtmg6tepU0wVcpLknwqu9CLSjRxO8kDh5SrpI+r
         t0qlJcOWzg9Bn8Lfaq27ktvKBsaafJ8+RW5OBoGk/eURmT99SXIFf0lFi81gOmx4VggE
         1iqu7HvmhJsXp+Wlm53MYq2yjNHgEngvvMjl02cyOHXV8rafSzQwCEDO5KSRV0Mv/hCp
         42N73n+0xsXLJuokHqZ9uheR9uEY4uJmwxiwkyoF9YuLV5DwhCfD7/SPOwNYGPhHeur/
         wo1w==
X-Received: by 10.66.251.36 with SMTP id zh4mr513357pac.100.1403230031317;
        Thu, 19 Jun 2014 19:07:11 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id xs2sm35248114pab.0.2014.06.19.19.07.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jun 2014 19:07:10 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.694.g5736dad
In-Reply-To: <1403230004-11034-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252206>

When cache_name_compare() is used on counted strings of the same
length, it is equivalent to a memcmp().  Since the one use of
cache_name_compare() in name-hash.c requires that the lengths are
equal, just replace it with memcmp().

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 name-hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/name-hash.c b/name-hash.c
index be7c4ae..63cc188 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -179,7 +179,7 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
 	 * Always do exact compare, even if we want a case-ignoring comparison;
 	 * we do the quick exact one first, because it will be the common case.
 	 */
-	if (len == namelen && !cache_name_compare(name, namelen, ce->name, len))
+	if (len == namelen && !memcmp(name, ce->name, len))
 		return 1;
 
 	if (!icase)
-- 
2.0.0.694.g5736dad
