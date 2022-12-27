Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A32C4708D
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 18:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiL0Sjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 13:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiL0SjR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 13:39:17 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED965CE3B
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 10:39:16 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso3394122wms.5
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 10:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXAdX75nhYi01ydMIGjT0Co0Noc04mSCq+VVSdNlflA=;
        b=UkrXVb8qUGv+YnCD7BiWhmJ0MW+SFp/fSnHNJfqXU29kDEleann8kFwnSjR3BMjHCT
         odMF5xpSn8ab7rUsx1szgSsjayX5HhoyBKIHFDuczCW2ApF+g/j9ba0588HU1rW2aCfu
         WnBwUJYriTaLhy7bo95cFUBk1N/kFhYW/8dB6+jxovSVW2X4Aq3jlv26vUVA9u+/CBsw
         MSZajQRvUuqgdK62jX/8wO7Ppse1ZOhOq1/hzNQrGEK2dUTTozAWZie6F9rF7JPgo00q
         5A+pp/oBUip5ruLKIiDbW/TS0M29c7bhRBoansRyXlANrvG5MF7JC4E3qYIv7gxtj2I8
         B2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXAdX75nhYi01ydMIGjT0Co0Noc04mSCq+VVSdNlflA=;
        b=HQ9pJf0TQ6BK2a5vFPPPMJCjsuoRwm9grsJs5bFkjJICSygmaCR+LDkzo5IIF9tlNb
         /IJ5gowQ01Hy80q+/A4Gojvuga/q/fHtFzvAjWXslXRW+uq91V+EwrUmcIr0IIT8ec10
         cNq8g01sS/3y88yEivNVkwybBBGExSBylsFX+S2/ado19GCiMpqo8OcmNhCYsE1gSXtk
         XNhlMatrJgP05OyjIFHEQM5RBSSVs3gKReLftfjOs2aEWYL9PkKhpH+DYFUVLxTi0gmY
         IY+AFBBzers0QDoGQUzCvnCwE2IE3ZP5F5lC+DcKIpkhq407asR+dkeblLjDtlIVVLNR
         Jfjw==
X-Gm-Message-State: AFqh2kph+u2hnwVgRzXf82nDz/thsFWhW8aWBkVOyO9UzeDMwGXVRlGS
        5fjy65ToqU8SBfPNmqSqQAFjAQbm+fs=
X-Google-Smtp-Source: AMrXdXtoK0t5t3cAZFA1nLZS2yqYE3ntgKVofl0ORo90g6xVxCNuW4kZxnJtFL9Llw69UdZolF7TmA==
X-Received: by 2002:a05:600c:1f12:b0:3cf:8155:2adc with SMTP id bd18-20020a05600c1f1200b003cf81552adcmr16298628wmb.33.1672166355223;
        Tue, 27 Dec 2022 10:39:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q2-20020a1cf302000000b003d1cc0464a2sm18118770wmq.8.2022.12.27.10.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 10:39:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Hubert Jasudowicz <hubertj@stmcyber.pl>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] bundle <cmd>: have usage_msg_opt() note the missing "<file>"
Date:   Tue, 27 Dec 2022 19:39:10 +0100
Message-Id: <patch-2.2-00f74250fd0-20221227T183708Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1106.gf45ba805d1a
In-Reply-To: <cover-0.2-00000000000-20221227T183708Z-avarab@gmail.com>
References: <xmqq5ydzpwtk.fsf@gitster.g> <cover-0.2-00000000000-20221227T183708Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the usage we emit on e.g. "git bundle create" to note why
we're showing the usage, it's because the "<file>" argument is
missing.

We know that'll be the case for all parse_options_cmd_bundle() users,
as they're passing the "char **bundle_file" parameter, which as the
context shows we're expected to populate.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 3d1ad220ff8..acceef62001 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -58,7 +58,7 @@ static int parse_options_cmd_bundle(int argc,
 	argc = parse_options(argc, argv, NULL, options, usagestr,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	if (!argc)
-		usage_with_options(usagestr, options);
+		usage_msg_opt(_("need a <file> argument"), usagestr, options);
 	*bundle_file = prefix_filename(prefix, argv[0]);
 	return argc;
 }
-- 
2.39.0.1106.gf45ba805d1a

