Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CE2C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiI3SKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiI3SJM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:09:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B25E1E556A
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:08 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so5489419wml.5
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+FTXlLn9s3at+3RoRiqeNSlFyKNswATPdO5x26i1aVU=;
        b=CKPK+ysMtPIYWfrm/DccFx468u5Cd0KxWFcnG9LFqiyCoNhUWakjkhGQBMZgmDLUO/
         fOBXmqCgcqAKuUW+/FGrzREmO8xSnc2zRdCqtGcnP8XFqWqoeUhT36G58VR8dGmNzcDA
         6v/OgUwM+d+54cTaAuml6ztM8pECRF3rNPXJDkPPy7kxJZ1X/MdXf18YGg3trBY2C45p
         3LjmMkDlgwfnNbcCl7ruNQuKP6K1LeH8Vhnd1ZWMsbpIR9KJdnEprqY7gE7xKPQuXoMK
         ju9ktGccPabtIiUy80nKFVEa9XajbHsMQy3KZPLJf+CLNFF78sigFrXcsl9GywdJK6UD
         Ihdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+FTXlLn9s3at+3RoRiqeNSlFyKNswATPdO5x26i1aVU=;
        b=26iXIbhPdJDPfLP8yoAGlWAtxcJE3W3a/We/cSN8avVw7Vq0R28O7Ehaq3CgAnLZSG
         /j6MZ8W9YStP+CszNTBlQRahGCjD7Zh8SW5e536L+DosW16Uk/R9ErTdXPB9o11XFyhi
         o/kEl6lujvrDd0r4tepFsqDahAgcyZPZDah8oQ3Ac+bNDOEj1/p8r+uDX1jk8C5FyNFx
         mGlg6CvoZ4BD30mr1PqhcIylu1FQx0JLBYNiSp0K5EmO/W/7rIehD1SNAo42vFuy9Mrh
         tqo0cqqjwKr/VFtdsBUVLtJDsHdvH7H1iGyxuRm0sNMXfNY7OUNGOvxxkikccNmLEDJf
         IzSA==
X-Gm-Message-State: ACrzQf2HCio72SUErvI4EHUEMOQq8fjT6GtYN/OwqJRIOGJ96QaUKSJe
        wqqFKiPASP4f7/kI4HRWoDJT4+yYI4OqNw==
X-Google-Smtp-Source: AMsMyM6AmzkrNp+RZmnbBYHoaFZvNQUIO0ZRdH2sxFKH+SlpZ0JV3i6VTvtNvfwa8RQ9IYfc6BPPpA==
X-Received: by 2002:a05:600c:2188:b0:3b4:9725:7941 with SMTP id e8-20020a05600c218800b003b497257941mr14675266wme.175.1664561346451;
        Fri, 30 Sep 2022 11:09:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:09:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 17/36] t/helper/test-proc-receive.c: use "<options>", not "<options>..."
Date:   Fri, 30 Sep 2022 20:07:40 +0200
Message-Id: <patch-v3-17.36-041aa64f3c7-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As in a preceding commit use "<options>", not "<options>...", in this
case there is no *.txt version, but let's fix this one too while we're
at it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-proc-receive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
index cc08506cf0b..a4b305f4947 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -6,7 +6,7 @@
 #include "test-tool.h"
 
 static const char *proc_receive_usage[] = {
-	"test-tool proc-receive [<options>...]",
+	"test-tool proc-receive [<options>]",
 	NULL
 };
 
-- 
2.38.0.rc2.935.g6b421ae1592

