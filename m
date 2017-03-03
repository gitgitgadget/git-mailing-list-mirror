Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD3642023D
	for <e@80x24.org>; Fri,  3 Mar 2017 09:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751427AbdCCJvT (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 04:51:19 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35251 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbdCCJvS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 04:51:18 -0500
Received: by mail-pf0-f195.google.com with SMTP id 67so5076979pfg.2
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 01:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qGPsQ0i7KVgTmi340NTDPp2oN60x6f0WxiDVt95wews=;
        b=G6g3wBxiG/7fXfbPWwY1v0M1iq4Y3FVp9lepDcoVLCEliftL5ZY6IU69I2cFTTvPxM
         Jm/Z8hW7GlUXptSSDejbqc2QrFML3wMjLyRP8Joh0VB2rFSnzADxZt2gA4ZUriwQzdL2
         u9iCnqyEdnhLlCmJZndZFft5gluHcJzkK0F6c26oCvILEosMVTeIu60gQ3enBEbgox2A
         fq4Ar2tTC7E5rhSqH4C8+V6rBr+kAjO5eqZBCwVHY+WpEHLaj1uAmIwT2fCZhEwMrMMJ
         uHO26lLkmj5kpwRU9E2HvCXH1D+/UsIaGcKwoIlLCUobjtG/XeTH14mulwhO22YlMqsj
         Ivjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qGPsQ0i7KVgTmi340NTDPp2oN60x6f0WxiDVt95wews=;
        b=rKWYutO+XSo3rfK0aQgpCuF5801Wh3mu8Oh4x0DnQnF4giCLyKz0N8+XZNhFzPFhBl
         HUyN78VXyL3988NCXc/QIGPwLjeV1h4Yz5si3QcBMTkv1jZpBUSzBTcU+WA93T9KgBjo
         kOMlaJ8CJeWcvUTrac1yTj2VyPP6aDkCHCtKzuPAEINAv2iQr3IRZO0F2u1/nNN1tsaE
         JWkoKpWk7Ncw0QpGIJ0JihTEeRRypUkt6xNwFKxYBp7xZjLMrdDTw1S4HqxBrcebwudt
         2cFX8yyZHrVzL8ZG6ob0wuz3f6Ge4nSjcDCyA5EjitF2EunLcRhqZpT6AEHQp4zm51dX
         EXkA==
X-Gm-Message-State: AMke39nL/aWiPo+qRV0VL42BmTrPTdsmFcIj2b7zhGSHDKxWMG8tZGP3DUjrSJCchT4i1w==
X-Received: by 10.98.54.196 with SMTP id d187mr2295015pfa.33.1488534207577;
        Fri, 03 Mar 2017 01:43:27 -0800 (PST)
Received: from ash ([115.73.169.226])
        by smtp.gmail.com with ESMTPSA id l3sm2898417pfc.18.2017.03.03.01.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 01:43:26 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 03 Mar 2017 16:43:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/2] attr.c: check if .gitattributes is a file before parsing it
Date:   Fri,  3 Mar 2017 16:42:52 +0700
Message-Id: <20170303094252.11706-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170303094252.11706-1-pclouds@gmail.com>
References: <20170303094252.11706-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to the previous patch, this is about better error messages
when .gitattributes happens to be a directory.

FWIW .gitignore code is also checked. There open() is used instead and
open("dir") does not fail on Linux. But the next read should fail with
EISDIR, which is a pretty good clue already. No idea how open() on
Windows behaves.
---
 attr.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 5493bff224..34b6a6b9a8 100644
--- a/attr.c
+++ b/attr.c
@@ -703,11 +703,17 @@ void git_attr_set_direction(enum git_attr_direction new_direction,
 
 static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 {
-	FILE *fp = fopen(path, "r");
+	FILE *fp;
 	struct attr_stack *res;
 	char buf[2048];
 	int lineno = 0;
 
+	if (is_not_file(path)) {
+		warning(_("'%s' is not a file"), path);
+		return NULL;
+	}
+
+	fp = fopen(path, "r");
 	if (!fp) {
 		if (errno != ENOENT && errno != ENOTDIR)
 			warn_on_inaccessible(path);
-- 
2.11.0.157.gd943d85

