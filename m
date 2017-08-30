Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC77B20285
	for <e@80x24.org>; Wed, 30 Aug 2017 17:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbdH3Ruu (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:50 -0400
Received: from mout.web.de ([212.227.17.11]:57985 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752005AbdH3RuI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:08 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LfiqM-1dAxy110iQ-00pIap for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:07 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 13/34] help: release strbuf on error return in exec_man_konqueror()
Date:   Wed, 30 Aug 2017 19:49:44 +0200
Message-Id: <20170830175005.20756-14-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:VeFL8q8rmdDajZNcogysGVcuGZbwyciUAFs6hzJ2tNpwJd85aLK
 knZ4S4SJwWTpFxarQpoA6Y045bJPvY0+UG3zaYVHnebUFQMrF6AQ9I9jx5kllRJg4z46NIF
 CYEOlCmuY5Lg0k4Mrz4gvLrM5kVknXhjyizzspmALetRSK0w4awoFbvEZtdtpkrEAMnnuRH
 sR/futppUWGQqV++yRAIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9aIgpeh5WNA=:C97sGX5Kl1/L1JSxAwZ+QW
 y3ls/OP7PjsUBvzL5JZ9NBN7rg8fs33gQCf9AqzSyO3qP98Z7oP4oCbZSk6DBt5E/iHG9ZECs
 6VKGurJv3l2PA7ompJauCi4tYLuXeC/0WHRNtKwdDUbHVUBCLaFut+hAJRm5BxEvgIpMeOUAr
 0cjStJIjFtsBP1Pimg4yWSw6Tsb5sy4UqOHjcmKRwO3oLKEy0b4ZdDl3xqo2mE6+clxyABz1L
 1MQkPpswmorv0zx2KKnDjXtlumRy6+T09rXz42IL59AcLQAODufFoejRKupsqb8tLBIoo/ogo
 lbzuLWYo3xbwMuNIdRVDRYiRFG7j9EOYkk6vYVW86QDyXVyClJAP9ymI3UTxAMOCHcPdRL11G
 KFj+Oq6eAfZUv1sUyHxRPGkEk7ZkMMIRgpLG1oge4UExn+5U27uYrVVfa+K+AuvvizTbT54jA
 nXwVT2cJKGwIlu2uWpQd2vZyXuOGzYbuTAE4DJAXrr46UVRpaPxAKCJ1ZT0RvrwJ5F9mAN+Ia
 4VO8k0yfrLPgg8JJfGu1DVqE63KV763kvtlBuYQqhxYRMK40dp/h2SA5QrvQdoqqO9T03Oap5
 GADn4xOS1SE0RZlPJdzzpI06Lahnhrv3M4EcKpVXrIf438HPA+ySKXxYn/yL5XxHaI5lhySt8
 UHgxFNeiMfmRZWjCiyfif1Jzm+LZmTdXCX9/CUeuXPaVF5n6YnMGjgO/ptAW4vMZbV6RbgeVo
 VsFwkzCbE8tPXJbUyky2JXmwyJRMENZ69NaC0TAUp0TterMWoU9SrJyDyQFtm0rla87WXog+E
 hSUbzzfhvwsw6MwcOqhRso5Hb2/WA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/help.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/help.c b/builtin/help.c
index 334a8494ab..991a8bb16c 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -137,21 +137,22 @@ static void exec_woman_emacs(const char *path, const char *page)
 static void exec_man_konqueror(const char *path, const char *page)
 {
 	const char *display = getenv("DISPLAY");
 	if (display && *display) {
 		struct strbuf man_page = STRBUF_INIT;
 		const char *filename = "kfmclient";
 
 		/* It's simpler to launch konqueror using kfmclient. */
 		if (path) {
 			size_t len;
 			if (strip_suffix(path, "/konqueror", &len))
 				path = xstrfmt("%.*s/kfmclient", (int)len, path);
 			filename = basename((char *)path);
 		} else
 			path = "kfmclient";
 		strbuf_addf(&man_page, "man:%s(1)", page);
 		execlp(path, filename, "newTab", man_page.buf, (char *)NULL);
 		warning_errno(_("failed to exec '%s'"), path);
+		strbuf_release(&man_page);
 	}
 }
 
-- 
2.14.1

