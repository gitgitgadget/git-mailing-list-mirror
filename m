Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434EEC05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 02:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjBICGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 21:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjBICF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 21:05:59 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D62A25973
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 18:05:58 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id x10so667640pgx.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 18:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzfXWOdo1KIBzy4SWIya38z0LYd6tvLZRvLlMtq7v3Q=;
        b=fL/5ZJlKiHYsG++t0nsJ4kBilEUy2dU4LEqCxwEcbId2kVMEWdEBUvivSH5rWntbqN
         IeSH7HSvFJPGUKRqhRhMyY5KUtNvFvmuI5awfMmCIdlDuDvta6WdDtlE7Sjp8X9uHnS7
         n1OSRp6rszpk7OBMOJp59fHW+mDnFBgkxoJfQh1Ds3wsRhP3wEoNQMF5NULxSrScH4na
         asNkNtLNZjdHfMN7X1NZm3ZLaM3pXmSq4kfA18AB13aXA1roq/uVf+Safa2owqCUVXp7
         n0TCP8XJpMRZdCfa0Y5A37mG+uIEgUI/pX9oSwJePneiQ0k7J1vrMRMr1Jz7I90sxCFu
         SW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HzfXWOdo1KIBzy4SWIya38z0LYd6tvLZRvLlMtq7v3Q=;
        b=Dp7soXna0T7QRxSGkzgOp9oLX1WghKm84gRBftOBm8DNTrLXixA/bW3NNhIaxRqiVO
         dE3AtWV2bOu6Lcok5tFrs/mfvUyG4m6XEh2LTYJW+kDbGoXspR/VqHZb7dAlqNuyRqtX
         Bc/jzgBQzLiRJdCUCDIFAZQnzddLQP5ymwP8cjmXvpn+ZOkIWfDKzZW3O5igmuuYWC3e
         IC8KAeBnPGsXtHQSGyJazLmTAwQp9J14y7bDZu97aN6AQoTK1yJ9SSNFy8vm56siguIP
         ILAWkQUzGX1bIu3s4gkqu3EqDKCZxQuQCHUoFXH5873YopwJRPgc7QrxKINXndBvelxv
         68jg==
X-Gm-Message-State: AO0yUKWZAaMBQu4a6mqrV7y/0Wdepug2pmALGTLcHtHUA9Uh4dYM0il0
        dP6d4AF6uNkKTySGfAKxQM4=
X-Google-Smtp-Source: AK7set+gi4TaPnwOzDG4MaDEBvdLyneRH4b2zpU2WWq+Tnju3ktb3BrkHktQnlYsVRsVS5ORHMvgUA==
X-Received: by 2002:a62:7904:0:b0:5a8:4861:af80 with SMTP id u4-20020a627904000000b005a84861af80mr3694021pfc.20.1675908357883;
        Wed, 08 Feb 2023 18:05:57 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id w3-20020aa78583000000b0059242cd5469sm130389pfn.13.2023.02.08.18.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 18:05:57 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Max Gautier <max.gautier@redhat.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] gpg-interface: lazily initialize and read the
 configuration
References: <Y+PGRaiTTaZ/DtlJ@work-laptop-max>
        <Y+PRTYtFDoE73XEM@coredump.intra.peff.net>
        <xmqqmt5orqgv.fsf@gitster.g> <xmqqh6vwrpce.fsf@gitster.g>
        <xmqqlel7rj9z.fsf_-_@gitster.g>
        <230209.86fsbfznot.gmgdl@evledraar.gmail.com>
Date:   Wed, 08 Feb 2023 18:05:57 -0800
In-Reply-To: <230209.86fsbfznot.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 09 Feb 2023 01:17:39 +0100")
Message-ID: <xmqq5ycbpp8a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> One thing left un-noted here is that this will defer any errors in the
> config now until use (or lazy init), so e.g.:
>
> 	git -c gpg.mintrustlevel=bad show --show-signature
>
> Used to exit with code 128 and an error, but will now (at least for me)
> proceed to run show successfully.

That one is probably a good thing.  We shouldn't interrupt users for
a misspelt configuration value that the user is not using.

>> @@ -632,6 +644,8 @@ int check_signature(struct signature_check *sigc,
>>  	struct gpg_format *fmt;
>>  	int status;
>>  
>> +	gpg_interface_lazy_init();
>> +
>>  	sigc->result = 'N';
>>  	sigc->trust_level = -1;
>
> This is needed, because we need "configured_min_trust_level" populated.

I specifically did not want anybody to start doing this line of
analysis, because it will add unnecessary bugs, and also introduce
maintenance problems.  You may be able to grab the current state of
the code, but that will get stale and won't be a good guide to keep
our code robust.

>> @@ -695,11 +709,13 @@ int parse_signature(const char *buf, size_t size, struct strbuf *payload, struct
>>  
>>  void set_signing_key(const char *key)
>>  {
>> +	gpg_interface_lazy_init();
>> +
>>  	free(configured_signing_key);
>>  	configured_signing_key = xstrdup(key);
>>  }
>
> But this is not, we could say that we're doing it for good measure, but
> it's hard to imagine a scenario where we would end up actually needing
> lazy init here. we'll just set a variable here, which...

And especially this one, we must have init or we'll be incorrect, I
think.  There is a direct set_signing_key() caller (I think in "git
tag") that does not come from the git_config() callback route.
Without the lazy initialization, we'd get configured_signing_key
from the config because early in the start-up sequence of the
command we would do git_gpg_config() via git_config(), and then try
to process "-u keyid" by calling this one again.

If you forget to lazily initialize here, configured_signing_key gets
the keyid obtained via "-u keyid", and then when control reaches the
real signing function, we'd realize that we still haven't
initialized ourselves.  And we call lazy init, which finds
configured keyID, which is very likely different from "-u keyid"
(the user would not be passing "-u keyid" from the command line to
override, if that is the same as the configured one), and clobber
it.

Thanks.
