Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27B5C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 13:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B77613B1
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 13:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFBNmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 09:42:32 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:36746 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhFBNmc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 09:42:32 -0400
Received: by mail-ej1-f43.google.com with SMTP id a11so3211176ejf.3
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Q7RWahSoAgaKBhcDxvnSgOQwFOrq2vAR1XWKtqxevcg=;
        b=C0fC6/zv7FvN/MBeeJTducChNUVU/wRoaovvg8sZ4ZKCPiC7XIcioNkqWaBTQ1PKvj
         YmkAKIy3Jq1bg7ZSeLqeZ5UMSzpNwm/WnHLR97/ZqzoLFTnQpwggHfjuF9nE7BWpbeLm
         vN2rta1zLlcLi1r+SjfRrpUkjfkVqUUbUVW6QJeND/qN9kWleosnQ9EhaIOYPGS7Bqs/
         bL6wC4BrxRiG717QRWQpab5gXFmyg1+xOyuhs8Od8+wdbVfqNw1XLj3LZzpdwuliAc9i
         6nfP7xGSwL1NSfL6x/1Ooh+klziPgafsZtD+SQuV1/5S4B5x9H8lOegUXymgaGS/1U/o
         eIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Q7RWahSoAgaKBhcDxvnSgOQwFOrq2vAR1XWKtqxevcg=;
        b=T88NoLTA9mwlPdn6z4btIuCJ3OwEWlz5RqA6NDaCCmIX8KOx5wxz5DHfLPCqqxM75a
         orI7TcHbSbpFgyei21GmzHljqUa8AuxH6DXeeN6gOcVW3lL/gVFLylrSchGNT9//5KRW
         3b/gIbirW8fbCOG+mtaIp8ydCyF/62ue8oDQz9KmQatrcJCpmqtUgK0X3Gyuqib3hCgw
         l/JSWz9Ow9Km+YMj/HXQS1htVf+cooNvcR5Z/w3KzsBlythpMXAJKpBEo19hGtav72sr
         yzhpk5Wj+LbvwYT/v175h9Yk4vIjT3NaEAcUpLVfW+TC0148ZdDjO9ll0rLOG1gvlCXd
         wTQQ==
X-Gm-Message-State: AOAM531ZX490wHqfqbfnVOVybXtLHw6PelCTwyN3rBeYBsGgzQz32hIo
        CdMc5JXZrGbOEgF9GepplXk=
X-Google-Smtp-Source: ABdhPJya9Tnq7v4xrAalO2XDnL18ev6JV7w1Fzqy5Ep/mAt0PxjVHuJix3YM6yjJap9IXaR91BMqXQ==
X-Received: by 2002:a17:906:f298:: with SMTP id gu24mr15857251ejb.452.1622641178146;
        Wed, 02 Jun 2021 06:39:38 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id hr23sm21914ejc.101.2021.06.02.06.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 06:39:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, gitster@pobox.com,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] t2080: fix cp invocation to copy symlinks instead of
 following them
Date:   Wed, 02 Jun 2021 15:36:57 +0200
References: <5386ee606567248464d39c313ee6177862a1f337.1622071475.git.matheus.bernardino@usp.br>
 <87r1hsl4qb.fsf@evledraar.gmail.com> <871r9n2dlu.fsf@evledraar.gmail.com>
 <YLbgi0jQn8BJ1ue2@danh.dev> <87pmx47cs9.fsf@evledraar.gmail.com>
 <YLdqDn9vCBc7sPDN@danh.dev>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YLdqDn9vCBc7sPDN@danh.dev>
Message-ID: <87mts875d3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 02 2021, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> On 2021-06-02 12:50:53+0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>>=20
>> On Wed, Jun 02 2021, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
>>=20
>> > On 2021-05-31 16:01:01+0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
>> >>=20
>> >> On Thu, May 27 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >>=20
>> >> > On Wed, May 26 2021, Matheus Tavares wrote:
>> >> >
>> >> >> t2080 makes a few copies of a test repository and later performs a
>> >> >> branch switch on each one of the copies to verify that parallel ch=
eckout
>> >> >> and sequential checkout produce the same results. However, the
>> >> >> repository is copied with `cp -R` which, on some systems, defaults=
 to
>> >> >> following symlinks on the directory hierarchy and copying their ta=
rget
>> >> >> files instead of copying the symlinks themselves. AIX is one examp=
le of
>> >> >> system where this happens. Because the symlinks are not preserved,=
 the
>> >> >> copied repositories have paths that do not match what is in the in=
dex,
>> >> >> causing git to abort the checkout operation that we want to test. =
This
>> >> >> makes the test fail on these systems.
>> >> >>
>> >> >> Fix this by copying the repository with the POSIX flag '-P', which
>> >> >> forces cp to copy the symlinks instead of following them. Note tha=
t we
>> >> >> already use this flag for other cp invocations in our test suite (=
see
>> >> >> t7001). With this change, t2080 now passes on AIX.
>> >> >>
>> >> >> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.=
com>
>> >> >> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
>> >> >> ---
>> >> >>  t/t2080-parallel-checkout-basics.sh | 2 +-
>> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> >>
>> >> >> diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-paralle=
l-checkout-basics.sh
>> >> >> index 7087818550..3e0f8c675f 100755
>> >> >> --- a/t/t2080-parallel-checkout-basics.sh
>> >> >> +++ b/t/t2080-parallel-checkout-basics.sh
>> >> >> @@ -114,7 +114,7 @@ do
>> >> >>=20=20
>> >> >>  	test_expect_success "$mode checkout" '
>> >> >>  		repo=3Dvarious_$mode &&
>> >> >> -		cp -R various $repo &&
>> >> >> +		cp -R -P various $repo &&
>> >> >>=20=20
>> >> >>  		# The just copied files have more recent timestamps than their
>> >> >>  		# associated index entries. So refresh the cached timestamps
>> >> >
>> >> > Thanks for the quick fix, I can confirm that this makes the test pa=
ss on
>> >> > AIX 7.2.
>> >>=20
>> >> There's still a failure[1] in t2082-parallel-checkout-attributes.sh
>> >> though, which is new in 2.32.0-rc*. The difference is in an unexpected
>> >> BOM:
>> >>=20=20=20=20=20
>> >>     avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"' tr=
ash\ directory.t2082-parallel-checkout-attributes/encoding/A.internal=20
>> >>     efbbbf74657874
>> >>     avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"' tr=
ash\ directory.t2082-parallel-checkout-attributes/encoding/utf8-text=20=20
>> >>     74657874
>> >>=20
>> >> I.e. the A.internal starts with 0xefbbbf. The 2nd test of t0028*.sh a=
lso
>> >> fails similarly[2], so perhaps it's some old/iconv/whatever issue not
>> >> per-se related to any change of yours.
>> >
>> > The 0xefbbbf looks interesting, it's BOM for utf-8.
>> >
>> >> I tried compiling with both NO_ICONV=3DY and ICONV_OMITS_BOM=3DY, bot=
h have
>> >> the same failure.
>> >
>> > I didn't check the code-path for NO_ICONV=3DY but ICONV_OMITS_BOM=3DY =
only
>> > affects output of converting *to* utf-16 and utf-32.
>> >
>> > So, I think AIX iconv implementation automatically add BOM to utf-8?
>> >
>> > Perhap we need to call skip_utf8_bom somewhere?
>>=20
>> I debugged this a bit more, it's probably *also* an issue in our use of
>> libiconv, but it goes wrong just with our test setup with
>> iconv(1). I.e. on my boring linux box:
>>=20=20=20=20=20
>>     echo x | iconv -f UTF-8 -t UTF-16 | perl -0777 -MData::Dumper -ne 'm=
y @a =3D map { sprintf "0x%x", $_ } unpack "C*"; print Dumper \@a'
>>     $VAR1 =3D [
>>               '0xff',
>>               '0xfe',
>>               '0x78',
>>               '0x0',
>>               '0xa',
>>               '0x0'
>>             ];
>>=20
>>=20
>> On the AIX box to get the same I need to do that as:
>>=20
>>     (printf '\376\377'; echo x | iconv -f UTF-8 -t UTF-16LE) | [...]
>
> FWIW, my Linux with musl-libc also need to be done like this.
>
>> I.e. we omit the BOM *and* AIX's idea of our UTF-16 is little-endian
>> UTF-16, a plain UTF-16 gives you the big-endian version.
>
> Per spec, plain UTF-16 *is* big-endian. [1]
>
> 	In the table <BOM> indicates that the byte order is determined
> 	by a byte order mark, if present at the beginning of the data
> 	stream, otherwise it is big-endian.
>
>> To make things
>> worse the same is true of UTF-32, except "iconv -l" lists no UTF-32LE
>> version. So it seems we can't get the same result at all for that one.
>
> Ditto for UTF-32
>
>> So from the outset the code added around 79444c92943 (utf8: handle
>> systems that don't write BOM for UTF-16, 2019-02-12) needs to be more
>> careful (although this looked broken before), i.e. we should test exact
>> known-good bytes and see if UTF-16 is really what we think it is,
>> etc. This is likely broken on any big-endian non-GNUish iconv
>> implementation.
>
> Linux with musl-libc on little endian also thinks UTF-16 without BOM is U=
TF-16-BE
>
> I still think we should strip UTF-8 BOM after reencode_string_len
> I.e. something like this, I can't test this, though, since I don't have a=
ny AIX box.
> And my Linux with musl-libc doesn't output BOM for utf-8
> It doesn't write BOM for utf-16be and utf-32be, anyway.
>
> -----8<----
> diff --git a/utf8.c b/utf8.c
> index de4ce5c0e6..73631632bd 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -8,6 +8,7 @@ static const char utf16_be_bom[] =3D {'\xFE', '\xFF'};
>  static const char utf16_le_bom[] =3D {'\xFF', '\xFE'};
>  static const char utf32_be_bom[] =3D {'\0', '\0', '\xFE', '\xFF'};
>  static const char utf32_le_bom[] =3D {'\xFF', '\xFE', '\0', '\0'};
> +const char utf8_bom[] =3D "\357\273\277";
>=20=20
>  struct interval {
>  	ucs_char_t first;
> @@ -28,6 +29,12 @@ size_t display_mode_esc_sequence_len(const char *s)
>  	return p - s;
>  }
>=20=20
> +static int has_utf8_bom(const char *text, size_t len)
> +{
> +	return len >=3D strlen(utf8_bom) &&
> +		memcmp(text, utf8_bom, strlen(utf8_bom)) =3D=3D 0;
> +}
> +
>  /* auxiliary function for binary search in interval table */
>  static int bisearch(ucs_char_t ucs, const struct interval *table, int ma=
x)
>  {
> @@ -539,12 +546,13 @@ static const char *fallback_encoding(const char *na=
me)
>=20=20
>  char *reencode_string_len(const char *in, size_t insz,
>  			  const char *out_encoding, const char *in_encoding,
> -			  size_t *outsz)
> +			  size_t *outsz_p)
>  {
>  	iconv_t conv;
>  	char *out;
>  	const char *bom_str =3D NULL;
>  	size_t bom_len =3D 0;
> +	size_t outsz =3D 0;
>=20=20
>  	if (!in_encoding)
>  		return NULL;
> @@ -590,10 +598,16 @@ char *reencode_string_len(const char *in, size_t in=
sz,
>  		if (conv =3D=3D (iconv_t) -1)
>  			return NULL;
>  	}
> -	out =3D reencode_string_iconv(in, insz, conv, bom_len, outsz);
> +	out =3D reencode_string_iconv(in, insz, conv, bom_len, &outsz);
>  	iconv_close(conv);
>  	if (out && bom_str && bom_len)
>  		memcpy(out, bom_str, bom_len);
> +	if (is_encoding_utf8(out_encoding) && has_utf8_bom(out, outsz)) {
> +		outsz -=3D strlen(utf8_bom);
> +		memmove(out, out + strlen(utf8_bom), outsz + 1);
> +	}
> +	if (outsz_p)
> +		*outsz_p =3D outsz;
>  	return out;
>  }
>  #endif
> @@ -782,12 +796,9 @@ int is_hfs_dotmailmap(const char *path)
>  	return is_hfs_dot_str(path, "mailmap");
>  }
>=20=20
> -const char utf8_bom[] =3D "\357\273\277";
> -
>  int skip_utf8_bom(char **text, size_t len)
>  {
> -	if (len < strlen(utf8_bom) ||
> -	    memcmp(*text, utf8_bom, strlen(utf8_bom)))
> +	if (!has_utf8_bom(*text, len))
>  		return 0;
>  	*text +=3D strlen(utf8_bom);
>  	return 1;
> ---->8------
>
> 1: https://unicode.org/faq/utf_bom.html

That's getting us there, now we don't fail on the 2nd test, but do start
failing on the third "re-encode to UTF-16 on checkout" and other
"checkout" tests.

The "test_cmp" at the end of that 3rd tests shows that the difference in
test.utf16.raw and test.utf16 is now that the "raw" one has the BOM, but
not the "test.utf16" file.
