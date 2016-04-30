From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 01/19] read-cache.c: fix constness of verify_hdr()
Date: Fri, 29 Apr 2016 21:01:55 -0400
Message-ID: <1461978133-13966-2-git-send-email-dturner@twopensource.com>
References: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 30 03:02:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awJIj-0007ny-Ge
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 03:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbcD3BC0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2016 21:02:26 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33680 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbcD3BCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 21:02:25 -0400
Received: by mail-qk0-f182.google.com with SMTP id n63so53072445qkf.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 18:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uewEGQ0wF/3DxfN+baDwQCJkdkBanU90hVkFsq63qvw=;
        b=pdlpQB4uf8lEhnUBQO5bKrk37LKxsUQBRWtqaOj/nWZMezJJTJbbT589X6P75rho1L
         FMC2GoKzdtGv+28jRZE8dVWhZ2/bhK84d4CuMq+gDGb07U+gi2wwmia81Ro9CiHoSC+s
         uP4QAKHJc9l+Gh6bFwy8yKa8Fibojz01KT784o00FAWqX0aw3Q84anWKySPe94CIy51w
         cW0mrC7VVi48F56G9Dnc2AicBuTwUxLfppiH7n5yaZjngxUJ8yAGYTSOz+4kcEQxRANy
         d/tIzreNa3qNgov7mpei08RYPX8gDfJ4b7BLAZMibVK9UvVIwSh0d/W6Dz+rXpCV+7Fi
         RP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uewEGQ0wF/3DxfN+baDwQCJkdkBanU90hVkFsq63qvw=;
        b=CjdXsmQFhzlE2G04B2kWIl/bIKBAolBcKdq/MHmdKFzObh71y/wnAgcScErxxlziEX
         xoaH1DDOa8fk3NKpKoKuhhIFYk6ndLCXDDK/U5ayiHlA3j60xGYEOJVvMByFOjFbxkUk
         sPEx5MCeFiQ9hOhtmRkeYtgGavRy8dhjKT0yeuagTBvJXL9ofOxENqs64QBkvTW4FsSd
         r6gqLt7oZ2Zw93dnXZYhwps8wPH6cWrokpZGeHDqskbGFOiLCRWJX+sCq/wSfDzMHBiy
         5+A1x3bbQaaqfBbMlo/7Hwmf3JpZjWR2nMyE7hyaSyAgVEf7HmuokrUBiXF6szy4Gc1r
         XG/w==
X-Gm-Message-State: AOPr4FXXQ2DtDKBeMFQVGIOY+Xl2CSutBebUlEWZEmOJTfFdT8b5sU4DU3hZEX7ujOr+jA==
X-Received: by 10.55.164.66 with SMTP id n63mr22406092qke.189.1461978144551;
        Fri, 29 Apr 2016 18:02:24 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g11sm5284485qhg.22.2016.04.29.18.02.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2016 18:02:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293098>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
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
