Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4161C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjBBJxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjBBJx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:53:28 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46C19020
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:53:08 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q8so916232wmo.5
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+1xeIHH8e7VVPp3ZkirbCrLXngWO5KqVCVyQVH9ayE=;
        b=TZO6m9jYZQieprzLn80kIaAmeH1XFulQA6mLsMFP42WfN0mzLXGFMa/HwU1P8D5pxR
         yWV6rsBCFL8zF5lfzl78deXVEhMIrNNDSj3gifloydc0HJdmfD6/Dgg9Ajyv+6kWLQec
         jQkZwyFVoehGBfQE9Us8djRwa5ju0s0UUkZNA7BipAJ15FjaHkbLcdL8R4rw13MSPX8G
         P+KieO3xgLaPCim38tI5dYKgVvZXCRyShKzFRuGCr608qUC2Oo38ro1SRHgSO7g6KX6r
         u9HVW4NT/sMQO7OKRK3InywUHwmfeBAdrAdUgyw1tYcO4xLJuCYmXM//QI9rbj16HPp8
         5ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+1xeIHH8e7VVPp3ZkirbCrLXngWO5KqVCVyQVH9ayE=;
        b=Xqgqu4BxvYIqcN/tve4NfIsIBZiNcGalIJxY+YHEZFPpNZ0MWtMQhp9aEv5ofB8f8B
         MYi7ytywVyzHtaG0bTzhAP6HeReGlUSWBaR8lL9PdJiwtoFH0wSWMbAWSJRCkGf+jTbE
         FO1v8+/MyqbNd+UyBqJ4bWzoHxE4KjSIDiKY07zGuEaKrP9zwJGE+t7dbRZxOMrmS4H8
         a6BmftrFueXGf8LogIgrTIyBip6Ki8l9fNnzR+9QAPkdQghxBMsvEezC0om0lLbJB7He
         Sdgwm4RO+WHJWKAP+yUME4XhmLLJ7yIoDIvU9G2xt8JzXj/WUgkjaYRXT4rXJ93IwLfk
         2PAQ==
X-Gm-Message-State: AO0yUKWwKGeoOP8hvQsn1MoBuf4uezfafmnrA/AJtR+i8GVmOPWQQlfi
        AwEARfDM5h+bY/cVQ7CavbMJtQiSjlH4qvM3
X-Google-Smtp-Source: AK7set/bOidD/TdSHnq61icj6cgGpM9ub2KNvZMI0DMnoQxYMBNvjl0TD+7qKj2O2zr3HrgqiZ15ow==
X-Received: by 2002:a05:600c:2109:b0:3df:d86d:797a with SMTP id u9-20020a05600c210900b003dfd86d797amr1737455wml.25.1675331586869;
        Thu, 02 Feb 2023 01:53:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db03725e86sm4356234wmb.8.2023.02.02.01.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:53:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 10/19] http-backend.c: fix cmd_main() memory leak, refactor reg{exec,free}()
Date:   Thu,  2 Feb 2023 10:52:41 +0100
Message-Id: <patch-v6-10.19-9d9df0caf17-20230202T094704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us ever since
2f4038ab337 (Git-aware CGI to provide dumb HTTP transport,
2009-10-30). In this case we're not calling regerror() after a failed
regexec(), and don't otherwise use "re" afterwards.

We can therefore simplify this code by calling regfree() right after
the regexec(). An alternative fix would be to add a regfree() to both
the "return" and "break" path in this for-loop.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http-backend.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 67819d931ce..8ab58e55f85 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -759,10 +759,14 @@ int cmd_main(int argc, const char **argv)
 		struct service_cmd *c = &services[i];
 		regex_t re;
 		regmatch_t out[1];
+		int ret;
 
 		if (regcomp(&re, c->pattern, REG_EXTENDED))
 			die("Bogus regex in service table: %s", c->pattern);
-		if (!regexec(&re, dir, 1, out, 0)) {
+		ret = regexec(&re, dir, 1, out, 0);
+		regfree(&re);
+
+		if (!ret) {
 			size_t n;
 
 			if (strcmp(method, c->method))
@@ -774,7 +778,6 @@ int cmd_main(int argc, const char **argv)
 			dir[out[0].rm_so] = 0;
 			break;
 		}
-		regfree(&re);
 	}
 
 	if (!cmd)
-- 
2.39.1.1392.g63e6d408230

