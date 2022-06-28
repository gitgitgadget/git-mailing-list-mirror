Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B35C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344677AbiF1KG3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344682AbiF1KGO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:06:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC692E9E1
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:12 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d17so11269139wrc.10
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dYGXVYml6v5OQb5wpdTIvOmJ9DEIlen3XzcVVCfN/CE=;
        b=MrsxWPx/KTzcPPQtoZzkTzoPvEGWuc0pM2OtgiCx+GDWYJe5cjarMNE42U+oMdA9z1
         Pg8wZ80ueBfsNQigH00zS/Ue5iZxbBwLD8LTVBihxghNo7fXuIF9QYhIwByagP70kPYg
         nI0wQK1T2c2JQwAQo6kQAdNGFTYDPmEJe2WE9IIfGyLS8BcvU5xZC9hIxgUretTXHhGn
         SZF+szb1GeqVKr23gvDiC0pl4b3cwHLLojwrIOqYt0wXo1lbJWK1atD5Y+6+KdycRRW/
         QJpiCYOIZ3i9ZYR1QSeL0qlqnUgkDfGSEWPOYvJky5P9LlAYCAC3vD7GIVV+kRDTukyd
         kWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dYGXVYml6v5OQb5wpdTIvOmJ9DEIlen3XzcVVCfN/CE=;
        b=Vbyr6jwBiofWYo6ONTv3JtHTP/reUZKaZ3OoMRtw33fhKOoFBK0Y3i4uL98IyGq4B+
         Mm3FXHRh5Zzoa1pNC/RfneNqqQI2VA4y+JTRnKKJewYkE6CWtYf1fSFg4NJfz6/S8TrL
         986/ihdoN7STE6GODt/vkrmNvO3Ix7B7l50SZzQbKxSsRYAnU68rq2l7KKEBrFWEBPif
         zvrpZmF9EiC1N0EpLJHiD9YijifNpu7sIlYeivAh/m3I+M/wPMQdEwDVPThn5UxDbIdJ
         MqOShJZqzBmoCt7Mo5tDWRqzb+tAWm3RElVif/l+j0su4j78htoX2s7uPUI6QnXUafJy
         0r+A==
X-Gm-Message-State: AJIora9a3JMgRo0YPYY2kp+1ep0pj+hKhawO2mJADCc7mFRIVC/NH1/F
        bfeMIc6y/idSYvPWBVM7zP/7EMqZt5XDpA==
X-Google-Smtp-Source: AGRyM1s7OkwMYoCSpJn5Lq5HSjVX+kp97KzIO06NkyaOntevx8IJq+LYGO5OKL6ELS/dPaLwgFX7qw==
X-Received: by 2002:a5d:598e:0:b0:219:ea16:5a2a with SMTP id n14-20020a5d598e000000b00219ea165a2amr16436596wri.343.1656410771222;
        Tue, 28 Jun 2022 03:06:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b0021b91d1ddbfsm12914430wru.21.2022.06.28.03.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:06:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 03/12] git-submodule.sh: make the "$cached" variable a boolean
Date:   Tue, 28 Jun 2022 12:05:25 +0200
Message-Id: <patch-v4-03.12-e4750f190f8-20220628T095914Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
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
2.37.0.880.gf07d56b18ba

