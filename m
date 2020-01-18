Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377FAC33CB1
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 14:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090802469A
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 14:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN3Lt0+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgAROFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 09:05:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34888 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgAROFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 09:05:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so25248533wro.2
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 06:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oKuiaGbge3w89wwq6hiaDxTZqhaCMzDsxkfy/39CVRI=;
        b=lN3Lt0+Xtp/pShbLSrIONNs7FaIouAKEA9JZVRJwfawW2fSSR/K+hYSgBuObvG/1mx
         x5d5WIHdLCVvRf35JK2S3p9qxFVVYfdslFcQXGEptx8rVWA8JhD9VBP6mPivkqHtpYyW
         xSucbBEsEH7fO/eWmXFBCNWjegNUVKoG6Y7PpppEV+O7c1ljyQ3K8SsQHwLxreNQH5QK
         h+iCpuQ0RN4h3Tw6WVH7FLHsBPZCMMW6d7m1H/nVEZscwhm8EjlNnIzqi35N6AKf1w4C
         2DEKIubyTyBHyoijvFOgOwFbsrV5yQlHXL1Gj/pLk86Pb28Ueh/RK98QQUN5ayJBIgBj
         gaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oKuiaGbge3w89wwq6hiaDxTZqhaCMzDsxkfy/39CVRI=;
        b=hpQBYOVdgvmTmId6OWMPaESIeo370JxsD5KPqFRAxKZwoAeWiy5Sn5R4IjP/AAee79
         6Tm4Ypx2IS1R0pxCn7+3ePAhMEkHAcRXZ7g3YhqvM7XvUur12W04px21pEdUNBtsXO+7
         xr8xVF18L2VkAAdKSy1Qw0ZpC/kd8aEj7fpYnizuWfsuK+6Bciptx8VoqTaiBlTl2rix
         /zoK8fiXfu/nPSBhkySZWxadpBBcDf5m2+zc/FMFyEPCNmewno9PgIJFNniEECzS9k7S
         ck2F4yYhYMYBT7VL3xtImzCZcLSnBU6js6zGAg1/5jIgauYdp4IIohaDtpuiVO+pFDXW
         odqw==
X-Gm-Message-State: APjAAAU/mh/GKvUVSZHMrHH+7OwKoWZf9o3fGk07oYn7sLJmK/Cy4SOG
        ZvcxXDvW2blSC5xsBE2bfcBdo34Y
X-Google-Smtp-Source: APXvYqzU84MTSeUn1h4o44MtIogfmuyvAeOQs/ZmlReCNoFQSDEkYGGQoo5RnN8hLKnUGJsunhCQ+Q==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr8502717wrp.322.1579356314481;
        Sat, 18 Jan 2020 06:05:14 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-84-141.w90-5.abo.wanadoo.fr. [90.5.87.141])
        by smtp.googlemail.com with ESMTPSA id u84sm3615892wmg.10.2020.01.18.06.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jan 2020 06:05:13 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH] po/fr.po: various typofixes
Date:   Sat, 18 Jan 2020 14:59:13 +0100
Message-Id: <20200118135913.1845-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"commande" and "récupération" are feminin nouns in French, but here
their definite article is "le", which is the article of masculine nouns;
the correct article is "la".

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 po/fr.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/fr.po b/po/fr.po
index 3ff44e57af..776c58e56d 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -3556,7 +3556,7 @@ msgstr ""
 msgid ""
 "you may want to set your %s variable to at least %d and retry the command."
 msgstr ""
-"vous souhaitez peut-être régler la variable %s à au moins %d et réessayer le "
+"vous souhaitez peut-être régler la variable %s à au moins %d et réessayer la "
 "commande."
 
 #: dir.c:554
@@ -3794,7 +3794,7 @@ msgstr "pas de commit commun"
 
 #: fetch-pack.c:1070 fetch-pack.c:1536
 msgid "git fetch-pack: fetch failed."
-msgstr "git fetch-pack : échec de le récupération."
+msgstr "git fetch-pack : échec de la récupération."
 
 #: fetch-pack.c:1209
 msgid "Server does not support shallow requests"
-- 
2.24.1

