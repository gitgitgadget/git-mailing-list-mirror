Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F26BC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiGAKnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbiGAKnL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:43:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744C1F09
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:43:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k7so2571637wrc.12
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DkDKh64MPIHoP8xiJUsr857ldZ0TDJhZi8caQQPrj9k=;
        b=QjMUx7bdCofWeZ8j08c6fiCRu+t3Izq171iOPzT/0EPys2fCRQCgzo8xQDkCaZs1S6
         Iws1WsemRcXBPaoOS561mK3fqQpIqDRVfkcg0lhlHVtpeg0OidBeFunMGPUzImrHoay5
         s7cAK8v1pKqnahgkJW8qSkQGvkFfIAMHIGR+U+C29sR1N/wSyR3Vwvk5HMnJWIue29Ln
         O6BufFT7Jc4BzpJLbGsS7O0tnzfIdkHRUIh3KgAjUqDq8WMhBhm2mb9ww7fbgd9MFRfE
         tX0s1B2ajMSpykXL4f9L/VTy9IM5QOIyfWG46m7DI4jr4E2QAFlAZKxiR/CcdIxOi8se
         Djhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DkDKh64MPIHoP8xiJUsr857ldZ0TDJhZi8caQQPrj9k=;
        b=2feXpytDA51MBU1r443vH1aEUVFnre0eMW5C4MCV7qm/k2tMEaav+dIg951l3HMyyc
         W1rYrpUBi3MCrY0xLsdyr5YKfFKyRRLyFv5axRU75ld0A60eLUyDPeU3RuptOu+MShIw
         lzkQECGtIX3pv8OF8t//gxmOcBbwTGu2fbCVKIUXqYdr8u/dPSQXV38aEWRaFJtRckCa
         ofNWRZLj+7QeBGJJpyQm59raQ9D88S95ysYijhMuj91ThnyoMOtCRKvYo7y3xVTTAU8y
         gWNhiZKqsNwzky94peAL1/VV5nREwOpvTUL1XRcMlqkTZFIWQXfb7fQHbYdxo5ImlpAx
         XJSw==
X-Gm-Message-State: AJIora8IX9KuHz1n/trqQ0EGbnMzFYwTE1ZFjjpDMpQykj8XRkLENNe/
        3khXuDdsqa9t7EFTIJzqskROrSaO3gkM0Q==
X-Google-Smtp-Source: AGRyM1v3MF4/7leC8N6ZOPyXGMNT4dspFMo9qIXSd82jxih1fVWiINxzFFEHwq7McosGanT9dOYtAg==
X-Received: by 2002:a5d:5234:0:b0:21b:829c:3058 with SMTP id i20-20020a5d5234000000b0021b829c3058mr12839590wra.13.1656672186780;
        Fri, 01 Jul 2022 03:43:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q63-20020a1c4342000000b003973c54bd69sm6257674wma.1.2022.07.01.03.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:43:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/11] revert: free "struct replay_opts" members
Date:   Fri,  1 Jul 2022 12:42:53 +0200
Message-Id: <patch-v2-04.11-6fc895676f4-20220701T104017Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call the release_revisions() function added in
1878b5edc03 (revision.[ch]: provide and start using a
release_revisions(), 2022-04-13) in cmd_revert(), as well as freeing
the xmalloc()'d "revs" member itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/revert.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index f84c253f4c6..2554f9099cc 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -246,6 +246,9 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("revert failed"));
+	if (opts.revs)
+		release_revisions(opts.revs);
+	free(opts.revs);
 	return res;
 }
 
-- 
2.37.0.900.g4d0de1cceb2

