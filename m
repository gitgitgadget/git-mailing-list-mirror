Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2463C77B6C
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjC1Rj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjC1Rjs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:39:48 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F840D520
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:39:46 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-17e140619fdso13504922fac.11
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680025185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZHVcxrIiwB+5tBr4XBrXFT748jQEXsTLrvJrG4ZfW4=;
        b=araFP7DOxatKFDsa80BdEAQRIV5mICxUZ6q1zEtoZCF4vOUUjkirj6km240UdK0kpi
         KOnkyGkcIsNq5SMaubOqm1H67qJqI3QxVpgM1wpWjhPHYcmjIVkcuCN8Md0Q4jal+5XH
         zCSv/+TVht593bhDLN4Go3xnXDJj08B4d8QhATHlrVY0ft1WXQVIqLjm6+BVhLVjATqB
         BbYMYDj/YYg8hlnYryLujeCrBd9f2mUOiXtQVQxXB/oi9jIvXaw58Dyijp3/+5zj7EM4
         xE9gkrNNUIAo0EKIISEZUh6CA98uf3YRwMyMAJfH0e0UYGwNA4Z/aB1majBVfMRLKd5L
         iwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZHVcxrIiwB+5tBr4XBrXFT748jQEXsTLrvJrG4ZfW4=;
        b=5o9FlRJhuP6hC8lzfRlEVKIBkXbii8+OKU2PKYicEnkycb7zXErGpfvkvx1rvujfo1
         /suM09NyLGyKDGejBo4F2wt8Dv9LXfEkjN7ldMTEmHUYXUKsQ6hsV41/g3NqLRqAlgRY
         JjsR19mbq1+mG+eL5kFRJ910Po9mVSJ4Z8Xtds+Ipy0L68vKKokt19slLjCHfzInBRSY
         Fsjx2TC5FmPZJDVYFKD6708o06WXR3scLeMmBq3AkUdwQLTOeGrK7t8TG5UUqgjcjoq1
         vBod8fFm6Y95q97lI0AqyUv6Dx7bJHqi8edaHy2mpbgyarFEJNEowdYefenV2zu9tVDy
         K3mQ==
X-Gm-Message-State: AAQBX9dRE4CpDEij6AMXw8u4sOzE0BB2DAqwQxycPOC3gY7pm4Syk5U9
        t1i9f+EE1QElTAY/dvTV9sv1jCLgRMY=
X-Google-Smtp-Source: AK7set9JhAE3ZdEaW80fsFhf5ha8VH40s5s9nLrGb8aJouTksM4IhOa6NZOOpL3rSW2ghx494cMvcA==
X-Received: by 2002:a05:6870:b506:b0:172:7218:9c01 with SMTP id v6-20020a056870b50600b0017272189c01mr10818892oap.2.1680025185285;
        Tue, 28 Mar 2023 10:39:45 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id eo17-20020a056870ec9100b0017aa2cd117asm11071445oab.13.2023.03.28.10.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:39:44 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/6] mergetools: vimdiff: check for empty fields
Date:   Tue, 28 Mar 2023 11:39:32 -0600
Message-Id: <20230328173932.3614601-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
In-Reply-To: <20230328173932.3614601-1-felipe.contreras@gmail.com>
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In zsh 'foo#bar#' produces an empty field at the end.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 06937acbf5..27d1644faf 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -87,7 +87,7 @@ gen_cmd_aux () {
 	IFS=#
 	for c in $(echo "$LAYOUT" | sed 's:.:&#:g')
 	do
-		if test "$c" = " "
+		if test "$c" = " " || test -z "$c"
 		then
 			continue
 		fi
@@ -155,7 +155,7 @@ gen_cmd_aux () {
 	do
 		i=$(( i + 1 ))
 
-		if test "$c" = " "
+		if test "$c" = " " || test -z "$c"
 		then
 			continue
 		fi
-- 
2.39.2.13.g1fb56cf030

