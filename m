Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D086CECAAD5
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiHaXTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiHaXSi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B064C636
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k9so20176325wri.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GomI5uZ4aQ1wFZgZhCpM5/jtzhNLGeIGmNPH4JilbnY=;
        b=MskdPHP+N8fDvYw/22J+mXOhvHHnMTvdbC9WSwmJCvqKvHcjfBDwzdnpAB55UaJs1Z
         qmYomOF+bBiU3sbl/YK5QlUC/Ur7DibPcrx/5rbVE2Nt0WVE2b/EC/9bwo56sg5WcYJx
         cpo/VVCvkc1UJfLKa6oLcARjXw46kAA6JL0NOavoEk2XIkMQ87k2006u1jPgPCdww8HD
         ZZsG1pHmjHkqlIUBO8cQej1s9C/xhsC/vf7EJ/MQ1kx22J0F3vaqXc3XyZ3is8DfNqN4
         P4Rm0vE1JPLoIGP2UnhxzYXNZxjfS3CMYo+pgwPmTF7Axhf7tt3IsV0YIrqyc6SDp8eH
         QTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GomI5uZ4aQ1wFZgZhCpM5/jtzhNLGeIGmNPH4JilbnY=;
        b=iSOqoI++0lDXyJwi6YKERekXoyPPM1XJ3Z88x3lYiTgemtl10ooPN1qsbuwtcQcCCQ
         hSRi1YKxzKVknEAFY/rnJ9z/uSdqXQFqdSzAzFVIHtzjqBHSJVIQT6lEgWDjxyjf8jfk
         RRyyOq9DKwCpR2ZBl8dnepXdFkdjVkWVHhXX2CwgdxbyxOJlTzS/ZMRvSgyA7lGcmdIv
         YTfvK1IGU0EGVxKRWwYRqnYFO13zAUwRMAggFBoVZIVnrbtzEtd8ABHxktn7RDQPDg4p
         spyeH0/9c0IRuPeSb21mRjLGqh/bVZCj3al6QYouqwfTkJKINFsHVbbBT2Y6L3iWSi5t
         LQzA==
X-Gm-Message-State: ACgBeo0r0KpHfJPhplZYsu9pEchcuOvx25c/ZNttmC4olB41d7KCm5Rj
        1wjlYTjXYrLzgGjlaaxY+Pd/GtFwMmaUWg==
X-Google-Smtp-Source: AA6agR670VbbqkHFCe7Ywwqu9T0wKxswUcKvPteepU9JYTRY8/gSp7C+aKjUj31fJM6mlnpU3k+K8A==
X-Received: by 2002:a05:6000:178c:b0:223:141:8a14 with SMTP id e12-20020a056000178c00b0022301418a14mr13228835wrg.629.1661987917094;
        Wed, 31 Aug 2022 16:18:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 21/33] submodule--helper: add missing braces to "else" arm
Date:   Thu,  1 Sep 2022 01:18:03 +0200
Message-Id: <patch-v4-21.33-9edd68f9c5a-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
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
index 59c3a9afe6e..6c40be3170f 100644
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
2.37.3.1420.g76f8a3d556c

