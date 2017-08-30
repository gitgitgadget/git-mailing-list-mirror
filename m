Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A26520285
	for <e@80x24.org>; Wed, 30 Aug 2017 18:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbdH3SUt (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:20:49 -0400
Received: from mout.web.de ([212.227.15.14]:57617 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752671AbdH3SUR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:20:17 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LrHMi-1dO4lA0Q28-0136Gh for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 20:20:16 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 30/34] userdiff: release strbuf after use in userdiff_get_textconv()
Date:   Wed, 30 Aug 2017 20:20:15 +0200
Message-Id: <20170830182015.21228-1-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:wP7QUmLWFrKP66PNTzZZmaeuIv7peDJZdbUrxES11Qrdjfc7ymO
 h5P1syD64+xEk71l/KL6mMx+TYmwmU5Jh2gbZ6RsHsrf2GH5vdtPnHD2aN4lyfQ+s8ha7iR
 zVfYFnhdgARNB4JhK4vppkMSR7cWl8tE8zGlSTIwPVZNL0KMjAQBaF4uZwXZQaa+rOjyetz
 ev+bmG9SYTfR4unAwHWsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q/ZFggDVe8w=:CyuVvu2rs/+FHlGEwASq6h
 ssO4y8LQRDt0RNOg/9XHyfj4e1K3DWpDLrudDB+lma7bbfFq7ewU2fTUBPRaa15cBzjrb9UoE
 GRni9tN2TVSbeeAZcnb8uh0hg082RIB+kri7VqV1P6CSSGrwgeF/hhy2y8KkajBLQVrTPhPmE
 V9SQ7OyzCvIy9VQW1zUKeQ1BWg/pgBfAmhIVwV8i8vmXwKo7UMR8/AbFNRZuE2JyjOfjwdROF
 p97FDIgmTTXa2RspIZEeEpMuab7N7x6zqH03AWO02VMfibpznc5QllpnOtSUcFPaHSaBEJR5e
 3IJgiw5fsGC7I0uy1Yl7ahOrMW2D1H6hnfD8BRMxwIvn8D38lmOWbk+O6urP+y1mt71VEQI4R
 5dajN1JqtTAEHEOmBSzEVUCGWIEeDcbpw/91PM4AFurh2YpsWN3YrnFI1uruxYEYJxh9W5VT+
 TPu/wWmVaK9ghP1N8R2+xIQf4zcUYugete/pGddFZ8/uIq0slzK9ciUJrwQjfa5M1ClQkJ3GR
 /74fPCuxwENg2iQF5oR3By9LizGl/wXcJbOiLaH/lvAZo4yusC7Z2XzYOQ445LGPYEKHZYtQ1
 yaYp9/dBURnUKiy2B5XeGDQNDtLBJ/1A/L+jcnFGvJe9kwtKJHudnH/tM3CwhkKSrJv6SkEt8
 zrhczk5hNtP+2nd8Xyux8xWE8xJRa6t63vim/4niRyNtCmUWFioSmWUGhzt5LFVNK9YJbs2pM
 2hIrHmsMkUuJsefFsMd4/Iw9hakSZ3KHhDpSGWxnGB5F8FBvYJ1ifMYauZHMsY5bAoflQsFTr
 KlPWhwgb2vQcdU+J2aJUeV8bPqb9A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 userdiff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/userdiff.c b/userdiff.c
index 2c1502f719..6321103ce2 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -284,16 +284,17 @@ struct userdiff_driver *userdiff_find_by_path(const char *path)
 struct userdiff_driver *userdiff_get_textconv(struct userdiff_driver *driver)
 {
 	if (!driver->textconv)
 		return NULL;
 
 	if (driver->textconv_want_cache && !driver->textconv_cache) {
 		struct notes_cache *c = xmalloc(sizeof(*c));
 		struct strbuf name = STRBUF_INIT;
 
 		strbuf_addf(&name, "textconv/%s", driver->name);
 		notes_cache_init(c, name.buf, driver->textconv);
 		driver->textconv_cache = c;
+		strbuf_release(&name);
 	}
 
 	return driver;
 }
-- 
2.14.1

