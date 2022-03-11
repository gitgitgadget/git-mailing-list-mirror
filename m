Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429D4C433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 16:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350308AbiCKQ0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350279AbiCKQZr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 11:25:47 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C40D1107E5
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:42 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so5644114wmb.3
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0rwuJYKjMRjBT//Nq0sHtSMGuOB17HSSTa64Jbm01n4=;
        b=qQ3q1Ts98138/zGVV0KgXB9U8lG2/OAqhj1VHjPVWDVrYHbLsEit1+SD651H7tlxt0
         ROz30N5zYPNZA7qlbrfghnkqBs+9kAmam3Pai7426tA+KRBgIFMh9VSrD1a9gOY/ZJ+j
         MU6PFyS3BP3Teph9Psp+QK1BvcgpNs6aSvzs8zi9zOeOa/iV7WULBpbcEuxSk8tiMenP
         L+/hexVxaGQuypcE6GIlzSVOd013rfXEKhO+7kj+7AJRwDqV+grUSchbccKxniLEqM8l
         Sa53heiMa9XTNCWcRYuvbHQjgogzJTAsANRFmZs+i3ZdbpFtZeEYbvgP8AeT0+48W1da
         R8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0rwuJYKjMRjBT//Nq0sHtSMGuOB17HSSTa64Jbm01n4=;
        b=UVc/zKAm0iQ47zEy1/80xj2KIUOW5iPGGebUpBWqftWdA8kMc+aLnc4VSx28mxeWCX
         eu0jvrqcq9OEYkwZM0W3QPOcjGJrUOcITeI71A9l1i7NgiV9IxmWv5jGgRDprFOPrCGV
         qt6HulK7FyBKMmShMNUQzdI3Huc4aZjj0n4muBcbhidNKmeqjex1nJwm7gm/cJqkvBOS
         PQjXSViyfQ6vH+xFZdXX4ckvv/VPDYf4Y3qyvdbJC6klClhwk8lcSmlw/dovAXLp+3ds
         meJ1ycT+1NNvwnW/51stclINrR4+RC7QJysOb7mPwebtAKllOA4tNeqgVERUKtzfmvZ/
         FLlA==
X-Gm-Message-State: AOAM533RDoMpM0Vo1ychR7xpQnLkm+GJnYWTjPM9tat7vVyBvosYR8dW
        yJmae8fIslECVx/XpNQtYBDaa02X9vX4ig==
X-Google-Smtp-Source: ABdhPJxCS4mgWo9jjgZxyd9mkcjYBVHFE0IrSlzKLr4sFRhGmKZ4Gtu+Yc9citXDGcYmzLKa9RdEIQ==
X-Received: by 2002:a7b:c055:0:b0:37b:dc5f:7f48 with SMTP id u21-20020a7bc055000000b0037bdc5f7f48mr8246220wmc.110.1647015880730;
        Fri, 11 Mar 2022 08:24:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm7318667wmb.22.2022.03.11.08.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:24:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 10/13] fetch-pack: move --keep=* option filling to a function
Date:   Fri, 11 Mar 2022 17:24:22 +0100
Message-Id: <RFC-patch-v2-10.13-31a22eb3bd4-20220311T155841Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1337.g7e32d794afe
In-Reply-To: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com> <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the populating of the --keep=* option argument to "index-pack" to
a static function, a subsequent commit will make use of it in another
function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fetch-pack.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index a0558f70b0c..0010867e5f5 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -842,6 +842,16 @@ static void parse_gitmodules_oids(int fd, struct oidset *gitmodules_oids)
 	} while (1);
 }
 
+static void add_index_pack_keep_option(struct strvec *args)
+{
+	char hostname[HOST_NAME_MAX + 1];
+
+	if (xgethostname(hostname, sizeof(hostname)))
+		xsnprintf(hostname, sizeof(hostname), "localhost");
+	strvec_pushf(args, "--keep=fetch-pack %"PRIuMAX " on %s",
+		     (uintmax_t)getpid(), hostname);
+}
+
 /*
  * If packfile URIs were provided, pass a non-NULL pointer to index_pack_args.
  * The strings to pass as the --index-pack-arg arguments to http-fetch will be
@@ -911,14 +921,8 @@ static int get_pack(struct fetch_pack_args *args,
 			strvec_push(&cmd.args, "-v");
 		if (args->use_thin_pack)
 			strvec_push(&cmd.args, "--fix-thin");
-		if ((do_keep || index_pack_args) && (args->lock_pack || unpack_limit)) {
-			char hostname[HOST_NAME_MAX + 1];
-			if (xgethostname(hostname, sizeof(hostname)))
-				xsnprintf(hostname, sizeof(hostname), "localhost");
-			strvec_pushf(&cmd.args,
-				     "--keep=fetch-pack %"PRIuMAX " on %s",
-				     (uintmax_t)getpid(), hostname);
-		}
+		if ((do_keep || index_pack_args) && (args->lock_pack || unpack_limit))
+			add_index_pack_keep_option(&cmd.args);
 		if (!index_pack_args && args->check_self_contained_and_connected)
 			strvec_push(&cmd.args, "--check-self-contained-and-connected");
 		else
-- 
2.35.1.1337.g7e32d794afe

