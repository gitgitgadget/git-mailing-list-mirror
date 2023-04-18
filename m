Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BA7C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 20:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjDRUkl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 16:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjDRUkk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 16:40:40 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21476AD1E
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:40:39 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54fc337a650so222873407b3.4
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681850438; x=1684442438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Hs+3ywhbstovkOsQyBNUBwcoLP41kBSwzvbmhtSIqs=;
        b=4QhlGv1npoYSLa2CcxGInOijJYslrUEVfslk0V9JuK3j6X0asIS6BaprgNnVbWAYVk
         79QZYZ4I6kyQN1kxk3huj0tiCJEuXwmHLOeTNxL+eUON2DvKqvIqsEPIjcHyfjyt9kzG
         cc3EQDBhVgg0KQdOvosRZkSSlmJnaMXjbq2QZXe6IIlFmo9l4gYSGDqJusr4L6dO07bT
         SiNsNTh/ticNsOtOHxI5zDBVQVv0Mt+C3M9inrLiuMlrUyzVAV0Ouq6awmjhhQzOy1hg
         FCQshCXe1wzHRlmg+6v4Z+JYt0cv8fKT2PZ/h6nL3I9zL2gQgIOtm6He0LDLa/srisoW
         iYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681850438; x=1684442438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Hs+3ywhbstovkOsQyBNUBwcoLP41kBSwzvbmhtSIqs=;
        b=DDixPNgqdw/750YYMi75dGklGxu0WYdTBknHGj671HOhmjSQI15lgNPdNdWdXm8jbN
         FHebzSiw42FlZQEpxpO6CRtW1LnWzW4mfzGEqQN3hhqKVoQlox24md+ZwNluulR3OpK7
         TJooYxeOXCZBccKkbIO6JH8Qks0GBknbPuFCJd4VocrC7Lzq0ovR7BiKU2UEmCAE3g3c
         uuWe9CfKr/ha9/uiX3troAD3j+M3h8WcjbVNzMwr5gsqPGFMMVm02zfyGblUB7N/f6gE
         Fi0y6S7MuUE1VpJx/Blz7dgN81UGrex9Ddzm00e/Q/Z3NH98KkSBiSX+GbrwiA9VS0QG
         Y9Qw==
X-Gm-Message-State: AAQBX9css3tA+ES6tFeJQHJ1WuofjtGN+e2piRHwsvmqUtD5Dz19j/ur
        2YMzFQFLdftyfyLVjnmjr4NKBtMc7Vt5k/3HfJghPg==
X-Google-Smtp-Source: AKy350Y7eBIUo1YMtRWvWUYbG1kcFdu5E3Q1sMO+T5VATa9VCHRLghD1qjyWqqwIPya/diZkPL5kCg==
X-Received: by 2002:a81:8701:0:b0:54f:881e:75bb with SMTP id x1-20020a818701000000b0054f881e75bbmr1041825ywf.45.1681850436770;
        Tue, 18 Apr 2023 13:40:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a206-20020a814dd7000000b00545a081847bsm4057680ywb.11.2023.04.18.13.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:40:36 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:40:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/10] builtin/repack.c: fix incorrect reference to '-C'
Message-ID: <52fb61fa9c7398c7b412336b3ebe5724f5263108.1681850424.git.me@ttaylorr.com>
References: <cover.1681764848.git.me@ttaylorr.com>
 <cover.1681850424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681850424.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cruft packs were originally being developed, `-C` was designated as
the short-form for `--cruft` (as in `git repack -C`).

This was dropped due to confusion with Git's top-level `-C` option
before submitting to the list. But the reference to it in
`--cruft-expiration`'s help text was never updated. Fix that dangling
reference in this patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index df4d8e0f0b..d9eee15c2f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -774,7 +774,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("same as -a, pack unreachable cruft objects separately"),
 				   PACK_CRUFT),
 		OPT_STRING(0, "cruft-expiration", &cruft_expiration, N_("approxidate"),
-				N_("with -C, expire objects older than this")),
+				N_("with --cruft, expire objects older than this")),
 		OPT_BOOL('d', NULL, &delete_redundant,
 				N_("remove redundant packs, and run git-prune-packed")),
 		OPT_BOOL('f', NULL, &po_args.no_reuse_delta,
-- 
2.40.0.362.gc67ee7c2ff

