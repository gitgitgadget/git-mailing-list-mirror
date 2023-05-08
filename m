Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63433C77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 23:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjEHX4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 19:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjEHX4o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 19:56:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C3F3C33
        for <git@vger.kernel.org>; Mon,  8 May 2023 16:56:42 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aaea43def7so35422125ad.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 16:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683590202; x=1686182202;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6tdUT14Ax88rOmKSKc5hjPBos2LUDBYI2Numca9Ejg=;
        b=f150W37Dl+d87kP2ShWXSWTaST9ofOCjl/oqySEYaaYaH7v83PwV+p++v+gR6aTkzK
         aph7Rm412H7doe/Ur9SJSdTnCxYrbtHWhnDVNoBJHLvyZggAqcWvDVndPeLzzqPUO6Ks
         F2pLB18WZal8hH+OQBB3xsg9nhzWADIt0alLYlopgo/NZS/82S75XluESPxENTfxis2F
         fVv4gcpaS69H3o/A38FIRqPZrRt/ILeVHR/ECL7fHBthW6b43zOXYCpDqS99isYM3/cE
         DbhZ9LSnq651jin5mjrOzryh8/Uws/tercbyn2RLG5/8EOUrTXZxaaQMnnXezIMRaFQb
         j8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683590202; x=1686182202;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X6tdUT14Ax88rOmKSKc5hjPBos2LUDBYI2Numca9Ejg=;
        b=iiz2GCvRUyBLdd3GdLG3T2sW+b128TIReSBrIgSa/gcJUJxwODWGmQvPFM5JTuLei5
         1kShs9Sn1Uvy/OTLyWvCESBTVqeAcUDCMqpwVYNlyVA0f8pBX3roIzij4MzTY24VNsbl
         vjetAr1QogbWk4rHLdYkML8lmTgeCY4xGOHslkGVGI8Vi06E/rqO2GjLpU/KzwAlclfA
         JAPWu/HYHNLVmOf9l1BIiq5CVgjWEjaw9nNX5+nlv1QDqa7Je1/JOXI/IIEqtCGrHvEA
         d882K1Q1Ck6Z2kE369RVjwQX0AVuMmxxeGT4sNx46KvT2ePcwHSugL+DqUbe7tkDT+5h
         6jhQ==
X-Gm-Message-State: AC+VfDz50g0zsU4G9nw8rHfKp+sUChUmoOmMhQjAOHdznngcvTsMzxwL
        Q4FExfRZ8TFUBe59KatQArE=
X-Google-Smtp-Source: ACHHUZ6ncyoBT1hSwDPWALm4VZ7g1RWactoj9KV5R6KtVE2rBz+HpxfwN/DxiRFaG6w4QeiJQoBulQ==
X-Received: by 2002:a17:902:8d8b:b0:1a9:3fab:3ebe with SMTP id v11-20020a1709028d8b00b001a93fab3ebemr11972000plo.10.1683590201789;
        Mon, 08 May 2023 16:56:41 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id g24-20020a17090a579800b0024dee5cbe29sm15094283pji.27.2023.05.08.16.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 16:56:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 08/15] refs/packed-backend.c: refactor
 `find_reference_location()`
References: <cover.1683581621.git.me@ttaylorr.com>
        <836a5665b7df065811edc678cb8e70004f7b7c49.1683581621.git.me@ttaylorr.com>
Date:   Mon, 08 May 2023 16:56:41 -0700
In-Reply-To: <836a5665b7df065811edc678cb8e70004f7b7c49.1683581621.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 8 May 2023 18:00:05 -0400")
Message-ID: <xmqq5y924bt2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> The function `find_reference_location()` is used to perform a
> binary search-like function over the contents of a repository's
> `$GIT_DIR/packed-refs` file.
>
> The search it implements is unlike a standard binary search in that the
> records it searches over are not of a fixed width, so the comparison
> must locate the end of a record before comparing it.
>
> Extract the core routine of `find_reference_location()` in order to
> implement a function in the following patch which will find the first
> location in the `packed-refs` file that *doesn't* match the given
> pattern.
>
> The behavior of `find_reference_location()` is unchanged.

The splitting out of this step is rather unfortunate in that the
extra parameter "start" given to cmp_record_to_refname(), together
with a rather curious returning to "-1" when the parameter is false,
are not justified at all by looking at the caller, because the only
caller of the function, find_reference_location_1() always passes
"start" it got from its caller without modifying, and the sole
caller of that passes "1" to "start".  IOW, the behaviour of
cmp_record_to_refname() when "start" is false can be any arbitrary
garbage (it could even be BUG("")) and the claim "the behaviour is
unchanged" will still be true.

But that does not help the readers all that much.

So, yes I can agree that this does not introduce any new bug, it is
a mysterious no-op, and why we want to pass different values in "start"
in future steps in order to achieve what is not explained and leaves
the readers frustrated.

I'll stop here for now and come back to the rest laster.

Thanks.

