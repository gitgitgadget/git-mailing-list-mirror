Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9C7C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 07:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1364D61426
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 07:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbhDUHDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 03:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236951AbhDUHC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 03:02:58 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065E4C06138B
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 00:02:25 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r9so61917164ejj.3
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 00:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=/7LJGaiPnEimj9E9Reo9YXmdsN5PTf26AId1NAtQMzs=;
        b=scszjta2fmuse05LJ4qDl1iTgGFtv9mNxgqZVWqdtuj9gQlr5NeHUQC5r35IdV8jRC
         MCdBbSb13CIeZ2sJdhDBN6ia71eNiIQEDE/rQYWu87pkegzWbg/p/YDuKJO86RGJEMDd
         zjs3X0FGEqdo9DYd+g3XobBXYmuc0gexo0H8uLavPnl2+yuNDXZtn1lJsEawZmeg4mFz
         hLGywUBRcorpAoK7QwWFQ3TeI3UKGOGd9uFgIVN1M4W4fzmVhVt2VLzWbv2oHpc4cUL7
         t5w98vSdaU67KmT/reAd8QyGBIKpoZDVH0JhcYYoB8ZCqAOK4lvKPcBIV1sjzlYi0YFY
         4BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=/7LJGaiPnEimj9E9Reo9YXmdsN5PTf26AId1NAtQMzs=;
        b=cb/XqW9noMmuKiPC1TUkQ9neHSA9akMBL486hJsjNDPV91pxgs9PcpZZnGTf8chcrL
         saVoFu6vykTUSOcQWEeuDMPAdTl2lS79prIevusnDBzbHNRT1ekl57aK6GvKaHdGIm60
         7DEA00NqBnCatJ8jBJJELt+MFpF/Txa30i6u/D562kp2dxirTlT+TQ+55/vIHkBEZW3A
         vL1ybna/0ozBtae9TBzt6KitSWFkuQzWLqsmSiUVt50XdLhcMSyX4PUsDYoRIR+nvusq
         4MA6wMLeY+FQMPNCV/Vag81Y1z5AuUg/6n3ekj7VdNJ/luSlN01Gf51leGfVyJs487vb
         gzTA==
X-Gm-Message-State: AOAM531oaQbn6qOFHC6eALIK5yeBo9j3Gua9aIRbQccOfFMw6En9safl
        qqkN8W0Tf0ZXLggPPgH06ZHmGH+cEyDfOQ==
X-Google-Smtp-Source: ABdhPJydXEzRSPvMBLgIXZLR3cvGdS1D1fOR71UENWe83Kbw9FssoNGuIwyk2Pci54V0buIh4At/Xw==
X-Received: by 2002:a17:906:b7ce:: with SMTP id fy14mr31112422ejb.261.1618988543517;
        Wed, 21 Apr 2021 00:02:23 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c12sm2115416edx.54.2021.04.21.00.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 00:02:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 16/18] t7003: check reflog existence only for REFFILES
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <a5b9439192db3ad3c01db0e67cc1f60bad9109e8.1618829583.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <a5b9439192db3ad3c01db0e67cc1f60bad9109e8.1618829583.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Apr 2021 09:02:22 +0200
Message-ID: <87h7k03ytd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t7003-filter-branch.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index cf30055c88dd..380bdf934317 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -396,7 +396,9 @@ test_expect_success '--prune-empty is able to prune entire branch' '
>  	git branch prune-entire B &&
>  	git filter-branch -f --prune-empty --index-filter "git update-index --remove A.t B.t" prune-entire &&
>  	test_must_fail git rev-parse refs/heads/prune-entire &&
> -	test_must_fail git reflog exists refs/heads/prune-entire
> +	if test_have_prereq REFFILES ; then
> +		test_must_fail git reflog exists refs/heads/prune-entire
> +	fi

Same comment as on an earlier patch[1], i.e. aren't we leaking some
"does the reflog exist" abstraction all the way up from reftable in a
way that's broken here?

1. https://lore.kernel.org/git/87pmyo3zvw.fsf@evledraar.gmail.com/
