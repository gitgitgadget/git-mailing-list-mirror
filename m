Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9636CC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiI3SKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiI3SJE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:09:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A475A1E92C4
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j7so2636742wrr.3
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ZQpLqys8ZsZyzmv6yq88Cz7pH20a05DNi1SDGH3G2RE=;
        b=NoFCcRv6FcpyvYrh2epWqFMUTFJah2ZUk+T3qLlWCq/7ugg1CvbClqL7bC2Ul0X5AH
         QKOuJZjEKbGsa55dj1G+i4eSTa/Vlr6G0i8Ju0XbG47sT6UsdiAnVrD69+r+EXuv+xdP
         ywBOdqeTMYrCcndFrVTXv1/f1U0OSAl2/HqjrtD4cv66IcP8PqNEHm5X8nrLO2lfEnvC
         Jlqpu2f9ai3t47+xyN7E9o6khjCTqxkrIj+nij86PAsl8PuasIoMbS3nhMDSALOdck2G
         N5sw/2GKF06WYaPE0MZDeEhdeCC0+C0dqAAz9QzwHm4L/bzKUS87c6xNw/J/WCVTkWPi
         iKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZQpLqys8ZsZyzmv6yq88Cz7pH20a05DNi1SDGH3G2RE=;
        b=uvVlExpedeAYSMaOe/1fESlN4LmQ7kQvKz6Ienj38b9FfnayBGUNur7d8C68FTdLGs
         sVcJSEN/9KGYXUZwp++038GmtDzjd6tVUvEIcKWK1pcz1Szn6XJNFYuwxyWMgUI9zXnx
         SlOm+asNRVkCagkUqnbPQ5anXvxH+MuZnJnlTJemtPPyDgqhm1gx1Rs34wTMJPo60Y07
         0YXXwPzepu9FQQnpptwOsoILIS4I7OTDrzF8cJ/X6FtzHx2ZR3hd+nHKxSM9k9VDNipe
         MnnL4x0/heyoeMncR7yxj2rNhmV0zUhpAwaDa7kbIimYmFo9s9NRoKawZZMLye2K6bax
         iGmg==
X-Gm-Message-State: ACrzQf349NNU0HihRDreCU/GN21saO6rqSc/L9hrzginG+Wxd/IpsZK7
        sdIx9FEqDSxqSvVPE7+9iq8fsWB+fQ6nTw==
X-Google-Smtp-Source: AMsMyM56J1s7GnukrVn+BnGk1FqAdf+JEGjZXtTU8fF5QReezxaRza/Rx82HVH47KA1MSzJY+vmQDQ==
X-Received: by 2002:a05:6000:168f:b0:22e:4c3:de09 with SMTP id y15-20020a056000168f00b0022e04c3de09mr1565064wrd.40.1664561342849;
        Fri, 30 Sep 2022 11:09:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:09:01 -0700 (PDT)
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
Subject: [PATCH v3 16/36] doc txt & -h consistency: use "<options>", not "<options>..."
Date:   Fri, 30 Sep 2022 20:07:39 +0200
Message-Id: <patch-v3-16.36-db850539d2a-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's arguably more correct to say "[<option>...]" than either of these
forms, but the vast majority of our documentation uses the
"[<options>]" form to indicate an arbitrary number of options, let's
do the same in these cases, which were the odd ones out.

In the case of "mv" and "sparse-checkout" let's add the missing "[]"
to indicate that these are optional.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-mv.txt     | 2 +-
 Documentation/git-status.txt | 2 +-
 builtin/pack-objects.c       | 4 ++--
 builtin/sparse-checkout.c    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index 79449bf98fe..972a055fbd8 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -9,7 +9,7 @@ git-mv - Move or rename a file, a directory, or a symlink
 SYNOPSIS
 --------
 [verse]
-'git mv' <options>... <args>...
+'git mv' [<options>] <args>...
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 54a4b29b473..5e438a7fdc1 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -9,7 +9,7 @@ git-status - Show the working tree status
 SYNOPSIS
 --------
 [verse]
-'git status' [<options>...] [--] [<pathspec>...]
+'git status' [<options>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3658c05cafc..573d0b20b76 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -180,8 +180,8 @@ static inline void oe_set_delta_size(struct packing_data *pack,
 #define SET_DELTA_SIBLING(obj, val) oe_set_delta_sibling(&to_pack, obj, val)
 
 static const char *pack_usage[] = {
-	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
-	N_("git pack-objects [<options>...] <base-name> [< <ref-list> | < <object-list>]"),
+	N_("git pack-objects --stdout [<options>] [< <ref-list> | < <object-list>]"),
+	N_("git pack-objects [<options>] <base-name> [< <ref-list> | < <object-list>]"),
 	NULL
 };
 
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index aac0f708e42..58a22503f04 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -20,7 +20,7 @@
 static const char *empty_base = "";
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout (init | list | set | add | reapply | disable) <options>"),
+	N_("git sparse-checkout (init | list | set | add | reapply | disable) [<options>]"),
 	NULL
 };
 
-- 
2.38.0.rc2.935.g6b421ae1592

