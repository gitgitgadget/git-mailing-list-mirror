From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 01/16] read-cache.c: fix constness of verify_hdr()
Date: Tue, 12 Apr 2016 20:32:54 -0400
Message-ID: <1460507589-25525-2-git-send-email-dturner@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.co,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 02:33:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq8kL-0002e5-Q9
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 02:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758900AbcDMAdX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2016 20:33:23 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35546 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758896AbcDMAdW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 20:33:22 -0400
Received: by mail-qk0-f182.google.com with SMTP id o6so13625779qkc.2
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 17:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uewEGQ0wF/3DxfN+baDwQCJkdkBanU90hVkFsq63qvw=;
        b=w9q/mUxEfBTI7v5h2RLTG8ZqlWiwyWCLTv6MTjvLf4uXv2fzZ527jqHV/l6P4JPjGD
         CUK/vnqs1QyKfP6iov1NA0aqQCUpWvCEL8kch9mW7ke8wbmsYeCzFXTWrwrfhdrpmE9C
         7VVBfqGla/t2WyeAagdWUDs973WmdTYyJDjepRq+eNjC5hmwAuAskk3eZxqo5RMNQ0IH
         BGkc9u7iA1kZmcD0C+rWeN3hulzq8vmHWio/feZwBniR7s49eUy1nfieZOpufDCbzyjl
         m5SaCz0N5vDMokIIdEIR7lhRCQzQpGwYIVVgzDOBIW22H25csrVAb1XwvoDCUM1Phc1x
         lyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uewEGQ0wF/3DxfN+baDwQCJkdkBanU90hVkFsq63qvw=;
        b=LsD3blv3H/3SJERCfwkzujt0rJY5fuOO+x8HQnszGkMW5NhUmo8twLEcjIsGJ241b3
         3oaUdGlNh05L6D5TZfVmkU80K/ExfTkdN0c+pEGE+884HwVEOCt/hTWRyd4t0lYGvKAn
         GtqaWlwq6VKZVa1CmJ752ElhbBzu5qI2Zkl4HvgcTQEOzFcRhv26TG+sKCag0P/NVupO
         VLTvIYPdUjM4fmA2cdLqtYwJ/5Kw0FLqPzkpCPxFqAqJjk/AJiIY4qEwWOllfoXYmqN5
         tueHlQcMmvG5OPG/fVBeREoLSTYsxEHJeLQ478kv/16w9pSEfztrD+kyijqEnfmz53ha
         QgLg==
X-Gm-Message-State: AOPr4FXOAA2aUy0Ip2AhbGWrAtUIn+1OupNUO+hJRut3/UOWn68R3+fMbSmYKkCn10WcVQ==
X-Received: by 10.55.178.198 with SMTP id b189mr7350731qkf.98.1460507601345;
        Tue, 12 Apr 2016 17:33:21 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id v65sm14677604qhc.6.2016.04.12.17.33.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 17:33:20 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291338>

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
