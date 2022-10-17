Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0A9C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 18:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJQSro (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 14:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJQSrm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 14:47:42 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFBD6CD39
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 11:47:41 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id m16so17378725edc.4
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 11:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/4I6mKXPRgNWpyLHFEvKdQgpvaJrFJWT2bky6XLlmNQ=;
        b=dFMGv2hjsNA50jylbafQFOKLecwjUlPcXjqN2/SAQVXUMoILDN7RpO9mK7SGGFzIIo
         UTusv+lyDR48BC8kUdEKWw+DtA/Bs/j2RHfR0I888ulysfitf44C87cafiq6yDOO87ax
         gC+83i4Llltpj+0onUwrDOCwjV1h6nzRzyo+fHDZkX70J5ZYEw0r59e2cPZeD/NSvwGL
         3W6KFm11RfMQJxuGI2vAMlGzKWbCxYOq5uGUqz2nH2D4FOONAT4ffWkSyO8nzh7eBBso
         U8BDd1Rv80R+GJxa1pP95G9gMIn/A37lvHKhMWr2wsBcHeq/eggQTAXhY9wbpFskEIFp
         SB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/4I6mKXPRgNWpyLHFEvKdQgpvaJrFJWT2bky6XLlmNQ=;
        b=oka1XydeZ4UzRISuNzc2DMRSTguHY6Ix4qIEpAfTZLghBq+QxdvVXzvXLxqeoeXeOX
         KtdmrbsScy1fl+OZs8w+RLBgvwyD31OXR1lbhpadlYLuIMYDbBwxFPbvlpH8M03S1mLm
         ModJz0GBXw/3verSnC1J/MPk5Pr0Z4C1X/Fjhke/4II2BdfMjPt98X+5qmJbLxaP4oku
         eQLqqag6ckMz3I0Vn81BcQJ5k1jkBGpHJhN4DAr0Tn1P5lVF7xHu5BF2gG4fGy9hj8Tk
         evuL+DACuk+7HPSD5TkSC6ImxLvgQjj/OE8Q4baTfhsNwKQFf7ubtN7d5DKZyTH2tkDu
         ZcRQ==
X-Gm-Message-State: ACrzQf14Rm7NnA6ChjDs5uCH1p8lIVDMDTyVMKLkNMs8scX1RkUiW/tP
        Gcq+GFsoZTrBvXur+ZQys+Y=
X-Google-Smtp-Source: AMsMyM7Fdi78D3GVUkEjkWGKNyXWRnBtnJWEHUFTHLxB4qU2GsINKqh+/FJx/SmB1E9u/P8jgUQI7Q==
X-Received: by 2002:a05:6402:34cd:b0:45d:a345:764 with SMTP id w13-20020a05640234cd00b0045da3450764mr4484885edc.415.1666032459349;
        Mon, 17 Oct 2022 11:47:39 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c21-20020a17090603d500b00764a76d5888sm6420565eja.27.2022.10.17.11.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:47:38 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1okV9G-005bWh-0G;
        Mon, 17 Oct 2022 20:47:38 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 00/11] cocci: make "incremental" possible + a
 ccache-like tool
Date:   Mon, 17 Oct 2022 20:36:46 +0200
References: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
 <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
 <Y02V0E0JRSNa4Sb9@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y02V0E0JRSNa4Sb9@coredump.intra.peff.net>
Message-ID: <221017.86czaqjnhy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 17 2022, Jeff King wrote:

> On Fri, Oct 14, 2022 at 05:31:16PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> The big change in this belated v3 is that we now run against a
>> concatenated version of all our *.cocci files. This is something I
>> discussed with Jeff King at Git Merge, after having confirmed the
>> viability of that approach on the cocci mailing list.
>
> Is that safe? The last time it was brought up on this list (AFAIK) was
> in:
>
>   https://lore.kernel.org/git/alpine.DEB.2.20.1808030755350.2446@hadrien/
>
> where Julia said:
>
>   I'm surprised that the above cat command would work.  Semantic patch ru=
les
>   have names, and Coccinelle will not be happy isf two rules have the same
>   name.  Some may also have variables declared in initializers, although
>   perhaps the ones in the kernel don't do this.  Causing these variables =
to
>   be shared would not have a good effect.
>
>   Putting everything together can also go counter to the optimizations th=
at
>   Coccinelle provides. [...]
>
> Maybe we don't do any of the things that could trigger problems in our
> spatch rules. But it's not clear to me what we're risking. Do you have a
> link for further discussion?

I think 10/11's commit message should answer your question:
https://lore.kernel.org/git/patch-v3-10.11-52177ea2a68-20221014T152553Z-ava=
rab@gmail.com/

The tl;dr is that it's not safe in the general case, as noted in the
post you & the more recent one I linked to in 10/11.

So, with this series doing:

	perl -pi -e 's/swap/preincrement/g' contrib/coccinelle/swap.cocci

Will error it if you run it with "SPATCH_CONCAT_COCCI=3DY", but not with
"SPATCH_CONCAT_COCCI=3D", as the rule names conflict in the ALL.cocci.

But as 10/11 notes we can just avoid this by not picking conflicting
names, which doesn't seem like an undue burden.

AFAICT we have 5 named rules, and seemingly only 1/4 actually needs its
name, the rest are apparently only using it for self-documentation, and
we could either remove the name, or accomplish the same with a comment:
=09
	diff --git a/contrib/coccinelle/hashmap.cocci b/contrib/coccinelle/hashmap=
.cocci
	index d69e120ccff..c5dbb4557b5 100644
	--- a/contrib/coccinelle/hashmap.cocci
	+++ b/contrib/coccinelle/hashmap.cocci
	@@ -1,4 +1,4 @@
	-@ hashmap_entry_init_usage @
	+@@
	 expression E;
	 struct hashmap_entry HME;
	 @@
	diff --git a/contrib/coccinelle/preincr.cocci b/contrib/coccinelle/preincr=
.cocci
	index 7fe1e8d2d9a..ae42cb07302 100644
	--- a/contrib/coccinelle/preincr.cocci
	+++ b/contrib/coccinelle/preincr.cocci
	@@ -1,4 +1,4 @@
	-@ preincrement @
	+@@
	 identifier i;
	 @@
	 - ++i > 1
	diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.c=
occi
	index 0970d98ad72..5f06105df6d 100644
	--- a/contrib/coccinelle/strbuf.cocci
	+++ b/contrib/coccinelle/strbuf.cocci
	@@ -1,4 +1,4 @@
	-@ strbuf_addf_with_format_only @
	+@@
	 expression E;
	 constant fmt !~ "%";
	 @@
	diff --git a/contrib/coccinelle/swap.cocci b/contrib/coccinelle/swap.cocci
	index a0934d1fdaf..522177afb66 100644
	--- a/contrib/coccinelle/swap.cocci
	+++ b/contrib/coccinelle/swap.cocci
	@@ -1,4 +1,4 @@
	-@ swap_with_declaration @
	+@@
	 type T;
	 identifier tmp;
	 T a, b;
=09
