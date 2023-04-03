Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3497AC76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 22:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjDCWds (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 18:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjDCWdr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 18:33:47 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57B34229
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 15:33:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l12so30862974wrm.10
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 15:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680561222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTIVO4CzqYGDdGVLSLZ5Q4oUYJVrpVeyxTmpchSgJYI=;
        b=bpTaHZsbhXTdqLnslovWD1FZDmlK1uwLDSYMGhpQ2hcrLGeo2LT50TVpJGOc5seB6k
         IR/4nhXc6JA2btexpj3R3qQQqprLBjMUgDna1Jb0u8WVhj8BiRdXZVXllbYHl1d0NgQh
         ValGVnJa1skq6w24wMLDqmSvfxZjYIwf16wCC+ic1CuAZzKNjuZtFPeN/lz5BXK6zADS
         RoYIXuSXbnfhv/iVmWLR2FdRx41r1aCFQx0HN45wjVrfgHF/y5Qy+FJMEd81jCAH/SZE
         r6nSELwnHZ/88qtaX+qB/lo3kWBl1rHInj1Cn8oHi9eTm5Di9kS/XWMZAclsitMIlNpT
         IG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680561222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTIVO4CzqYGDdGVLSLZ5Q4oUYJVrpVeyxTmpchSgJYI=;
        b=KF6F93n7K5kQ4Wx3S0kO/BnTq5sWoG0Qs3kjA8VF2l8BVeXEtB4dZamHfKCzox3Px5
         0RANbprTdW52JJRlvzov6jfMoczNBV098MJWGvZkQPhhkXCb6yXGDL36geeqgyR+HFrP
         MU7YIjTL/1H8zdgRQtamOzlNfpl15ULxrE5SjjRQ6BZRx4kh5Ojeu14IIiuqcpS3Kb3J
         musRkqr989L/GA4+qGmq7dzsYoFo6kicl6UNOtg1egHePFYB1maufwyjfmgli6dq4l+e
         05V74/KoiWub1cCzy2sFYGaNGGJaSuWs7ZpdumTjGml04ALah47TDfRL6LhvoHOrq74f
         JnRw==
X-Gm-Message-State: AAQBX9fxh9K3YzIGKcClKwIiEu49vsEgqPRfISZbTs3vFSW4t81OHhtv
        lW83sKOLYNjnyTTgQeeSwVZxebr5VVas5bK5RIw=
X-Google-Smtp-Source: AKy350bYxVUWss7JPOMAHEJzXZgfsgRV8PKGHGc60K89tk7VWXVkOLz6L2t3HA/ZVNOE5bJL4OBF9A==
X-Received: by 2002:a5d:560b:0:b0:2e4:b9a3:441a with SMTP id l11-20020a5d560b000000b002e4b9a3441amr43797wrv.50.1680561221642;
        Mon, 03 Apr 2023 15:33:41 -0700 (PDT)
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
Subject: [PATCH v2 1/6] t0300: don't create unused file
Date:   Tue,  4 Apr 2023 00:33:33 +0200
Message-Id: <20230403223338.468025-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230403223338.468025-1-rybak.a.v@gmail.com>
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
 <20230403223338.468025-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 'credential config with partial URLs' in t0300-credentials.sh
contains three "git credential fill" invocations.  For two of the
invocations, the test asserts presence or absence of string "yep" in the
standard output.  For the third test it checks for an error message in
standard error.

Don't redirect standard output of "git credential" to file "stdout" in
t0300-credentials.sh to avoid creating an unnecessary file when only
standard error is checked.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t0300-credentials.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index c66d91e82d..b8612ede95 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -808,7 +808,7 @@ test_expect_success 'credential config with partial URLs' '
 
 	git -c credential.$partial.helper=yep \
 		-c credential.with%0anewline.username=uh-oh \
-		credential fill <stdin >stdout 2>stderr &&
+		credential fill <stdin 2>stderr &&
 	test_i18ngrep "skipping credential lookup for key" stderr
 '
 
-- 
2.40.0

