Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DE6C6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 17:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjDRRus (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 13:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjDRRum (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 13:50:42 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EA2D326
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 10:50:41 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ec9ccab8bbso2338528e87.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 10:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681840239; x=1684432239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2unZZ0tkwjTB6Nef/MJvYMRgoZQUGroeYnEdH+E8r0=;
        b=Ib9lZ9PInm3TZjwfiX+mgm4Dvgke3Pwm2qSycENUawvrun5FaTDUNKiZb+EQzkJSRJ
         /kvyr5Na4x5TQSOtXPjk9BcLRYOA23TnVUwYBaYyFHGh3me8A7r1KvwyNNpLFg3uVC+M
         WExwNc6eLSqYI72iwNvDcWJzNqfSeSsWcgNRzGmjUTk9XP3YH2493bf4cR2sKNxwQInB
         JRp9y2ikjWuz6YRifrRwswA+JesHGmGvphIXqZCUxTsUevnTgnwbL1OUJcuhDAD5EVRp
         Iux3j+pn6X/y/qA8sxoLa6zz2AIPhgMd+idNt4WR9nbZtXSBrctClK6xkHplxjjtTzPp
         P1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681840239; x=1684432239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2unZZ0tkwjTB6Nef/MJvYMRgoZQUGroeYnEdH+E8r0=;
        b=T6UrcC27dwWJwyBoAGV7mQExxwHUXpwgsa9ykdd3PZDUAl///Pd7MRFz4mAnSsiiTK
         s0iQxtPq0M7sCHQZ77wGSnDufMe55rceAlCGUoYqVsCNaDFumxGNfe9NY9NAcF3T1LFh
         oLK7pbZy9EZMvhjxIPU977u2qjP5M73wGjZhNuxV+3LVXq7QA//9VshHslP8/ZzSgnOF
         K+AbFGAEC9p12yjt3U7/1dZDr7cAeBaosMhTxZdN4qovS/fffqb59LNF5CBeW3rKDaCy
         ecIEenx7IcUuhwU1C0hgHXfPlBkl8akFL4Cu582UOEFmFFpTVR5jkAvphgHa8WOvkcoO
         Xufg==
X-Gm-Message-State: AAQBX9cxnlvKo86mEhJQ+3R/NSNI85EEH91pYXXEOm+GMgHL8fqxffLa
        XBKYou4r436wsuvFtSoPukZ5V91nzdSjbCwS
X-Google-Smtp-Source: AKy350bE8I0bK/eAH2s83nBO8ptw5i5HGFFxPnvyDwUQNOdCrk6F4oANhVUsma5Yp/rw4utesQIxDg==
X-Received: by 2002:a19:ad4b:0:b0:4eb:680:391c with SMTP id s11-20020a19ad4b000000b004eb0680391cmr2955755lfd.10.1681840239313;
        Tue, 18 Apr 2023 10:50:39 -0700 (PDT)
Received: from titov.fritz.box ([195.246.120.47])
        by smtp.gmail.com with ESMTPSA id l20-20020a19c214000000b004ed149acc08sm2294998lfc.93.2023.04.18.10.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 10:50:38 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] t1300: drop duplicate test
Date:   Tue, 18 Apr 2023 19:50:32 +0200
Message-Id: <20230418175034.982433-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418175034.982433-1-rybak.a.v@gmail.com>
References: <20230414081352.810296-1-rybak.a.v@gmail.com>
 <20230418175034.982433-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two almost identical tests called 'git config ignores pairs
with zero count' in file t1300-config.sh.  Drop the first of these and
keep the one that contains more assertions.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1300-config.sh | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 2575279ab8..696dca17c6 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1458,13 +1458,6 @@ test_expect_success 'git config ignores pairs without count' '
 	test_must_be_empty error
 '
 
-test_expect_success 'git config ignores pairs with zero count' '
-	test_must_fail env \
-		GIT_CONFIG_COUNT=0 \
-		GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
-		git config pair.one
-'
-
 test_expect_success 'git config ignores pairs exceeding count' '
 	GIT_CONFIG_COUNT=1 \
 		GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
-- 
2.40.0

