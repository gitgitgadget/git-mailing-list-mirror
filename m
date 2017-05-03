Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEDB1207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbdECKSm (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:18:42 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34473 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753114AbdECKSk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:18:40 -0400
Received: by mail-pg0-f65.google.com with SMTP id t7so27646639pgt.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wiuoCDFbalhcO8IvaOMN7/JJ38FSwaBZv0GZKH+aj6Q=;
        b=V+qBImnwqvTscOBZibWdaD6YyyRlt06JG+oi1e/4p4V9/eIxRtuxduZfsPOx92vP0J
         7rqOMR433mMgdSSpit8LDFnAT80BFVVx/v4ClLSdoMmYtPWhy9CCDQN0cDQe72dwzuT1
         i8/FBzhSBeCHg13EjjhFCS340UStN/nxgFbdUB9fNkLod2GIJ8bJU4wA6FNsunPUmukK
         KOJLZReA3AgGJrvimmrsgBJeQYN+ytoe+74vkF9BLS5bM9DzlyznO7Eg55KxtFX+cW1R
         B9pz/1B0ZK+9bnFp48FaQTTNh56xPP57HGyg5vWh+3Kwr9WdHc8e/5qyxK7stjh86LDN
         Ub4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wiuoCDFbalhcO8IvaOMN7/JJ38FSwaBZv0GZKH+aj6Q=;
        b=m+2iBZL1KgEeQHCbnxgvkXLa9eBbgoNqQYbFyhomRNeBIxSimTCRb/xfoJ7lMEZs4f
         VYvOpmGYzdLB8OyBBO5zVxF0FnG/7438mPMEtOLitaq1FFcjyQIcX1ohpXyZL+1L4qZz
         ipYtA8EK+wSxE57/jvxDyimddBnSgaY5ZASEIEB8IOvj8pLI3S+XDKi9r6PLghJ7GZc2
         mwXmIKv1VGqyVxR3Q59ocvT/AONwlUaDpjcZVVL6wgPhO6JFSR8XIp7LbXnHABIDDWIs
         EYhgzNDySfLbsMxW4teA7OGdBS3S7Qam8IfxAHLbe0YB5S4CJQQ6K6zSxMJKhGeBf9mD
         8KqA==
X-Gm-Message-State: AN3rC/5nmviU1CXaF5qxMY3DXm19uBH8ekB8BTK1ZsRb73pMbQxnqGgr
        WyXznmXS0BP78g==
X-Received: by 10.98.90.6 with SMTP id o6mr4014248pfb.101.1493806714593;
        Wed, 03 May 2017 03:18:34 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id 12sm35098768pgb.35.2017.05.03.03.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:18:34 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:18:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 06/21] attr.c: use fopen_or_warn()
Date:   Wed,  3 May 2017 17:16:51 +0700
Message-Id: <20170503101706.9223-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170503101706.9223-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
 <20170503101706.9223-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 attr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/attr.c b/attr.c
index 7e2134471c..821203e2a9 100644
--- a/attr.c
+++ b/attr.c
@@ -720,16 +720,13 @@ void git_attr_set_direction(enum git_attr_direction new_direction,
 
 static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 {
-	FILE *fp = fopen(path, "r");
+	FILE *fp = fopen_or_warn(path, "r");
 	struct attr_stack *res;
 	char buf[2048];
 	int lineno = 0;
 
-	if (!fp) {
-		if (errno != ENOENT && errno != ENOTDIR)
-			warn_on_inaccessible(path);
+	if (!fp)
 		return NULL;
-	}
 	res = xcalloc(1, sizeof(*res));
 	while (fgets(buf, sizeof(buf), fp)) {
 		char *bufp = buf;
-- 
2.11.0.157.gd943d85

