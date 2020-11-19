Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A16C2D0E4
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 07:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F3B246BB
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 07:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pT9d13ah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgKSHob (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 02:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgKSHoa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 02:44:30 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13251C0613CF
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 23:44:29 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id gj5so6510877ejb.8
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 23:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=EfJKNIbL3vJfFzMFga8QkbjyVHy7TzxP0v+rR4gwq3U=;
        b=pT9d13ahCeEL0NDqA16IjqG72mKNwa71CB0BlPL7y9DXvxuIwhlHQS0+qzz37JTZrA
         MLOAhiKkMq7anj/k0bu5WfsawVNxmr+2HyWaxi6Wrm2wUaWJ7mwKA0P4GS0X+0Uc/dC0
         ngrXOlHCfZ6ScRBao7Vk4sJsr+z0vbfnvTBHd1MQZe9oQgS0XTYF7F5KN2FuUp6870Tj
         rxQdXCXDkVpLaE+DzOk1eSGjzSWLruaAHW/LPZxmAEgnPvPdorJc3fb5dsBM5gjzIuxd
         FOwwnLfaHPOaIRDoR0u6soGPimHBFtAxg6pR1ZmIqRkecw1lVTnyEhP6kMIjF+gRRwN9
         /uwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=EfJKNIbL3vJfFzMFga8QkbjyVHy7TzxP0v+rR4gwq3U=;
        b=mtYI2BSaQaDBEJvNgDfEoETWQBYjIpOKTX3QVN8Iqe+jvo7sEEksSEP8swyoIuhVfn
         SYM1Vl5bKyV3C/M1BBPcGJ1M5+GgvLZPf2wIuaMGIP/a9Gkz3Rd8roJ7/auU3Fu4i9yA
         cyN72sBfOY+8yGJW87sgsdBQ8iACwajFPxTNnP4hEmrewn4Fe9bzetV+riLNYstWZVQR
         kLqKWtp03L3cvnPZI13j8KT2RTeWcjRJs6z0eqaHcoXVwzJ+wycyxZSGsrfj5swYyjZ3
         ogwaBER+1EmjWp+ovqizXadsYLnM4hAZQ0J5wgAJqUiDATwudvmOG9lCE7M8kiH4ibdY
         5vyA==
X-Gm-Message-State: AOAM531QkB1eIznYI0cgMviGnzSOUk67TRVKJY8hrHBeX0yxApMBHFCx
        iSXG1+WKCP0nAY3vFnQE2B0=
X-Google-Smtp-Source: ABdhPJybgIewYCTqyRomPQqRvSK3D2UiPinngZ4LT4zsxjQxR1ziuCXWfPuDRlb4A+J8yi1YlkmlSA==
X-Received: by 2002:a17:906:fcc2:: with SMTP id qx2mr28255450ejb.549.1605771867731;
        Wed, 18 Nov 2020 23:44:27 -0800 (PST)
Received: from evledraar (ip18-11-210-87.adsl2.static.versatel.nl. [87.210.11.18])
        by smtp.gmail.com with ESMTPSA id n11sm14661005eds.3.2020.11.18.23.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 23:44:27 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, shouryashukla.oo@gmail.com, git@vger.kernel.org,
        christian.couder@gmail.com, kaartic.sivaraam@gmail.com,
        Johannes.Schindelin@gmx.de, liu.denton@gmail.com,
        pc44800@gmail.com, chriscool@tuxfamily.org, stefanbeller@gmail.com
Subject: Re: [PATCH v2 2/3] submodule: port submodule subcommand 'add' from shell to C
References: <xmqqd01sugrg.fsf@gitster.c.googlers.com> <20201118231331.716110-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <20201118231331.716110-1-jonathantanmy@google.com>
Date:   Thu, 19 Nov 2020 08:44:26 +0100
Message-ID: <871rgprdt1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 19 2020, Jonathan Tan wrote:

>> Whew.
>> 
>> This was way too big to be reviewed in a single sitting.  I do not
>> know offhand if there is a better way to structure the changes into
>> a more digestible pieces to help prevent reviewers from overlooking
>> potential mistakes, though.
>> 
>> Thanks.
>
> I just took a look at this, and one thing that would have helped is if
> you ported the end of the function first in a commit, and work your way
> backwards (in one or more commits).
>
> After reading through the whole thing, I saw that this is mostly a
> straightforward start-to-finish port (besides factoring out code into
> functions), but it would be much easier for reviewers to conceptualize
> and discuss the different parts if they were already divided.

Having done some minor changes to git-submodule.sh recently, I wondered
if we weren't at the point where it would be a nice approach to invert
the C/sh helper relationship.

I.e. write git-submodule.c, which would be the small entry point, it
would then mostly dispatch to a submodule--helper, which would in turn
mostly dispatch to a new submodule--helper-sh (containing most of the
current git-submodule.sh code), which in turn would re-dispatch to the C
submodule--helper (which as an aside, then sometimes calls itself via
process invocation).

It's quite a bit of spaghetti code, but means that there's a straighter
path to porting some of the setup code such as the "--check-writeable",
is_absolute_path() etc. being changed at the start of the change here to
git-submodule.sh.
