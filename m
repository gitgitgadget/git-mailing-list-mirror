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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF4CC47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478A86100B
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhFBLYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 07:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhFBLYk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 07:24:40 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A4FC061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 04:22:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id e7so940374plj.7
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 04:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ddfn+M0bpiXL+8e8+h9HbHUbDJ/GGmRzHQ2z3ZsQFFo=;
        b=kC3YnSadyueTMHFszjV5fqJX02XFXiCJKG8PsQNyZBwO4fhNfMxQGaQZFLWJx3xAxE
         31INhonDQEp1ueFIZxXnq8Es+f0cxEaYktYIrOJ+vlPe6rFhIFAS6JSxSFzDD7k2+dML
         YOoH5PsllYMe7LphparlnHTlecIuGBUrbVp7BHy53PD2IlezS8IqTBdrjuhOlAPQKQ0Y
         Ygtwwi0vJmlU5EuLrOY3MESwZaLNyKK1LULGOR01IqG1EJFTje+pb3nA3ZVU1praK4Wj
         fAHbjqzYUaW2/xKmYUggpMnyQLKvtAnBUpmpM2HRIQa1d5e7fQsvQBxs35pQtne7O3EI
         euxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ddfn+M0bpiXL+8e8+h9HbHUbDJ/GGmRzHQ2z3ZsQFFo=;
        b=ioSrcBMoARerNMQLKDMldvXGW7MITOW33r7MVvGYwHM+YyR/2cDPsYxtGzu7dilpwO
         8x5plPflhX74bDh94mn1IHZOvfk/rWwsRo2pqc4pUnT0KHQGDL5ywtlqE748dLhFli+b
         ymbBElRKNcDV2pD3M39LK9ugL5pf96iE8DG8XeDBWyoYaDF3mKugA802yX3PhAqnmt5q
         jrUUibYRumpNCPVTLA9FzvlORYd8zfrJyh2sTCnXVaaJ/36lBnJSR+8Bl1hLW29moA8K
         6cm38wM5miqpSOqFhQkplyFeviw2nE7ZwqBddfhHUIptUiQlSJhgE2I9oe7qoiABKFFg
         UqDg==
X-Gm-Message-State: AOAM533jJ/Cs2QSo2XM4MPLuPIR2J10VjB1LzaFZJW18gCfFjMEXTrfW
        pZzeF0preE93JppLoDLXuWbV+9adIoQV1Q==
X-Google-Smtp-Source: ABdhPJzghT+NTd5x1LoQoJwShC4JlCzzsmoRq3ze3Bv2HXNqbwlTnd6RPt7d+7cyQ2R/K2960vvTiQ==
X-Received: by 2002:a17:90a:bd05:: with SMTP id y5mr30256792pjr.229.1622632976619;
        Wed, 02 Jun 2021 04:22:56 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id p11sm16457903pjo.19.2021.06.02.04.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 04:22:56 -0700 (PDT)
Date:   Wed, 2 Jun 2021 18:22:54 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, gitster@pobox.com,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] t2080: fix cp invocation to copy symlinks instead of
 following them
Message-ID: <YLdqDn9vCBc7sPDN@danh.dev>
References: <5386ee606567248464d39c313ee6177862a1f337.1622071475.git.matheus.bernardino@usp.br>
 <87r1hsl4qb.fsf@evledraar.gmail.com>
 <871r9n2dlu.fsf@evledraar.gmail.com>
 <YLbgi0jQn8BJ1ue2@danh.dev>
 <87pmx47cs9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pmx47cs9.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-02 12:50:53+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> On Wed, Jun 02 2021, Đoàn Trần Công Danh wrote:
> 
> > On 2021-05-31 16:01:01+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> >> 
> >> On Thu, May 27 2021, Ævar Arnfjörð Bjarmason wrote:
> >> 
> >> > On Wed, May 26 2021, Matheus Tavares wrote:
> >> >
> >> >> t2080 makes a few copies of a test repository and later performs a
> >> >> branch switch on each one of the copies to verify that parallel checkout
> >> >> and sequential checkout produce the same results. However, the
> >> >> repository is copied with `cp -R` which, on some systems, defaults to
> >> >> following symlinks on the directory hierarchy and copying their target
> >> >> files instead of copying the symlinks themselves. AIX is one example of
> >> >> system where this happens. Because the symlinks are not preserved, the
> >> >> copied repositories have paths that do not match what is in the index,
> >> >> causing git to abort the checkout operation that we want to test. This
> >> >> makes the test fail on these systems.
> >> >>
> >> >> Fix this by copying the repository with the POSIX flag '-P', which
> >> >> forces cp to copy the symlinks instead of following them. Note that we
> >> >> already use this flag for other cp invocations in our test suite (see
> >> >> t7001). With this change, t2080 now passes on AIX.
> >> >>
> >> >> Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> >> >> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> >> >> ---
> >> >>  t/t2080-parallel-checkout-basics.sh | 2 +-
> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-checkout-basics.sh
> >> >> index 7087818550..3e0f8c675f 100755
> >> >> --- a/t/t2080-parallel-checkout-basics.sh
> >> >> +++ b/t/t2080-parallel-checkout-basics.sh
> >> >> @@ -114,7 +114,7 @@ do
> >> >>  
> >> >>  	test_expect_success "$mode checkout" '
> >> >>  		repo=various_$mode &&
> >> >> -		cp -R various $repo &&
> >> >> +		cp -R -P various $repo &&
> >> >>  
> >> >>  		# The just copied files have more recent timestamps than their
> >> >>  		# associated index entries. So refresh the cached timestamps
> >> >
> >> > Thanks for the quick fix, I can confirm that this makes the test pass on
> >> > AIX 7.2.
> >> 
> >> There's still a failure[1] in t2082-parallel-checkout-attributes.sh
> >> though, which is new in 2.32.0-rc*. The difference is in an unexpected
> >> BOM:
> >>     
> >>     avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"' trash\ directory.t2082-parallel-checkout-attributes/encoding/A.internal 
> >>     efbbbf74657874
> >>     avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"' trash\ directory.t2082-parallel-checkout-attributes/encoding/utf8-text  
> >>     74657874
> >> 
> >> I.e. the A.internal starts with 0xefbbbf. The 2nd test of t0028*.sh also
> >> fails similarly[2], so perhaps it's some old/iconv/whatever issue not
> >> per-se related to any change of yours.
> >
> > The 0xefbbbf looks interesting, it's BOM for utf-8.
> >
> >> I tried compiling with both NO_ICONV=Y and ICONV_OMITS_BOM=Y, both have
> >> the same failure.
> >
> > I didn't check the code-path for NO_ICONV=Y but ICONV_OMITS_BOM=Y only
> > affects output of converting *to* utf-16 and utf-32.
> >
> > So, I think AIX iconv implementation automatically add BOM to utf-8?
> >
> > Perhap we need to call skip_utf8_bom somewhere?
> 
> I debugged this a bit more, it's probably *also* an issue in our use of
> libiconv, but it goes wrong just with our test setup with
> iconv(1). I.e. on my boring linux box:
>     
>     echo x | iconv -f UTF-8 -t UTF-16 | perl -0777 -MData::Dumper -ne 'my @a = map { sprintf "0x%x", $_ } unpack "C*"; print Dumper \@a'
>     $VAR1 = [
>               '0xff',
>               '0xfe',
>               '0x78',
>               '0x0',
>               '0xa',
>               '0x0'
>             ];
> 
> 
> On the AIX box to get the same I need to do that as:
> 
>     (printf '\376\377'; echo x | iconv -f UTF-8 -t UTF-16LE) | [...]

FWIW, my Linux with musl-libc also need to be done like this.

> I.e. we omit the BOM *and* AIX's idea of our UTF-16 is little-endian
> UTF-16, a plain UTF-16 gives you the big-endian version.

Per spec, plain UTF-16 *is* big-endian. [1]

	In the table <BOM> indicates that the byte order is determined
	by a byte order mark, if present at the beginning of the data
	stream, otherwise it is big-endian.

> To make things
> worse the same is true of UTF-32, except "iconv -l" lists no UTF-32LE
> version. So it seems we can't get the same result at all for that one.

Ditto for UTF-32

> So from the outset the code added around 79444c92943 (utf8: handle
> systems that don't write BOM for UTF-16, 2019-02-12) needs to be more
> careful (although this looked broken before), i.e. we should test exact
> known-good bytes and see if UTF-16 is really what we think it is,
> etc. This is likely broken on any big-endian non-GNUish iconv
> implementation.

Linux with musl-libc on little endian also thinks UTF-16 without BOM is UTF-16-BE

I still think we should strip UTF-8 BOM after reencode_string_len
I.e. something like this, I can't test this, though, since I don't have any AIX box.
And my Linux with musl-libc doesn't output BOM for utf-8
It doesn't write BOM for utf-16be and utf-32be, anyway.

-----8<----
diff --git a/utf8.c b/utf8.c
index de4ce5c0e6..73631632bd 100644
--- a/utf8.c
+++ b/utf8.c
@@ -8,6 +8,7 @@ static const char utf16_be_bom[] = {'\xFE', '\xFF'};
 static const char utf16_le_bom[] = {'\xFF', '\xFE'};
 static const char utf32_be_bom[] = {'\0', '\0', '\xFE', '\xFF'};
 static const char utf32_le_bom[] = {'\xFF', '\xFE', '\0', '\0'};
+const char utf8_bom[] = "\357\273\277";
 
 struct interval {
 	ucs_char_t first;
@@ -28,6 +29,12 @@ size_t display_mode_esc_sequence_len(const char *s)
 	return p - s;
 }
 
+static int has_utf8_bom(const char *text, size_t len)
+{
+	return len >= strlen(utf8_bom) &&
+		memcmp(text, utf8_bom, strlen(utf8_bom)) == 0;
+}
+
 /* auxiliary function for binary search in interval table */
 static int bisearch(ucs_char_t ucs, const struct interval *table, int max)
 {
@@ -539,12 +546,13 @@ static const char *fallback_encoding(const char *name)
 
 char *reencode_string_len(const char *in, size_t insz,
 			  const char *out_encoding, const char *in_encoding,
-			  size_t *outsz)
+			  size_t *outsz_p)
 {
 	iconv_t conv;
 	char *out;
 	const char *bom_str = NULL;
 	size_t bom_len = 0;
+	size_t outsz = 0;
 
 	if (!in_encoding)
 		return NULL;
@@ -590,10 +598,16 @@ char *reencode_string_len(const char *in, size_t insz,
 		if (conv == (iconv_t) -1)
 			return NULL;
 	}
-	out = reencode_string_iconv(in, insz, conv, bom_len, outsz);
+	out = reencode_string_iconv(in, insz, conv, bom_len, &outsz);
 	iconv_close(conv);
 	if (out && bom_str && bom_len)
 		memcpy(out, bom_str, bom_len);
+	if (is_encoding_utf8(out_encoding) && has_utf8_bom(out, outsz)) {
+		outsz -= strlen(utf8_bom);
+		memmove(out, out + strlen(utf8_bom), outsz + 1);
+	}
+	if (outsz_p)
+		*outsz_p = outsz;
 	return out;
 }
 #endif
@@ -782,12 +796,9 @@ int is_hfs_dotmailmap(const char *path)
 	return is_hfs_dot_str(path, "mailmap");
 }
 
-const char utf8_bom[] = "\357\273\277";
-
 int skip_utf8_bom(char **text, size_t len)
 {
-	if (len < strlen(utf8_bom) ||
-	    memcmp(*text, utf8_bom, strlen(utf8_bom)))
+	if (!has_utf8_bom(*text, len))
 		return 0;
 	*text += strlen(utf8_bom);
 	return 1;
---->8------

1: https://unicode.org/faq/utf_bom.html

-- 
Danh
