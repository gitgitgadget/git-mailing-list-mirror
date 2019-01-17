Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7287B1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfAQNH7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:07:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45620 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:07:59 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so4418195pgc.12
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Of5vdHctr2pbYrRwZg+LAS026KDLSqMGegEYKX1z78=;
        b=RvwFFRm8+GPZZwM7GIEBOkjz2Gy009uiL4bMsPMJ2MNl6Q7tuBfAG09I9QB4b/PbDk
         VG5rsH+NFEiKTNH59xlS7sOKzRUOYigSpEEpPnpzVQ4gjoeeLtW5X22V3IsjU556ABA/
         kpOPOQvB0RlMYwOAsAWx/tugamIZv6Ou0ARhTTFbUERktbQu7hxxsRSjeRMdNR4aCm/P
         TjlksGPcsyfZ8aLllS9Hi7e5gVjLE3KesHjlBynqNA0PhngIbCKvxugQizrgEXn4gaSi
         aoyPQk5qgL8eJUlPoOSgxxK4aUCGtyuNkLTbbky4HE6o8Cjpw8p9PW0r1dwPsPLHKBaT
         D/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Of5vdHctr2pbYrRwZg+LAS026KDLSqMGegEYKX1z78=;
        b=WJaY8TPMjAVzhaydAmTGIeO4/JHgf0hLO0B46JbNVX4DcUEetvoNELKHUvCqcsT/Ib
         FKxuU6Lyqz1CBqOUPVMAPK+P9tpxGWumnwpzTKi0cyPV2+Z0PC+2VNSBJM+dQLD1T6w9
         7v/sZjmPqpgLClvfuD2pD0ESQcJoYd7J1O5o/pGYTIBLE0dY6NKvuoU8bPts7SUWdx7d
         9VG6QvwkgMIpjYZB5SXpZvNgM1s/LzVYafnmYidjMmH1LogNpk56EpiEjFNzl+v0nolo
         tDw1dZeTX+cAK+3tUee7h/2l4oYo+S994Bm/5rH3qjGW2x79lawPHDSiec9jkNp1eo6G
         V+XA==
X-Gm-Message-State: AJcUuke2tZm36sgrLgj3BPpf9aYFdUbZR6JWT+l/S7Fx2c0A5FaaS9wm
        sITgRgOdZg7jiO59neGSXPZ+AgcA
X-Google-Smtp-Source: ALg8bN5u3FOL14qvcmEgUjmJ2kH67dcFH66RcmgtwHzQVSR2YWWM877FPnIVKgM3aE+UgNfA1Podog==
X-Received: by 2002:a62:34c6:: with SMTP id b189mr15141887pfa.229.1547730478248;
        Thu, 17 Jan 2019 05:07:58 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id e9sm2457787pff.5.2019.01.17.05.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:07:57 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:07:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 17/76] diff.c: convert --numstat and --shortstat
Date:   Thu, 17 Jan 2019 20:05:16 +0700
Message-Id: <20190117130615.18732-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190117130615.18732-1-pclouds@gmail.com>
References: <20190117130615.18732-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 07796d2b3c..69a4d55e38 100644
--- a/diff.c
+++ b/diff.c
@@ -4903,6 +4903,12 @@ static void prep_parse_options(struct diff_options *options)
 			  N_("synonym for '-p --raw'"),
 			  DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW,
 			  DIFF_FORMAT_NO_OUTPUT),
+		OPT_BIT_F(0, "numstat", &options->output_format,
+			  N_("machine friendly --stat"),
+			  DIFF_FORMAT_NUMSTAT, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "shortstat", &options->output_format,
+			  N_("output only the last line of --stat"),
+			  DIFF_FORMAT_SHORTSTAT, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4931,11 +4937,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--numstat"))
-		options->output_format |= DIFF_FORMAT_NUMSTAT;
-	else if (!strcmp(arg, "--shortstat"))
-		options->output_format |= DIFF_FORMAT_SHORTSTAT;
-	else if (skip_prefix(arg, "-X", &arg) ||
+	if (skip_prefix(arg, "-X", &arg) ||
 		 skip_to_optional_arg(arg, "--dirstat", &arg))
 		return parse_dirstat_opt(options, arg);
 	else if (!strcmp(arg, "--cumulative"))
-- 
2.20.0.482.g66447595a7

