From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 01/15] read-cache.c: fix constness of verify_hdr()
Date: Tue, 19 Apr 2016 19:27:55 -0400
Message-ID: <1461108489-29376-2-git-send-email-dturner@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 20 01:28:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asf48-00086s-6Y
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbcDSX2R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 19:28:17 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34187 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbcDSX2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:28:16 -0400
Received: by mail-qg0-f54.google.com with SMTP id c6so19265330qga.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 16:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uewEGQ0wF/3DxfN+baDwQCJkdkBanU90hVkFsq63qvw=;
        b=04peTNgSxwJ7GCvRz7FmG5QtaXpqMy0dnCp53c9oMV7aVBdxrYVPALLou1NNtuDuAD
         4v41ZeAA+GbeGaD5bCNwR8Ij0xVxDxaKHnfuFDpuZ9DVqI6SbF9eFT1PAuhg094+tt3h
         Y5fUNN9hEavIw0g9RFc8Jtuv9wGSzcb+gDP8IKMSwTqgCiTy3xLb1lIE0i9B6MuADxvp
         dDDoUNw9d3bN6z74GwRMTfo4lu9oklMeZizS5kVcGOm7u2DBCvf6M5S4DSOJcLYqsHPN
         LVLZ2dSz0RM90BzBrRQk6uCX+0MctiZzp8QhhOh9Be5nuZLn7wVjbZkZ73AnO7IkF4mg
         rRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uewEGQ0wF/3DxfN+baDwQCJkdkBanU90hVkFsq63qvw=;
        b=YVNk/++ymeIetyW9sSY4khi1fQPUUf8SO0L7S48WsITGb6ilLpmr2wyTrH+l0jjcTI
         pk5Pf7TZMuu9qIMCZRC7BnjNVHZ54G57PjGwKKiDoBE5aMjAYNDkKAFkdN51rLXkfHKA
         7yBx52y2JZmWzgaIXRfvn9vjrksdu2bwRJteFJ651dTIiZwQIHeW8LeDqHzD1uLsOlyu
         wElqV5rbOYayipBgHt+l6s5HBHBsoLNeDrDRCyh9nAjMZird6kK4Qj9eV09DMILxTKZk
         d6nX8dj+khTIki2EcNrYlrX77AhqT7eFk9vlXtdWcZ/UWPtLMWl7lGL3qpt199p3Fv6Y
         AEBQ==
X-Gm-Message-State: AOPr4FVNG8huDZfPdcYcAWomw1Aq86LWrWUNYXjH5ooMEEw0OSovlrddhlDQzykNjDBrbg==
X-Received: by 10.140.199.4 with SMTP id u4mr7590038qha.56.1461108495470;
        Tue, 19 Apr 2016 16:28:15 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id h34sm29879663qge.30.2016.04.19.16.28.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 16:28:14 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291952>

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
