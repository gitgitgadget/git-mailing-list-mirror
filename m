Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3610FC4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 00:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiKVAHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 19:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKVAGx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 19:06:53 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9827208C
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 16:06:52 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id e13so18476553edj.7
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 16:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VI5xKAEAjLUL9lidTfU7vp80u8YhGgxQcxipIlKV8W0=;
        b=oDEOhnU+IKIPDjQgHduaxNuxSkR9W2yvHkHnIUHk9VPz8IH7+5elk2NZEhEk7/eNcC
         pivjmnY6cqMUwmo/b1aToAcif9ouuusSg7JZTsSmGtR6FczuhBBEe43M23zunw5GnZ3E
         h53g4o9mUbYGRJ9R1zQJGPbNPvokZXV9djwzQUaUvCMzkqgPOcffqfDdi9Dk7j0gU7Vy
         1leeECC1g+Rtwx8QKWeqm98RXVg3f4BOcebXJUtg/7qt/zBsamgqCMYJvM6fO2I3LCFX
         BHG7nKxwxIyfyDjdG9L+vVN5oyqpdQ8DylfHOxgufEOU47ozyKrkgjRop4WJw5QtYFkX
         GQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VI5xKAEAjLUL9lidTfU7vp80u8YhGgxQcxipIlKV8W0=;
        b=ttOiD7NRhXILpd0YwT6WpW8WLNF1+ZpkXbuS+TLzv39NbI5H13ew1W443Qs/jfAIEH
         xn6oftTl598pYRbfjm2ocqOMRWgrjr999DaooWVniaUQAJArYxdKmoPkx3BD8cTZXvmr
         w9u8wtrInDBn4JsYrSLAB5rKVRKYNkwd5epytLug7WoYVeGuyDWXe6hIy/jx4zmFEvMB
         uH83HGzq6Kdzm3dY4kX8UIbl2sfV4OPGH2bPOC36XVvSC7yGn+pEGem6io4/3jKlwPzK
         MpmeeLQ1qp/OpKSwl7Aqfqf2W2BxR9e7CFXJJLmhnFGUJF5xDDVvnvHfYsMEnZYJ/4sb
         Vbpw==
X-Gm-Message-State: ANoB5plhCip7jTi8EKX2NmjiumcrJTmfVCRLZsFrE37qTySia/fMRImK
        gbprAf4pIYwNhOH3P7pzt+c=
X-Google-Smtp-Source: AA0mqf5o150QIsgiiuskjwOAxaGjJkYDKncRbzZRgViGIQ0CoQFyzXDperXAgZ6ToF2//aE8xGoJDg==
X-Received: by 2002:a05:6402:1a:b0:467:30ad:c4ca with SMTP id d26-20020a056402001a00b0046730adc4camr18855669edu.285.1669075611028;
        Mon, 21 Nov 2022 16:06:51 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id er21-20020a056402449500b00451319a43dasm5725026edb.2.2022.11.21.16.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 16:06:50 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oxGoM-000Tsm-02;
        Tue, 22 Nov 2022 01:06:50 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] fixing parse_object() check for type mismatch
Date:   Tue, 22 Nov 2022 01:05:22 +0100
References: <Y3Up5Vi75Up8LaGQ@coredump.intra.peff.net>
 <20221116211419.439356-1-jonathantanmy@google.com>
 <Y3a3qcqNG8W3ueeb@coredump.intra.peff.net> <Y3fXYKj8PdS4EKLB@nand.local>
 <Y3vQ/6QcTEFfpjLt@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y3vQ/6QcTEFfpjLt@coredump.intra.peff.net>
Message-ID: <221122.86h6yrc0o6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 21 2022, Jeff King wrote:

> On Fri, Nov 18, 2022 at 02:05:04PM -0500, Taylor Blau wrote:
>
>> On Thu, Nov 17, 2022 at 05:37:29PM -0500, Jeff King wrote:
>> > I'm adding Taylor to the cc as the author of t6102, when we were
>> > tracking down all of these "oops, it's not really a blob" cases. This
>> > fixes one of the lingering cases from that test script.
>> >
>> >   [1/2]: parse_object(): drop extra "has" check before checking object=
 type
>> >   [2/2]: parse_object(): check on-disk type of suspected blob
>> >
>> >  object.c                               | 5 ++---
>> >  t/t6102-rev-list-unexpected-objects.sh | 4 ++--
>> >  2 files changed, 4 insertions(+), 5 deletions(-)
>>=20
>> A blast from the past :-).
>>=20
>> I took a careful look at both of these patches and they looked good to
>> me, so let's start merging them down.
>
> I saw this hit 'next', but I think =C3=86var's simplification suggestion =
is
> worth taking. So here is a patch on top to do so (the original branch is
> jk/parse-object-type-mismatch for the benefit of any newly-returned
> maintainers).
>
> I was going to do a "helped-by", but since the only thing in the patch
> is the suggested change, I just handed over authorship. :)
>
> I didn't forge a signoff, and I think mine is sufficient under DCO's
> part (b), but =C3=86var please indicate if that's OK.

This looks good to me, thanks for following up. In case my SOB is needed
feel free to add it, but it's fine without that too as far as I'm
concerned.

> -- >8 --
> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Subject: [PATCH] parse_object(): simplify blob conditional
>
> Commit 8db2dad7a0 (parse_object(): check on-disk type of suspected blob,
> 2022-11-17) simplified the conditional for checking if we might have a
> blob. But we can simplify it further. In:
>
>   !obj || (obj && obj->type =3D=3D OBJ_BLOB)
>
> the short-circuit "OR" means "obj" will always be true on the right-hand
> side. The compiler almost certainly optimized that out anyway, but
> dropping it makes the conditional easier to understand for humans.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/object.c b/object.c
> index fad1a5af4a..682b852a46 100644
> --- a/object.c
> +++ b/object.c
> @@ -286,7 +286,7 @@ struct object *parse_object_with_flags(struct reposit=
ory *r,
>  			return &commit->object;
>  	}
>=20=20
> -	if ((!obj || (obj && obj->type =3D=3D OBJ_BLOB)) &&
> +	if ((!obj || obj->type =3D=3D OBJ_BLOB) &&
>  	    oid_object_info(r, oid, NULL) =3D=3D OBJ_BLOB) {
>  		if (!skip_hash && stream_object_signature(r, repl) < 0) {
>  			error(_("hash mismatch %s"), oid_to_hex(oid));

