Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C00C636CC
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 01:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjBIBMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 20:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjBIBMW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 20:12:22 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2ADC175
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 17:12:12 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g13so1180469ple.10
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 17:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLz1kN1SFxcFfl/UiDqft2nNXXwHoPH+fqEEB0lGUUg=;
        b=FjDyWCtx+2yfbyzFC+5S2VnIAeXc6y7wgRmZlMo4ujizKctK49OCK8XeG9KmZhhbJF
         QVmJHvUcNN1zy04Xu/ba+Y3uMLXNjrauJcQ5rcRheUoP6rpS3r0Iq2kKyv8SvFynk1PC
         Hav8kngtCk+/bwz/5XAETShKgkvnXmFQl63+GOy93wUlJeOPC5dUkOBHW0nhKM+6An+K
         +hiVA25/JCd4P7COfZz2XGMYEh/hdZ/SnpG3iKk6Om37zvz6UfS81YfRxi7gQKhKBzd0
         oMZ19vJjhlF/4WlcFVetJzPxzd7gq9PStT8jh4TXATNpji/7yenFKsRJqICxDJp6rGdt
         aBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLz1kN1SFxcFfl/UiDqft2nNXXwHoPH+fqEEB0lGUUg=;
        b=lu+PI0II0XX5se23w7eOpdaZ/uBtcHgFWfpCLNVmH9PY+QHooN6d4jEdRQ982tTsXR
         R0/1+KG1rLVTS42mDr3Mgs2oh2hU3Eszr+Xj1IIDt4I0dkz1Zx/ojYeSUAjxZr8kJEYX
         QzQHwCnLvAjBp5edqBAQi/0zdSYQjsgFTaKDJvttIz36YzyxeGpfp71Uwu9nveqztSbp
         OXPPC8hPsd4Kzr196Lfiy2uuSxd2Mic0FuJ40iu6vrJWT4oyEjC1sBU7ifez4gIRg/uB
         PRYkXfpuzIf8I3txovWlPeIbFVGBmOUgQG5YIi2bytn6PT9PCzuK6cw1hORw+K7R4nvR
         rOHg==
X-Gm-Message-State: AO0yUKXZgeleFwKtQ9gXR7/cLcbBZ8omud/aEWa8QLexPBuYDeHOLdOX
        YX3YCiPq/GokWS1p88R8rmCzdUlytBvrXw==
X-Google-Smtp-Source: AK7set+yywdTxvUrObsu7Pskl8D0vpNK+tTTmgPu3CvN5Y6YA0fL4G/LEoML0dIKnJpgjQRTRP3m+w==
X-Received: by 2002:a17:902:e411:b0:192:c36c:f115 with SMTP id m17-20020a170902e41100b00192c36cf115mr6727644ple.66.1675905131978;
        Wed, 08 Feb 2023 17:12:11 -0800 (PST)
Received: from kir-rhat.redhat.com (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902a38800b00198e6257921sm73965pla.269.2023.02.08.17.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 17:12:11 -0800 (PST)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Kir Kolyshkin <kolyshkin@gmail.com>,
        Roman Dodin <dodin.roman@gmail.com>
Subject: [PATCH] remote: align columns on -v
Date:   Wed,  8 Feb 2023 17:12:01 -0800
Message-Id: <20230209011201.1974721-1-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230207235238.1850757-1-kolyshkin@gmail.com>
References: <20230207235238.1850757-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, git remote -v produces a misaligned output when some remote
names are shorter and some are longer than a tab step. For example:

giuseppe	https://github.com/giuseppe/runc (fetch)
giuseppe	https://github.com/giuseppe/runc (push)
kir	git@github.com:kolyshkin/runc.git (fetch)
kir	git@github.com:kolyshkin/runc.git (push)
lifubang	https://github.com/lifubang/runc (fetch)
lifubang	https://github.com/lifubang/runc (push)
marquiz	https://github.com/marquiz/runc (fetch)
marquiz	https://github.com/marquiz/runc (push)

Let's find the maximum width of remote and use it for alignment.
With this change in place, the output looks like this now:

giuseppe  https://github.com/giuseppe/runc (fetch)
giuseppe  https://github.com/giuseppe/runc (push)
kir       git@github.com:kolyshkin/runc.git (fetch)
kir       git@github.com:kolyshkin/runc.git (push)
lifubang  https://github.com/lifubang/runc (fetch)
lifubang  https://github.com/lifubang/runc (push)
marquiz   https://github.com/marquiz/runc (fetch)
marquiz   https://github.com/marquiz/runc (push)

[v2: use utf8_strwidth and padding, fix description]

Reported-by: Roman Dodin <dodin.roman@gmail.com>
Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
---
 builtin/remote.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 729f6f3643..654472a87c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -13,6 +13,7 @@
 #include "strvec.h"
 #include "commit-reach.h"
 #include "progress.h"
+#include "utf8.h"
 
 static const char * const builtin_remote_usage[] = {
 	"git remote [-v | --verbose]",
@@ -1245,14 +1246,26 @@ static int show_all(void)
 	result = for_each_remote(get_one_entry, &list);
 
 	if (!result) {
-		int i;
+		int i, width = 7;
+
+		if (verbose) {
+			for (i = 0; i < list.nr; i++) {
+				int w = utf8_strwidth((list.items + i)->string);
+				if (w > width)
+					width = w;
+			}
+		}
 
 		string_list_sort(&list);
 		for (i = 0; i < list.nr; i++) {
 			struct string_list_item *item = list.items + i;
-			if (verbose)
-				printf("%s\t%s\n", item->string,
+			if (verbose) {
+				int padding = width - utf8_strwidth(item->string);
+				if (padding < 0)
+					padding = 0;
+				printf("%*s%s %s\n", padding, "", item->string,
 					item->util ? (const char *)item->util : "");
+			}
 			else {
 				if (i && !strcmp((item - 1)->string, item->string))
 					continue;
-- 
2.39.0

