Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F4EC77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 19:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbjEKT5e convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 11 May 2023 15:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238502AbjEKT5d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 15:57:33 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35142D74
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:57:31 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6216a09ec38so4185986d6.3
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683835051; x=1686427051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pi3y62K8hstpT0Xy4BWiwYGjzBR/FMskEQAK9QkkkCo=;
        b=ibD0bkg8xXLJenXhljxL0BVCwWm7a+NZdZpv4+vRPsqXTi7DBr1j9U7NfbF08WONva
         c7FG7U7YWxaAChdMgjYR89Lm8sKL8NlvjnIGuQ+SV7IBMRtV/rTxOAt1fNCkHEp6TyPy
         2AVVozRzHaCKn8RDkuQj8jiymMUKfVNDAAlv0kFTpOa0kdEG+9SvZnLyPuMy4xSMq+J3
         AFVmG/ayXwNMX1vFmBJD47HjhCqitV7gF2YpQnPSELw4gyiQoxksCT9af+eQQdJ2t8yI
         FxNFm6pAhqkqFD31OTkPuS1ilz/35slhDcABo+nunHrLZSkBEo9LyyRM2aE9dd5nvHpL
         bENw==
X-Gm-Message-State: AC+VfDw+FwevAJwsz4OHI3sss1bNxsz7zSIvP52GXAIutXl0pAyv+WYH
        DW/3DPoMpJ9HePZOCtjSNDb49L+euhl+mBDGR3E=
X-Google-Smtp-Source: ACHHUZ7nlkOb4YFnMmJCJUSBNkScttIc/btFAllcY7zXvmXtCmLIMbSGiR61sllFdbZ7V8Cn4V3vC1uu1al4g9eKUlc=
X-Received: by 2002:a05:6214:2425:b0:621:700b:f9ef with SMTP id
 gy5-20020a056214242500b00621700bf9efmr2785757qvb.15.1683835050952; Thu, 11
 May 2023 12:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230511194446.1492907-1-calvinwan@google.com> <20230511194822.1493798-1-calvinwan@google.com>
In-Reply-To: <20230511194822.1493798-1-calvinwan@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 11 May 2023 15:57:19 -0400
Message-ID: <CAPig+cSTVbvyUOOoVrsTS8t4VSoCbVRoA=i6j0_4KZX5ZTt34Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] strbuf: clarify API boundary
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 3:48 PM Calvin Wan <calvinwan@google.com> wrote:
> strbuf, as a generic and widely used structure across the codebase,
> should be limited as a library to only interact with primitives. Add
> documentation so future functions can appropriately be placed. Older
> functions that do not follow this boundary should eventually be moved or
> refactored.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
> diff --git a/strbuf.h b/strbuf.h
> @@ -1,6 +1,15 @@
> +/*
> + * NOTE FOR STRBUF DEVELOPERS
> + *
> + * The objects that this API interacts with should be limited to other
> + * primitives, however, there are older functions in here that interact
> + * with non-primitive objects which should eventually be moved out or
> + * refactored.
> + */

Sorry, I meant to send a follow-up to my previous email[1] but forgot.
In particular, I wanted to say that I think the second part of the
above comment (the "however" and everything which follows) ought to be
dropped since it will become stale once those "older functions" are
finally removed; it is likely nobody will remember to update this
comment. So, the above could rewritten something like this:

 /*
  * NOTE FOR STRBUF DEVELOPERS
  *
  * strbuf is a low-level primitive; as such it should interact only
  * with other low-level primitives. Do not introduce new functions
  * which interact with higher-level APIs.
  */

[1]: https://lore.kernel.org/git/CAPig+cTQg7XzORPHeD79aHEi1ggOjTPw9X02VPgxcV9uoBOBxg@mail.gmail.com/
