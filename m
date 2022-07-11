Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0292FC433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 11:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiGKLZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiGKLZS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 07:25:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4461B655BA
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 03:57:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w12so5003564edd.13
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 03:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dbUyMyY0VXMfTuF80NXCme4mmp0hbrGlDQme1FFBpXo=;
        b=XO+WIegmA0tkITBgbWuSqQo3QgAsjAkaUZeq4xpTpKmhrha2w/mTXijjT0jfbTQJm1
         CGb5hKzkY1xhYECnXcOhsavR8ccxzFDFLdHGLbLhUXPEnAj+YXEddpX0OMhYNQEkLrtx
         slPJsNtkuqowvui+2xliIcqLGnUCeBao2eu/Xf/Gc2HYAwvBK7uUNFU7q/TkoTYi6c4/
         3ipTCkGYa9DAWASMWJrS3kuut9gR0cTSjfRyJSGYKMbtjLMBh4tv3T6p2bjCwRlImuzq
         LT3E+ZZiF7/g6OZhxklPnjb9nlA2/Mx7Rd2ntVX6OzocDBgqTETgROG5Ni5F2JMhdhkF
         6cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dbUyMyY0VXMfTuF80NXCme4mmp0hbrGlDQme1FFBpXo=;
        b=PMkK4SXaLKJQo2cZazTm2oGayK8YIC9SMQQAs9nWDruOl/dtwcmsxiK+M6IIxK4MA5
         Wnow3IJ20a/K/3EL4CEONqocpvwM2tL7JmdhWBe/Fb8f+gX4YUIHAocI519Rj3wvKzz9
         P9XweTiVJQ3318TnX/P5XBqUn3Opy4mt/QW1FAFt+/8tb7faBMf8jSdAit3kExbzkamu
         pAhbCsmOOxnJhNLG6gsjmjJFuN4iYa78fSHXPRfBhtBW9GJfqNT13fXcdnZV5al/bxNK
         r9svqR77WRspGZn8mcBbVm7SjvnQEHPwZNxzdnzgDPIGf+H/WJfx9ho7h8oTYuTjMzMe
         kZ5A==
X-Gm-Message-State: AJIora/rwPx5uLcVgt72b/Xzq+NfBS1aQnDnRkPgOqCVdp4lOm7w6MlJ
        SjKq/ryZLEWKs77qug3AjkMsJZRxmqE=
X-Google-Smtp-Source: AGRyM1vf/Y4avL9eSq4Q4OSVF60AMwOQF+6pUkcMQTHtvGUNROP4I9+O2cAATPYXEF+d0VlfSejezw==
X-Received: by 2002:a05:6402:51ce:b0:43a:d409:b3e8 with SMTP id r14-20020a05640251ce00b0043ad409b3e8mr6211674edd.166.1657537031645;
        Mon, 11 Jul 2022 03:57:11 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g8-20020a056402114800b0043a587eb95dsm4144483edw.5.2022.07.11.03.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:57:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oAr6E-000n7R-1h;
        Mon, 11 Jul 2022 12:57:10 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/6] add and apply a rule to find "unused" init+free
Date:   Mon, 11 Jul 2022 12:54:03 +0200
References: <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com>
 <cover-v4-0.6-00000000000-20220705T134033Z-avarab@gmail.com>
 <YsvwLIfjZffUWOP/@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YsvwLIfjZffUWOP/@coredump.intra.peff.net>
Message-ID: <220711.86wncj7w8p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 11 2022, Jeff King wrote:

> On Tue, Jul 05, 2022 at 03:46:54PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> This series adds a coccinelle rule to find and remove code where the
>> only reference to a variable in a given function is to malloc() &
>> free() it, where "malloc" and "free" also match
>> "strbuf_init/strbuf_release", and then later in the series anything
>> that looks like a init/free pattern.
>
> As before, I'm perfectly happy with the actual transformations here.

Thanks!

>> Changes since v3[1]
>>=20
>>  * Add a "coccicheck-test" target in an early and new patch, the
>>    structure mirrors that of coccinelle.git's own tests. As the
>>    diffstat shows we have a *.c and *.res file which is C code
>>    before/after a *.cocci rule is applied.
>
> I have mixed feelings on this. I'm not opposed per se, and I even like
> the fact that it provides examples of what we expect a rule to do. But I
> worry about a world where the cost of using coccinelle goes up because
> now transformations need to have tests along with them. The idea of
> cocci is to make your life a little simpler and more efficient when
> fixing up the code base (as opposed to perl, etc).

That's fair, and I suppose we could add some really complex tests that
e.g. include the original headers.

But right now these just work on stand-alone *.c files with no includes,
and the runtime is thus trivial. So I thought it was OK to run it along
with the main job.

> But if it comes with a bunch of boilerplate tasks, that might no
> longer be the case. I'm already often on the fence about using cocci
> just because of the hours I've sunk into debugging and puzzling things
> out.
>
> I dunno. Maybe the bar is higher for stuff like this that we expect to
> continue to find problems as time goes on (because it is not "here is a
> transition", but "this is a common and easy mistake to make").
>
> So again, I'm not really opposed to this patch in particular, but I want
> to express caution at the direction we might be going, and at applying
> new rules over-zealously.

Yeah, we definitely need to be more careful with "ongoing" rules like
these, but hopefully between the tests & lack of false positives this
one looks sane...

>>  * We now catch init/reset patterns as well as init/release fully
>>    (i.e. for the "struct strbuf" early on)
>
> Yeah, that makes sense.
>
> -Peff

