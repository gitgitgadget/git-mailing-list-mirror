Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FEEC38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 20:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbiJZUrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 16:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbiJZUrd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 16:47:33 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347DA10A7C5
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 13:47:32 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r14so43625246edc.7
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 13:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gi24mpHLSjtQgl6u3VrSW0gSGdy7KqC2VqLmHMMsqrc=;
        b=Gca9B9+ej8VDQV1z/zS1csPDI9aYUFDpONylmilyoc0BBJIjs4fNN9JjZM5tgcMOhx
         c/bM3EgfSx4nFiXsUQAVniz6TwhmVhML+iv1Kebnvr4bAdeiD7FBBIC7YNK+NOIIuqzj
         ReKmj1yRaw6uYzTHIcr9mJzogycsN5+VgnbaS+E+U5+3MWK2VSVJVNvSxsz8+sP0e63N
         IKeBJkSTGwm66F+gbQDMN+QyhVLd3yw8okSfd3rgrBo7/c2AvadyQUfE/afkfMScFfmt
         zpYudhZYaBKosfsieHR0EL+mG46BaDwLFFdhjoe3RfgG0K/keMShg7sW5CRSC0kjf7W7
         TzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gi24mpHLSjtQgl6u3VrSW0gSGdy7KqC2VqLmHMMsqrc=;
        b=2kpaGQK0Ba7k1fg8E50ruCAxlVc+OCZm1bbjzGOO1rqf2eD+pWt9I6PDdXuyMwV6kY
         EbOmzBip3OYkJPRAqVce+1nKP5xUSAzm4xkUkMYpxR/fs7APt92FDKOEcCJYDKYoD+Jb
         zRpDdBeUbiciVxBkLoWElUVWxXqskqfN/vN+ymdFSsa5PzlbXCzwbjqT31/oRIX8lwhl
         GaWuxtG09WzoQjsrKs1m3Paz71ug0oXuSQ71YiWKrgtET1JD0ydvQ6sjVwTCVcb8Y1UT
         sdTsapCnDG6HFXzE5MEuI5TRywnG8Oc+RXeseObZT1PaWaKpfk+ztDU9+n1d2bX4rhBx
         N1bQ==
X-Gm-Message-State: ACrzQf2nAwCdxaYgGsnnBy8aOhtRlh5+bUuql//+M5xSvEFh/7YEd8Dz
        zY7y/7z+V7LS6cPjDNNXyRE=
X-Google-Smtp-Source: AMsMyM51FdgzOQQrkviZy47yDFphHAKKL8Za/k6oDoSJTNfDbOGJcZFZzdZzABzCc5ZpoV0d+Ca/0A==
X-Received: by 2002:a05:6402:191:b0:45c:83e8:d74a with SMTP id r17-20020a056402019100b0045c83e8d74amr41102275edv.329.1666817250737;
        Wed, 26 Oct 2022 13:47:30 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ga36-20020a1709070c2400b0073c10031dc9sm3529675ejc.80.2022.10.26.13.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:47:30 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1onnJB-008uIC-1o;
        Wed, 26 Oct 2022 22:47:29 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 3/3] Makefile: simplify $(test_bindir_programs) rule
 by splitting it up
Date:   Wed, 26 Oct 2022 22:43:50 +0200
References: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
 <patch-v2-3.3-400f487e30d-20221026T143534Z-avarab@gmail.com>
 <xmqqr0yuh144.fsf@gitster.g> <221026.86tu3qbd03.gmgdl@evledraar.gmail.com>
 <xmqq5yg6gwhs.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqq5yg6gwhs.fsf@gitster.g>
Message-ID: <221026.86h6zqb9cu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 26 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Are you asking if "define"'s execute in some context outside the purview
>> of rules, so that if you $(call) one from within a rule and it errors,
>> that we won't clean up the file?
>
> Not at all.
>
> I was wondering why the defined sequance does not end in
>
> 	...
> 	<$> >$@+ && \
> 	chmod +x $@+ && \
> 	mv $@+ $@
>
> like many other command sequences in the Makefile.  As I said, I did
> remember we had discussed delete-on-error; I just didn't recall if
> we do depend on it already.

Ah! For the purposes of this patch the actual answer to that is that
it's just moving existing code around.

So this happens to be the pattern we should prefer with
.DELETE_ON_ERROR before & after 3/3.

But if it was doing that "$@+ $@" mv dance I'd have just blindly
retained that too, to avoid "while at it" and all that...

The code I touched in 1/3 uses the "mv $@+ $@" for no good
post-.DELETE_ON_ERROR reason, but I just left that in place as-is...

>> I can drop them, FWIW I've found it quite handy to add these to ad-hoc
>> debug templates. E.g. you can run:
>>=20=09
>> 	$ make -f /dev/null -E '$(eval $(file <Makefile))' -E '$(error $(call b=
in_wrappers_template,a,b,c,d))'
>> 	make: ***=20
>> 	## bin_wrappers_template
>> 	# 1 =3D a
>> 	# 2 =3D b
>> 	# 3 =3D c
>> 	# 4 =3D d
>
> OK.  That use pattern was what I was missing.
>> ...
>> So you see what the parameters expand to. Maybe just changing the
>> heading to:
>>
>> 	## bin_wrappers_template: $(1..N) below for manual "$(error $(call ..."=
 deubgging
>
> Yeah, it would be totally useless without such an instruction.

Will update it with that.
