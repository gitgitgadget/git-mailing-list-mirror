Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B7FC433F5
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 10:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F60660F56
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 10:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245246AbhJQKHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Oct 2021 06:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245237AbhJQKHR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Oct 2021 06:07:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CC2C061765
        for <git@vger.kernel.org>; Sun, 17 Oct 2021 03:05:07 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z20so58115762edc.13
        for <git@vger.kernel.org>; Sun, 17 Oct 2021 03:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=cqLURochHIkFBXbaW55qSsd/gRKfrK37hXCQYjCTdpo=;
        b=VDyKrK/7xnFBaNHCL9SUP5kBxu+QNqT0ke+nywPesCjanwG4vGE2dGdSiEYRluSYZ+
         1LvXmI9KjJQuVvulnH4J4+b0OuhBWeuLBi+Uh+ufZV6XEWReQF3VGjc1/b7Qtx+MEuqW
         CvckOok0R45O+XFcB1q+oQYuzD+D52wchVUEcp+eSl8gWntZA+ii59OxYA2gdfoKFMvz
         sqOTBla/FjTM1rClpiqiT9btSiuyVK2AlSwLkqhvlY4preoIMzIww58u8jcJ7OF5TFNN
         G1+9gvJVugaGX+tCwDcBBIqI2E4b5jyGeGZN9Gveq8VoRBCkoeJTeGv/HFMdS4Jp90f/
         MN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=cqLURochHIkFBXbaW55qSsd/gRKfrK37hXCQYjCTdpo=;
        b=w8WsinM+lpxYPcUv8QmhnOBbdqOKDvcPigPCXjHJrYn3SUlN831kGqejNPFHGP0/hp
         7dr/nimnuG9e88bLxI3Zr7r0UfMXXqfHc8n8hZeGn7h1J40kCOn0ECPnOBX7ECpL8xeV
         AoI5RLpxGNu4jb2N7jrfgy53PBTP9YC2hIaGgSpxOe/ddXDiI8UNsGob+/v3304WGzuZ
         Yq5bpiv0tGLPKoD6x9fmfr6GTiC3dJJvzSlxKRc1lQzwFRenkcxJ7vqOVlTnpal/wZ6G
         mBDlG3rN6Enc1zBdLUEd1XrZNUHoQnt0sn9EIxre/6Z27lI/tUTI8PecYttq1OYQGODt
         RqpQ==
X-Gm-Message-State: AOAM531uyR1w4yb4ypP+2pDIM95zZxbjHhQRZmLJZNs3Kco4iT7fq6D9
        NbgrkNPBIfgON/2OCRXzj2s=
X-Google-Smtp-Source: ABdhPJwDwQahuxO7h8SaFDSx5Yujnp6HTkOkOQET1H6OwhrLnYVy9+iIFKTJuZgMikzTWAekKWqFsg==
X-Received: by 2002:a05:6402:2808:: with SMTP id h8mr34645037ede.394.1634465105997;
        Sun, 17 Oct 2021 03:05:05 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 91sm5202674ede.56.2021.10.17.03.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 03:05:05 -0700 (PDT)
Received: from avar by evledraar with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mc32O-0009yX-U2;
        Sun, 17 Oct 2021 12:05:04 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hamza Mahfooz <someguy@effective-light.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
Date:   Sun, 17 Oct 2021 11:44:31 +0200
References: <20211015161356.3372-1-someguy@effective-light.com>
 <20211015161356.3372-3-someguy@effective-light.com>
 <xmqq4k9i5a4n.fsf@gitster.g> <eddcbe66-b172-90b7-309e-e9ce5b5b44a4@web.de>
 <87zgr8dg8j.fsf@evledraar.gmail.com>
 <fc7eb9fc-9521-5484-b05f-9c20086fd485@web.de> <xmqq1r4k197p.fsf@gitster.g>
 <0ea73e7a-6d43-e223-ab2e-24c684102856@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <0ea73e7a-6d43-e223-ab2e-24c684102856@web.de>
Message-ID: <87r1ckc6gf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Oct 17 2021, Ren=C3=A9 Scharfe wrote:

> Am 17.10.21 um 08:00 schrieb Junio C Hamano:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>>>> Literal patterns are those that don't use any wildcards or case-foldi=
ng.
>>>>> If the text is encoded in UTF-8 then we enable PCRE2_UTF either if the
>>>>> pattern only consists of ASCII characters, or if the pattern is encod=
ed
>>>>> in UTF-8 and is not just a literal pattern.
>>>>>
>>>>> Hmm.  Why enable PCRE2_UTF for literal patterns that consist of only
>>>>> ASCII chars?
>>>>> ...
>>>>     echo 'Ren=C3=A9 Scharfe' >f &&
>>>>     $ git -P grep --no-index -P '^(?:You are (?:wrong|correct), )?Ren.=
 S' f; echo $?
>>>>     1
>>>>     $ git -P grep --no-index -P '^(?:You are (?:wrong|correct), )?R[e=
=C3=A9]n. S' f; echo $?
>>>>     f:Ren=C3=A9 Scharfe
>>>>     0
>>>>
>>>> So it's a choose-your-own adventure where you can pick if you're
>>>> right. I.e. do you want the "." metacharacter to match your "=C3=A9" o=
r not?
>>>
>>> Yes, I do, and it's what Hamza's patch is fixing.
>>
>> That may be correct but is this discussion still about "Why enable
>> ... for literal patterns that consist of only ASCII"?  Calling "." a
>> "metacharacter" and wanting it to match anything other than a single
>> dot would mean the pattern we are discussing is no longer "literal",
>> isn't it?  I am puzzled.
>
> Right, =C3=86var's comment is not about my question, but highlights an
> inconsistency in master that is fixed by Hamza's patch.

Yes, sorry about that. Just generally about the messy semantics.

> I'll repeat and extend my question: Hamza's patch enables PCRE2_UTF for
> non-ASCII patterns even if they are literal or our locale is not UTF-8.
> The following change would fix the edge case mentioned in its commit
> message without these side-effects.  Am I correct?
>
> diff --git a/grep.c b/grep.c
> index fe847a0111..5badb6d851 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -382,7 +382,7 @@ static void compile_pcre2_pattern(struct grep_pat *p,=
 const struct grep_opt *opt
>  		}
>  		options |=3D PCRE2_CASELESS;
>  	}
> -	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern=
) &&
> +	if (!opt->ignore_locale && is_utf8_locale() &&
>  	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
>  		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);

I haven't had time to carefully look into this, but one caveat to check
out is if it works with older PCRE and whether you need e.g. the
GIT_PCRE2_VERSION_10_36_OR_HIGHER.

I tried your suggestion on top of Hamza's series, compiled PCRE v2
10.23, tested, and also tried manually removing the
PCRE2_MATCH_INVALID_UTF flag and tested again.

We pass all tests with both, so maybe this is safe to do (or maybe we're
missing some test we haven't thought of yet...).

One thing that makes me nervous is that we had breakages in the past
once the patches escaped into the wild, particularly because the code
being modified here has is_utf8_locale(), and our tests run under
LANG=3Dc LC_ALL=3DC.

I tried running all the tests with a non-C locale, there's a lot of
failures, but none new with this change. As an aside the below patch
makes all but one shortlog test pass for me. I wonder if we shouldn't do
this for real to smoke out any $LANG or $LC_ALL dependencies.

I.e. almost all of the failures were due to relying on the sort order of
sort(1), and in one case comm(1), the first hunk here is also redundant
to defining our own ls(1) wrapper....

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index bd17f308b38..738ca6ef587 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -693,12 +693,12 @@ test_expect_success 'expire removes unreferenced pack=
s' '
 		^refs/heads/C
 		EOF
 		git multi-pack-index write &&
-		ls .git/objects/pack | grep -v -e pack-[AB] >expect &&
+		ls .git/objects/pack | sort | grep -v -e pack-[AB] >expect &&
 		git multi-pack-index expire &&
-		ls .git/objects/pack >actual &&
+		ls .git/objects/pack | sort >actual &&
 		test_cmp expect actual &&
-		ls .git/objects/pack/ | grep idx >expect-idx &&
-		test-tool read-midx .git/objects | grep idx >actual-midx &&
+		ls .git/objects/pack/ | sort | grep idx >expect-idx &&
+		test-tool read-midx .git/objects | sort | grep idx >actual-midx &&
 		test_cmp expect-idx actual-midx &&
 		git multi-pack-index verify &&
 		git fsck
@@ -802,7 +802,7 @@ test_expect_success 'expire works when adding new packs=
' '
 		refs/heads/E
 		EOF
 		git multi-pack-index expire &&
-		ls .git/objects/pack/ | grep idx >expect &&
+		ls .git/objects/pack/ | sort | grep idx >expect &&
 		test-tool read-midx .git/objects | grep idx >actual &&
 		test_cmp expect actual &&
 		git multi-pack-index verify
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8361b5c1c57..f4f9d231f28 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -417,14 +417,22 @@ test -n "$BASH_VERSION" && shopt -u checkwinsize 2>/d=
ev/null
=20
 # For repeatability, reset the environment to known value.
 # TERM is sanitized below, after saving color control sequences.
-LANG=3DC
-LC_ALL=3DC
+LANG=3Den_US.UTF-8
+LC_ALL=3Den_US.UTF-8
 PAGER=3Dcat
 TZ=3DUTC
 COLUMNS=3D80
 export LANG LC_ALL PAGER TZ COLUMNS
 EDITOR=3D:
=20
+sort () {
+	LC_ALL=3DC LANG=3DC command sort "$@"
+}
+
+comm () {
+	LC_ALL=3DC LANG=3DC command comm "$@"
+}
+
 # A call to "unset" with no arguments causes at least Solaris 10
 # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
 # deriving from the command substitution clustered with the other
