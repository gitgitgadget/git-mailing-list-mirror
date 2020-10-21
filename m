Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A049EC4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394AC2237B
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoMtlAz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503605AbgJUSEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 14:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405153AbgJUSEj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 14:04:39 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AA3C0613CF
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 11:04:39 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 13so3065581wmf.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 11:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ai9JYqlJh47JBTVfqyQu0+EgkRZlNcwR2sfJrzvRFSQ=;
        b=XoMtlAz6ZSALkvIAw+r6lMP9FdX56gwb1pumwedjLv7IwlFwhz5Yx/JqcIQ31zUFFJ
         NibtU8Y6d4G7MlaHRjkLxppzRguMkMiGhZVgu+uGV5bGRRjDbPqIB3KWKIqdV2FJWeKO
         WkDaLzX1wnIcRAKIa8hoIR86jRgzyGDxMB4q/cMV7BI1ksGynMkT77uxp7x0KRiPTLUt
         PB3nsJifUgF2S58kIouul6k7IagsApxVDacEnSZvNdnYYAARR0ViC47CHp67ADtVFmIL
         1XI1/BX7QD7ZDyGrKYrCqPaGHYrabF/2svmlxJPd1M0iXLLqd7NBCkRabvFUvJ6yKVpD
         SRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ai9JYqlJh47JBTVfqyQu0+EgkRZlNcwR2sfJrzvRFSQ=;
        b=Tx9+NWMwZHMSXzPJ8iILOIvjriaAqx7g+ZNKMnydW6ibKoJGiCP/wwCVctNDpMS3Hg
         YQC9l7MdpsdWoTvr4CeYpIGWwxX6WSoaexpEpsBaIQEPTm5MB+EQ4GitjLJfVdvJmT+j
         dA99PwIgSUKSKnuMOV+ZmnZaONeu4zneiIU3f0CQLC8aZ7e3pfGHdvDzitLKvazgxcDv
         IUVXjNDfUUrqtek00ByuZK/7uRY2gGzTemM8cSjxwEBE8yIFxz/CoK1ZMkmZh/nuDEaH
         bZFIbFxcuIhUJrr7rL9gU9qvaofo6Q1g6Oxc2Rlfd42ZUX/jjhnub3MDYOPGNRff1Lc6
         RcZQ==
X-Gm-Message-State: AOAM532oV7vZUFj1OXUPkfzqGE7SoW6zzcDPIpzDJNwF9iWIJ1h6gihe
        aDW+97EcobXeoRVd779pxhspo8ML/xQ=
X-Google-Smtp-Source: ABdhPJw6MlY4AmYXEZm/UT06Ng3lkPEIGk8PmL9ZlMWj+jQWZslez7nyrXEe6OvRvFt+sHN7QYLZfw==
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr4926421wms.77.1603303478061;
        Wed, 21 Oct 2020 11:04:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm5221104wro.3.2020.10.21.11.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 11:04:37 -0700 (PDT)
Message-Id: <598521091a54caa73556b8bc9caf552d3216ba63.1603303474.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.767.git.1603303474.gitgitgadget@gmail.com>
References: <pull.767.git.1603303474.gitgitgadget@gmail.com>
From:   "Alex Vandiver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Oct 2020 18:04:34 +0000
Subject: [PATCH 2/2] fsmonitor: make output of test-dump-fsmonitor more
 concise
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Vandiver <alexmv@dropbox.com>

After displaying one very long line, summarize the contents of that
line.  The tests do not currently rely on any content except the first
line ("no fsmonitor" / "fsmonitor last update").

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/helper/test-dump-fsmonitor.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index 975f0ac890..a42e402bf8 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -4,7 +4,7 @@
 int cmd__dump_fsmonitor(int ac, const char **av)
 {
 	struct index_state *istate = the_repository->index;
-	int i;
+	int i, valid = 0;
 
 	setup_git_directory();
 	if (do_read_index(istate, the_repository->index_file, 0) < 0)
@@ -15,8 +15,18 @@ int cmd__dump_fsmonitor(int ac, const char **av)
 	}
 	printf("fsmonitor last update %s\n", istate->fsmonitor_last_update);
 
-	for (i = 0; i < istate->cache_nr; i++)
+	for (i = 0; i < istate->cache_nr; i++) {
 		printf((istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) ? "+" : "-");
+		if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID)
+			valid++;
+	}
+
+	printf("\n  valid:   %d\n", valid);
+	printf("  invalid: %d\n", istate->cache_nr - valid);
+
+	for (i = 0; i < istate->cache_nr; i++)
+		if (!(istate->cache[i]->ce_flags & CE_FSMONITOR_VALID))
+			printf("   - %s\n", istate->cache[i]->name);
 
 	return 0;
 }
-- 
gitgitgadget
