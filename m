Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73207C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F657611AB
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243670AbhETPPm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 11:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbhETPPl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 11:15:41 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FBBC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:14:20 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o5so10843091edc.5
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=YdqLm4Hzzh5N8/06+RnzmZs8PlgzXW+bsXIsQ+vruFY=;
        b=bpzc4RWm6DTe2Zc87LA7WZL0RPZCHrN0I8hkiaq0sIcSzwi9mlgPMEW9INdmhImLnn
         zKUb+kOu/rUZ58Q3avdcQPg9JNlMrdoN5gNh1+dU2mCA15FH3PcqQJ+BuywzYO7PVif0
         ScVRA80tEZF6KzuXwFIE4QAm2GWPymc3RQfnyluAO5+L7f8Gj/sY/AE6HsfWvRahXW9R
         KCQ4r1RatxOw9O3gkcuDs52ya2MSghh7JRKc31/J+H1SPxSAb7053nM+wT0tbWLHzP2j
         hdiDscyzptWFBxIrQ0l9bePfKBdmrsBK685NiUs0Sb0awO/KrLxjJlDtAXMqjm740adp
         Gk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=YdqLm4Hzzh5N8/06+RnzmZs8PlgzXW+bsXIsQ+vruFY=;
        b=X6JmgkphCWrbJr3aAXjN/HX0/sa1UFkNDa5d7OIL2qQQ7ipcwIXTMERjYeyx0pejf5
         onz/xCJTUPVD9R09/1aQRKVL4GHgWjdgWoVwEdhSnPklaRx23JxdbBTFtigfKvv13CRQ
         DOyMz1yLo+vLRUxyHUcTRWimIE6OOtTV2McuijkKquI+DLX4xpRoCGXJmkQPy7XyGFFy
         O6AyykroE/NKrX3lnKW/4vYQMbzfEjyq2a8PYnpydKwoSlUUyo52iNnxqhmXzQeLt8Ap
         2pP0VA4WMeIUxpeeoJXRYNcS5ANQDo/rhPDwWD8F+J0MPE27FGsxemmhw8U3F+gDNIvc
         C/aA==
X-Gm-Message-State: AOAM531jR2LDAjTkygy3iELbvQcso/Y0Bh52Cib5YpwXnRDFq3HGUET0
        dog8mkQdeKPvao5/LjeCoeHxcWUzfwOETQ==
X-Google-Smtp-Source: ABdhPJz9YEvRV8R+/tNC5G4l+hSkc2nKtTY6pOSusS/lZPK5njIuxPv9R2iLwGGftVXjfCbCXWhTLA==
X-Received: by 2002:aa7:c485:: with SMTP id m5mr5384648edq.230.1621523658391;
        Thu, 20 May 2021 08:14:18 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id i5sm1561180ejv.120.2021.05.20.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:14:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 03/21] t9300: check ref existence using test-helper
 rather than a file system check
Date:   Thu, 20 May 2021 17:11:36 +0200
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
 <c5855b0caa7320c8b3f1ad5c5904ae73b1decb97.1619519903.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <c5855b0caa7320c8b3f1ad5c5904ae73b1decb97.1619519903.git.gitgitgadget@gmail.com>
Message-ID: <874kexqvxy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t9300-fast-import.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 5c47ac4465cb..1aea943bef72 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -392,7 +392,7 @@ test_expect_success 'B: accept branch name "TEMP_TAG"' '
>  		git gc
>  		git prune" &&
>  	git fast-import <input &&
> -	test -f .git/TEMP_TAG &&
> +	test $(test-tool ref-store main resolve-ref TEMP_TAG 0 | cut -f1 -d " " ) != "$ZERO_OID" &&
>  	test $(git rev-parse main) = $(git rev-parse TEMP_TAG^)
>  '

We have resolve-ref and verify-ref in the helper, why not a few-line
"exists-ref" or similar instead of needing to parse this out with
shell/cut/test?

I haven't tested, but in resolve-ref we do this:

        printf("%s %s 0x%x\n", oid_to_hex(&oid), ref ? ref : "(null)", flags);
        return ref ? 0 : 1;

So re my earlier question about "ref" being NULL or not, isn't this
going to be reflected by the exit code of resolve-ref already? I.e. any
"exists-ref" would just be a convenience wrapper equivalent to a
"--quiet" flag for resolve-ref, no?
