Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73FAC433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiI3SLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiI3SKW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:10:22 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6158B1EDF74
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m4so7992726wrr.5
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=O8Bu7r84EzE59hopkfLpjHA7BiJ5vGC0aro7TD2H9Jk=;
        b=ShFjdknrxSa1X/JLR1i0a8F050ruZwwe4wz2PRHg/kulwOKHQ/v4xD5PJmk5uOZ3fc
         s7287FFEharCrtyzuAVg+vOe4K/4QSO+CcbE8hODN36N8WincFpbTAOwTGNSAzaweiKG
         mP/G6zMU1lMPrHJrzgYlirk9ZeL82Kx8ADIdoQDlf7Dh/O+GWCaFgeizQ7wlAkBvFJGe
         VeQH+vvOUeHykvzCBbIFMFnBSBNb6aGh4E8UVjPcXNfoL2nbo/87MhjTaGMZ3Crst2qA
         2r9X9knbIBOkIy9Gkmcqkziqzi3u+ir/0TJVTENpb9qsNEyUb1pBRiqCRBDpqp/UyEfX
         3aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=O8Bu7r84EzE59hopkfLpjHA7BiJ5vGC0aro7TD2H9Jk=;
        b=pvXDuZyAKp99JuICQ+6DFzsZ+aqJTQH+MHUEJGTCa73iiW37QwRRpGQeVZAfpRdJae
         6XrObCRUunLruL80XqRg4ZQP6cPOZXfia32TSvKJrRKnCAoNAPT5DmN/cl8Ttp3ExNPY
         oHv9fEWy2jTHnqBhdayQ1XDE/IwOKyQ0iRajOVM1b/zQy5UZmGser7BRAK/lRI1MnVZj
         Ak1C+ZhVhS/5Ng391Zs9YYvj/cEqmB96CyTvDcZdApyuhchwRMrnObOyVYgHtT5GylD3
         EPCA6RQoqIB2q4G1opJegdJ6tkS+SucuW6QueMtIthuLq9IAd67qMKpf8cXLvVRTo+c4
         +o0A==
X-Gm-Message-State: ACrzQf3Zv/X1cuo5Xcm8I4kCDjf3cW0veOCPCCkbJo90H5rMNqdSvqgm
        jYMooj0qKzH0TvQvkp7jTxalvmw6uEVmBw==
X-Google-Smtp-Source: AMsMyM7VlpE4a65D0G461zQUsXvGMH80Z1U4jMHCozaxXYR6lbyTjLy6WC/2AVcRZ2hRDr3/bnxseQ==
X-Received: by 2002:a05:6000:68c:b0:22a:bde3:f8cc with SMTP id bo12-20020a056000068c00b0022abde3f8ccmr6460214wrb.556.1664561357794;
        Fri, 30 Sep 2022 11:09:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:09:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 20/36] doc txt & -h consistency: make output order consistent
Date:   Fri, 30 Sep 2022 20:07:43 +0200
Message-Id: <patch-v3-20.36-98bdd0353cf-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix cases where the SYNOPSIS and -h output was presented in a
different order.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index a11f8c6e4bb..6f3941f2a49 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -31,8 +31,8 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 static const char * const merge_base_usage[] = {
 	N_("git merge-base [-a | --all] <commit> <commit>..."),
 	N_("git merge-base [-a | --all] --octopus <commit>..."),
-	N_("git merge-base --independent <commit>..."),
 	N_("git merge-base --is-ancestor <commit> <commit>"),
+	N_("git merge-base --independent <commit>..."),
 	N_("git merge-base --fork-point <ref> [<commit>]"),
 	NULL
 };
-- 
2.38.0.rc2.935.g6b421ae1592

