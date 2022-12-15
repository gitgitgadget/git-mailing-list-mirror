Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB93C00145
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 08:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLOIww (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 03:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiLOIwn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 03:52:43 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727D628702
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:33 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w15so2281922wrl.9
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdKcGYb1p/lHbC49gl1ooptz03QHJzw2wNvRj4cQdRo=;
        b=gfm7sHIh6LdVVddRySgFQn3x/oJInPrASp4JkniiiSD2Yt2cL7Io71H/mKulVw4elj
         vjJ++sCzaclEktfGa1j1N9XfC1l2gO/DLB2uiUpnuzMQDHAwhIVjXlJzVdZqihZzQcAZ
         y/VUGxNkBZELtvY6BVP6vLFwG1b/i5fuzGC82Y61lcBKDNTpU0pLGHlKwc4zUBjVR3DK
         f832Pjk5ynLyfZrPjdXFpH2eb8lUbjk47NU8QFoi7Qq1mFloPpMbcsFZ77FRLMp6BcLN
         NGxPD2L/XzLNfG249d3rAiYetpFlSsWHD2N0/XexPe0UVKABm3MwsPbwOeOyW9/v5z4z
         YMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdKcGYb1p/lHbC49gl1ooptz03QHJzw2wNvRj4cQdRo=;
        b=IOVk4bi4lKpedVszXMTnOPqoKd3HF+Khh3YzKHp/JiStWamlaPmRETWHLYYLYHo6JZ
         aS+QjlYndYPN52c8kCrSf+0Sex4QE5AuvAiHJ1Y7xnu/qeqttClNIhZdDkDYWVQHxHKz
         YqD7DtzpZvM/2z3tKMiecKdGL0pL6oTAUJvL2/Mci+y/uTDx8Cms2A1xkHAANfX2mW0u
         dKEN6zhj2UkcVoii6f3Gr9gs1m9vKSRL5kY/6x+FOsmxcDsUXW3TVNzKWtr8wLjfy58/
         elIRMLzHfJ6uE6GYCafB7EfGgP2dpH1siUw7kbGzd4YsvbHf/NdoXB8K3kDCekmxuuEa
         Nirw==
X-Gm-Message-State: ANoB5pkbhxjKX+WNPSgxNpduYtR8iz47YUUuos6eU2nofzrT3lJOkn4M
        xhIt18RIlepWHVicIYWCE6uoSL60OxDOyw==
X-Google-Smtp-Source: AA0mqf7a3OMbVyOnbw/dyxfmsuYctDM6xNW1BoHgUP3atC1NsqDIjjnhl6Ns5p7oisSuoAFlQp616w==
X-Received: by 2002:adf:ebce:0:b0:234:f41a:b50b with SMTP id v14-20020adfebce000000b00234f41ab50bmr20030922wrn.38.1671094351554;
        Thu, 15 Dec 2022 00:52:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r10-20020a0560001b8a00b0024274a5db0asm5464905wru.2.2022.12.15.00.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:52:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 07/12] merge-index i18n: mark die() messages for translation
Date:   Thu, 15 Dec 2022 09:52:11 +0100
Message-Id: <patch-v10-07.12-de4d11798db-20221215T084803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
References: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com> <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark the die() messages for translation with _(). We don't rely on the
specifics of these messages as plumbing, so they can be safely
translated.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-index.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 2dc789fb787..4d91e7ea122 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -16,7 +16,7 @@ static int merge_entry(int pos, const char *path)
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
 	if (pos >= the_index.cache_nr)
-		die("'%s' is not in the cache", path);
+		die(_("'%s' is not in the cache"), path);
 	found = 0;
 	do {
 		const struct cache_entry *ce = the_index.cache[pos];
@@ -31,7 +31,7 @@ static int merge_entry(int pos, const char *path)
 		arguments[stage + 4] = ownbuf[stage];
 	} while (++pos < the_index.cache_nr);
 	if (!found)
-		die("'%s' is not in the cache", path);
+		die(_("'%s' is not in the cache"), path);
 
 	strvec_pushv(&cmd.args, arguments);
 	if (run_command(&cmd)) {
@@ -39,7 +39,7 @@ static int merge_entry(int pos, const char *path)
 			err++;
 		else {
 			if (!quiet)
-				die("merge program failed");
+				die(_("merge program failed"));
 			exit(1);
 		}
 	}
@@ -130,6 +130,6 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 			merge_one_path(argv[i]);
 
 	if (err && !quiet)
-		die("merge program failed");
+		die(_("merge program failed"));
 	return err;
 }
-- 
2.39.0.rc2.1048.g0e5493b8d5b

