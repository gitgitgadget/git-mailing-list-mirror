Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963EAC4332F
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 22:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7428961057
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 22:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhIFWsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 18:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhIFWsP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 18:48:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C177AC061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 15:47:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u14so15889427ejf.13
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 15:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=56UqspQDSVD357e8cq9p+lJeA0WvZsHSTuyP5PJVr0E=;
        b=irS3NnF84PAMOnXfP7KeKBkuY7N3cEG2IawDtjgjApc7C6apACiJyOeIMCRob3i+gF
         +EXA07pR2yxft5IFwaAKrmdAIaHfrPaFnPfUQUzhK9mybOhJtRE1CJuLvvRlKV5LFKPC
         Z+QlgL2X4YoKWYYOQa9CAsh8h7p+4l+AQnne88VaP0nu6Dvi6Dxx1hEANsGOK3zakwFU
         jcySAEHZk82XhXPo3zf7v4iLZuOmkgriOCyXPqvaYrqhbkNl9/HNqgwgom3vhBHCTuQ/
         XPDn3wIG17pSA27ocQcOKFNFFfogZaw0jvw+lK1n3mQ90+fPSyltojzKIeDGifwfRcei
         HERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=56UqspQDSVD357e8cq9p+lJeA0WvZsHSTuyP5PJVr0E=;
        b=HqLSWCX/GLW1EFr7O/sIVApBjHoOnN465qzQla4qSTv7xTJOK+bwSKwfJJ07D23OjQ
         3y2+cZFUOf1NKlOnv/1PXXcI4/FCkyPKmWawlhNkb9TN18tRtEY5KVfu7UUHJPBlqfLt
         DMN/U7TA2YUpq6JUvWFt+/feyBf0zO1+zoInRjCvTWDPbX37/3Sz0n6yU1Itvfq34hqT
         m0Gnml6X4Dbu1uHEcePhHlPilZCCcpnY+XD1sZNmd9H9oGvVc20GRuoosTNUGHN6tXxa
         wubEzTvtgMHxTBWjPNjJAVPumYX0KXMXAyYqQ2MTmAgECjA9HFZ/OS+JzB6uFH1fw2l5
         AM8A==
X-Gm-Message-State: AOAM531OmXPe+XzR0WaXrniq8snpCbMEthg9Xgc2bJ5TnIv72oy/GoHH
        p79Pl4SJqgPCrAJhdc9fOLq2XwF9xg0UDQ==
X-Google-Smtp-Source: ABdhPJyiJVBOlCWuzopLJ76YcEEopZMFpqiUMkG56MOz0KBuSbo+xx0sK8MgQZkuQ0a0vhXoKnLqnw==
X-Received: by 2002:a17:906:7847:: with SMTP id p7mr15516633ejm.335.1630968428039;
        Mon, 06 Sep 2021 15:47:08 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p16sm5307888eds.63.2021.09.06.15.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 15:47:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 4/5] refs: drop force_create argument of
 create_reflog API
Date:   Tue, 07 Sep 2021 00:42:26 +0200
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
 <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
 <aa25fd9b7de02c3b5c620def8fae4d5b6ce456c5.1630947142.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <aa25fd9b7de02c3b5c620def8fae4d5b6ce456c5.1630947142.git.gitgitgadget@gmail.com>
Message-ID: <87zgspmidx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 06 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> There is only one caller, builtin/checkout.c, and it hardcodes
> force_create=1.

Was it ever needed? A glance at abd0cd3a301 (refs: new public ref
function: safe_create_reflog, 2015-07-21) suggests probably not, but
then there's 0f2a71d9923 (refs: add REF_FORCE_CREATE_REFLOG flag,
2015-07-21) ...
 
> [...]
> -static int files_create_reflog(struct ref_store *ref_store,
> -			       const char *refname, int force_create,
> +static int files_create_reflog(struct ref_store *ref_store, const char *refname,
>  			       struct strbuf *err)
>  {
>  	struct files_ref_store *refs =
>  		files_downcast(ref_store, REF_STORE_WRITE, "create_reflog");
>  	int fd;
>  
> -	if (log_ref_setup(refs, refname, force_create, &fd, err))
> +	if (log_ref_setup(refs, refname, /*force_create=*/1, &fd, err))

We can lose the inline comment here & let the function definition speak
for itself, we usually don't inline comment boolean flags.

In any case, having not dug (but presumably you have) some overview of
how we ended up having this not-required flag would be nice. I.e. was it
always this dead-end, or did we replace it with REF_FORCE_CREATE_REFLOG
at some point etc?
