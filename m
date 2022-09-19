Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E39EC54EE9
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 11:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiISLsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 07:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiISLsB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 07:48:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F002B245
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 04:48:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id dv25so63736095ejb.12
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 04:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=7YtgfZLg3hF9Q7SCArSNrEx3oNm8zbBlTrzxqR/6wk8=;
        b=XGaPbk4S3W2RJUNzpT0dZak7W5gDdPE6FVT+4u/Ebv4H1KpGT7PSo5MOxs7KxcKOZz
         At1Vv0WOSUteuj9TzfKf4NZrQ8J2G0s56WhWzjZlawQ+Xw2KHh9MflQ52tsnDS1IPND9
         uhhN0CthZOBCDiu9BdDc7uFwfJ3lyKn6YZuiM7TatpEQylcN2C13c/AgSsMO8MTi9Q0t
         e23SntPV5L9POJdejdQ1jDPY9rROr0QXTHZQkEGHtJnnHaZwBfA0PUqfoKFWvtJU79Ah
         6+lr8u3W4jfRo+snKQMm04Xk2W0C3OGw+lcrr2qQaJ9N98dmpYDk+fmtRIx1JX9hekbf
         Q8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=7YtgfZLg3hF9Q7SCArSNrEx3oNm8zbBlTrzxqR/6wk8=;
        b=60GhU1pnpIu/nWy8Z7EShaqiMpOG/tWhQEM57txU2NOs5Rr5W4IVfEBs4KvMLRM9fh
         maM4g53MbVNMkUqn0LhJsUYRmr58pdZO8OfvaWaIP8rgvaf+313gZxUjOl8OkY6HWmSX
         UX4jeSP+ltsQK6nQZalh3St+V6zdtY9hNs3tvgvoMSv3n0Ff7k0R0yLsVKeYLOWt/bnT
         +t8x0eBrJL1RJOF531OoEH7iYrOAlFG1Sw9WYRdNOXelduuNUSUq1dzd9cqrxddxNvrY
         54yfb82oSLW8FagiteELRJxa3JIpX2lnYEfCnKUdBAiTs8i5RLp3jMsaas2JcfVDI0AX
         WJJQ==
X-Gm-Message-State: ACrzQf1Gi/GpRu6ns/VfAnZgtNfKBE952qw1+CxoT/FSG1YklNejcBlW
        YJ4WyFENS8qQlRgvpSmirhU=
X-Google-Smtp-Source: AMsMyM5AzdF8aOKaGJue6rjkliyPLLWCh8q23iVsRHUsj5LweRdAfQ2Dr4lNbwSCnNMkawOo/gsiig==
X-Received: by 2002:a17:906:dc8f:b0:77f:eefe:27e8 with SMTP id cs15-20020a170906dc8f00b0077feefe27e8mr12571571ejc.601.1663588078457;
        Mon, 19 Sep 2022 04:47:58 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f9-20020a17090631c900b0078197a9421csm6528ejf.85.2022.09.19.04.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 04:47:57 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oaFFl-000ctE-0o;
        Mon, 19 Sep 2022 13:47:57 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Florine W. Dekker" <florine@fwdekker.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: Wildcards in mailmap to hide transgender people's deadnames
Date:   Mon, 19 Sep 2022 13:20:13 +0200
References: <2e846a72-a4c6-2a5a-255a-15eee037f574@fwdekker.com>
 <854127f2-55aa-5636-813d-d91b8a4cdcbc@web.de>
 <f13bc5aa-dadd-a895-eeca-79bd77c5363b@fwdekker.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <f13bc5aa-dadd-a895-eeca-79bd77c5363b@fwdekker.com>
Message-ID: <220919.86mtav60wi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 14 2022, Florine W. Dekker wrote:

> On 14/09/2022 09:40, Ren=C3=A9 Scharfe wrote:
>> Am 13.09.22 um 23:53 schrieb Florine W. Dekker:
>>> Now, John can now add the following line to their mailmap config:
>>> `John Doe <john.doe@example.com> <\*.doe@example.com>`, which does
>>> not reveal their old name.
>> That would falsely attribute the work of possible future developers
>> ann.doe@example.com and bob.doe@example.com to John as well.

First, I'm very happy to see that someone has picked up the thread on
this again.

> Good point. I assumed such false positives would be unlikely because I
> was considering very-small-scale projects, but I agree that using=20
> wildcards is not at all feasible for larger projects.

Yes, please, making the mapping fuzzy in any way is really going against
the core design of the mailmap mechanism, it should be unambiguous,
*also* for commits going forward.

>> Supporting hashed entries would allow for a more targeted obfuscation.
>> That was discussed a while ago:
>> https://lore.kernel.org/git/20210103211849.2691287-1-sandals@crustytooth=
paste.net/
>
> That was an interesting read. I agree with =C3=86var in that thread in th=
at
> I think URL encoding is sufficient. I think it meets Brian's use case
> of never having to see the old name again, and my use case of
> obfuscating it from accidental discovery by friendly
> collaborators.

The question that was left open in my mind after that previous
discussion was weather people who wanted the "deadname" feature would
find this acceptable, I don't think we got any explicit ACK/NACK on that
(but I may be misrecalling, and didn't go back & re-read the whole
thing).

I'm happy that there's at least one ACK to it here in the form of your
reply, and hopefully that represents what a wider audience would prefer.

> While a hash certainly gives a stronger sense of
> security, I think it's a false sense of security, because, as you note
> below, recovering old email addresses from the tree is not much more
> trivial than reversing the encoding. And either way, a sha256 hash can
> easily be inverted in a few days(?) using a dictionary attack with
> email addresses from data breaches.

It's going to be "milliseconds", not "days". Brute-forcing a SHA-256 to
find an unknown E-Mail address might take longer, but by definition for
a .mailmap entry you already have both sides.

So "brute-forcing" is just a matter of hashing authors & E-Mails in our
history, and seeing if they correspond to .mailmap entries.

> As someone who has changed her name, I would be content with using a
> simple URL encoding.

I'd be happy to have that as a feature, in particular because (as I
pointed out in the previous discussion) it has a large use-case outside
of this .mailmap topic, namely wanting to map e.g. mis-encoded author
names in past commits to the right encoding (which I've personally had
some use-cases for).

There might be other "bonus" use-cases I've missed. E.g. is ">" or "<"
allowed in obscure E-Mail addresses (maybe within quotes?), our current
parser would barf on it, but being able to URI-encode it would work
around that. I don't know offhand to what extent there's an overlap with
various RFC-pedantic E-Mail addresses one could come up with, and what
we'd accept in commit objects with "fsck".

In any case, I think that an implementation of this & patch to
gitmailmap(5) should explain this sort of feature in those terms. If
some people then find it useful to encode things in the ASCII-space for
some reason (e.g. the social "deadname" reason) that would also be
useful.

But in terms the docs I don't think it should be documented in that
way. Git just needs to provide the feature, we don't need to dictate how
& why someone might use it.

>> [...]
>>     $ git log --format=3D'%ae %aE' |
>>       awk '$1 !=3D $2 && !a[$0] {a[$0] =3D 1; print}' |
>>       grep -F l.s.r@web.de
>>     rene.scharfe@lsrfire.ath.cx l.s.r@web.de
>>
>> The same can be done with names (%an/%aN).
>
> You're absolutely right. With "advanced tools" I was referring to
> anything more advanced than a plain `git log` ;-)

The thing that still makes me a bit nervous on this topic is that we
need to make it really clear that we're *not* providing some promise of
obscuring these values going forward, but just providing a feature that
some people might rely on as a combined social mechanism, and with the
assumption that the defaults of the "git log" view are unlikely to
change.

I.e. I think a "deadname" use-case of this would probably:

* Have some comment at the top of .mailmap about why some values are
  over-encoded (or perhaps it would be obvious to everyone working on
  that repo why someone was encoding the "plain ASCII" A-Za-z0-9 space).

* Use the default "git log" view, where we happen to map these (given
  the right options, config etc.)

But should not:

* Assume that other tools such as "fsck", "check-mailmap" or even "log"
  won't have future features that make de-obscuring these values easier,
  or something that's part of a normal workflow.

  E.g. I've wanted a "fsck for mailmap" for a while, i.e. to scan the
  file, parse our history, and see which entries are redundant or even
  potentially missing (based on e.g. names matching, but having
  different E-Mail addresses).

  It would be hard not to de-obscure URI encoded values for some
  features like that, e.g. if "log" adds the ability to say "this name X
  was mapped from Y".

* In general pretend that the mailmap is anything but a *public* and
  easily readable mapping. It's inherent in the feature that the
  consumer of it will know that X used to be Y.

The last thing we want is to create some feature that effectively ends
up being some self-doxxing (or self-"de-deadnaming"?) mechanism, because
we've left a gap between user expectations and what we can realistically
provide.
