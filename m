Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EBCC43219
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbiKHSSw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbiKHSSP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:18:15 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A4E5986B
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:18:05 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id f27so40819705eje.1
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqDGbIBYaYIzrxzpvhPtJvmjhEVfdDHo4mC3QOIIrKE=;
        b=cQZ2RwQCsPSd64IFMZPS3isl/XRFCEmRxkUzrCfFjHFAKFn2qofmWNZ/vciUsTgSD2
         fmgWZNQUZx9msvMjutiHFjCaTu3uMoyHKDPg73Ldtnhk8dEUGv9aQ3/Mo04CnBK7G5Gg
         SBIIzezOPbK2vhdMRlotboQ5/ZIyy/ATMALPL5lIVQNgaSjlBmQkxRopr/v9SrNq/jiT
         ATSmVF6bFu6P7PaGU3rPQRhseHBV+dBZeN++41pBpVxZx/+qVNo7LIOT5XaR0OG86/65
         ETLRQFe202uctbCR9S5ltdva23lorajQkvBzQP7YGxRnAQAeBHsx0opIy5imVTpXE/JR
         bjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqDGbIBYaYIzrxzpvhPtJvmjhEVfdDHo4mC3QOIIrKE=;
        b=S5j2l/uF7lfgIvpoVo05RAtEIC4unq/nPqKtFv4UwrqixO4Fij3meeErCUtJ4AW/Qi
         fvMV0kZng4dbCkEuw6PXnl0Gcp2UHvMPBTQAEgHayZ6KN48nBsiatEk+wMSLlJst0SzA
         PMVfSppdWqFLXZPMz5p216Bk70FQQXIGWA/NFreervQILY4+oKjd7WkDroKg0yzPihpD
         1tjXcNh5fZKdC99M+tLrCEJxICJWSevRvroVhdIyG6u92439C4GXU99L0/LGzbPqCEYR
         aJDHL020x8Qp3sRu/faetWavzVuzWueey1fh34buc585m6STmR3bYSdaOaq4CJkjf44y
         Oe2w==
X-Gm-Message-State: ACrzQf3fDQz++LUcxmVUVxrYh1G5FRSCJPHw8AZFaX5nyiF+fVUWl/Kl
        DjGYbNS90raU+mWhA/zBFEFjKff8j7sqpA==
X-Google-Smtp-Source: AA0mqf6Ozr0xMBDrjqO3htJxz9/XCaFZXZb0Fh0PRGwARglsR4iaOANp0z8jhzgQ1uKkYLRvWeqHKA==
X-Received: by 2002:a17:906:a157:b0:7ae:5d04:c96 with SMTP id bu23-20020a170906a15700b007ae5d040c96mr14284021ejb.564.1667931484801;
        Tue, 08 Nov 2022 10:18:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709063e5200b007a62215eb4esm4994131eji.16.2022.11.08.10.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:18:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/15] cherry-pick: free "struct replay_opts" members
Date:   Tue,  8 Nov 2022 19:17:49 +0100
Message-Id: <patch-v2-13.15-10a477c7730-20221108T172650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call the release_revisions() function added in
1878b5edc03 (revision.[ch]: provide and start using a
release_revisions(), 2022-04-13) in cmd_cherry_pick(), as well as
freeing the xmalloc()'d "revs" member itself.

This is the same change as the one made for cmd_revert() a few lines
above it in fd74ac95ac3 (revert: free "struct replay_opts" members,
2022-07-01).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/revert.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index ee32c714a76..0f81c8a795a 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -261,6 +261,9 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	opts.action = REPLAY_PICK;
 	sequencer_init_config(&opts);
 	res = run_sequencer(argc, argv, &opts);
+	if (opts.revs)
+		release_revisions(opts.revs);
+	free(opts.revs);
 	if (res < 0)
 		die(_("cherry-pick failed"));
 	return res;
-- 
2.38.0.1467.g709fbdff1a9

