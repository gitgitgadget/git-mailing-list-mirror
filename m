Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F852207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 11:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031608AbdDTL1e (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 07:27:34 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36380 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944524AbdDTL1E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 07:27:04 -0400
Received: by mail-io0-f195.google.com with SMTP id x86so15324767ioe.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ceiAdLmo4u1+TU28aTaeVpLoTRf9+QSU4EvL51Udjms=;
        b=mromnl4Dzl5Ie90z8BX59ypdQiDGu5OVBOVmEEAswGscvi64x1UqpZ3vxnI+7Ys6R+
         NYyoyMzUR6ayVYzO/8ETW7xXNnVVb6SgN6iAe9NN+Vfm0y0ejJ3Ja4Up5TxqZHHV4FyF
         B5peC3nHY7LKGosox0dsgI7MGMAQ2Du4fwTI59D6lCiJ4U08ZjY/G4pNN5nU7lEM+mkP
         /tQDD3hXZmip9jc7qYBsEEDunhLumUUu7ThtByR9R+PC5gWLNQjlf3uSGMiDECtZouwS
         PLNlzCR5JHuIkAqhIgccugL3ryrph/hT5WpFMAufN8/4vojTJZ/hiyn5RHsQKAuxaMWC
         vwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ceiAdLmo4u1+TU28aTaeVpLoTRf9+QSU4EvL51Udjms=;
        b=VJLNGn84Vdwg8LShRjvzuhu1n1dUq4gnQj0amwVh4ZtCBNEqjBVR7wlLLR+QmQ2iAW
         5GhGqHYqb6/qk0hGb/z3UB+ktgQkEUvBgb6b3lIh5xOq1MssDw6vpeC7CP2sgKrKWewK
         6Oson8DIifOj8mVrYRZYiF0qI6gXpuRUMkj94EFnrZAxnIadt8FXREgozPTgVJVB4/YX
         24JKqlQK85Zeuxb7RW4I8c9oH00Dx2RstuwTUoikxCvB6JxsCq++QVJQY0PjYNeXk+hU
         E05VxURPkCEp83+GpXCqHFoFksIWmOTFmkTfGfWKAL/E3c/Nr00y0D+TrzMFx7THIdbT
         QKoQ==
X-Gm-Message-State: AN3rC/5SrCwbLTEcLESrDDXBQzpAODCEiLeXP0PH2FQEqcx/9lJ0YTDd
        SMrUtyrSGom+Tg==
X-Received: by 10.98.220.8 with SMTP id t8mr7580930pfg.144.1492687619088;
        Thu, 20 Apr 2017 04:26:59 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id j4sm10035582pfk.91.2017.04.20.04.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 04:26:58 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 18:26:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/15] remote.c: report error on failure to fopen()
Date:   Thu, 20 Apr 2017 18:26:01 +0700
Message-Id: <20170420112609.26089-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170420112609.26089-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's plenty of error() in this code to safely assume --quiet is not a
concern.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 remote.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 801137c72e..8ccc1e7b99 100644
--- a/remote.c
+++ b/remote.c
@@ -253,8 +253,12 @@ static void read_remotes_file(struct remote *remote)
 	struct strbuf buf = STRBUF_INIT;
 	FILE *f = fopen(git_path("remotes/%s", remote->name), "r");
 
-	if (!f)
+	if (!f) {
+		if (errno != ENOENT)
+			warn_on_inaccessible(git_path("remotes/%s",
+						      remote->name));
 		return;
+	}
 	remote->configured_in_repo = 1;
 	remote->origin = REMOTE_REMOTES;
 	while (strbuf_getline(&buf, f) != EOF) {
@@ -279,8 +283,12 @@ static void read_branches_file(struct remote *remote)
 	struct strbuf buf = STRBUF_INIT;
 	FILE *f = fopen(git_path("branches/%s", remote->name), "r");
 
-	if (!f)
+	if (!f) {
+		if (errno != ENOENT)
+			warn_on_inaccessible(git_path("branches/%s",
+						      remote->name));
 		return;
+	}
 
 	strbuf_getline_lf(&buf, f);
 	fclose(f);
-- 
2.11.0.157.gd943d85

