From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 01/16] read-cache.c: fix constness of verify_hdr()
Date: Wed,  6 Apr 2016 18:11:47 -0400
Message-ID: <1459980722-4836-2-git-send-email-dturner@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
X-From: git-owner@vger.kernel.org Thu Apr 07 00:12:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anvgo-0004h6-KB
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 00:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988AbcDFWMi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2016 18:12:38 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:33431 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbcDFWMh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 18:12:37 -0400
Received: by mail-qg0-f46.google.com with SMTP id j35so48391599qge.0
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 15:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SSoa93rHY6DlfpeRAIMSLhVwvhKGdHd/q7Zc3RtPR7I=;
        b=RGjd8Osrmi6nr38xWUAT59RUEBFuriycBEeaYDVexA3nF/AYrXNVxXWWYctrDTKCkl
         g+tPuHCBMcbGy1aUJPqWEZux6TfTJBeFsI9Rn7PQf8zRx1Ui5gU/o3fd50rUpbeZCQxP
         uErtWrqmKyQdOPSIegRq/MviBZzfIJFjKTZNuy0+UJ7AO6dexLaG3Ue8xvVYwI82Kxqu
         gDwRBJVAOIDDaIbjh5aH8k7Ay4i/oosztGgfWJHD1hziA/r6KThQEMT9f3XxjnbE0yIu
         zVVvRA42YmT9JzMh1lkmdXDM67rprZlxbesNAm2ZY233mppCzVfdkHJTCyBaE3IgV98J
         jfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SSoa93rHY6DlfpeRAIMSLhVwvhKGdHd/q7Zc3RtPR7I=;
        b=bjFEP5/7rd0Cx+20Ti1+nb+TvuTrdNYMLe1tfLO0W87O0CkYSvtvXeRT2iL4d0PQ6O
         OoGg/Y64Jv9zvsE+BGCfDiYqaI2pfuRDeoV2qelMv/782LSzm60DSUysSEcwVe3bNPoY
         LbiyjAdkE6b9hnK95zq4UNJgnLVexHY8wu/PR4sx8Pdq8cFmqwr36pL/BPd70QyeetTs
         yXV74gHNXsMGG4kH+cYpsVgrapO3me9yhOTFvFNZkeuUWjk25vtCo1JtqaxrKHy64HGF
         zWuNb3m886N1V4olsYT3Ri+xF+XJDF4CpCdXlI25YWxRFlgIYnNPPAvryM9vVRpfEhgN
         DkPQ==
X-Gm-Message-State: AD7BkJKkjD/QFBRItTM6cT7sdmfBFjOdNxme/sOIoV5WjHq6q3N8mGYUQQNllFZbd5i6Ag==
X-Received: by 10.140.148.134 with SMTP id 128mr31528767qhu.98.1459980756306;
        Wed, 06 Apr 2016 15:12:36 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l33sm2165241qge.11.2016.04.06.15.12.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 15:12:35 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290871>

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
