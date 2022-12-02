Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E180AC4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiLBLxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiLBLx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:53:27 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44647D0385
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:53:06 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id td2so11003057ejc.5
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSL4YVkBl9v4YL3WkETOQZTaX4loOZ85oAtX2cPjg/U=;
        b=WpH6f3Fq1gYXFt12osznhhIBMi6KOVApLF+/Max5UQ5W5TOvR+sGiFBhWdAQjMEdQU
         ravyBT45HhED3hBO8cw5E0oThB0LwlAbFCE51yYTr4QxUKJnBGuJEG+GwoPyNGxz5DCT
         XKXEg1qgwvZMsFq6voVtz6Q8bVRMG1RdQERcBRnlUwB4aXETev/0ZIs/0NPPJTdBVfG5
         W6IF3MQnWHDBfvjJoT4kkDjW1ZMOJINXrDSWCKdWq2FWYdOnBYy5SaIa1OxFUJ+9Hr2a
         nPO364PcjKcPEPkURxjTg4BA5CXIsVkrdzgY8RZH2dYQ9QaMNhy/nsX8qplBEdqsOX19
         64Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSL4YVkBl9v4YL3WkETOQZTaX4loOZ85oAtX2cPjg/U=;
        b=TVkm9NiqvY9cmynrEYmr97bD19Hj/X2H8Up4wvZINNyUuNqQTutFsh5zVBlgrw05BZ
         nfbsyrXrOjjN+LyjaPVG7EV9xMpxjGrBm2REo3aK1uLckhYmYdbMVCPWrrsIMjkAXv01
         h6CiJyFv0VlTwJqipUev5lHewza1Cao+2d4mZ9lcCLtMpN0ybux0fZjmxLakW+HAOxl/
         NPn/ueKFUUtKcNTQhVnXLfzz/Soj56yF851Is1pY51MW/ZmEcJ0G8eS3w1Lr1dtaAcM7
         Wm6nwt2kn9pSBI7bsi24vJSLtEnbhg88YD+fLfOPdGp+k6KWqw+DpT0qZI8EMFm0eEFD
         XeTw==
X-Gm-Message-State: ANoB5pl64KhLUR6R6a8HnN/CCjkLcTNYT9z81wg0LxrTISFEJaU/Eht0
        llwpJn8ZaPWxBKfRk/xsaolVf9saJxI1gw==
X-Google-Smtp-Source: AA0mqf7wj4fIXRGhncD3yZWCBM2181WZdUesfjAfi2nSN6W8O2T27UEex2wV5HZLcQR6nuQyS10fZg==
X-Received: by 2002:a17:907:8c8e:b0:78d:4167:cf08 with SMTP id td14-20020a1709078c8e00b0078d4167cf08mr11757687ejc.337.1669981985014;
        Fri, 02 Dec 2022 03:53:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q20-20020aa7da94000000b00458947539desm2833754eds.78.2022.12.02.03.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:53:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/8] merge tests: don't ignore "rev-parse" exit code in helper
Date:   Fri,  2 Dec 2022 12:52:34 +0100
Message-Id: <patch-v3-1.8-64dfec31fb3-20221202T114733Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the verify_mergeheads() helper the check the exit code of "git
rev-parse".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7600-merge.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 7c3f6ed9943..060e145957f 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -105,7 +105,7 @@ verify_mergeheads () {
 	test_write_lines "$@" >mergehead.expected &&
 	while read sha1 rest
 	do
-		git rev-parse $sha1
+		git rev-parse $sha1 || return 1
 	done <.git/MERGE_HEAD >mergehead.actual &&
 	test_cmp mergehead.expected mergehead.actual
 }
-- 
2.39.0.rc1.981.gf846af54b4b

