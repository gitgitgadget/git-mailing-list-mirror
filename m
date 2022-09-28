Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAE2C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 20:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiI1UH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 16:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1UHz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 16:07:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122E39551B
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 13:07:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a26so29444239ejc.4
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 13:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=FLBAcVRTCz2j3wxqp2/DvZgyT7TO1uKx7VJMhg2/iJc=;
        b=Bgmy4IuttGGcug65mk3Hztl67BL/U51PfEeq/sdWDJ02he7Bx5mViHyYBhQciopyoK
         yzwt5Ow/xDwSFkxYrQABwc+FZAUkR7vK0Xp6zf2ptUwM+H22kqgBQb41hVSFeZZEP+Ta
         8efKmj2/6CvzUg+1LNKigU+5Hji+RJhNTpNNObXsuey0rhvUy9fFmMXsTjCNjrjoQGot
         kBEoRB3bn7ThvjPX2KUttHulykBmUyzCLKkuj2OPKyzKCLkuJi4U977cLJlBq6aNf1Qt
         J7QtveqKHt33NxoNIdO30Fec40w3HC4Z/IjiSbfe0XdjGaaKgEk3N+Qucx1INM6cEZ1f
         Y8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=FLBAcVRTCz2j3wxqp2/DvZgyT7TO1uKx7VJMhg2/iJc=;
        b=kuB/qo4ijtrt++0n3MeM2WZqperD94LYQo7G03lfYFW0kRFzBewcVuaQimTfMFPK+p
         QigZfio2CFQtbjoIpP0u+jxa1wcqH94qEPdANp7dAv9RhF0/Vfn6T2HbewPdTLKfCwJa
         AMlPwtfHd2NN9jUkncTNasn/YMxlipZ/OYekCpDrRl4kqYmubbaTNBjR83Z2mInXDo0i
         QlH9nKiUd61FhsNZm8iPKfQ+J9Paix4TqK06IYVA0KDm0Z+6dqYqP7ktnajSxsjtJx2F
         dwPnIfHedu5XFsKMSSgiMqEcbb4Rea/Co6yCsoV1OeDtPygHZd7g+z4n3PS8durxq7xB
         DAkA==
X-Gm-Message-State: ACrzQf2vw1mVJcAWqeBcK0o7i/NIzv6A2enuK/kLobyXXTW/WT776AGX
        4Oeq9kSYyrdHjdoVMeht7BsmERLdOJRuwA==
X-Google-Smtp-Source: AMsMyM6HzH7v/PbrEzwwIt6q03mE4sI7j5pOoJBkMj1jR8yRl7HVyHiOWQWMnCIQszTiNSbj9G8JVQ==
X-Received: by 2002:a17:907:6e90:b0:782:a5ef:89a8 with SMTP id sh16-20020a1709076e9000b00782a5ef89a8mr24388553ejc.639.1664395672525;
        Wed, 28 Sep 2022 13:07:52 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id n19-20020aa7c453000000b0045722259584sm3889374edr.86.2022.09.28.13.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 13:07:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oddLT-0015gj-0h;
        Wed, 28 Sep 2022 22:07:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/5] config: return an empty list, not NULL
Date:   Wed, 28 Sep 2022 21:33:44 +0200
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
        <396343ce7dd17f86bbbc66197c6f0b4012caf445.1664287711.git.gitgitgadget@gmail.com>
        <220927.86sfkcyebf.gmgdl@evledraar.gmail.com>
        <b85d8a43-6640-aa9c-3103-0c3d43c2a479@github.com>
        <220927.86k05oy5oi.gmgdl@evledraar.gmail.com>
        <26b3c9ef-5dd7-18f2-89c4-8d210a409ce4@github.com>
        <220928.86y1u3wnaz.gmgdl@evledraar.gmail.com>
        <31ceb36b-3c60-c4c2-c6fb-3f602eb9d4ea@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <31ceb36b-3c60-c4c2-c6fb-3f602eb9d4ea@github.com>
Message-ID: <220928.868rm3w9d4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 28 2022, Derrick Stolee wrote:

> On 9/28/2022 10:37 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Wed, Sep 28 2022, Derrick Stolee wrote:
>
>>> If we return a negative value on an error and the number of matches on
>>> success, then this change could instead be "if (repo_config....() > 0)".
>>=20
>> Hrm, I think you're confusing the worldview your series here is
>> advocating for, and what I'm suggesting as an alternative.
>>=20
>> There isn't any way on "master" to have "an empty list", that's a
>> worldview you're proposing. In particular your 1/5 here removes:
>>=20
>> 	assert(values->nr > 0);
>
> Yes, I think the lack of a key should be the same to an empty list
> because it is logically equivalent and an empty list is safer to use
> than a possibly-NULL list. That's what started this whole investigation.
>
> By no longer returning NULL, we can eliminate an entire class of bugs
> from happening.

This saga was started because this code had a segfault:

	const struct string_list *list =3D git_config_get_value_multi(key);
	for_each_string_list_item(item, list) { ... found =3D 1 ... }

In general I completely agree with you that APIs should be safe by
default, especially when it comes to NULL. E.g. it's *very handy* that
the "buf" member of "struct strbuf" is never NULL.

But I just don't see it in this case, i.e. the alternative once we make
*_multi() act like the rest of the config API is:

	if (!git_config_get_const_value_multi(key, &list))
		for_each_string_list_item(item, list) { ... found =3D 1 ... }

Or, well, in my version:

	if (!git_config_get_const_value_multi(key, &list))
		found =3D unsorted_string_list_has_string(list, maintpath);

But that unsorted_string_list_has_string() pattern could also be used in
the former.

I've found this "if I have this data, then" behavior of the config API
to be very handy & safe to use, we just haven't used it for this one API
entry point.

>> More generally the config format has no notion of "an empty list", if
>> you have a valid key-value pair at all you have a list of ".nr >=3D 1".
>
> The critical part is that you have a return code that has three modes:
>
>  1. Negative: some kind of parsing error happened, such as a malformed
>     'key' parameter.

Critically not "some kind of parsing error", but "malformed key error",
we've already parsed the config itself at this point.

>  2. Zero: The 'key' was found with multiple values.

Well, found at all, maybe it has just one value.

>  3. Positive: The 'key' was not found. (Are there other innocuous
>     errors that fit in this case?)

It's just "not found", nothing else (there's no "return 2;" etc).

But in terms of simple API use if your key is a constant string
(i.e. the ones where we hardcode the key in the C source) we just need
to handle cases #2 and #3, hence why I added that _*const_value_multi()
wrapper.

Of course it's possible to get an error on
git_config_get_const_value_multi("mal.formed.key.", but we'd BUG() out
on that in development, and once we test it once we know the hardcoded
key is valid. So as an API it makes sense not to worry about it, but
just BUG() out.

You only need to handle this "malformed key" case on runtime in
git-config(1) itself, and e.g. "git for-each-repo --config=3D<key>", where
we get the key from the user

> This "positive means not found" is very non-obvious.

Is it? I find it quite idiomatic in C, but yeah, it would be odd in some
other contexts and/or languages.

In this case though every other function in the config API works that
way, i.e.:

	git grep 'if \(!.*config_get_'

So whatever our desires if it were a clean-room API (where a key
existing might return 1), surely consistency would win out at this
point.

> Even with your goal of exposing those parsing errors when the 'key' is
> user-supplied, I still think it would be better to provide a non-NULL
> empty string_list and only care about these return values:
>
>  1. Negative: some kind of parsing error happened.
>
>  2. Nonnegative: parsing succeeded. The string_list has all found values
>     (might be empty) and the return value is equal to the string_list's
>     'nr' member.

Can you show me how this sort of thing would look in your proposal:

	int bool;
        const struct string_list *list;
        int found =3D 0;

	if (!git_config_get_const_value_multi("a.list", &list))
		found =3D unsorted_string_list_has_string(list, "needle");
	if (!git_config_get_bool("a.bool", &bool))
		if (bool) ...;

AFAICT that would be:

	int bool;
        const struct string_list *list =3D git_config_get_value_multi("a.li=
st");
        int found =3D unsorted_string_list_has_string(list, "needle");

	if (!git_config_get_bool("a.bool", &bool))
		if (bool) ...;

I find it unintuitive to make it act differently just because it's a
collection, so we can get away with basically stuffing the "existed?" in
the value itself (as .nr =3D=3D 0).

> In these cases, I see two modes of use.
>
> First, check for an error and exit early (empty list no-ops naturally):
>
> 	if (git_config_get_const_value_multi(key, &list) < 0)
> 		return -1;

No, the _*const_value_multi() never returns < 0, that's a BUG(). So we
don't worry about that for the common case.

At the tip of my branch for this gc, log, versioncmp etc. all use that.

Which means that this right after:

> 	for_each_string_list_item(item, list) {
> 		...
> 	}

Would be an error, we'd have a NULL list if we got a return value of 1,
but the common case is:

	if (!git_config_get_const_value_multi(key, &list) {
		struct string_list_item *item;

		for_each_string_list_item(item, list) ...
	}

> Second, ignore errors. Care about non-empty list:
>
> 	if (git_config_get_const_value_multi("known.key", &list) > 0) {
> 		...
> 	}

Since that's the *_const_value_multi() not > 0, just "!fn()" will do,
since it's 0 or 1.

> But this is just a matter of taste at this point, and I'm getting the
> feeling that my taste for reducing the chances of NULL references is
> not very popular.

It's very popular with me :)

I just don't see how it's needed in *this case*, since we can entirely
sidestep the need for a dangerous NULL value by making it act like the
rest of the API.

 think the reason the bug in [1] happened is exactly because
git_config_get_value_multi(key) currently acts in a way where you need
to explicitly remember to handle the NULL, *and* if you forget to do so
it's easy to have it work.

I.e. in your (initial buggy) version:

	const struct string_list *list =3D git_config_get_value_multi(key);

	for_each_string_list_item(item, list) { /* boom, "list" can be null */

The problem being that you can easily write that idiomatically, have it
work in development (because you test with that in your config), and
then it blows up if you don't have that config.

But that's exactly why I think the rest of the config API is well
designed, because as soon as you need to write that as:

	const struct string_list *list;

	if (!git_config_get_const_value_multi(key, &list))
		for_each_string_list_item(item, list) { /* "list" can't be null /*

You're forced to structure your code in such a way that you can't really
forget the implicit NULL check, because to make use of the API at all
you need an "if I have the data, then..." block.

1. https://lore.kernel.org/git/8a8bffaec89e55da0c5bcac2f04331e0d4e69790.166=
4218087.git.gitgitgadget@gmail.com/
