Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5CDC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbiKHOLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiKHOLA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:11:00 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615066869A
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:10:55 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id kt23so38875704ejc.7
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 06:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtbehhi5CD+kChAgVeBUz+Crf3e73PpzRmxDlq2S0EE=;
        b=P3vY7gHVrw2tneP6IpGdLV95me7Yvb6+ydIcYnX+HkgpwBAiaxDebER8e9xOeT6Pxz
         1AhNifLzTemQJoUEtislXSLdV4xEw1w9KIye8yoYxo3RB5rcVKve5+//mIcgImhCaCVw
         Q9Zr+FPTcGDt7dNz+fLJaTnjjHC/Ey5Wu9LPFga1XqV+8OZlMCSmBgINCNweMJeUpiNI
         Wj8jnGdXw8igwj6n7BX5SilamE45D3mKAx9ufHaaKpSo/bFo6x4Jqebj4q57L9y8wfHd
         esHLO5Ii7dhojEqCegPDhDN/1TVhW9XqS/iBZDJ3I2kocODFRjhTRE6JZ83tfQsOmLRN
         Y9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtbehhi5CD+kChAgVeBUz+Crf3e73PpzRmxDlq2S0EE=;
        b=fy08VkyM/8KZXcOVgpTNCW+yC7s3XCD+9jBezB6kxSCgYPwVv9SZUnaSF42q394hjn
         L7bZ1zKIH26J5xn+VlF6O5VtYFGQitjUdOsWe/cP+FsJ/AdIr4qIkeBDpj2wOAEcbJ7M
         lMhiVOy4mNew/JQZqdm33BRqBX9TQDvGAHIKydCBA4x+pLU1qi3T4laeIwzn1xCTAb88
         GWkeUnq7gAASGbc+1BUN0kK4DsBmkjPe9lynVoeO6fF9KIHwmX4JICT76Nipwh4M156i
         KaDrhSmeZero5CJEXddHHqPrjmpVjXIdATJQN8KraXCnjBe1f5uc7KTA1Ff0ZcFGfH60
         gvjQ==
X-Gm-Message-State: ACrzQf2XdSM27Ou2+8FHg/am/8MW0krIoVX9sAuYw404ruUIm9qRVCJL
        fxmDtkdBBhShyPMHISs4cbK8ISIK7gMyvw==
X-Google-Smtp-Source: AMsMyM6h1sdqYaNbY/dC/khayh94HX4Rf5jfhqTjj629VqkLsfclS3+SSO6CxWrjUzpGab7yFaDkog==
X-Received: by 2002:a17:907:3188:b0:741:4bf7:ec1a with SMTP id xe8-20020a170907318800b007414bf7ec1amr54720561ejb.448.1667916653615;
        Tue, 08 Nov 2022 06:10:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a16-20020a170906369000b0078d9c2c8250sm4683666ejc.84.2022.11.08.06.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:10:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/9] submodule.c: refactor recursive block out of absorb function
Date:   Tue,  8 Nov 2022 15:10:36 +0100
Message-Id: <patch-v2-5.9-459ea25125b-20221108T140501Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A move and indentation-only change to move the
ABSORB_GITDIR_RECURSE_SUBMODULES case into its own function, which as
we'll see makes the subsequent commit changing this code much smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 submodule.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/submodule.c b/submodule.c
index b958162d286..fe1e3f03905 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2310,6 +2310,23 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	strbuf_release(&new_gitdir);
 }
 
+static void absorb_git_dir_into_superproject_recurse(const char *path)
+{
+
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	cp.dir = path;
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
+		     get_super_prefix_or_empty(), path);
+	strvec_pushl(&cp.args, "submodule--helper",
+		     "absorbgitdirs", NULL);
+	prepare_submodule_repo_env(&cp.env);
+	if (run_command(&cp))
+		die(_("could not recurse into submodule '%s'"), path);
+}
+
 /*
  * Migrate the git directory of the submodule given by path from
  * having its git directory within the working tree to the git dir nested
@@ -2366,21 +2383,10 @@ void absorb_git_dir_into_superproject(const char *path,
 	strbuf_release(&gitdir);
 
 	if (flags & ABSORB_GITDIR_RECURSE_SUBMODULES) {
-		struct child_process cp = CHILD_PROCESS_INIT;
-
 		if (flags & ~ABSORB_GITDIR_RECURSE_SUBMODULES)
 			BUG("we don't know how to pass the flags down?");
 
-		cp.dir = path;
-		cp.git_cmd = 1;
-		cp.no_stdin = 1;
-		strvec_pushf(&cp.args, "--super-prefix=%s%s/",
-			     get_super_prefix_or_empty(), path);
-		strvec_pushl(&cp.args, "submodule--helper",
-			     "absorbgitdirs", NULL);
-		prepare_submodule_repo_env(&cp.env);
-		if (run_command(&cp))
-			die(_("could not recurse into submodule '%s'"), path);
+		absorb_git_dir_into_superproject_recurse(path);
 	}
 }
 
-- 
2.38.0.1464.gea6794aacbc

