Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED1FC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 00:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA78603E5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 00:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbhIMAmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 20:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhIMAmt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 20:42:49 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55400C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 17:41:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kt8so17131133ejb.13
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 17:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=2MfvQLFlr4TS9Bid2JQVNpys2pFYsVXEYnLB5BGU2ZI=;
        b=BH3mAQGgMURtANqDogWmRoLM1sKSUW3l4icbXfe32Y1qeaKoeP3La7J5Vj2k1CGI8Q
         gqG+5COXa2dm57PvzHgua1pwpHhx3tbb/k3b5WozzJz90x3wU4yV00yHRwcwh+K3D226
         rFFSSqPrW3J9F68X3MA2Adgamz/lxWfnbm0pgLpLj+KVAMkeV1irBxtx0maGQ8Dw8spl
         /8dKZocD74IU24HJb79dtbw1hjyMcVfRVeZMLo7Rfx5QvgVmNRFIrVgSlNZK6VlvStdx
         F/l5kmnhle88mrUP1KDA4DVWdxWsbP40D/6DUB6OO8mzG/a5EVoCzwSqa6UhH69n54Xi
         MMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=2MfvQLFlr4TS9Bid2JQVNpys2pFYsVXEYnLB5BGU2ZI=;
        b=Q4JmY4uSEymW3mV3scKf60i1Af4ltsiX1AGddpnVtkaj7Gqzsttp5GxE53EtVkPTQN
         zOvu7sCy8IkTvhG2f130g/A9gCwlqI3GVq+CQR3NfAgLscqMcpXVtZhRaBtiz2OkU/2+
         NYRmNeKbcfY5EYjlb/opr26gnoNEvUP4oMQgzW8ZQ3vqAJjsBTz6ZN/UehD0rSthGNGr
         3uI+kTiABNbJM8+G//5TUnxL/+VDCcR0qkBkxR9wnT4UXkccbvXL38WxvXpCOsDQraNM
         oycEPAQgyW89yDV048vq0YBpq6n/vth0ADqJtzbw+se/X3g3KQ9Acwb+3Z9BKj7I/efC
         Oreg==
X-Gm-Message-State: AOAM533GflODptSr90ozfligXZKRPhJ2BOtm4vCf3ez7Gz01YKe2SGRB
        vuvvQqatLiaRI+y6pCX+K+o=
X-Google-Smtp-Source: ABdhPJygGB7a3kDkQJ9n1kA6Vee9hz5RKVdURVB+wy6Z/qd3aMa3zKI9ybaLqzTZZxpc/uXWEVim+g==
X-Received: by 2002:a17:906:901:: with SMTP id i1mr10070732ejd.248.1631493692874;
        Sun, 12 Sep 2021 17:41:32 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n25sm1204254eda.95.2021.09.12.17.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 17:41:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/6] parse-options: stop supporting "" in the
 usagestr array
Date:   Mon, 13 Sep 2021 02:21:33 +0200
References: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
 <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
 <patch-v3-3.6-e23a8231f38-20210911T190239Z-avarab@gmail.com>
 <xmqqpmtdjuqj.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqpmtdjuqj.fsf@gitster.g>
Message-ID: <878s015mtg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 12 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
>> index ad4746d899a..2910874ece5 100755
>> --- a/t/t0040-parse-options.sh
>> +++ b/t/t0040-parse-options.sh
>> @@ -10,8 +10,6 @@ test_description=3D'our own option parser'
>>  cat >expect <<\EOF
>>  usage: test-tool parse-options <options>
>>=20=20
>> -    A helper function for the parse-options API.
>> -
>>      --yes                 get a boolean
>>      -D, --no-doubt        begins with 'no-'
>>      -B, --no-fear         be brave
>
> Isn't this, and a lot more importantly the next one ...
>
>> diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.=
sh
>> index b29563fc997..6badc650d64 100755
>> --- a/t/t1502-rev-parse-parseopt.sh
>> +++ b/t/t1502-rev-parse-parseopt.sh
>> @@ -6,8 +6,6 @@ test_description=3D'test git rev-parse --parseopt'
>>  test_expect_success 'setup optionspec' '
>>  	sed -e "s/^|//" >optionspec <<\EOF
>>  |some-command [options] <args>...
>> -|
>> -|some-command does foo and bar!
>>  |--
>>  |h,help    show the help
>>  |
>
> ... coalmine canaries that tell us that end-user's scripts using the
> "git rev-parse --parseopt" in the documented way will be broken?
>
> I'd rather not have to sorry about breaking end-user scripts this
> way.  Unlike a very small number of in-tree parse_options() call in
> C programs, we have unbounded of them.

I re-rolled this in v4 to not change how the function works at all:
https://lore.kernel.org/git/cover-v4-0.4-00000000000-20210912T235347Z-avara=
b@gmail.com/

I do think we're going above & beyond what's reasonable in maintaining
these interfaces, i.e. per 21d47835386 (Add a parseopt mode to
git-rev-parse to bring parse-options to shell scripts., 2007-11-04) I
don't think anyone thought that interface would be used outside of
git.git.

But then perhaps I'm wrong, or it has been, and since we ended up
sticking it in rev-parse which was marked as plumbing we can't change
how it or the underlying C APIs it relies on work.

In practice I doubt it would break things for anyone, but per the result
of the discussion to "remove dead shell code" [1] I don't think I'll get
anywhere with that.

I do think that getting some answer to [2] & how we think about the
likes of "git rev-parse --parseopt" going forward would be very
useful.

I.e. would you be OK with us marking these as deprecated / warn on their
out-of-tree use? If so we could after some time remove a lot of code &
simplify things once the last in-tree shellscript user goes away.

Or if we don't see that they can ever be changed that's also useful to
know (and per [2] I think I'd feel obligated to send in a revert
bringing git-parse-remote back).

1. https://lore.kernel.org/git/cover-v3-0.4-00000000000-20210911T111435Z-av=
arab@gmail.com/
2. https://lore.kernel.org/git/87tuiwjfvi.fsf@evledraar.gmail.com/
