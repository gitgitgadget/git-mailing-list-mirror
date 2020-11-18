Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B2FC3E8C5
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 17:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF8A4248EB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 17:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="JrFmKl5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgKRRrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 12:47:32 -0500
Received: from mout.web.de ([212.227.17.11]:46977 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgKRRrc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 12:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1605721637;
        bh=5m9W9hleV/EajUdzBJZKH8VI8QIki1t6ls4Fzv0Jvd4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JrFmKl5fyLFS+b06paG3Wvocou7wNixuvGJpKohGamBPFYwRqkTmQcBME5RGEuVve
         SjAkuU5A9/eQX8QG7kxj2GUeCIgyNmsnldyZhZdyaQhNBfmOmAHA49SaR+I9DnM5lq
         7YGhLOYunYv7L+b2Hak1FbJFhZ1WlzcnwBqTh0DI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LyDlZ-1k9M0031CX-015aiR; Wed, 18
 Nov 2020 18:47:17 +0100
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
To:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <223b14f7-213f-4d22-4776-22dcfd1806c2@web.de>
 <7b95417a-c8fb-4f1e-cb09-c36804a3a4d0@web.de>
 <20181005165157.GC11254@sigill.intra.peff.net>
 <dca35e44-a763-bcf0-f457-b8dab53815cf@web.de>
 <20181005190847.GC17482@sigill.intra.peff.net>
 <c05f192b-4e89-48b0-1c23-b43ec6fdb74b@web.de>
 <20181005194223.GA19428@sigill.intra.peff.net>
 <c141fb44-904f-e8b6-119f-7d2d6bcfd81a@web.de>
 <20181017083340.GB31932@sigill.intra.peff.net>
 <20201118021605.GB360414@google.com>
 <20201118065437.GA16996@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c236ca17-0f9e-a900-8a50-f467eaf6b485@web.de>
Date:   Wed, 18 Nov 2020 18:47:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201118065437.GA16996@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HKxqxCqDaMFCIXtYCMExi/G9yYlQLp0mYKRBgPSb8QIZpb/fXyn
 CTV+DyCgJB+UgfyS7mY/m9l7PJT4myFnUoZOFFTuL4wuRZ9R9spa5NWouKeqKfDfEOghdrK
 toMg2Cg/Ymc/W+0dEhPcLda4rM8XnthvocbilcnV3uSyDaZ9PDvf9Db1p1XA0yCx0U81ZaI
 wBQklu3uP5bWz7xUKsskA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zROr22PePhE=:KL8hQ9S46IgxdHyWHtU3SV
 9fxNVUSknm9a0T5hNdHLy7T4bQ+d6l96O7vBNJrSJCRcc/oFLckNEQPEuFmZN4+iaewKqxzSt
 hgKqL1fwzdzf/EgtqEJZY3dnbv2dBvXtul0EVFEnj/rV3trZiwLNLd1cdlu0ksj8SMDsPUYps
 chXyB/FwU3AS3+SLr/7hON+gGq3+E5kT8LwaYgQi3/LyjAW/+JX3wNUQ69nh4nxErYVkqz5+F
 X+wxKY0+R4+lbTJnBixvwtfA0ycc8xdSEVvWdzQRhoCWwE2RU8gebWpPGnzgn9cDOSYcSE4pW
 mzLxvgO5W0piPwHLwAiKhIbc3xrUB/fCVDdi+cVvUTqBH/ZJv4QxVJ0NQFpW2BLFldmE/ius8
 QHFjLfqVpUE5zrAncFpPR+ZnhvO6wiW++8VTivIEqT6xfav3U6d6hLsYgf0ZtPfLOAhzVrQrI
 9hjZ24tc/17XGFxAZy6nac81UOG5tML7qa7wKGg2eWRY4OJ53qV920GhnFvRuFoHHX1cxvEMm
 7SJh8WBCocmew1jn+bk9eVH9EO+13qftaidujaWeJyXW7aqX0UEn9PtuufjhVifAlIc3eYzG4
 1MT45TCf3vJ/6yEsoRKg5dmRaU+StTt/AFXEcuSX2Xa9begWKpbNVDjx/MRqR+7cS6EC3nJPD
 yUkLxxYLPOr+kscWaemXifnfd8RCvZY3Ri9l+yXTHDP0bg98a0dpUZmNOku555a6rv9hKnpKn
 1m1M/xAUW5J73L70Nf6G4U5InvxZlOfo/evAlpBIcRUwCT6+mqrWJwGjb7xxklzajOkS0p8CB
 9uR2J2UeG6YInTMjuBaECVxx6CHz9YRQV7mt/L3NULhbMhGJm+Dy2xUx/bJNZsIi27sxMlPxp
 CoiQe8yUZFdwFH5AzCiA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.11.20 um 07:54 schrieb Jeff King:
> On Tue, Nov 17, 2020 at 06:16:05PM -0800, Jonathan Nieder wrote:
>
>> Since this came up in [1], I took a glance at this.
>>
>> I also think it looks reasonable, though it's possible to do better if
>> we're willing to (1) cast between pointers to function with different
>> signatures, which is portable in practice but I don't believe the C
>> standard speaks to and (2) conditionally make use of gcc extensions,
>> for typechecking.
>
> The C standard definitely is not OK with calling a function through a
> wrong declaration or cast. I won't find chapter and verse

http://www.open-std.org/jtc1/sc22/WG14/www/docs/n1256.pdf is a draft for
C99, and says under 6.3 Conversions, 6.3.2.3 Pointers, paragraph 8:

   If a converted pointer is used to call a function whose type is not
   compatible with the pointed-to type, the behavior is undefined.

> Now in practice you're probably fine as long as the number and sizes of
> the parameters are the same between the function definition and what the
> caller casts to. And so if we're talking about casting individual
> parameters between a void parameter and another pointer, that would
> usually be fine (in practice; the standard only says that void can store
> the type of anything, so it _could_ be larger than some other pointers.
> I don't know of any modern systems where this is true, though).
>
> Which is all a roundabout way of saying that yes, I think this kind of
> cast is probably OK in practice.
>
> I _think_ the ccan type-checking macro you pointed to would catch this
> sufficiently on systems with typeof() that it would also protect systems
> with different calling conventions. But I admit it's pretty dense.
>
> So I dunno. The nice thing is that this puts the ugliness all inside of
> QSORT(), which becomes magically type-safe. But it involves importing a
> lot of tricky bits under the hood.

A generic and type-safe QSORT would be nice, but if it calls a function
via a converted pointer then it's technically relying on undefined
behavior unless I misunderstand the standard.  I prefer occasional
mistakes (that are caught by ASan or USan or when the sort order actually
matters) to guaranteed undefined behavior that happens to work, until it
doesn't.

> The downside of Ren=C3=A9's patch is that it hides the declaration of th=
e
> comparison function (and the typesafe wrapper) inside a macro. But the
> resulting code is (IMHO) pretty easy to comprehend.

I tried some more variants back then, before I dropped the ball
eventually when RL distracted me.  I think my favorite one was a
DEFINE_SORT macro that took the name of a typed comparison function --
the code looks more like normal C.

Handling arrays of pointers was a bit tricky, and I had to introduce
DEFINE_PTR_SORT and DEFINE_CONST_PTR_SORT for them, but they allowed to
use the same comparison functions -- they consistently took element
pointers.  Just one rule to follow, and the compiler would yell when
a mismatched macro was used.

And at that point it occurred to me that comparison functions would
ideally take two elements, not pointers.  All the pointer mangling
could be done in generated code.  GCC and Clang inline it
appropriately, so this convenience would be free -- but other
compilers don't, and that would make sorting more expensive on those
platforms.  Dead end.

The last one I looked at was a dumbed-down version, but I think this
requires some weird comparison function signatures in some cases
(patch below, basically untested).

I can understand now why monomorphization approaches like
https://github.com/attractivechaos/klib/blob/master/ksort.h seem
attractive (no pun intended)..

Ren=C3=A9

=2D--
 git-compat-util.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index adfea06897..8d871a8e33 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1124,6 +1124,23 @@ int git_qsort_s(void *base, size_t nmemb, size_t si=
ze,
 		BUG("qsort_s() failed");			\
 } while (0)

+#define DECLARE_COMPARE(scope, compar)					\
+scope int compar##__void(const void *, const void *)
+
+#define DEFINE_COMPARE(scope, compar)					\
+scope int compar##__void(const void *a_void_ptr,			\
+			 const void *b_void_ptr)			\
+{									\
+	return compar(a_void_ptr, b_void_ptr);				\
+}									\
+DECLARE_COMPARE(scope, compar)
+
+#define GET_COMPARE(base, compar)					\
+(0 && compar((base), (base)) ? NULL : compar##__void)
+
+#define SORT_ARRAY(base, n, compar)					\
+QSORT((base), (n), GET_COMPARE((base), compar))
+
 #ifndef REG_STARTEND
 #error "Git requires REG_STARTEND support. Compile with NO_REGEX=3DNeedsS=
tartEnd"
 #endif
=2D-
2.29.2
