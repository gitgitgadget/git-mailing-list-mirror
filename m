Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587FEC77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 20:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344239AbjD0Uk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 16:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjD0Uk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 16:40:26 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9E23C15
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 13:40:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64115e652eeso7824914b3a.0
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682628024; x=1685220024;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5hP2WNtYAXmssONUviSB30kjGyFW+sXTLh30MQ0Y0c=;
        b=Pe8atCYSEBE+seelhq30eJ5KlCuHNQCm4WqwHt/Lqwqbj5/sMu6ClECvFFUkGL/PIE
         PVDlpV6rzdta5PxBxh2esfIw+ZKnlX9f1MnO487WBvFXQfDTMcVCRA0ggdTgdeXE4799
         ohEbWlUMUrXPM9jjAP2YEUpvxHl0RmdF06fa42XKI1kCWm/7oFtFoqI29ZVjCLPnhB/q
         ryYlrArtZbstGLGjyjH7fSzOZGL4fk4ZXmqFsxODAJM7DF3FY3fBcxylkhihavIpDNYz
         R6cnZ+8MEionnAzhMlr05rXDA8ThU32I21kFDzSC9/f+myTBpKlne7+L7ld3fLQ7awij
         2b1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682628024; x=1685220024;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z5hP2WNtYAXmssONUviSB30kjGyFW+sXTLh30MQ0Y0c=;
        b=AYWqP8G8zPHxwHzcYujvz3nsjp1EFG+RUKLtOa9+MCF0SS7Vh+I0/53sIfdy5uS1nC
         JefCC218kbA4+2msyp4RiRiwq/tOOCov10/zUK+pkFVlh0kH+fg0wrLgBgK2/ytqh+61
         cVQ60nJq2kAL1kO7GrJJOvBAo2n3e0I6HedZIv22NTEij1J7/N+oIX64LE4Pq3BuYHkm
         /gkCbYfYtVClKslFOMeLiF1QKf7wkRtR9LvvSU8htSyltUxr6/PFaTM9NTllMT9L0Wef
         4fdlonBykQYiKkHKOfH3OMgG+u5WKvRWpWctTsaRDoJxh/7X4t5OjwPngkC+DfyBGBSD
         ZMYw==
X-Gm-Message-State: AC+VfDwec/sUkg58beubGEe9rc5x57TXJBo7ui9/fVZS1/VzxjhflZQ5
        D6oE6yxouAroQGBnhFawtyQ=
X-Google-Smtp-Source: ACHHUZ7ofBw9WZyKKef+thXd/0lxJ4inWU6HKbHU2qZS5iKpQ+Lh6MrBGX/dbUQq6yWIXWFzlsOJPQ==
X-Received: by 2002:a17:902:ec87:b0:1a2:89eb:3d1a with SMTP id x7-20020a170902ec8700b001a289eb3d1amr3856695plg.6.1682628024490;
        Thu, 27 Apr 2023 13:40:24 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id iy17-20020a170903131100b001a66e81d8fdsm12075075plb.116.2023.04.27.13.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 13:40:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Adam Majer <adamm@zombino.com>
Subject: Re: [PATCH 1/2] http: advertise capabilities when cloning empty repos
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
        <20230426205324.326501-1-sandals@crustytoothpaste.net>
        <20230426205324.326501-2-sandals@crustytoothpaste.net>
        <20230427053016.GD982277@coredump.intra.peff.net>
Date:   Thu, 27 Apr 2023 13:40:23 -0700
In-Reply-To: <20230427053016.GD982277@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 27 Apr 2023 01:30:16 -0400")
Message-ID: <xmqq8redjbyg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I think in this hunk:
>
>> @@ -1379,6 +1381,8 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
>>  			data.no_done = 1;
>>  		head_ref_namespaced(send_ref, &data);
>>  		for_each_namespaced_ref(send_ref, &data);
>> +		if (!data.sent_capabilities && advertise_refs)
>> +			send_ref("capabilities^{}", null_oid(), 0, &data);
>>  		/*
>>  		 * fflush stdout before calling advertise_shallow_grafts because send_ref
>>  		 * uses stdio.
>
> you would want to drop the "&& advertise_refs" bit, after which both of
> the cases above would yield a sha256 repository.

Good suggestion.

>> +test_expect_success 'clone empty SHA-256 repository with protocol v0' '
>> +	rm -fr sha256 &&
>> +	echo sha256 >expected &&
>> +	GIT_TRACE=1 GIT_TRACE_PACKET=1 git -c protocol.version=0 clone "$HTTPD_URL/smart/sha256.git" &&
>> +	git -C sha256 rev-parse --show-object-format >actual &&
>> +	test_cmp actual expected &&
>> +	git ls-remote "$HTTPD_URL/smart/sha256.git" >actual &&
>> +	test_must_be_empty actual
>> +'
>
> This looks reasonable, though I think if we do not need HTTP to
> demonstrate the issue (and I don't think we do), then we should probably
> avoid it, just to get test coverage on platforms that don't support
> HTTP.

HTTP tests tend to be more cumbersome to set up and harder to debug
than the plain vanilla "over the pipe on the same machine"
transport, so I tend to agree with the statement.

They however represent a more common use case, so having HTTP tests
in addition to non-HTTP tests would be nicer, if we can afford to.

Thanks.

