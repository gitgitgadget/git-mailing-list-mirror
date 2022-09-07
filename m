Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713CAC38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 22:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiIGWH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 18:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIGWH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 18:07:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D375795AD3
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 15:07:23 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d12so15929859plr.6
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 15:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=dnvo+8vJYoMruXbF5lmNk1tQfjvp201YNPNOmtmv6l0=;
        b=lY65PNF4UoRIHP91DeNyoPDO8mPnUbvkkpuLmsPA9/31nNCdBjpMtqp4XhkmdFzlGq
         PjMAu8CIT31M13tj9Th3QcRjndSkHzbobOoLh0vITMqqQ2XcsW0mZ3vSkkrCuPcCgrbv
         6hZSfTmdjX/uBL3BAI47TdeM7KjdtXXD+PxPhMI4/SmgJ075Rbtw/A1PJ0fMDmNDClHR
         eERPEsl7NnVI34h2Z1Ms21zMmPbLeG6V+yPhqB1W1Ksts0jP8RjxX7ihVY8VE4FLg6X2
         VNOWQy55RtnQbRtZd0QAKNjr6sUukv56ucg8o/2pk0p/0rYKoV6KE9Y1ZTlw2hm5fW2j
         VMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=dnvo+8vJYoMruXbF5lmNk1tQfjvp201YNPNOmtmv6l0=;
        b=YJybv7wXgKcK6G/lFlW5Wn9rsG4S48iCvi3r1Lc/Cf/5i5c9rvywqc+DPv/c5COHtS
         0SSOz7xBNdytMqUVXmLPsiZ0qhjwT38d7SnnI/GWBCS17aPbkE2mGXe/wvmLWncv8yS+
         Jv4V0nSf6HI+FWzBAhxH7rkOz0zr7mpO76R3fWmgXMifekssxwo4qK1LbOWq3nBQOgpD
         XFdpXGt5nQubtJKPNOf8cZ27sDIT/T7rApqccAxM0iGfZIBQBD5LEazZkhO/AbEpzNOQ
         CSbtwnTn73bTFM23QIksUtAskRM9jGkL5rO7VuR2gjFbaMOnP0uEpu7u5csnS6/QWOEC
         SZIA==
X-Gm-Message-State: ACgBeo0hooiBhlXqrNeB9xAYuC7iMALe7qZhQIOW1NyeUd5msyc2/vQj
        wjvj5rQQt96U+tDciDKfZQw=
X-Google-Smtp-Source: AA6agR40FxRaL9gb2r8EgQD6GbJC0SdANesYZz8pXVcUozgYAGNM+UTZ/QqIOTDG3eF6PiTlpExC3g==
X-Received: by 2002:a17:90b:1d01:b0:202:6634:996b with SMTP id on1-20020a17090b1d0100b002026634996bmr443691pjb.14.1662588443253;
        Wed, 07 Sep 2022 15:07:23 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902ccc400b00172c7a2c662sm12792420ple.48.2022.09.07.15.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 15:07:22 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        Xin7 Ma =?utf-8?B?6ams6ZGr?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ?= =?utf-8?B?5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: Re: [PATCH 2/3] upload-pack: skip parse-object re-hashing of "want"
 objects
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
        <YxfSRkEiiP4TyZTM@coredump.intra.peff.net>
        <xmqq1qsnugsu.fsf@gitster.g>
        <YxkAxutS+B8//0WF@coredump.intra.peff.net>
        <YxkG3A30vNfu55Sx@coredump.intra.peff.net>
Date:   Wed, 07 Sep 2022 15:07:22 -0700
In-Reply-To: <YxkG3A30vNfu55Sx@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 7 Sep 2022 17:02:20 -0400")
Message-ID: <xmqq8rmususl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] t1060: check partial clone of misnamed blob
>
> A recent commit (upload-pack: skip parse-object re-hashing of "want"
> objects, 2022-09-06) loosened the behavior of upload-pack so that it
> does not verify the sha1 of objects it receives directly via "want"
> requests. The existing corruption tests in t1060 aren't affected by
> this: the corruptions are blobs reachable from commits, and the client
> requests the commits.
>
> The more interesting case here is a partial clone, where the client will
> directly ask for the corrupted blob when it does an on-demand fetch of
> the filtered object. And that is not covered at all, so let's add a
> test.
>
> It's important here that we use the "misnamed" corruption and not
> "bit-error". The latter is sufficiently corrupted that upload-pack
> cannot even figure out the type of the object, so it bails identically
> both before and after the recent change. But with "misnamed", with the
> hash-checks enabled it sees the problem (though the error messages are a
> bit confusing because of the inability to create a "struct object" to
> store the flags):

Makes sense.

>   error: hash mismatch d95f3ad14dee633a758d2e331151e950dd13e4ed
>   fatal: git upload-pack: not our ref d95f3ad14dee633a758d2e331151e950dd13e4ed
>   fatal: remote error: upload-pack: not our ref d95f3ad14dee633a758d2e331151e950dd13e4ed
>
> After the change to skip the hash check, the server side happily sends
> the bogus object, but the client correctly realizes that it did not get
> the necessary data:
>
>   remote: Enumerating objects: 1, done.
>   remote: Counting objects: 100% (1/1), done.
>   remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
>   Receiving objects: 100% (1/1), 49 bytes | 49.00 KiB/s, done.
>   fatal: bad revision 'd95f3ad14dee633a758d2e331151e950dd13e4ed'
>   error: [...]/misnamed did not send all necessary objects
>
> which is exactly what we expect to happen.

Thanks.  Let's queue it on top.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t1060-object-corruption.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
> index 5b8e47e346..35261afc9d 100755
> --- a/t/t1060-object-corruption.sh
> +++ b/t/t1060-object-corruption.sh
> @@ -139,4 +139,11 @@ test_expect_success 'internal tree objects are not "missing"' '
>  	)
>  '
>  
> +test_expect_success 'partial clone of corrupted repository' '
> +	test_config -C misnamed uploadpack.allowFilter true &&
> +	git clone --no-local --no-checkout --filter=blob:none \
> +		misnamed corrupt-partial && \
> +	test_must_fail git -C corrupt-partial checkout --force
> +'
> +
>  test_done
