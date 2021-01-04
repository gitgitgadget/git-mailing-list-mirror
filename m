Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55DFC43381
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 16:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B89E20674
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 16:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbhADQLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 11:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbhADQLl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 11:11:41 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA9EC061574
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 08:11:00 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id w1so37445200ejf.11
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 08:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4THRXGFrW9OjpmuXq8vh7M1B+tcL65WUBEqJlVCloWM=;
        b=VDP6jdIeRly7TjDSkj4aMzxtduI2je6cgTjESy10zM9JmlWjCeO2w9u7PYcJ43xsMo
         ZVO1YNGbe8knTI8fvy5mzTwcCOgqWU0yw+O2zwpe9bG+oq/FAuYQmOG6AlVGXISDFwqN
         eODGQ5lIhrqu6yPP2Dfw9CJS7g5wCeauC5dMKBalJllaSFEEnDBRYHfkKeZfpUcruMsY
         H84vABgr8mOf8TRLDwQ32uKUfnNx8XrZwgRl6g1n2CaHXIPcAkoxJiJtSrzBRSa1Jz8d
         GNr/9QLH4t7FQV6gwTUlnlXGEGpWh/mt+viAKBQgn9YH/HPrBOIYt/4fRQt2GCpO8eiq
         Sm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=4THRXGFrW9OjpmuXq8vh7M1B+tcL65WUBEqJlVCloWM=;
        b=l8/Ci3stJQPpT8KBblVw6+2cswHH6SaoI2SaM654VliyLZOINsbdTbzBHMx4qbwP44
         1l/XkLUEPy04pAlWEKn10vK9eX4XE0f+jdYAx6lVpNcc9azN724oQqdZ86PfW6EF1+RY
         MS0UFXpf/YAfvobbt6Yb+p/mTPSSrBlec/6uT3Sa45eIJE/MZlDVIkpUG2tZgGlpUWhY
         /uVcUtUOVBOdSUNc27Q9j+2ST4ddp3cBLkcIqz0i75nAxUcCa6H8PHiuvEMf129mpiST
         2KeTLRItGqPnb5E6GuXHOYfS/o6CMVhq8Nb09nzbbqvNCRzJaqvXiidFCWH7X3svH52p
         iWtQ==
X-Gm-Message-State: AOAM533GkYQRh2kUpn/JOkjbCkcKAJg6387v1uUZTYTIHgE46c0EF6Oq
        uOVdDuTvgmzvDEBa7H+dYSK1Lubi/g4=
X-Google-Smtp-Source: ABdhPJz85ch6/QEKvs7xVQQwwun7CcFCj1DsOX1ZAkGn2ZW4f7s/lltlT3HucZbs4cI/U++mIzO6AA==
X-Received: by 2002:a17:906:9386:: with SMTP id l6mr37466617ejx.425.1609776659443;
        Mon, 04 Jan 2021 08:10:59 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id o10sm23784096eju.89.2021.01.04.08.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 08:10:58 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 4/5] mailmap: use case-sensitive comparisons for
 local-parts and names
References: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
 <20210103211849.2691287-5-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <20210103211849.2691287-5-sandals@crustytoothpaste.net>
Date:   Mon, 04 Jan 2021 17:10:58 +0100
Message-ID: <87czykvg19.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 03 2021, brian m. carlson wrote:

[For the purposes of this reply I'm also replying to your commit message
in 3/5, which I think makes things less confusing than two E-Mails]

> Currently, Git always looks up entries in the mailmap in a
> case-insensitive way, both for names and addresses, which is, as
> explained below, suboptimal.
>
> First, for email addresses, RFC 5321 is clear that only domains are case
> insensitive; local-parts (the portion before the at sign) are not.  It
> states this:
>=20
>   The local-part of a mailbox MUST BE treated as case sensitive.
>   Therefore, SMTP implementations MUST take care to preserve the case of
>   mailbox local-parts.

It seems better to quote the part of this where it goes on to say:

    However, exploiting the case sensitivity of mailbox local-parts
    impedes interoperability and is discouraged.  Mailbox domains follow
    normal DNS rules and are hence not case sensitive.

And also that RFC 5321 says earlier

    "a host that expects to receive mail SHOULD avoid defining mailboxes
    where the Local-part requires (or uses) the Quoted-string form or
    where the Local-part is case- sensitive.  For any purposes that
    require generating or comparing Local-parts (e.g., to specific
    mailbox names), all quoted forms MUST be treated as equivalent,".

So if we're taking RFC 5321 MUST requirements as something we've got to
do we're still not following it. But as I'll go on to note I think
rationale by RFC 5321 is perhaps not the best thing to do here...

> There exist systems today where local-parts remain case sensitive (and
> this author has one), and as such, it's incorrect for us to case fold
> them in any way.  Let's add a failing test that indicates this is a
> problem, while still keeping the test for case-insensitive domains.

I don't really care much about this feature of mailmap, but I'm
struggling a bit to understand this part.

We're not an SMTP server or SMTP server library, so we don't have to
worry about mail mis-routing or whatever.

We just have to worry about cases where you're not all of these people
in one project's commit metadata and/or .mailmap, and thus mailmap rules
would match too generously:

    "brian m. carlson" <sandals@crustytoothpaste.net>
    "brian m. carlson" <SANDALS@crustytoothpaste.net>
    "BRIAN M. CARLSON" <sandals@crustytoothpaste.net>
    "BRIAN M. CARLSON" <SANDALS@crustytoothpaste.net>

Is that really plausible? In any case, neither of these two patches make
reference to us already having changed this in the past in 1.6.2 and &
there being reports on the ML about the bug & us changing it back. See
https://lore.kernel.org/git/f182fb1700e8dea15459fd02ced2a6e5797bec99.123845=
8535u.git.johannes.schindelin@gmx.de/

Maybe we should still do this, but I think for a v3 it makes sense to
summarize that discussion etc.

> Note that it's also incorrect for us to case-fold names because we don't
> guarantee that we're using the locale of the author, and it's impossible
> to case-fold names in a locale-insensitive way.  Turkish and Azeri
> contain both a dotted and dotless I, and the uppercase ASCII I folds not
> to the lowercase ASCII I, but to a dotless version, and vice versa with
> the lowercase I.  There are many words in Turkish which differ only in
> the dottedness of the I, so it is likely that there are also personal
> names which differ in the same way.
>=20
> That would be a problem even if our implementation were perfect, which
> it is not.  We currently fold only ASCII characters, so this feature has
> never worked correctly for the vast majority of the users on the planet,
> regardless of the locale.  For example, on Linux, even in a Spanish
> locale, we don't handle "Sim=C3=B3n" properly.  Even if we did handle tha=
t,
> we'd probably also want to implement Unicode normalization, which we
> don't.

As one of those people, aren't you confusing two things here. I daresay
that almost everyone with a non-ASCII name doesn't have a non-ASCII
E-Mail address, sure some do, but treating those as one and the same
doesn't seem to make sense.

Yes you can have non-ASCII on the LHS of @ in an E-Mail address, it just
seems to me that's very rare.

Do we have known cases where we're making use of this case-insensitive
matching of the *name* part? Showing some of those non-ASCII cases in
the tests in 3/5 would be nice.

> IN general, case-folding text is extremely language- and locale-specific
> and requires intimacy with the spelling and grammar of the language in
> question and careful attention to the Unicode details in order to
> produce a result that is meaningful to humans and conforms with
> linguistic and societal norms.
>=20
> Because we do not have any of the required context with a plain personal
> name, we cannot hope to possibly case-fold personal names correctly.  We
> should stop trying to do so and just treat them as a series of bytes, so
> let's add a test that we don't case-fold personal names as well.

[... end <snip> of commit 3/5 ...]

> RFC 5321 is clear that the local-part of an email address (the part
> before the at sign) is case sensitive, and this has been the case since
> the original RFC 821.  It directs us that "the local-part MUST be
> interpreted and assigned semantics only by the host specified in the
> domain part of the address."
>
> Since we are not that party, it's not correct for us to compare them
> case insensitively.  However, we do still want to compare the domain
> parts case insensitively, so let's add a helper that downcases the
> domain and then compare byte by byte.
>
> Similarly, it's not possible for us to correctly case-fold text in a
> locale-insensitive way, so our handling of personal names has also been
> subject to bugs.  Additionally, we've never handled non-ASCII characters
> correctly, which means that our previous comparisons really only worked
> well for a fraction of the people on the planet.  Since our code wasn't
> right and it's basically impossible to compare personal names without
> regard to case, let's also switch our matching of names to be byte by
> byte.

I'm still undecided about whether we should be calling strcasecmp() to
begin with, but I don't really find this convincing. Just because we
only support brian@ and BRIAN@ being the same but not =C3=A6var@ and =C3=86=
VAR@ we
should break the existing behavior for everyone?

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  mailmap.c          | 27 ++++++++++++++++++++++++---
>  t/t4203-mailmap.sh |  4 ++--
>  2 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/mailmap.c b/mailmap.c
> index d3287b409a..5c52dbb7e0 100644
> --- a/mailmap.c
> +++ b/mailmap.c
> @@ -64,7 +64,22 @@ static void free_mailmap_entry(void *p, const char *s)
>   */
>  static int namemap_cmp(const char *a, const char *b)
>  {
> -	return strcasecmp(a, b);
> +	return strcmp(a, b);
> +}

It seems to me if we're not going to use strcasecmp() we can get rid of
this whole namemap_cmp() function. See the comment just above it &
de2f95ebed2 (mailmap: work around implementations with pure inline
strcasecmp, 2013-09-12). I.e. we had a wrapper function here just
because we were using strcasecmp().

> +/*
> + * Lowercases the domain (and only the domain) part of an email address.=
  The
> + * local-part, which is defined by RFC 5321 to be case sensitive, is not
> + * affected.
> + */
> +static char *lowercase_email(char *s)
> +{
> +	char *end =3D strchrnul(s, '@');

Speaking of pedantic readings of RFC 5321, aren't we closing the door
here to proper DQUOTE handling? I.e. the local-part containing a @
within quotes :)

