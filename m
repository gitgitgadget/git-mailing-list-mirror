Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0DBC61DB3
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 09:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjALJeL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 04:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239908AbjALJdR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 04:33:17 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D0CB40
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:28:16 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v10so24761357edi.8
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ryDSHIbpT2K2bf+8o4bqnbpe8SrMwY7dIdrYBBW0K1E=;
        b=Y8sqJF3BugsqMJWtVBPCUbq3mCkssGvJT6+AVx1MiGYjbCNjkDY02qsGfD+4cosUI6
         Gt5z9BHq6Gdc5EQ7buJ0g8FSpAvj/52mdd4/hv8G5vmQZ73sKJUcmAIitpbconEcOwYR
         fUACwuuEek2kG7QbetdlR5b+UseM0fGnIQPcb68d9K+iFvQ9tI+67U+XdUSgHK2LvaYt
         0znLR3VnlCJ6hqHRt4SnOzxMdO/5BX9Xxzymdf92Y0cvzbdP7139O/oJi5n8fIuSO63t
         ZWBbPzDTefy2q3BORHWvt4MogG0QUPNBvn0BFXQzfpzI5rU6VhL7gP8M1lAIkHAwuvzH
         vbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ryDSHIbpT2K2bf+8o4bqnbpe8SrMwY7dIdrYBBW0K1E=;
        b=W1jbb9Iz1BIro8eQ8nbowqoBxe3jqpS14ZGkGLwhMdUg5MtJEZE+eqWxQvAuH9BjNi
         M4nGzBEBIFZlOpqvL4I6CJrKTU/3OdibnUo3JmwOMzv1UFID5JREpB/FOmhxQQyY1BhE
         x/hOPjx/EngLx9leo0GOZeHm4Aw8m7HSa6kHWSp/l4TimpDMbpfGeXyfQcQGGhEemClH
         TXFUhNyhgBmNI20s9QWOnas294A11B0MFDgBcJRPopyYKgVxdsymbNOgRzKE8W9GGfYR
         ZMD5DxIBiaVQpxdWBq7IUGLo8lZYd2i9siBRita4jrTQkCrqPFBJXJsfJwp/PUCYjPQD
         q8Qw==
X-Gm-Message-State: AFqh2kqKrP3Yn+Slmv04ATny3uS4VQ4+n+6FJrIwlboJlMieBf4x4hkw
        Bp+R3QFdjL2bjlmZdZWKUJzNwukZZ1g=
X-Google-Smtp-Source: AMrXdXsv5NqAC9x1qlWxghVgze1P1ymjT6V57fSqNboq2ToPkKU/t6aB0CUFfA6e6lq/iXfa1GfsRw==
X-Received: by 2002:a05:6402:25c6:b0:46c:d2a3:76b3 with SMTP id x6-20020a05640225c600b0046cd2a376b3mr69706997edb.14.1673515694464;
        Thu, 12 Jan 2023 01:28:14 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id l15-20020aa7c3cf000000b00467481df198sm6955975edr.48.2023.01.12.01.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 01:28:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pFtsb-00064y-1T;
        Thu, 12 Jan 2023 10:28:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 0/5] cleaning up read_object() family of functions
Date:   Thu, 12 Jan 2023 10:21:46 +0100
References: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
 <f1028cba-5fc6-3584-3f21-545550012e9d@github.com>
 <Y77/T8dktee3wOA5@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y77/T8dktee3wOA5@coredump.intra.peff.net>
Message-ID: <230112.86fscg2jbm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 11 2023, Jeff King wrote:

> On Mon, Jan 09, 2023 at 10:09:32AM -0500, Derrick Stolee wrote:
>
>> I did think that requiring callers to create their own object_info
>> structs (which takes at least four lines) would be too much, but
>> the number of new callers is so low that I think this is a fine place
>> to stop.
>
> Yeah, that was my feeling. I do wonder if there's a way to make it
> easier for callers of oid_object_info_extended(), but I couldn't come up
> with anything that's nice enough to merit the complexity.
>
> For example, here's an attempt to let the caller use designated
> initializers to set up the query struct:
>
> diff --git a/object-file.c b/object-file.c
> index 80b08fc389..60ca75d755 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1700,13 +1700,12 @@ void *repo_read_object_file(struct repository *r,
>  			    enum object_type *type,
>  			    unsigned long *size)
>  {
> -	struct object_info oi =3D OBJECT_INFO_INIT;
>  	unsigned flags =3D OBJECT_INFO_DIE_IF_CORRUPT | OBJECT_INFO_LOOKUP_REPL=
ACE;
>  	void *data;
> +	struct object_info oi =3D OBJECT_INFO(.typep =3D type,
> +					    .sizep =3D size,
> +					    .contentp =3D &data);
>=20=20
> -	oi.typep =3D type;
> -	oi.sizep =3D size;
> -	oi.contentp =3D &data;
>  	if (oid_object_info_extended(r, oid, &oi, flags))
>  	    return NULL;
>=20=20
> diff --git a/object-store.h b/object-store.h
> index 1a713d89d7..e894cee61b 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -418,7 +418,8 @@ struct object_info {
>   * Initializer for a "struct object_info" that wants no items. You may
>   * also memset() the memory to all-zeroes.
>   */
> -#define OBJECT_INFO_INIT { 0 }
> +#define OBJECT_INFO(...) { 0, __VA_ARGS__ }
> +#define OBJECT_INFO_INIT OBJECT_INFO()
>=20=20
>  /* Invoke lookup_replace_object() on the given hash */
>  #define OBJECT_INFO_LOOKUP_REPLACE 1
>
> But:
>
>   - it actually triggers a gcc warning, since OBJECT_INFO(.typep =3D foo)
>     sets typep twice (once for the default "0", and once by name). In
>     this case the "0" is superfluous, since that's the default, and we
>     could just do:
>
>       #define OBJECT_INFO(...) { __VA_ARGS__ }
>       #define OBJECT_INFO_INIT OBJECT_INFO(0)
>
>     but I was hoping to find a general technique for object
>     initializers.
>
>   - it's not really that much shorter than the existing code. The real
>     benefit of "data =3D read_object(oid, type, size)" is the implicit
>     number and names of the parameters. And the way to get that is to
>     provide an extra function.
>
> So I think we are better off with the code that is longer but totally
> obvious, unless we really want to add a function wrapper for common
> queries as syntactic sugar.
>
> -Peff

I agree that it's probably not worth it here, but I think you're just
tying yourself in knots in trying to define these macros in terms of
each other. This sort of thing will work if you just do:
=09
	diff --git a/object-store.h b/object-store.h
	index e894cee61ba..bfcd2482dc5 100644
	--- a/object-store.h
	+++ b/object-store.h
	@@ -418,8 +418,8 @@ struct object_info {
	  * Initializer for a "struct object_info" that wants no items. You may
	  * also memset() the memory to all-zeroes.
	  */
	-#define OBJECT_INFO(...) { 0, __VA_ARGS__ }
	-#define OBJECT_INFO_INIT OBJECT_INFO()
	+#define OBJECT_INFO_INIT { 0 }
	+#define OBJECT_INFO(...) { __VA_ARGS__ }
=09=20
	 /* Invoke lookup_replace_object() on the given hash */
	 #define OBJECT_INFO_LOOKUP_REPLACE 1

Which is just a twist on Ren=C3=A9's suggestion from [1], i.e.:

	#define CHILD_PROCESS_INIT_EX(...) { .args =3D STRVEC_INIT, __VA_ARGS__ }

In that case we always need to rely on the "args" being init'd, and the
GCC warning you note is a feature, its initialization is "private", and
you should never override it.

But likewise you don't need the "0" there, if the user provides an empty
list that's their own fault, they should use OBJECT_INFO_INIT
instead.

If they do provide arguments it's an implementation detail how any
"default" arguments get init'd, if they're not clobbering any "private"
arguments we're OK.

So using an explicit "0" is the same as providing nothing in the
"*_ARGS()" case, in both cases we're just offloading that zero-init to
the language.

The only way I think you can dig yourself into a proper hole here is if
you're trying to support 0 or N args, as P99 shows that's possible, but
quite complex (and not worth it, IMO).

1. https://lore.kernel.org/git/749f6adc-928a-0978-e3a1-2ede9f07def0@web.de/
