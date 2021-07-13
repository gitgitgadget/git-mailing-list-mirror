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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542FBC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 23:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF1D6136D
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 23:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbhGMXlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 19:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbhGMXlW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 19:41:22 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE94C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 16:38:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id hc15so139402ejc.4
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 16:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3Ycj/aXk5NZWRnOsx7PvVlFQX7QJSbZ2OKNbfKqMg58=;
        b=bboJECXKeHjoHAUEZY31m8rEb22HYdw5ZZzUBwGszZzU563upKVSKoX9O32Q3TPdae
         d4MDCwvXRHS7rS3/1RKk1IMyr1IsOz+OCSzYbLEHyQBxigvj4h6Th51jvbYClX0YRt6F
         ZQhT7cPLzLUjtLxj2Q4pQX2540u5VxZ7UP/donzHI7442PZ8Rnflq7CqnNLbAo/k4NNy
         gXEKr5otmv7rWAve8j4oV5KFnjKJaomnqySdXQ0V3WH8nTORcAYZVCGjmerH+5kMngRo
         8qYXKiDftm74byli8XcnueYIMeYw+SFKYw39K4qXG1IqGWRV/Od5ygoIIHADRX/3oj+S
         Bf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3Ycj/aXk5NZWRnOsx7PvVlFQX7QJSbZ2OKNbfKqMg58=;
        b=IFvApy31m8L/5oy8KZF5V3LUpEubuKOZAEqx+8DKZPFAufNkhgEtVC0kQCIh3XMMY7
         VqjCSsJfCrFyZfuTIBpxpwdseRnQOM25NgrKGYm0EVU63plBvGCQ1CqN78aXKRBAvDqg
         mINuGlaNWeYTDDQ2LtO8Jzfs/dWYqHw2hRfbrayXmSuq8Y8e7z1qdFt0vhTOCcVf35c4
         dyoKEibPloffhnJ4/pm+dUmDuKgnVpaq+zpj+TaBj9eGkdO9KdZ6X0a0qVQ5khrD/KWl
         dXHlmFDpaMpKLfRYgzF6rDvjZCWW03Q0Q0lcHYBfncpLOmQZud3k2ww8NsQe9iFZc0Uk
         lZSQ==
X-Gm-Message-State: AOAM531rnWvZPhYZPV527gD72689ELugfHnsEW8dwDAOLITrIlDj3DPG
        ZGdAT9g3g8SyRjXBLHJpv2A=
X-Google-Smtp-Source: ABdhPJwoa+Cu3ufMekz08bLfsQNGsdubXPIMnFxwN5yVImV3/xl5BE9FDV2lPIX2dY+WkBAovpZYhw==
X-Received: by 2002:a17:906:7946:: with SMTP id l6mr8737278ejo.216.1626219509730;
        Tue, 13 Jul 2021 16:38:29 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g11sm178772edt.85.2021.07.13.16.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 16:38:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] fetch: die on invalid --negotiation-tip hash
Date:   Wed, 14 Jul 2021 01:34:41 +0200
References: <cover.1624486920.git.jonathantanmy@google.com>
 <8df607f4cfb3064200bf4effc91726c92804e637.1624486920.git.jonathantanmy@google.com>
 <YO4Vc58rl2Ble31u@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YO4Vc58rl2Ble31u@google.com>
Message-ID: <878s293htx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 13 2021, Emily Shaffer wrote:

> On Wed, Jun 23, 2021 at 03:30:53PM -0700, Jonathan Tan wrote:
>> 
>> If a full hexadecimal hash is given as a --negotiation-tip to "git
>> fetch", and that hash does not correspond to an object, "git fetch" will
>> segfault if --negotiate-only is given and will silently ignore that hash
>> otherwise. Make these cases fatal errors, just like the case when an
>> invalid ref name or abbreviated hash is given.
>> 
>> While at it, mark the error messages as translatable.
> I don't usually like this kind of "while we're at it" change, but in
> this case it's very very small, so it doesn't bother me much.
>> 
>> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>> ---
>>  builtin/fetch.c  | 4 +++-
>>  t/t5510-fetch.sh | 9 +++++++++
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>> 
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 9191620e50..2c50465cff 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -1428,7 +1428,9 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
>>  		if (!has_glob_specials(s)) {
>>  			struct object_id oid;
>>  			if (get_oid(s, &oid))
>> -				die("%s is not a valid object", s);
>> +				die(_("%s is not a valid object"), s);
>> +			if (!has_object(the_repository, &oid, 0))
>> +				die(_("%s is not a valid object"), s);
> Any reason not to consolidate these, e.g. if (get_oid || !has_object)?
> Then we wouldn't dup the err string.

Generally I'd agree, but aren't we explicitly conflating cases where
something is a valid way no name an object v.s. being certain that such
an object does not exist? I.e. this should be something like:

    if can't get_get():
        error "couldn't get the OID of revision '%s'"
    if can't look up fully-qualified OID:
        error "the OID '%s' does not exist"

Or something...
