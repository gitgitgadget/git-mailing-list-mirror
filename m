Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0396EB64DD
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 06:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjHIGrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 02:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjHIGrg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 02:47:36 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B30010CF
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 23:47:36 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686efb9ee0cso6089032b3a.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 23:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691563655; x=1692168455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pfpB9r+W2TX6S1+C/Ow1CmjRt07wdvLVDf7FGnRX04=;
        b=IkcJ9zN0R4QByB24QVvlf8gj4OCw0SIhz3kXgZaQyPB4NIsjvOAe7UfXsgYu0/PB6c
         eWBvmhlPXm7/2VZni8y5JJ7+xh5Xi+XXM1jGzCHACLbIKg86Souu1ODuI+J9j5uUO3fR
         LFTE3J7RdCsFLQKilxJVH5+ITwUch4YZUJ5uFDao0od+4CZUXZKAr/6pRLjgZcC0IOeg
         q4PlvKaoLiOiOhvmmLCi1AeCGvjMLFPpc18ZUBrQBhz3aqF4zCaBw89kQkbmOR3oIB/p
         3Jsw8FTO/q1+uTp5QX1CdyUncQ0xlZhVAscna47cqOmm5C/5CzyAH7ffI2lwTVW0mKhe
         ilQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691563655; x=1692168455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pfpB9r+W2TX6S1+C/Ow1CmjRt07wdvLVDf7FGnRX04=;
        b=VhP/MobeJSU50WV1TDItuXuKcLw04ULEGWS+3lCuqnAloj2UG3dBJ6HuluLiBeTaMg
         nic6GCBVgH/MHAezTF48JWwG1ME3FPvoPrXOif8/s2iYhRJM4NbwJsUcrswU75V+BbQm
         WLPU9uxT4s57oFUD/0SfRemCpWcCJtJO2FLBG0gn9aMdxIwzxgTUmcEYM8srKenplk4l
         JH3MRTFidUYpicef/Cjul0qqliQicDejyZ8v8q5tsdUbS7gfZbOLEjjtTvEVGxMjkmam
         UduffvecdgVwrf6qb8jzsXbaW8hudzOdy/GlnwGVcGg4g1g5w/VFp12MBsM28irwsjku
         H7aQ==
X-Gm-Message-State: AOJu0YzgWsLpQxuUWBKsCRiOPF4RvXYNEHbbwfKw1sk6LBAbrRflFRGh
        towuARcRiUwMD8pilDOOVe4=
X-Google-Smtp-Source: AGHT+IEqmGQeTbQ9HpdLS5XunySFARa8eAksAOEVNwVXwabeKcHj5Y4bnIdNVRdJpLSJRYgjw/WP8g==
X-Received: by 2002:a05:6a00:23d6:b0:687:494c:2ebf with SMTP id g22-20020a056a0023d600b00687494c2ebfmr2262842pfc.7.1691563655419;
        Tue, 08 Aug 2023 23:47:35 -0700 (PDT)
Received: from localhost.localdomain ([2404:2280:2000:10:bbd1:e247:bbd1:e247])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79204000000b0063f0068cf6csm9132733pfo.198.2023.08.08.23.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 23:47:34 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     jacobabel@nullpo.dev
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, phillip.wood123@gmail.com, rjusto@gmail.com,
        rsbecker@nexbridge.com, sunshine@sunshineco.com
Subject: RESEND [PATCH v10 7/8] worktree add: extend DWIM to infer --orphan
Date:   Wed,  9 Aug 2023 14:47:22 +0800
Message-ID: <20230809064724.13032-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.41.0.328.g2e11c30e.dirty
In-Reply-To: <20230517214711.12467-8-jacobabel@nullpo.dev>
References: <20230517214711.12467-8-jacobabel@nullpo.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> +static int can_use_remote_refs(const struct add_opts *opts)
> +{
> +	if (!guess_remote) {
> +		if (!opts->quiet)
> +			fprintf_ln(stderr, WORKTREE_ADD_DWIM_ORPHAN_INFER_TEXT);
> +		return 0;
> +	} else if (for_each_remote_ref(first_valid_ref, NULL)) {
> +		return 1;
> +	} else if (!opts->force && remote_get(NULL)) {
> +		die(_("No local or remote refs exist despite at least one remote\n"
> +		      "present, stopping; use 'add -f' to overide or fetch a remote first"));
> +	} else if (!opts->quiet) {
> +		fprintf_ln(stderr, WORKTREE_ADD_DWIM_ORPHAN_INFER_TEXT);
> +	}
> +	return 0;
> +}

s/overide/override?

 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4cd01842..10db70b7 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -696,7 +696,7 @@ static int can_use_remote_refs(const struct add_opts *opts)
                return 1;
        } else if (!opts->force && remote_get(NULL)) {
                die(_("No local or remote refs exist despite at least one remote\n"
-                     "present, stopping; use 'add -f' to overide or fetch a remote first"));
+                     "present, stopping; use 'add -f' to override or fetch a remote first"));
        }
        return 0;
 }

---

I found it when working at l10n round of 2.42.0, maybe it's not late to fix
this typo：

Thanks.
