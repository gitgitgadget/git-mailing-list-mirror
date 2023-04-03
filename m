Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1BFC76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 22:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjDCWdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 18:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjDCWdr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 18:33:47 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C4F422B
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 15:33:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j24so30933119wrd.0
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 15:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680561222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRu4JBrQ9k+aFnaTKf0xWSTGf6TU8UWVGqC92cgpg48=;
        b=lQZcpei97z8yZ62OGM5Z+/mJNXvujf0Da57OZs93KWx3/uy48h8gMlxuq2p7GRW3FW
         h1qSKT/UU6jDfetPmzCVxo+eilP0ykUaCdQna7RBLcvgn0sQ3j7mghLzf7YqGD126AO1
         wIQTfbA+MYi4KYJQDk3MCL2/gBdBhJYlM86Ka7DyTDXLrwhFFKq582k0Kh5e0LC3Hr/4
         c2bIjUeLKP9qvKq7QTIpwOgrDVGniAeSYh2EfoXEfCKK7AgV+Ks43QGUTSKR1ym8yG8Z
         SfQpLkJ+3qjVuLwGP6FWBhro33+mpEfDN36Ielif77deZC7AE+439+knkbMVlGZD+CmM
         w4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680561222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRu4JBrQ9k+aFnaTKf0xWSTGf6TU8UWVGqC92cgpg48=;
        b=FEmKWs3IJKMYm3vd+K8e38ty8RVWNyd8/TN8d9C4ykfn9R1xfjejDra1FsojrCI/oS
         k444XgaWMCsJ7S2beWQI76n3c/rRgtvTAVEbbMWFa2AOY0HDB1/X9V+3JgTA2wZvIjDo
         3udMteztDxzXkq3JdFMC1ZarhAdvC9Mlg12669LbOoas0hqIHcmqMtoEpVtUOkCvNvAf
         +fnyLtPEoj7HS2abUcaHWRJ/Xqw+xvodh8Sf6q0rWqKSdGAiGV6pRJXGOfcVxJtOR/SM
         TMcThamEpSLrlSopo3McyzHl+5bIhAPI3fCbgzzZdPCtM87JImDvwkT8dXxNsvslfFkt
         6KNw==
X-Gm-Message-State: AAQBX9eG/VbkwlwNmhIf8mO4IoHGOMZEHCCfliOvdtlyl48juXuFd5Dl
        oCqgEePMVpTkXtFAFdeh96x5utx7TzODkKINuJk=
X-Google-Smtp-Source: AKy350YbmmvhgkmJw+1Yy01oVVNxGu6+gGL2IPQbDmCBgva78sIcFr62RJh0Pi0c14DsEVkxbHqZtg==
X-Received: by 2002:adf:db81:0:b0:2ce:a093:6fd3 with SMTP id u1-20020adfdb81000000b002cea0936fd3mr74992wri.16.1680561222240;
        Mon, 03 Apr 2023 15:33:42 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.24])
        by smtp.gmail.com with ESMTPSA id m17-20020adfe0d1000000b002d1e49cff35sm10697453wri.40.2023.04.03.15.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 15:33:41 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/6] t1300: fix config file syntax error descriptions
Date:   Tue,  4 Apr 2023 00:33:34 +0200
Message-Id: <20230403223338.468025-3-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230403223338.468025-1-rybak.a.v@gmail.com>
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
 <20230403223338.468025-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Three tests in t1300-config.sh check that "git config --get" barfs when
the config file contains various syntax errors: key=value pair without
equals sign, broken section line, and broken value string.  The sample
config files include a comment describing the kind of broken syntax.
This description seems to have been copy-pasted from the "broken section
line" sample to the other two samples.

Fix descriptions of broken config file syntax in samples used in
t1300-config.sh.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1300-config.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 2575279ab8..d566729d74 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1571,7 +1571,7 @@ test_expect_success 'git config --edit respects core.editor' '
 # malformed configuration files
 test_expect_success 'barf on syntax error' '
 	cat >.git/config <<-\EOF &&
-	# broken section line
+	# broken key=value
 	[section]
 	key garbage
 	EOF
@@ -1591,7 +1591,7 @@ test_expect_success 'barf on incomplete section header' '
 
 test_expect_success 'barf on incomplete string' '
 	cat >.git/config <<-\EOF &&
-	# broken section line
+	# broken value string
 	[section]
 	key = "value string
 	EOF
-- 
2.40.0

