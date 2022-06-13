Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE54C43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 22:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbiFMWjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240416AbiFMWjM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 18:39:12 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8178E617B
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:11 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m16-20020a7bca50000000b0039c8a224c95so2953331wml.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y+r5och2DZ/8noC0JmNt3LVq+VX5ioGRh30WmY3pn6g=;
        b=EgQGKNgi+9kcyDNp86kg5wLZN2lzsOb0e/Vn9Es1+AreTNidtEQUO/OSrBg+3p+RNj
         jBsTiY4qlb6EeO0fTeo9WvjSEBredU0tcfuKEJtE8sy14xrndTMWW0FABxDmu3uhJ2oF
         cETFcS431iuoNv/1y3iuTRAyM/aD3+Ovc3g/zIlizKqsjyPJd809tS6iUKj4IzRw3agQ
         +qDswaEA1opuY6gQ6oHKClD/fSyHWPWFkl2/JtmTjp1pxju03tuO/PX9MPLXDS+j/kQG
         eEwHUau8Wcxfj7SCL8p9nZqvKljYqwHe2PZYyMgNcLiCg2uMSBmQYodQCGfMHs9Bvfmc
         tr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y+r5och2DZ/8noC0JmNt3LVq+VX5ioGRh30WmY3pn6g=;
        b=69VRBxgzwfdNSX0Hi4kIypQiLWYARLaaHoNoxaAsb1yUcs1z1KIQR2o1ler+Rf2dd9
         VLAQJT5sa/cfE0ImU9cngg0XMUj2YKKt7z0LOXhwkzbD0de0hEGT4w8JDY2SiOUrl8rm
         mm81q5afogNQ8yj8rK9O6gdn5XnTjIrqJbWW8DtdJ37n6y1wHFbNvLgl3179ngO/GXUu
         ZjmArf5/smXE5sqGVX87eiSUYgfOwpeXZDWONaL5U+Gu/Tk7Kb/DjOjhr1NpdwBurIgt
         B1mdaIv5CarthRPZCIKZwqxsJed82BK5D1PR6h0VbrZRnX4cTb6O8LriTgkD0hvRcaqp
         Bj7w==
X-Gm-Message-State: AOAM533zW3NXjQX4byVAd+b6IjNjhIj2iVA5znJsLSi2aSD845jRSIhR
        /LpWelVCfLdc09aTyv1SDSaUF+atrz7f0A==
X-Google-Smtp-Source: ABdhPJxT6NoI2Btg1nYhwEUQNvt49oGEJZaQo03ZsunS7OWWg4llLDWSvoKOpQ7khFde8ZWRWji+Cw==
X-Received: by 2002:a05:600c:a42:b0:39c:9166:5a55 with SMTP id c2-20020a05600c0a4200b0039c91665a55mr900500wmq.141.1655159949864;
        Mon, 13 Jun 2022 15:39:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y3-20020adfd083000000b002103cfd2fbasm9670303wrh.65.2022.06.13.15.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 15:39:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/12] git-submodule.sh: make "$cached" variable a boolean
Date:   Tue, 14 Jun 2022 00:38:54 +0200
Message-Id: <patch-v2-03.12-d5c8613c654-20220613T220150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com> <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the assignment of "$1" to the "$cached" variable. As seen in
the initial implementation in 70c7ac22de6 (Add git-submodule command,
2007-05-26) we only need to keep track of if we've seen the --cached
option, not save the "--cached" string for later use.

In 28f9af5d25e (git-submodule summary: code framework, 2008-03-11)
"$1" was assigned to it, but since there was no reason to do so let's
stop doing it. This trivial change will make it easier to reason about
an eventual change that'll remove the cmd_summary() function in favor
of dispatching to "git submodule--helper summary" directly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 53847bbf6e2..b99a00d9f84 100755
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
@@ -583,7 +583,7 @@ do
 		branch="$2"; shift
 		;;
 	--cached)
-		cached="$1"
+		cached=1
 		;;
 	--)
 		break
-- 
2.36.1.1239.gfba91521d90

