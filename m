From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 01/17] read-cache.c: fix constness of verify_hdr()
Date: Fri, 18 Mar 2016 21:04:34 -0400
Message-ID: <1458349490-1704-2-git-send-email-dturner@twopensource.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 19 02:06:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah5LL-0008DR-Tp
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 02:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128AbcCSBGK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2016 21:06:10 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35869 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbcCSBGG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 21:06:06 -0400
Received: by mail-qg0-f49.google.com with SMTP id u110so114610101qge.3
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 18:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SSoa93rHY6DlfpeRAIMSLhVwvhKGdHd/q7Zc3RtPR7I=;
        b=fgfHTUGBtHS2OfVbon00h+gAhESRD1bq64MSgZYCNGCuPIByVWCyMZXi1LKpcwIetX
         lQDbyfr7fx51UQgEmPazatFu2SUWamGVeBGCF5po3D/ueBfRVahEirhPeY7DmR78dV8t
         xHoeJWELIagGVHtspXKG98JCb09bQnDpTHvjQa01xteKIgyXEE4q6aZCha9HzMY/27js
         SrDxCXrulI4clOF0Snx++sV1ZhgAWNaAaErWGSURsL6TQ3zh2OnlmdIXCt+8cvsNr4dX
         B2445RE9Eovmr5EL+U8urQ2UHI4nGsKLveihtPFa3p8/m1m3+vZo59VYC+sXbqZVw7qd
         Z9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SSoa93rHY6DlfpeRAIMSLhVwvhKGdHd/q7Zc3RtPR7I=;
        b=IJYmgyamtrNwbVrf2h1Er0ptLz/nfVYmdYh4sE3HB73atiIHGQhMjLUJXuTTBqC+eh
         6GJ7I73dewxfvKV4pg8hDAjV8Wd3DhkwT6ivqspfPTLoVedJWpChS0/4lqTbLdIiTxbL
         0Sz45EbpOoEhSTd3/5I9IDuV/mmAtVr/dPerev8nzs3PVSXT3XGvxVHFB1E2slxFhqXG
         1RruLwe5ekcjcuvSHtLVLY8R3Xl8RACFKGyhrxxqB7adgzMeuGA5JS5w7noRrr80skKX
         l/5AestF8Scyh3m7DPP9B8HIMp06McvKOKJaIK3JXjq4sMG0PE+BZiUMwBK8NMiYqmHB
         xEQg==
X-Gm-Message-State: AD7BkJJ7OXtEDBojfYnPtg5ClVjx+kFuHji8H55fcdZmcmN0BrsA2BVf9E6inYPr8p98tw==
X-Received: by 10.140.159.69 with SMTP id f66mr27984559qhf.18.1458349565297;
        Fri, 18 Mar 2016 18:06:05 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id 139sm7186154qho.2.2016.03.18.18.06.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 18:06:04 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289268>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index d9fb78b..16cc487 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1345,7 +1345,7 @@ struct ondisk_cache_entry_extended {
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
=20
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
+static int verify_hdr(const struct cache_header *hdr, unsigned long si=
ze)
 {
 	git_SHA_CTX c;
 	unsigned char sha1[20];
--=20
2.4.2.767.g62658d5-twtrsrc
