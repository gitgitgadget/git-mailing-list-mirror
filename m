Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676CEC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 07:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C1060FEF
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 07:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbhDLHKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhDLHKH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 03:10:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E97C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 00:09:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h10so13711078edt.13
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 00:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version:content-transfer-encoding;
        bh=4B5pYd1SHbeOpl/iq+y3jRHbnoHJ6zNJ1GC+Gz6y/IQ=;
        b=Qm5elI6CMEGQ+rxpOMtoht5nNFfIGMPFFcUw/OiDFpn7D9+3Qvk6JA0+d5ck2lkWyc
         W3aR9uvuG7i9k6opidRq8RLdPBdIbG8e4HPAX2qm/NbgF5Ham6Q7iKChxjnr5BT+ADsv
         aDHSq2ALpNOXFEn9o9FQkshkxIWM+4l7veZp1lCR/7Ns7PF5tS5HnfzgoXIJKI+izwbB
         pI6iR78LU2UnXlWgFbjXTQofwqfQeRmB7hEpZ5UjgJdFS8mThOZhPF5jbMC3v62oKn8V
         rWbrYA7+Zm8Dji7SQXwoHw64l2W9IxQ3vpz/85W5uIFykKDvpyHNnH9uwk2nStoN/pED
         eMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version:content-transfer-encoding;
        bh=4B5pYd1SHbeOpl/iq+y3jRHbnoHJ6zNJ1GC+Gz6y/IQ=;
        b=K6aiwy+cRm3TBogNbB16T26klktLVYsMvNhVuE63BE1Hi37TcOhxRgEIZKfZFr60gt
         evVyJmgljMxs6xFwRLyFdnEgUzdO/iCy19JbGAndPdt/XLBwCSx+rP4b0Y6MwK453Fsi
         rlxKayKD8Hdjow/6/GJOZHnrIweRXP9TtT/3qytbpzeAiGt4ilLaQuilz6kgJdorNS8G
         cYf83ktfjEv4sSBLGfPp3eLxaGrM98BKnr1dfSVnUeGiq2qWPkoKnBODV4jlGsPMarsA
         G0/ysFxRw4/90FDBvvfyUybuW1yEtNKYUfYrOzUD3XWdQ7jW8t+l/yYJDYlEgiL71TgG
         h31A==
X-Gm-Message-State: AOAM532YxsqXinDjJanHmsovyPq/ZLTBDZuxGLZ5xAm1XaJmhNJ9gE+N
        rf02pdniXfZZ2znJvJV62uU2/JTuFGdDxg==
X-Google-Smtp-Source: ABdhPJyW1PFw8U4V6qbK7g16t42Bsqsw+HiJcC0ZtlnYQc/MKm6/qRA6ZnYmXUovkz40IGkEsZ9SxA==
X-Received: by 2002:a50:c004:: with SMTP id r4mr27190519edb.192.1618211388742;
        Mon, 12 Apr 2021 00:09:48 -0700 (PDT)
Received: from cpm12071.fritz.box ([79.140.122.112])
        by smtp.gmail.com with ESMTPSA id bw14sm4444615ejb.89.2021.04.12.00.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 00:09:47 -0700 (PDT)
References: <20210403090412.GH2271@szeder.dev>
 <gohp6ko8et3jdm.fsf@cpm12071.fritz.box>
 <YG4hfge2y/AmcklZ@coredump.intra.peff.net>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: rather slow 'git repack' in 'blob:none' partial clones
In-reply-to: <YG4hfge2y/AmcklZ@coredump.intra.peff.net>
Message-ID: <gohp6kim4sf07b.fsf@cpm12071.fritz.box>
Date:   Mon, 12 Apr 2021 09:09:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Jeff King <peff@peff.net> writes:

> On Mon, Apr 05, 2021 at 03:02:33AM +0200, Rafael Silva wrote:
>
>> I'm not entirely sure about this (not this late in the day), but it seem=
s to
>> me that we should simply skip the "missing" (promisor) files when
>> operating on a partial clone.
>>=20
>> Perhaps something like:
>>=20
>> --- >8 ---
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index 525c2d8552..fedf58323d 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -3468,6 +3468,8 @@ static int loosened_object_can_be_discarded(const =
struct object_id *oid,
>>  {
>>         if (!unpack_unreachable_expiration)
>>                 return 0;
>> +       if (exclude_promisor_objects && is_promisor_object(oid))
>> +               return 1;
>>         if (mtime > unpack_unreachable_expiration)
>>                 return 0;
>>         if (oid_array_lookup(&recent_objects, oid) >=3D 0)
>> --- >8 ---
>
> you are avoiding writing out the file. But we should realize much
> earlier that it is not something we need to even consider loosening.
>
> In the loop in loosen_unused_packed_objects(), we skip packs that are
> marked as "keep", so we'd skip the new promisor pack entirely. But we'd
> still see all these objects in the _old_ promisor pack. However, for
> each object there, we call has_sha1_pack_kept_or_nonlocal(), so that
> would likewise realize that each object is already being kept in the
> other pack.
>

Agreed. Realizing sooner that we shouldn't even consider loosening the
objects from the packfile it's better solution.

> Something like this seems to work, but I only lightly tested it, and it
> could probably use some refactoring to make it less horrible:
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index fdee8e4578..457525953a 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -574,6 +574,23 @@ int cmd_repack(int argc, const char **argv, const ch=
ar *prefix)
>  		repack_promisor_objects(&po_args, &names);
>=20=20
>  		if (existing_packs.nr && delete_redundant) {
> +			/*
> +			 * tell pack-objects about our new promisor pack, which
> +			 * we will also be keeping
> +			 */
> +			for_each_string_list_item(item, &names) {
> +				/*
> +				 * yuck, we seem to only have the name with the
> +				 * packdir prefixed
> +				 */
> +				const char *prefix;
> +				if (!skip_prefix(packtmp, packdir, &prefix) ||
> +				    *prefix++ !=3D '/')
> +					BUG("confused by packtmp");
> +				strvec_pushf(&cmd.args, "--keep-pack=3D%s-%s.pack",
> +					     prefix, item->string);
> +			}
> +
>  			if (unpack_unreachable) {
>  				strvec_pushf(&cmd.args,
>  					     "--unpack-unreachable=3D%s",
>
> Do you want to try to work with that?
>

Yes, I'll try to work with that, together with refactoring that you
mentioned in the code and the other replies.

Thanks for the suggestion.

>> A quick benchmark did show some promising result:
>>=20
>>     # built from: 2e36527f23 (The sixth batch, 2021-04-02)
>>     Benchmark #1: ./bin-wrappers/git -C git.git gc
>>           Time (mean =C2=B1 =CF=83):     135.669 s =C2=B1  0.665 s    [U=
ser: 42.789 s, System: 91.332 s]
>>           Range (min =E2=80=A6 max):   134.905 s =E2=80=A6 136.115 s    =
3 runs
>>=20
>>     # built from: 2e36527f23 + minor patch (from above)
>>     Benchmark #2: ./bin-wrappers/git -C git.git gc
>>           Time (mean =C2=B1 =CF=83):     12.586 s =C2=B1  0.031 s    [Us=
er: 11.462 s, System: 1.365 s]
>>           Range (min =E2=80=A6 max):   12.553 s =E2=80=A6 12.616 s    3 =
runs
>>=20
>>     Summary:
>>           'Benchmark #2' ran 10.78 =C2=B1 0.06 times faster than 'Benchm=
ark #1'
>
> It's still quite a bit slower than a non-partial clone because the
> traversal with --exclude-promisor-objects is slow. I think that's
> because it has to open up all of the objects in the promisor pack to see
> what they refer to. I don't know if we can do better (and it's largely
> an orthogonal problem to what you're solving here, so it probably makes
> sense to just punt on it for now).
>
> -Peff

Make sense.

--=20
Thanks
Rafael
