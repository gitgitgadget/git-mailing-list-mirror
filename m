Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE302C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiHUN7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiHUN7K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:59:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA36323177
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e20so9799001wri.13
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=O1E0SVvoKCx8EjxdtzxxzB896hN9DbOouwuakVukSxo=;
        b=nv0bEY9O4+1a0d5b7FcDXDEU30LFU6Jb6VNpUcJVBMvKaK6wX8J5MMWX4JW0MeP0Bo
         KJeOjh8WTYpT0MAfU7T/UAnaNukBkXHufDw7xDm4CbHeWL3+1l/KRlRwfCZN5HhLOGXM
         /1LV4A6alNUgasE/4129p1ghhFZJPH8nZByCm1ksVgslpI4ZnuJlT/p4vNrjxFiFh3Zb
         0dvcuZS1sc8fzAZeIXX8p6vuwf9tOSgzPlbxWVi30X99Us2a4sDebw7l7yYvxLlqdb2x
         URzAr9FjQ4Vhr4T8qrfmJQ7cStdi/9Mx1WtRu6d85yc2u9sIbXyDy7Dkf5VJYwsienFn
         ju8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=O1E0SVvoKCx8EjxdtzxxzB896hN9DbOouwuakVukSxo=;
        b=kz9yI7EzzEC6rCxbehHxcEbK5wi2DpB3fIn0yZhVC+kz6U0N/oAmksmZzbSNGHSYVR
         8JlKPv/w8ijzD95Yj7IcRqdjtWqa20vijqUdC7orTaQ+L+xa+JOvEQBBLd1xQCOvaFg/
         kbIOZTQgnvBTEsE/grF2BWo3l4iO5VHRk9p/VBXMEvUAUN+QiBrd9Pagu4/v/OyrRO79
         Nlg25+fxqpAYXaNzaC1e4jpHrrn/mQyOR3UdsVHuXEMIf5eZA7FH5qhCpnIP8fjIJeov
         Qy3wLciJ8VJZbIPGU3oPAt3IuTC33FeWZI1atV+ePsq8kEd++AqQI+e4mDyakRYngjeX
         SdOg==
X-Gm-Message-State: ACgBeo1DqwCNuuJIhcD+ifruu9IxAzEL3XLpVg4CYwhzxDNJXjPwKLOi
        /HNbAoP9Sqyv0DwhfE1l5lmOLwxUkvqhiJv8
X-Google-Smtp-Source: AA6agR4kI7E+Dvxx+uDpD4C5s1QbGeI5OP626wK/Lg4ZzQKDJIVaQWTG5q8L8rbS9Unr/arzdGmsdw==
X-Received: by 2002:a5d:5581:0:b0:20f:fc51:7754 with SMTP id i1-20020a5d5581000000b0020ffc517754mr9008799wrv.413.1661090326070;
        Sun, 21 Aug 2022 06:58:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 20/32] submodule--helper: add missing braces to "else" arm
Date:   Sun, 21 Aug 2022 15:57:29 +0200
Message-Id: <patch-v3-20.32-55e3ea5f9dd-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing braces to an "else" arm in init_submodule(), this
stylistic change makes this code conform to the CodingGuidelines, and
makes a subsequent commit smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 61468237af2..ebd3e118eb7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -480,8 +480,9 @@ static void init_submodule(const char *path, const char *prefix,
 			fprintf(stderr, _("warning: command update mode suggested for submodule '%s'\n"),
 				sub->name);
 			upd = xstrdup("none");
-		} else
+		} else {
 			upd = xstrdup(submodule_strategy_to_string(&sub->update_strategy));
+		}
 
 		if (git_config_set_gently(sb.buf, upd))
 			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
-- 
2.37.2.1279.g64dec4e13cf

