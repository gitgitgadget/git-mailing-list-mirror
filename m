Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70AD220179
	for <e@80x24.org>; Sat, 25 Jun 2016 05:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbcFYFY3 (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 01:24:29 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36136 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbcFYFYS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 01:24:18 -0400
Received: by mail-lf0-f68.google.com with SMTP id a2so23667182lfe.3
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 22:24:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=00HvmmWigqNcU5yfjHMng54nWhMmuiuW+7zmh+JBi8Q=;
        b=HcXkP+AobNBZ5F8PwvfIRJPM7n26qRQyJbJyiCJ7+pkmjLzJwrt1UNcKMlbLALqUJT
         ii5dx8KkWquhOWhtPQgQ9XTOzmltfjfHH9f/5Pk4eKvAi54njh8e8Tp9FyWjTgVs00xf
         WHUCu9iOViBWyoqa5UwjFDtd1jp+rz2lOggzzoejwupaBzbbIIZM4Nl6ofDYa0G8vg7R
         okwAhcyJ6BoMLKicNJAM1RyafoGWdLEk/Md63t6Rgp/MUhAbs0vCCUbD+pWuZVR8At/f
         XmNqSxBGb2+8B9ihkkufzr7DlEmlw6G2TOyOSjt6PqN6cb9tyzShvtr+1ifPW+P/lOMV
         r16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=00HvmmWigqNcU5yfjHMng54nWhMmuiuW+7zmh+JBi8Q=;
        b=eEcWbgQUSHFV48j3pIxXlPyZbfMKrfT8FMS1eExYsUqy3k0FzIyZni4PSt64iLrhxG
         7JP+gB6uvEe2g6NGyiopqa+UB9KqgBa5iZm3BS1lVGR4EH0zf6WxBBps/e4FWY0ia9wT
         gd/2Rv+ckPr3k9ozWShD/guV3H8PjhNabi814rH279dx0FGiMwfd/djOpkPKv4nDErcj
         rY7g/EjTAbfyStZUPgDE8teuR00INXIl5KgeWhXJ00eJKh0v4a18ZdmlEUPiKB2UWhqs
         epRoESX2aWlSNDtZzvpdqdDtX0oPpmjTvMkc/pZEWhoxXLHj9awjdPTeK5vW0xinnIBm
         LxGA==
X-Gm-Message-State: ALyK8tIAMCQMaqfPC5Ozus2VvCT6e4vYf36ggBgyYwQGWWMMGrO0WKP9B1sOy5DBmLd7Rw==
X-Received: by 10.25.214.84 with SMTP id n81mr1986041lfg.162.1466832256578;
        Fri, 24 Jun 2016 22:24:16 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id s87sm1450921lfg.46.2016.06.24.22.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jun 2016 22:24:15 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 12/12] grep.c: reuse "icase" variable
Date:	Sat, 25 Jun 2016 07:22:38 +0200
Message-Id: <20160625052238.13615-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160625052238.13615-1-pclouds@gmail.com>
References: <20160623162907.23295-1-pclouds@gmail.com>
 <20160625052238.13615-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 grep.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index 3d63612..92587a8 100644
--- a/grep.c
+++ b/grep.c
@@ -438,10 +438,7 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		p->fixed = 0;
 
 	if (p->fixed) {
-		if (opt->regflags & REG_ICASE || p->ignore_case)
-			p->kws = kwsalloc(tolower_trans_tbl);
-		else
-			p->kws = kwsalloc(NULL);
+		p->kws = kwsalloc(icase ? tolower_trans_tbl : NULL);
 		kwsincr(p->kws, p->pattern, p->patternlen);
 		kwsprep(p->kws);
 		return;
-- 
2.8.2.526.g02eed6d

