Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD59C54E76
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 17:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbjAQRMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbjAQRLh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 12:11:37 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540C4442EF
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:36 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so76961502ejc.4
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/TBun5atiNc/oQ2kl9/mKAezutuVYs7tQgzxFAmUZ4=;
        b=npCNXgJe3wpb6E/NSFSWKqm3R74Q4Yk14We1bkaFL3RI1mI7rqj62CsMc8b6ivGvsu
         stI7EOz8/MFM5DamBPEL75s+YhvOHi255ZoXi0dso8S39m2NpGL8XmPOv1Jcg4gG3Z7g
         84qU30/iXJwS6wrZoAA6FLIy59bOvJqGjGkiZgeQFudjXzeTp42ap55dRYitmBN5onsV
         I6b9EnKShbSPee7DuRAX47PRUqd2F8lA1tJ4Y37G8krF+wFIdnTcb47F7WO6eZOCcc23
         XHV6nq0meUm98ooZKHHRB0lUR10GXbKeyFjXrVSAw/JXRZR29gv7PK1w9ohI+sIBKu7S
         oA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/TBun5atiNc/oQ2kl9/mKAezutuVYs7tQgzxFAmUZ4=;
        b=q/1Bt3BmFQsqbv39fYBOH9aQIoF0uE9POUlYQtSyodiaxOlHKhDQrwoUbxJxPYCx/2
         erbGFSuX+kOailgNKmlKG0gbi5154Tp5E/N4NwO0Ubf8wqk4T54dQobTdxuQewBbQYVV
         /fkY4Kmg17szmA0+8n7KOveEDCP9PSn8mJeAiw9uVxPSd8jFBoew82FAbzWgbWY1QwxE
         Lrw54CHueTvngwHsBq0LT2lyE/zKTENtjAEHvaPi0uWutkLENZWmI/mqsb8eAkdc6VEq
         zR4m6AA4cv07Iw6cGOb8ev53s4x41zC8si/KHUCde3E08/ZznIQ39NmWAUVggcH5+3b5
         0ojg==
X-Gm-Message-State: AFqh2kpOvlDPIRRM4Foq0WneGn/A3gnI+TGnq8Pt8M2SeLLCd/ZaFLea
        /a31G1u8TfZPCY/WpP9NLmd0BNj3evluNQ==
X-Google-Smtp-Source: AMrXdXszb72R2Zu/eEmYlrMRcrdv3qml3kVcZpLFQFB8AcOgjs/2wqUo7kdr+dqjWXx0zDp7RVfUuQ==
X-Received: by 2002:a17:906:9f03:b0:7c1:6e08:4c20 with SMTP id fy3-20020a1709069f0300b007c16e084c20mr3967732ejc.7.1673975494663;
        Tue, 17 Jan 2023 09:11:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b0046892e493dcsm13191268eda.26.2023.01.17.09.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:11:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 10/19] http-backend.c: fix cmd_main() memory leak, refactor reg{exec,free}()
Date:   Tue, 17 Jan 2023 18:11:15 +0100
Message-Id: <patch-v4-10.19-246f71bb447-20230117T151202Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com> <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
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
2.39.0.1225.g30a3d88132d

