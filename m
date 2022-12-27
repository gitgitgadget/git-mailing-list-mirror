Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E641C4167B
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 18:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiL0Sjb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 13:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiL0SjR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 13:39:17 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283A9CE26
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 10:39:16 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id ja17so9872950wmb.3
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 10:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NF+BcclTQ2UR7a7ru0/UrLR+963s9/P0JtZ23CUvIYo=;
        b=B11MTscI9ppL0FugoCicWOQ1ydwqX1JxN9dJMBO1tffHhufh+jaHXFKS9P6tHYH8X2
         MUfXtR70H0szfEySxsMmtr5i+Ao3f7onGxdHjtoeZ+H+33BA1n6741P6Dnxh4sMtJnv4
         PmWSUSjdDbB+BJeKytUihq0i6fPfLP7mMKQz8IStZ1dDv5HU3eIia3BwJIJ+LVoijFXl
         I4m2uzQ5sEYiWASZCpBcdkDP9utY65aJ0c7IOsCmNgHVNsrJG9v+0RKoWDXz5Q12ZTkK
         yEsK5046RSN0JLYhtp82e4q6bPd32Vl1qWlEJLZfuqBRNRbnDNHwaKe5Vmx7rQQoZgzN
         pgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NF+BcclTQ2UR7a7ru0/UrLR+963s9/P0JtZ23CUvIYo=;
        b=cS7ryDw7NS4+J42RZhqk61HcOuc0tIUZvRg25G8Jo6mBp1hl287ogWVw0q8hYe0q5L
         Lw+Y4Xp3WE8xjwzc3/miIwuD3e0ATeDH87FENP/YwR0Antw4h505YUqPNbCXmG/56/RV
         fUqbQnuiQCyqkpUhDddZ99GUyOKBlCHiedjJ1GUbA3hT9qjrQEziPA7T3bpKSOpku1sF
         dk87zWDXTFW96rSXwPUS8xI7L0H6zzTImb+d0Rl0X4h1I3yT8Gwe4Mtc/mBlSoWjAJLl
         Xno3AOaezaqhjznRaCN/8uK58knNWASJKi09+qORd+Z5f5JFs8tWMRdGOK6E/4FLJl8+
         8vsQ==
X-Gm-Message-State: AFqh2krT2itKVoU0i0rzIOJNt6aqhhoTKJq5wxSu10DoFUPjJ2w7YSc/
        /5XelNZqxqoYlcVQW8oyQ4svJug88d8=
X-Google-Smtp-Source: AMrXdXuoNnlvTin957c37eTdhypruAGh0U3PTpmq/7hhlAv7YremDfLeBpzLfPTbPy7ZB8+HGc+XVA==
X-Received: by 2002:a05:600c:246:b0:3d3:3deb:d91f with SMTP id 6-20020a05600c024600b003d33debd91fmr16506391wmj.5.1672166354304;
        Tue, 27 Dec 2022 10:39:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q2-20020a1cf302000000b003d1cc0464a2sm18118770wmq.8.2022.12.27.10.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 10:39:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Hubert Jasudowicz <hubertj@stmcyber.pl>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] builtin/bundle.c: remove superfluous "newargc" variable
Date:   Tue, 27 Dec 2022 19:39:09 +0100
Message-Id: <patch-1.2-357cea183d6-20221227T183708Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1106.gf45ba805d1a
In-Reply-To: <cover-0.2-00000000000-20221227T183708Z-avarab@gmail.com>
References: <xmqq5ydzpwtk.fsf@gitster.g> <cover-0.2-00000000000-20221227T183708Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in 891cb09db6c (bundle: don't segfault on "git bundle
<subcmd>", 2022-12-20) the "newargc" in this function is redundant to
using our own "argc". Let's refactor the function to avoid needlessly
introducing another variable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 61c76284768..3d1ad220ff8 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -55,13 +55,12 @@ static int parse_options_cmd_bundle(int argc,
 		const char * const usagestr[],
 		const struct option options[],
 		char **bundle_file) {
-	int newargc;
-	newargc = parse_options(argc, argv, NULL, options, usagestr,
+	argc = parse_options(argc, argv, NULL, options, usagestr,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
-	if (!newargc)
+	if (!argc)
 		usage_with_options(usagestr, options);
 	*bundle_file = prefix_filename(prefix, argv[0]);
-	return newargc;
+	return argc;
 }
 
 static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
-- 
2.39.0.1106.gf45ba805d1a

