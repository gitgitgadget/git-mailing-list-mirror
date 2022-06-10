Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98930C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbiFJCCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242557AbiFJCBv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:01:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E073D18360
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:01:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k19so34625373wrd.8
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SWCDf5jIVJYzwbGqgU48nEU444oCC3CpSqOR4EuHxoA=;
        b=IZm0GseT7F1OWnRzRE6QBEBc5ffzxNFRugIBczUQHaRJeD8HVvfLcFzKoyzo7yNck8
         QgPoN/bSyHHENdBADfdNWUh7TX5pi8Ke9AuNLnu+BHQlWwQ+BF5sVjy2QhmdQFSDcjis
         pjHxkzDNJm5LFcx4b6NjGBLYPa/XNul97atWGZft1oifzGSVmxkyAicMudjKwTB5vpYs
         g39EM71y15uAe4gEKS5KY2Lvdg5xx337lSky4s61686HBQ4JRXx25Ei39CD8lRG9b/hV
         +LjS2QK7M45qi+Jot1MllWTQevdxd3KiTp0up/40LC33l1Db+pfTSL8CkQoaKYkKLlYU
         GZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SWCDf5jIVJYzwbGqgU48nEU444oCC3CpSqOR4EuHxoA=;
        b=SNB4L31H7etzsitIRXiJTHMGOrTaJj7z6JtR3V1TB48NCZnznHOLKtGDiiPAOdvQP6
         veebvmid9Xwr+xbHvHEog9LOxsS2Ih4tH1E553BaKBQcC6I/lC7M+E7TNd5vqNqkdMnm
         Ydn6Fa09g1c3eaV7mi+ysTQS8QCl2JVxQvUoD/9Yjo+z6pLpv9PGNxULm8buWnpD3QLA
         JGEjWMkMEpl7W7cuIUwQ3j6kZ/jJRTjBABJbsCXWKRjVw9Y/i2ptrUz3Ci3BKbFxKEa/
         OwwIdlhTDODItzjFcZrvM232cuPElxKpByq+tIezYb2YBLQqaW29iRPijQAltQvehcgm
         Vx7g==
X-Gm-Message-State: AOAM533/9FKyTpCO/JcD3I8vUf12qCQvFScIr7RQfzTerPWceHTgz6qe
        4BgNah9Zmkg1OxPJzIcRkRxBtm44+pRQEw==
X-Google-Smtp-Source: ABdhPJyCGHf5F3tI6hVO9fEItDUO/m8QJ72vVramToMxcCsidE//MysjtpU3z/+0+3q5sl3S7/OV2g==
X-Received: by 2002:a5d:584c:0:b0:218:4e98:770a with SMTP id i12-20020a5d584c000000b002184e98770amr17082092wrf.271.1654826509165;
        Thu, 09 Jun 2022 19:01:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:01:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 05/20] git-submodule.sh: normalize parsing of --cached
Date:   Fri, 10 Jun 2022 04:01:17 +0200
Message-Id: <RFC-patch-05.20-124c062e3a1-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the assignment of "$1" to the "$cached" variable. As seen in
the initial implementation in 70c7ac22de6 (Add git-submodule command,
2007-05-26) we only need to keep track of if we've seen the --cached
option. In 28f9af5d25e (git-submodule summary: code framework,
2008-03-11) "$1" was assigned to it, but there was no reason to do
so. Let's undo that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 1b0a31b8383..20fc1b620fa 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -446,7 +446,7 @@ cmd_summary() {
 	do
 		case "$1" in
 		--cached)
-			cached="$1"
+			cached=1
 			;;
 		--files)
 			files="$1"
@@ -575,7 +575,7 @@ do
 		GIT_QUIET=1
 		;;
 	--cached)
-		cached="$1"
+		cached=1
 		;;
 	--)
 		break
-- 
2.36.1.1178.gb5b1747c546

