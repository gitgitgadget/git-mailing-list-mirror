Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44273C433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 22:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D3561A0A
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 22:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbhCXWik (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 18:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238830AbhCXWiP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 18:38:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9F2C06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 15:38:14 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id e14so17302172ejz.11
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 15:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=AuXO6kGvyiLLgT1zl2kSkOQsbo7suPgl/jsFyKgstpw=;
        b=Ni++MsTk9Q6sIElQjMM2vGNFtGDwgqQUtwKeC7PnZ/t48m+SK81cwo5nSt0aapUa6U
         yIzUcyIGMJzznzfJdumRgX18vpZqU0p9ewkp7VFttrC88URBZ+Rk2rWRzHsVcZabulDF
         WNxtzO+5cTIT0vgk4d2E85/7bTIALfoHZlgNzaZJoo4Bj/kvWe2hlaPzeCFQE677KrSP
         JS1B87RoH+rwEAL3gt4d1RTmHmmb2OUv8BM9Yhf4U61OhOXZNgRWKouSQdHORJBEweDr
         9hBGzz4R4UIUe6/nYQkQiXa2t8XNxkzOIyOhGJTP5MrtndPbiGJyD6/s3J4l85pcMxNH
         SqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=AuXO6kGvyiLLgT1zl2kSkOQsbo7suPgl/jsFyKgstpw=;
        b=FepQ6ER9J/QRWebD6dR7Pw8erkofnO82Vls/kg+qvM5j92+qFLpEuiTCujiifu24zy
         QmYWL2LhxVH363KlqeQH31qeSpPWL8QiAMu8uO96LqoWVtSA8cjNh6g/BCAcQj+Zqazd
         sdy5ZYGN/HFZPAZHkoWUfI3Z/TnUeRbw9pFJLII7s7eAK4wsEBU17qFArPVAlARO5YAz
         OKXmjRlGbWyzx10iOJMv7lwizs/yhSY0eiyPIgYmhcdrzHDNmyQQtBLTsKi9SlRfw7zB
         cg32Bg4MJznWkx6JmzvswZRsS8xidIhIfUOWzBRbiDbFii8OeIj66vXOf+aBBkMoudyO
         p0rQ==
X-Gm-Message-State: AOAM530eA0KoFu9yctSlITdORhds51/zX4gaYYaLwnKwi8kdKar0hFHS
        aGJMvkw6PQzyr9OacdJBaiY=
X-Google-Smtp-Source: ABdhPJwGyQB5dVtg7a46mLfJWUVYFU74dsQwk8OAqj5XOvpXesb6RI71dJeuoH7DS+9zfR5B9Vg3rw==
X-Received: by 2002:a17:906:9515:: with SMTP id u21mr6221205ejx.86.1616625493598;
        Wed, 24 Mar 2021 15:38:13 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id k9sm1778101edn.68.2021.03.24.15.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 15:38:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 05/37] hook: teach hook.runHookDir
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-6-emilyshaffer@google.com>
 <87im5whitx.fsf@evledraar.gmail.com> <YFuJGG1MUokL4o4i@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YFuJGG1MUokL4o4i@google.com>
Date:   Wed, 24 Mar 2021 23:38:12 +0100
Message-ID: <87o8f8p48b.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 24 2021, Emily Shaffer wrote:

> On Fri, Mar 12, 2021 at 09:33:46AM +0100, =C3=AF=C2=BF=C2=BDvar Arnfj=C3=
=AF=C2=BF=C2=BDr=C3=AF=C2=BF=C2=BD Bjarmason wrote:
>>=20
>>=20
>> On Thu, Mar 11 2021, Emily Shaffer wrote:
>>=20
>> > +	switch (should_run_hookdir) {
>> > +		case HOOKDIR_NO:
>>=20
>> Style: case shouldn't be indented
>
> Done, thanks.
>
>>=20
>> > +			strbuf_addstr(&hookdir_annotation, _(" (will not run)"));
>> > +			break;
>> > +		case HOOKDIR_ERROR:
>> > +			strbuf_addstr(&hookdir_annotation, _(" (will error and not run)"));
>> > +			break;
>> > +		case HOOKDIR_INTERACTIVE:
>> > +			strbuf_addstr(&hookdir_annotation, _(" (will prompt)"));
>> > +			break;
>> > +		case HOOKDIR_WARN:
>> > +			strbuf_addstr(&hookdir_annotation, _(" (will warn but run)"));
>> > +			break;
>> > +		case HOOKDIR_YES:
>> > +		/*
>> > +		 * The default behavior should agree with
>> > +		 * hook.c:configured_hookdir_opt(). HOOKDIR_UNKNOWN should just
>> > +		 * do the default behavior.
>> > +		 */
>> > +		case HOOKDIR_UNKNOWN:
>> > +		default:
>> > +			break;
>>=20
>> We should avoid this sort of translation lego.
>>=20
>> > +	}
>> > +
>> >  	list_for_each(pos, head) {
>> >  		struct hook *item =3D list_entry(pos, struct hook, list);
>> >  		item =3D list_entry(pos, struct hook, list);
>> >  		if (item) {
>> >  			/* Don't translate 'hookdir' - it matches the config */
>> > -			printf("%s: %s\n",
>> > +			printf("%s: %s%s\n",
>>=20
>> native speakers in some languages to read the sentance backwards.
>> Because if you concatenate strings like this you force.
>>=20
>> (We don't currently have a RTL language in po/, still, but let's not
>> create churn for if/when we do if we can help it)>
>
> Yeah, you are absolutely right. I'll take a look at your suggestion,
> thanks.
>
>>=20
>>=20
>> I have a patch on top to fix this, will send it as some general reply of
>> proposed fixup.s
>
> FWIW, I found this format of suggestions really hard to navigate. I had
> to go find your fixup (and I think you sent two different ones) and then
> had to scroll around and find what you're referring to from here. If I
> were to apply the fixup directly, I'd have to split it up and find the
> appropriate commits to associate each part of the diff with. I know
> generating scissors patches for each review is a pain, but I'd even
> prefer a prose "How about printing in each part of the case instead, so
> each string can be translated in full" or a non-formatted example inline
> to the catchall fixups patch you sent.

Sorry about that. FWIW I did try, but found myself jumping a bit too
much between different commits (as noted in some "maybe squash?"
comments elsewhere), and eventually just gave up and produced some
RFC-just-for-discussion patch on top of the whole thing and mostly
looked at the entire diff forthe series.

>>=20
>> >  			       (item->from_hookdir
>> > +	git hook list pre-commit >actual &&
>> > +	# the hookdir annotation is translated
>> > +	test_i18ncmp expected actual
>>=20
>> This (and the rest of test_i18ncmp in this series) can and should just
>> be "test_cmp" or "test_i18ncmp", the poison mode is dead. See my recent
>> patches to search/replace test_i18ncmp.
>>=20
>> The reason the function isn't gone entirely was to help a series like
>> yours in "seen", but if we're re-rolling...
>
> Oh cool, thanks, will do.

