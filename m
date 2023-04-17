Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B2EC77B78
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 19:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjDQTKz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 15:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjDQTKx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 15:10:53 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFCC1FF3
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 12:10:51 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l15so3047970ljq.8
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681758649; x=1684350649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRu4JBrQ9k+aFnaTKf0xWSTGf6TU8UWVGqC92cgpg48=;
        b=svFol8I3Ztn9XQCKcrB0N+r/TjFlSR96/wKUI1+QmzIp2j+6hARMcuJ+UgO0nHL/VY
         m+rzf4MT2OU2hk1igWX50WnZqFA0Rc1AP3guTBXzz3Oqk1jJqzP0vMa27ErDAU1wOlgX
         fYjqE+R/XGYJgm100SAy5UPDpa7P9Ut7Oj3jP9Xp2opy3DcqMq+kPq7+KS9E1ex5C+DP
         AkwewrlL0z/f4NT27dvZTg1TJLFvtNbKS6kSaFhLHQtoQnoaB9bLrQPFntq8g7hbdLk/
         LOIWHztDyTwrd+ZXYLB8qi9tJptPm6+rWz4RUaGskcq7nFWH6BJvdJJwXvYPDE4mSebG
         6qUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681758649; x=1684350649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRu4JBrQ9k+aFnaTKf0xWSTGf6TU8UWVGqC92cgpg48=;
        b=CS2jTtNiH8e2XuXnZZvygtCwKvfL57k2tBcmAJVIeSBFfEyZJ2XeEsGy9RlqRmIJdr
         pqImIgo/pH/JOjVkRPdbxyBL+rRc1EDWk1Rxgrk6VMY82G9xP3XY+RI9thYYdXM+uPcM
         9gNPBrEHRKP81lLB/B/60LQNExVU0zuor5jMUGEEUNKUq0gcLkGhJNM7h0+3NYLvmW56
         wwqsjCvmUPk6PTiGYt8bq1XGPdFwwo91v3muYYwPugPVjOPuhY4NM33OpG/ODsz26bGF
         pyO1c3CXfYnbNGQ6h0EfZjNRir+b5wj0F++HWMdbjTic2d+5J15+gJs6HrGlR1sC4iqd
         A3MQ==
X-Gm-Message-State: AAQBX9fu/JWp4jJg4eX26zuNGcHWoUIfKzLxAWy0uncPjg82U4mbPaCp
        wDuEwhLZx3zmxvsxS7DTpq34raToZpDj3uop
X-Google-Smtp-Source: AKy350ZfOx6iKN9M2koCQG88KEsblXr4AZKKpzpazZDo8vESEBxzXrL0fY7avgpGQBcXqimibzRFXA==
X-Received: by 2002:a2e:3602:0:b0:2a8:c842:d30a with SMTP id d2-20020a2e3602000000b002a8c842d30amr976487lja.37.1681758649587;
        Mon, 17 Apr 2023 12:10:49 -0700 (PDT)
Received: from titov.fritz.box ([195.246.120.47])
        by smtp.gmail.com with ESMTPSA id x1-20020a2e9c81000000b002a76e600228sm2304319lji.47.2023.04.17.12.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:10:49 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/6] t1300: fix config file syntax error descriptions
Date:   Mon, 17 Apr 2023 21:10:40 +0200
Message-Id: <20230417191044.909094-3-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230417191044.909094-1-rybak.a.v@gmail.com>
References: <20230403223338.468025-1-rybak.a.v@gmail.com>
 <20230417191044.909094-1-rybak.a.v@gmail.com>
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

