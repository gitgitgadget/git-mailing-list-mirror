Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BABAE7849C
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 00:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbjJBAtE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 20:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJBAtD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 20:49:03 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFDAA6
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 17:49:00 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-79fe612beabso283499839f.3
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 17:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696207739; x=1696812539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7PBn1uMZgvd3sbhBByjxO2ePwuH47zPU06vLl1WfXNE=;
        b=KONuGCgqvWj8BVY+Q+2va5fmcvpNFNxrAKaozdby6Ja7seCdPrvMojrCVAJw1ad3eH
         qM2VmEwYcIXIyFkLHIQplbA6mC+jtNUf5Tvd0lOizNKydnvV/JIhfATslboL3dvEvc4p
         bCE+02UueqVtDf1Cv0LyhJO483bdN4+Bfm+lKHAizPvn34RcnXWr7IZuDlfgW+3UhLk8
         jjf2AQHM+OASLOB9nbgCi5N+qATe9VXlQ+XFojHSjW+IETVpHPaAuClMnfxkEKWWT4Ep
         EeZAjGuCrKdhx3XcAbbUqbRbTIx4VIqUjAu7ZorlhSK9WltjKhTv+gatSokk2Ioqc7sj
         ApsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696207739; x=1696812539;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7PBn1uMZgvd3sbhBByjxO2ePwuH47zPU06vLl1WfXNE=;
        b=Pn2N+p1jrHhSg9Wqr6UwbrHsLCMx2MVFURu3TdqEPP/dmOSH4pq0cqpKn5h62GVa4u
         f4W4u240dUStRcplK3LrUJ/nFc3QSaQ2NdC5JU78QEw+XjI8PJ7bUq+r7wyHt5TdMVaa
         UEOliE455yjykun1bq/NdLubPEm4OTcS3skNzEahFwmKvLXuFoLP9s1eU6KbYjvoyUbU
         ha7WNK5UOg2dNyIt0GfxjY8MTLHXmrpJKMYYoRP2wN/Y6O2+/RdNKcr0b7VZfAtsGi+O
         GDshXNRr2vkTWgSMrnV/kjGEYmDrij1Ty9PLzdZHtoYxeSomiYzQmOCST1RBmYruLrJw
         hQ6g==
X-Gm-Message-State: AOJu0YxjwRplxzKJ1noOmDsDZkCBue4AEeDiHLUy9iHNE8aYZeZo5Dxf
        braYYpQT14GAnetzkh/Nga/XSRjmUBg=
X-Google-Smtp-Source: AGHT+IEvhhJ93rWgWBYEf/S6cSmFTCIWCbAVYXozFjsK/r2OD1I9gKbhrvn3/T0FrXiinmbWYtloSg==
X-Received: by 2002:a92:c26a:0:b0:350:e9c6:e765 with SMTP id h10-20020a92c26a000000b00350e9c6e765mr13242312ild.11.1696207739452;
        Sun, 01 Oct 2023 17:48:59 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id l2-20020a92d8c2000000b00352832ac0b0sm654448ilo.84.2023.10.01.17.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 17:48:58 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 21/30] repository: Implement extensions.compatObjectFormat
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
        <20230927195537.1682-21-ebiederm@gmail.com>
        <xmqqfs2zl2iy.fsf@gitster.g> <xmqqbkdmjbkp.fsf@gitster.g>
        <87bkdkhq4s.fsf@gmail.froward.int.ebiederm.org>
        <xmqqedigizms.fsf@gitster.g>
Date:   Sun, 01 Oct 2023 19:48:56 -0500
In-Reply-To: <xmqqedigizms.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        29 Sep 2023 11:48:59 -0700")
Message-ID: <87r0mdetmv.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Eric W. Biederman" <ebiederm@gmail.com> writes:
>
>> Did you have any manual merge conflicts you had to resolve?
>> If so it is possible to see the merge result you had?
>
> The only merge-fix I had to apply to make everything compile was
> this:
>
> diff --git a/bloom.c b/bloom.c
> index ff131893cd..59eb0a0481 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -278,7 +278,7 @@ static int has_entries_with_high_bit(struct repositor=
y *r, struct tree *t)
>  		struct tree_desc desc;
>  		struct name_entry entry;
>=20=20
> -		init_tree_desc(&desc, t->buffer, t->size);
> +		init_tree_desc(&desc, &t->object.oid, t->buffer, t->size);
>  		while (tree_entry(&desc, &entry)) {
>  			size_t i;
>  			for (i =3D 0; i < entry.pathlen; i++) {
>
> as one topic changed the function signature while the other topic
> added a new callsite.
>
> Everything else was pretty-much auto resolved, I think.
>
> Output from "git show --cc seen" matches my recollection.  The above
> does appear as an evil merge.

Thanks, and I found all of this on your seen branch.

After tracking all of these down it appears all of the errors
came from my branch, I will be resending the patches as soon
as I finish going through the review comments.


Looking at the build errors pretty much all of the all of the
automatic test failures came from commit_tree_extended.


There was a strbuf that did
strbuf_init(&buf, 8192);
strbuf_init(&buf, 8192);
twice.

Plus there was another buffer that was allocated and not freed,
in commit_tree_extended.


The leaks were a bit tricky to track down as building with SANITIZE=3Dleak
causes tests to fail somewhat randomly for me with "gcc (Debian
12.2.0-14) 12.2.0".


There was one smatch static-analysis error that suggested using
CALLOC_ARRAY instead of xcalloc.



The "win" build and "linux-gcc-default (ubuntu-lastest)" build failed
because of an over eager gcc warning -Werror=3Darray-bounds.
Claiming:

 In file included from /usr/include/string.h:535,
                  from git-compat-util.h:228,
                  from commit.c:1:
 In function =E2=80=98memcpy=E2=80=99,
     inlined from =E2=80=98oidcpy=E2=80=99 at hash-ll.h:272:2,
     inlined from =E2=80=98commit_tree_extended=E2=80=99 at commit.c:1705:3:
 ##[error]/usr/include/x86_64-linux-gnu/bits/string_fortified.h:29:10: =E2=
=80=98__builtin_memcpy=E2=80=99 offset [0, 31] is out of the bounds [0, 0] =
[-Werror=3Darray-bounds]
    29 |   return __builtin___memcpy_chk (__dest, __src, __len,
       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    30 |                                  __glibc_objsize0 (__dest));
       |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~

Previously in commit_tree_extended the structure was:

	while (parents) {
		struct commit *parent =3D pop_commit(&parents);
		strbuf_addf(&buffer, "parent %s\n",
			    oid_to_hex(&parent->object.oid));
	}

brian had changed it to:

	nparents =3D commit_list_count(parents);
	parent_buf =3D xcalloc(nparents, sizeof(*parent_buf));
	for (i =3D 0; i < nparents; i++) {
		struct commit *parent =3D pop_commit(&parents);
		oidcpy(&parent_buf[i], &parent->object.oid);
	}

Which is perfectly sound code.

I changed the structure of the loop to:

	nparents =3D commit_list_count(parents);
	parent_buf =3D xcalloc(nparents, sizeof(*parent_buf));
	i =3D 0;
	while (parents) {
		struct commit *parent =3D pop_commit(&parents);
		oidcpy(&parent_buf[i++], &parent->object.oid);
	}

And the "array-bounds" warning had no problems with the code.
So it looks like the error was actually that array-bounds thought
there was a potential NULL pointer dereference at which point
it would not have array bounds, and then it complained about
the array bounds, instead of the NULL pointer dereference.

I am going to fix the patch.  If array-bounds causes further
problems you may want to think about disabling it.

Eric

