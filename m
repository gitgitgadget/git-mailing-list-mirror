Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55971F424
	for <e@80x24.org>; Thu, 26 Apr 2018 05:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753003AbeDZF6p (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 01:58:45 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42155 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752902AbeDZF6j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 01:58:39 -0400
Received: by mail-pg0-f68.google.com with SMTP id e12so15078617pgn.9
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 22:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gTV5xXXKr+RpBO7qPmX2gMTrISIrxqcmhuGOn52Zeyg=;
        b=cwj1+KB9T/evpYvXkfTMbIzsp4bFSjv6FGfQV/FnuCGZBG8L/iSRP1PCmpchQZcNSO
         I528/J0HOyIr/t4b4929fnrSP4HFcxCyjj1YZ+CO5nEVXUxFgi1Ij5m6cgfGkrXqhzH/
         MBhHqSSrfxe7lZHR81sIAjrtRJ+WQl+80DvJEqvp3LPdjnLEBfVS0pMWkjLs3OEd4F1z
         sClSyA3ucPFJWTEMIkgNT0dtm7U+T0n77nkuqk+4ThHscKmcsBd4XszFrQROYp2i4dDJ
         rk+Cg+FW2BuX4dC5WOaaA1XNXk5myPIY2gpjkVlIaktc6W1S9HNALrFjDGXwBLyzs76f
         g+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gTV5xXXKr+RpBO7qPmX2gMTrISIrxqcmhuGOn52Zeyg=;
        b=qLOIs8E6kldx12nbDb/oFmQeOrfDE4geoLgwwMDsMtxHyNCgugkRmKJC9IJfjP9H0V
         Tu35VAsau6abwEXtRHnsPBPbQ1loykqVnZoelbpVVM7Baqpb24HGd29VO3OgaVlM1fwT
         /KE5X7NgrlbYDhapCJavSrrnip/ZJhmUuJ4b25nJ9a5frvZhFn+l6VcVZHbt6rQSQnRt
         s6FugiyEIA5SP3tqgjv55Ti958ijyweNTWRqaqut6VvPPin0gDu8ODhBXF6oKoKhI9/5
         aIjiAzCH32FG6Wwu8NbsHaMzpb79b6kNR/sWkOijtzEstzarX+R2IUvKF4YEXfckIbgP
         4fLQ==
X-Gm-Message-State: ALQs6tDkPHrkZEolmnFqax4GVu8Xe3PFa8bjy97ZUnK57UQMUzd5nhem
        NQDUij7qHMMquSeF03/SXhTIFmHTQNA=
X-Google-Smtp-Source: AIpwx4/N+qRSNDSl8HR+oexTbC/mgBhdmAOKLicr2U6TMu0LQWc3dg1Z2MfqtMKDOq9YB/6yEJpahw==
X-Received: by 10.99.95.14 with SMTP id t14mr25010642pgb.94.1524722318607;
        Wed, 25 Apr 2018 22:58:38 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:b5ff:86d4:d359:c7bd])
        by smtp.gmail.com with ESMTPSA id f22sm42196363pff.146.2018.04.25.22.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 22:58:37 -0700 (PDT)
Date:   Wed, 25 Apr 2018 22:58:36 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2 4/5] config.c: introduce 'git_config_color' to parse ANSI
 colors
Message-ID: <bb9a3e13d26c3986dc91fea8e73a879602701b1e.1524722247.git.me@ttaylorr.com>
References: <cover.1524716420.git.me@ttaylorr.com>
 <cover.1524722247.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524722247.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for adding `--type=color` to the `git-config(1)` builtin,
let's introduce a color parsing utility, `git_config_color` in a similar
fashion to `git_config_<type>`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 config.c | 10 ++++++++++
 config.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/config.c b/config.c
index 62c56099bf..d14813bef7 100644
--- a/config.c
+++ b/config.c
@@ -16,6 +16,7 @@
 #include "string-list.h"
 #include "utf8.h"
 #include "dir.h"
+#include "color.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -1000,6 +1001,15 @@ int git_config_expiry_date(timestamp_t *timestamp, const char *var, const char *
 	return 0;
 }
 
+int git_config_color(char *dest, const char *var, const char *value)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	if (color_parse(value, dest) < 0)
+		return -1;
+	return 0;
+}
+
 static int git_default_core_config(const char *var, const char *value)
 {
 	/* This needs a better name */
diff --git a/config.h b/config.h
index ef70a9cac1..0e060779d9 100644
--- a/config.h
+++ b/config.h
@@ -59,6 +59,7 @@ extern int git_config_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
 extern int git_config_expiry_date(timestamp_t *, const char *, const char *);
+extern int git_config_color(char *, const char *, const char *);
 extern int git_config_set_in_file_gently(const char *, const char *, const char *);
 extern void git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set_gently(const char *, const char *);
-- 
2.17.0

