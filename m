Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E45AE207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936424AbdDZUVZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:21:25 -0400
Received: from mout.gmx.net ([212.227.17.20]:63423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935809AbdDZUVY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:21:24 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LaXmV-1dpERM1ur1-00mLSo; Wed, 26
 Apr 2017 22:21:19 +0200
Date:   Wed, 26 Apr 2017 22:21:18 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 19/26] receive-pack: plug memory leak in update()
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <69b267b697cbf7f8948418e1b4d5eb52af911bf0.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pApGbvFDyXODAeXMNDJ0X0XKjx7LcWAFMEh/nJclYeh8q0K0XX8
 qwvB8niJhgi/pAGotKNXlXs477TOcyZIsoPYn7o+hTXcbyQimgCI4NBLjCaBY7jUzDKWm4P
 ZhxIjPVyO+EslwPX9tZjvt6jYo4G8PoPaMxNqZzE1t9PIIbMyYsboWzaOIA9Wd+0bQ1jWc+
 ioveUQYZJbFY3X23W0hQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V4DPD837r74=:ro8aFrOE/ki70S52+YYhxB
 Y5Z866HM3eLC5vaIcNvEtECxnJRhLYAcU+jagYG+uKY1+1uGZBt6S3pQNp9hi+7gyV9bUqgvw
 OtPSneruleaJm8hRDUX3CRlgvg5Sn30GmoOH1nYdM//wrTCSOmq/qLSoF6muPIw9AxxilOy81
 9jes89h8QSdJcfNZ9e6JkcERDX8dlxnRUiFdhS+5IIWjVUS6NYXro8vs3JWUM9sdHw+vAQXQn
 kV9E0Sy1oPNbCKx0MMLIUtA6puYV1upwbhc/3VywYvr+4Fgj/4Y2XaSkc/AOUp7/MQ8XDTIbS
 bFHfNvQXl2SjaGe56G0kV8SClU6U19L17mLpes8rdufy8X4s2pFKBts8qOoT2tiJ4pnseJqhC
 xwkGe9u7OlNpmXQ48pIq9DhbYFMKZLYlFw5hOqy5gIatDJ6WHvmLEAs/vlOCVYiZ3zGDMR1ZV
 W1wx712cgG94ARUMb5L6Z1Hx/cCuF64a/AzITPtC3zCCUbb0kMV8M9+4Ycjoj0e+nPksLfo1M
 HlV4YevtTW5yVG/1w5zN41aYn+1tNcd1+yE9AbUyZ2kd3no5f4hZSLyo2pS8FA7heeRQgyd/e
 cx/BiOoTrYtsYedAapNdn1IgR1s+1kl2RNSHDVzMrdKOpUyNXIUohNI8W36y4zq2y0KBATW61
 I07aVibXEkNZ/E+M83RtcP+MHSG66BxdNjfTfany+ebO9OPfs5bjt+1pFX/jm6pUx7JUeMxwX
 IVL/XJQbJ4cEItDJaIK96g/Q/u5cJB9kDx14yrmSzVqTYr3tN2RQMns4DWPLiHt/DydQabhpP
 P7dpRgP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/receive-pack.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f96834f42c9..48c07ddb659 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -986,7 +986,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 {
 	const char *name = cmd->ref_name;
 	struct strbuf namespaced_name_buf = STRBUF_INIT;
-	const char *namespaced_name, *ret;
+	static char *namespaced_name;
+	const char *ret;
 	struct object_id *old_oid = &cmd->old_oid;
 	struct object_id *new_oid = &cmd->new_oid;
 
@@ -997,6 +998,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	}
 
 	strbuf_addf(&namespaced_name_buf, "%s%s", get_git_namespace(), name);
+	free(namespaced_name);
 	namespaced_name = strbuf_detach(&namespaced_name_buf, NULL);
 
 	if (is_ref_checked_out(namespaced_name)) {
-- 
2.12.2.windows.2.800.gede8f145e06


