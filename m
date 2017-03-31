Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 820F31FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 13:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933214AbdCaNvo (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 09:51:44 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:50246 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933080AbdCaNvm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 09:51:42 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue003
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0La0Mr-1cQgbt1Ay5-00liHE; Fri, 31
 Mar 2017 15:51:36 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH v3 4/4] describe: pass --debug down to name-rev
Date:   Fri, 31 Mar 2017 15:51:24 +0200
Message-Id: <1f59ad094670665b9db44bdc0addf7de922e0246.1490967948.git.git@grubix.eu>
X-Mailer: git-send-email 2.12.2.739.gfc3eb97820
In-Reply-To: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com>
References: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <cover.1490967948.git.git@grubix.eu>
References: <cover.1490967948.git.git@grubix.eu>
X-Provags-ID: V03:K0:xa1bIP67DDon0YCqsx6m5NoHEM2rV8RiI0ubY7VP2anWnKktx/W
 H7CkLmVGTEVOnZqRhi5k/HPrIfwXkLvWi7FOk0pHNkVLcPiT5iYYDLIHxiY6kYoYsvjY34d
 K7ZUlxhrZHWBryEFl5JT/gV7booBZsWVN+pti8nvGzX2JSuKZ4GN5OKT5+1Jrnznx0GDbrE
 9jsag7yMVXobP5amLBA7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:glkO/ZV0YpY=:y8RLe/QctuKi6uLts4Od1V
 Viwh8QfWRO75XpcnaR3Ku2LyeKwBiNbMW9N5u2y/tdU5+HLcK/OSwkve2ApNxTYD++EMRzK9z
 mH1RHY07Fq1iYFXojQ7tsyNhJ0eocwrV84h5nkc0kZGPW5TpKVjjx+6j+G/weDHOF9Li+5yrd
 FxCzeRWo0+oupFCQ2KmykOWPdIB3Wok0Sa9HY0R3tJDTQKv3NLEznsXo7tjXB+FnmQt0bvBu6
 dQa12Ac++emlH0+Md2m7x+/9MqaTAhIEr4kd1bj24VD98o4xCHGU7FkVsJOdOHJZmFQ6FRCTM
 CUazMHJMJdsQ0Jnx0Pv7HiX3c27B8Q8UXaKcZZ/+oE4RkjnSxzcL3NIg1X2kOJwPSL8ThmIta
 o1MV0YAXBBRVPmgz7B2gFinXPT1yLv1rBMBYDDnvXc69Z6DbyOtDxc1cSiAy6G7PjP1up+8kC
 3JWVtok64YP2NHQ+7b6op0m9yrGQrc1rhAXD9EO3EqX2upv2ba5DpNL+Bmengqeh1SWPzQt1S
 7bBf4JceogdEnUGzUvsOotNiNiaqtvGFdcm1eQ2em/HYRIAythd1AUkUIXCBy+F3TUwklVgJH
 W4Xw50eV26ghwREgl9AkBr4U8VzxNU+X3r71WdjTU8dbtDQvTz8mCpwq0/Xm8+ztVZ64CfwvZ
 S+K/intm9yt3v1sP4gmYU+ezJQfkwp15cKM+VMHkrccNdrVrH7v7wyPf5pXAF7zCKO5Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that name-rev knows --debug, pass that flag down to name-rev when we
call it for doing describe --contains.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 builtin/describe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index a5cd8c513f..30196793f0 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -486,6 +486,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 				 NULL);
 		if (always)
 			argv_array_push(&args, "--always");
+		if (debug)
+			argv_array_push(&args, "--debug");
 		if (!all) {
 			argv_array_push(&args, "--tags");
 			for_each_string_list_item(item, &patterns)
-- 
2.12.2.739.gfc3eb97820

