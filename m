Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA4EC433F5
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 01:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA18060F9C
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 01:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhJIB0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 21:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhJIB0H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 21:26:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC2CC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 18:24:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a25so26706099edx.8
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 18:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=lIR0EOyYC/NiSw/1tm0oxoUdQZvZNLb6EAySjM92KYw=;
        b=ahGZctR+dDfRa5lM7LX9u1zbdGxd8AYFSfq50M93Ek56dHPIm+lmQW7ZPRoZf/Uq33
         dNecL5kbV1NZ9vn3MbshijYUDHlQfCkxDdLhJ3R6jZOMEE/V0+wRijN8y75BugQr2wyC
         NRLYb/OYGaGAxt2hjtJZUg2AvPXMW1N8hgLVlXJlTNostlxvQQfBNGqTI0SvJnvAuiNs
         he6i0prhxs9QPEos454Z8QeDPHxfb4ccActBEE91CVFD7FtrJAypHDsUScQfNKsL1a0m
         Vl7bYh9CxHl3hdJbo8CIHDzSVUa1XhkLncHH92y/xaL8G8+GlQRdxlgBhJKWHgU1+zQL
         T6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=lIR0EOyYC/NiSw/1tm0oxoUdQZvZNLb6EAySjM92KYw=;
        b=3Dd2QGsnXn5CopWW4i1wDxje7DcURD+wBgb9eWjkQVPQIMkTK7kFEGq0Tre/Wja5DK
         rv400XDRlA+UZFOSl7wQuV1seZ5N1l7a+VWbsU8kJ0eh6ypocMiJjXxgFOXL5lXOl4O+
         B1+T8T9fhwptJ4MXxXBja8v1Cgcf7y8q5UEeDeDuBg/Ms70eoVxlDmJMPhEWqzFfRsnK
         LbU+IFH1Ci9A2LH0xRrbX+6DsDRxVtQ9a9Bpc8H8irRE+u2gDAl0NmT/wZVc4Y75o0CR
         mzj/Nn1wqzSKalshfdLJ7XjxD46OMEspMEe9Va5e0hFxUPbkHercXFgBNM8qIdKqge4Z
         9+Wg==
X-Gm-Message-State: AOAM533lN1sv4cLoGIY0+r52K8mzUolefeBUsZqy1+RWO6x2yvn6TYhf
        FCmIkTJaekJtQJO6KCkV4HE=
X-Google-Smtp-Source: ABdhPJyL++dmerpX0Tqa12Jn9r3OYYyvO70lK4La0vq06JVcFvt1fNpghrOnFLFSk3HwCllrulb02Q==
X-Received: by 2002:a05:6402:35c4:: with SMTP id z4mr19628236edc.197.1633742649448;
        Fri, 08 Oct 2021 18:24:09 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v13sm381041ede.79.2021.10.08.18.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 18:24:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>,
        git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>
Subject: *Really* noisy encoding warnings post-v2.33.0
Date:   Sat, 09 Oct 2021 02:58:10 +0200
References: <9896630.2IqcCWsCYL@localhost.localdomain>
 <YSWVi8uLHZCTtG0l@coredump.intra.peff.net> <xmqqeeahjxj4.fsf@gitster.g>
 <YSkvNyR4uT52de13@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YSkvNyR4uT52de13@coredump.intra.peff.net>
Message-ID: <87ily7m1mv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 27 2021, Jeff King wrote:

$subject because I think we should really consider backing this out
before it gets to a real release.

I ran into this while testing the grep coloring patch[1] (but it's
unrelated). Before this commit e.g.:

    LC_ALL=3DC ~/g/git/git -P -c i18n.commitEncoding=3Dascii log --author=
=3D=C3=86var -100|wc -l
    28333

So ~3k lines for my last 100 commits, but then:

    $ LC_ALL=3DC ~/g/git/git -P -c i18n.commitEncoding=3Dascii log --author=
=3D=C3=86var -100 2>&1|grep -c ^warning
    299

At first I thought it was spewing warnings for every failed re-encoded
line in some cases, because I get hundreds at a time sometimes, but it's
because stderr and stdout I/O buffering is different (a common
case). Adding a "fflush(stderr)" "fixes" that.

But anyway, I think we've got a lot of users who say *do* want to
reencode something from say UTF-8 to latin1, but then might have the
occasional non-latin1 representable data. The old behavior of silently
falling back is going to be much better for those users, or maybe show
one warning at the end or something, if you feel it really needs to be
kept.

> On Wed, Aug 25, 2021 at 09:31:59AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>=20
>> > We feed the encoding "HTML" to iconv_open(), which of course has no id=
ea
>> > what that is. It's unfortunate, though, that we don't even print a
>> > warning, and instead just quietly leave the text intact. I wonder if we
>> > should do something like:
>> [...]
>> This addition sounds quite sensible to me.
>>=20
>> "git log --encoding=3Dbogus" would issue this warning for each and
>> every commit and that may be a bit irritating, but being irritating
>> may be a good characteristic for a warning message that is given to
>> an easily correctable condition.
>>=20
>> I originally thought that the warning would be lost to the pager,
>> but apparently I forgot what I did eons ago at 61b80509 (sending
>> errors to stdout under $PAGER, 2008-02-16) ;-).
>
> Here it is polished into a real commit.
>
> -- >8 --
> Subject: [PATCH] logmsg_reencode(): warn when iconv() fails
>
> If the user asks for a pretty-printed commit to be converted (either
> explicitly with --encoding=3Dfoo, or implicitly because the commit is
> non-utf8 and we want to convert it), we pass it through iconv(). If that
> fails, we fall back to showing the input verbatim, but don't tell the
> user that the output may be bogus.
>
> Let's add a warning to do so, along with a mention in the documentation
> for --encoding. Two things to note about the implementation:
>
>   - we could produce the warning closer to the call to iconv() in
>     reencode_string_len(), which would let us relay the value of errno.
>     But this is not actually very helpful. reencode_string_len() does
>     not know we are operating on a commit, and indeed does not know that
>     the caller won't produce an error of its own. And the errno values
>     from iconv() are seldom helpful (iconv_open() only ever produces
>     EINVAL; perhaps EILSEQ from iconv() might be illuminating, but it
>     can also return EINVAL for incomplete sequences).
>
>   - if the reason for the failure is that the output charset is not
>     supported, then the user will see this warning for every commit we
>     try to display. That might be ugly and overwhelming, but on the
>     other hand it is making it clear that every one of them has not been
>     converted (and the likely outcome anyway is to re-try the command
>     with a supported output encoding).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/pretty-options.txt | 4 +++-
>  pretty.c                         | 6 +++++-
>  t/t4210-log-i18n.sh              | 7 +++++++
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-opti=
ons.txt
> index 27ddaf84a1..42b227bc40 100644
> --- a/Documentation/pretty-options.txt
> +++ b/Documentation/pretty-options.txt
> @@ -40,7 +40,9 @@ people using 80-column terminals.
>  	defaults to UTF-8. Note that if an object claims to be encoded
>  	in `X` and we are outputting in `X`, we will output the object
>  	verbatim; this means that invalid sequences in the original
> -	commit may be copied to the output.
> +	commit may be copied to the output. Likewise, if iconv(3) fails
> +	to convert the commit, we will output the original object
> +	verbatim, along with a warning.
>=20=20
>  --expand-tabs=3D<n>::
>  --expand-tabs::
> diff --git a/pretty.c b/pretty.c
> index 9631529c10..73b5ead509 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -671,7 +671,11 @@ const char *repo_logmsg_reencode(struct repository *=
r,
>  	 * If the re-encoding failed, out might be NULL here; in that
>  	 * case we just return the commit message verbatim.
>  	 */
> -	return out ? out : msg;
> +	if (!out) {
> +		warning("unable to reencode commit to '%s'", output_encoding);
> +		return msg;
> +	}
> +	return out;
>  }
>=20=20
>  static int mailmap_name(const char **email, size_t *email_len,
> diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
> index d2dfcf164e..0141f36e33 100755
> --- a/t/t4210-log-i18n.sh
> +++ b/t/t4210-log-i18n.sh
> @@ -131,4 +131,11 @@ do
>  	fi
>  done
>=20=20
> +test_expect_success 'log shows warning when conversion fails' '
> +	enc=3Dthis-encoding-does-not-exist &&
> +	git log -1 --encoding=3D$enc 2>err &&
> +	echo "warning: unable to reencode commit to ${SQ}${enc}${SQ}" >expect &&
> +	test_cmp expect err
> +'
> +
>  test_done

