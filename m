Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1444EC4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE95C23A9B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgLSOKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 09:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgLSOKv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 09:10:51 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFCAC0617B0
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 06:10:11 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id d8so4750937otq.6
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 06:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=lO++mL/aQERef/uoYZdJ9jr5fALNcJzmhXjOwqN1UZI=;
        b=grWJ+CLrAtwnKfRx647Dm6uwwU2yyOlQU1/+Vbsq7Ll/5uw+8EvOJIL+GRjMsKDNX8
         HwvRtHiSED5ZJzN0tRyFWvkq1OPlqhAH+nRl/FM9HlyzVcBqnA4zDtG1qiqjQnbb1qxM
         VuTOueX77dJSLcQcFJhjRaGUzd6JFueDfhe0ocveBSuLOF5UwHi8lVgwLO2rNxlPnT3P
         Itlc5t5YheXvInKU9QwRxmHn/HNSS4hdeT+vVefM+Zw9Hjxe5KATpVdwSNHMh+IGOL2r
         Ls468gx1onDz0N6OYq7UQ7lSFuhf3JNMC0Q3r4G7uj1cURWXITIdZbGov5/z//1fBMIs
         v/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=lO++mL/aQERef/uoYZdJ9jr5fALNcJzmhXjOwqN1UZI=;
        b=Hf9BeN/0ATx3Zsl/a+0Atae2Gupa0mTFHAoLnFnxeuzoTFQVkx6Tqde5TRHMQibTx5
         eg7QcbRRYjWXby4urjZaTui9jSjzeahUyy+/2518KjJo0RcjEOCWetYpjRHKAtBpL3uW
         QO/yef8X3PLD3UMQg2VMsAukLxsluSf/l051KW0AtY7Hfx1SaJFYwttDdLLr5FUyPLCH
         uW2sMkqzpAmcQk9KJBr/kBL1WGrKeLDgJq23jDPUBcJsgl0xYcijTPb2irTAtEawUHI1
         UpFmXJdmoquFYsVe+Zs9xIn5VUay0KLb6aLQhExa2aWcgPEzkh+M4mx2raQz3oNPb+a3
         8SzA==
X-Gm-Message-State: AOAM530cWVvzCFm25SKmwimAzMfOdshZfMpGnDKvRV6Inemxe1d3pXMM
        zHC2qrulRsUp5BH5y+TI0Tn0ZWIDT/l0UA==
X-Google-Smtp-Source: ABdhPJwkSqy5LYZcUWhz6C+HZOl5WtyxfR11nITlsmxbg5FH4Erl2jSziJuF/8QvM5C/i+z/IpaXkw==
X-Received: by 2002:a9d:a4e:: with SMTP id 72mr6389320otg.267.1608387010826;
        Sat, 19 Dec 2020 06:10:10 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id g12sm2570798otg.10.2020.12.19.06.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 06:10:10 -0800 (PST)
Date:   Sat, 19 Dec 2020 08:10:09 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <5fde09c1ac7d_1def912083c@natae.notmuch>
In-Reply-To: <xmqq7dpeqrz4.fsf@gitster.c.googlers.com>
References: <xmqq7dpeqrz4.fsf@gitster.c.googlers.com>
Subject: RE: What's cooking in git.git (Dec 2020, #03; Fri, 18)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> * fc/bash-completion-post-2.29 (2020-11-10) 26 commits
>  - completion: bash: shuffle __gitcomp functions
>  - completion: bash: cleanup __gitcomp* invocations
>  - completion: bash: add __gitcomp_opts
>  - completion: bash: improve __gitcomp description
>  - completion: bash: rename _get_comp_words_by_ref()
>  - completion: bash: trivial cleanup
>  - completion: bash: cleanup _get_comp_words_by_ref()
>  - completion: bash: refactor _get_comp_words_by_ref()
>  - completion: bash: simplify _get_comp_words_by_ref()
>  - test: completion: switch __gitcomp_nl prefix test
>  - completion: bash: simplify config_variable_name
>  - completion: bash: improve __gitcomp suffix code
>  - completion: bash: change suffix check in __gitcomp
>  - completion: bash: simplify __gitcomp
>  - completion: bash: refactor __gitcomp
>  - completion: bash: simplify equal suffix check
>  - completion: bash: factor out check in __gitcomp
>  - completion: bash: get rid of any non-append code
>  - completion: bash: get rid of _append() functions
>  - completion: bash: remove non-append functionality
>  - test: completion: add run_func() helper
>  - test: completion: fix currently typed words
>  - completion: bash: do not modify COMP_WORDBREAKS
>  - completion: bash: fix for suboptions with value
>  - completion: bash: add correct suffix in variables
>  - completion: bash: fix prefix detection in branch.*
> 
>  Needs review.

I think I already mentioned these should be dropped in favor of an
easier to digest series [1].

I just sent another try as a reminder [2].

Cheers.

[1] https://lore.kernel.org/git/20201119015209.1155170-1-felipe.contreras@gmail.com/
[2] https://lore.kernel.org/git/20201219140621.1961760-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
