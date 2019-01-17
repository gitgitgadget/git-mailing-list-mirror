Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8543F1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfAQNHd (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:07:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36773 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfAQNHd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:07:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so4816738pfc.3
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJzyKQsXAqg5uJfcrkjmY8PMTsY6HPEZLxqx9sm6Bqo=;
        b=ugZSeWb/hfWFy0x2tuAC5StgvlOAn8wkOfQoaNGqco6H0VJanI31syDJ11LhrmnFA1
         cFOPIv3vFcdMxxyled0gGd62sCqI+wJxX/DswMJckcQCkSxVnl3w7M1S89f8RZz6heHR
         vsvcohaHXFJMwCTIB4bGrL7xS9h+6UVmCXVdcAq+mV9GlNgIsKArhdZpfpRdBmwpWPnR
         hThPuKmhEH4So8ds8N09WPvPZA6TX/+IUvZZ/wXe4UOXaKvzz+v3oxmMr4LgFeL7Puqi
         qQjP+pkKBRAGm9eO71kZNsq8jA0ieLk1OdUU5QVhWanNh5szDG/rTg9Bt6P2LcHEgl3o
         4zDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJzyKQsXAqg5uJfcrkjmY8PMTsY6HPEZLxqx9sm6Bqo=;
        b=AL8npFbccRCZJ8XM5Lq9uT9/4Or4P8+/Kg170Mkada5TucyQgRzht6g9K4Mi94t5O2
         ZuyYzwziENQi889bZbIbEHD4xhc+jCiOsy2px/mbC1LdnR9oeNCqndpsq8ITcRjLf4MH
         CTq9GXbLfmKW7OZ/6DYU1FQB8DafAg30RsODiOYTOxu1kKn7SGUpf0mKxhnN9Ez7jCw0
         Ulvth2UZ03dHiQckav5lh2Nb+tqwvMrwaF04yzs4PPQuGeHMfAVRl2omn0pUXU7tiyBm
         KMmaHuEY41Ls82TeIOganeiC576405EFraSg2z/yLtV5/TrPu+NAkpFiQFRc6rcXwjHe
         z14Q==
X-Gm-Message-State: AJcUukeq0Ac3pKXj/HjqRJRZCop+8q6zLoZjMTik8COLQkDP3RA6EKKF
        c0TGzh7aLjJtpGxskoCYZGawGCEl
X-Google-Smtp-Source: ALg8bN5e0XEuZ6zjq7HVebtZCN7140NeSSnE4dofnBoUaMJoA7SNpH/fY57ZsGsZiRSk+ZLi7BMbEg==
X-Received: by 2002:a62:2c4d:: with SMTP id s74mr14734543pfs.6.1547730452282;
        Thu, 17 Jan 2019 05:07:32 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id v9sm3841796pfg.144.2019.01.17.05.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:07:31 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:07:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/76] diff.c: convert -u|-p|--patch
Date:   Thu, 17 Jan 2019 20:05:11 +0700
Message-Id: <20190117130615.18732-13-pclouds@gmail.com>
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
 diff.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 60f46052a4..7b78af623b 100644
--- a/diff.c
+++ b/diff.c
@@ -4868,6 +4868,13 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 static void prep_parse_options(struct diff_options *options)
 {
 	struct option parseopts[] = {
+		OPT_GROUP(N_("Diff output format options")),
+		OPT_BITOP('p', "patch", &options->output_format,
+			  N_("generate patch"),
+			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
+		OPT_BITOP('u', NULL, &options->output_format,
+			  N_("generate patch"),
+			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
 		OPT_END()
 	};
 
@@ -4896,8 +4903,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch")
-	    || opt_arg(arg, 'U', "unified", &options->context))
+	if (opt_arg(arg, 'U', "unified", &options->context))
 		enable_patch_output(&options->output_format);
 	else if (!strcmp(arg, "--raw"))
 		options->output_format |= DIFF_FORMAT_RAW;
-- 
2.20.0.482.g66447595a7

