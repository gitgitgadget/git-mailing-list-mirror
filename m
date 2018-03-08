Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C22E41F404
	for <e@80x24.org>; Thu,  8 Mar 2018 18:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754558AbeCHSmO (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 13:42:14 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35286 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbeCHSmN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 13:42:13 -0500
Received: by mail-wr0-f193.google.com with SMTP id l43so6694318wrc.2
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 10:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CKYRAVuTCaF458ZMABg/b8CKD+LGDwgDiLvv1v+cgDs=;
        b=pXETPrh9m5EfUJmBL/1DEJFBTZj7Giej9X+iNjg/drkFS553g+WNemWLcH8jUcdUYd
         d8XkJ+4//BsHaJm3WSj2diz7S58FNSyuMs4OE4IaOZZ58rWKp/XNurqOXMPENGfuDpCN
         gfuUIdt5SDmX83PbLAV9RKqxAz4+GlTtrOkrB3Yi0Fdqf9McrGppay4eVuZJkwBQr+ju
         sfVIPQHzqDOBBw06QxwQ4M+mHD8aV2TVmJaGxj82m5oCzloV9PAGGvJPzQSUf3mVOUDY
         3pbFr5kyiy2iOaRupfBxGyhpPJ2yjOBKeEUdoVYu2CaRSGjn8C5Yrfm1rNgRECByrdCL
         BFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CKYRAVuTCaF458ZMABg/b8CKD+LGDwgDiLvv1v+cgDs=;
        b=eLIsx+5B6hgZcbzv9AIPB75JbI969kVNZ+UMxG3I+7JBMhWIQWyezx6yntPSTu7xWF
         Iz0QhFeBUXw7mWKBATepZZPXpwspsn7eSYoArkMyqifDDztjJNgWwes9hiaBX1dstXW1
         r3e/EOCX9Km2nF11POhALJLZRK2kWkrje17Y6wRdqjlTfe5dRVtH/HYX8gSSlQJpvA7z
         dWMDKehxaT5Xxd+ZoarNKVMzmSm4MJTb3UtIo9pSC6waYoxuZUF9a+b0RgMP8nWSov1A
         xuy0olMdVNafhAUH49aZ/F8y4IuM+dmO1f2rh413c4sXKZD4fw7vZ2NqlV5gFB6gsrHi
         tLhQ==
X-Gm-Message-State: APf1xPA+d/1e/zYXVHEZQQOh9RhTLBFStTcKAmjZHw6uF+NMl/S2syft
        TaCV+qbuQrdHqG+ASOkGTOpblif4
X-Google-Smtp-Source: AG47ELtqrCLdxsfHDrxo3IblVuDrO4NwWwn8F2prqqsGZ58DkVdkcjB2u9xMgN91tWkX90UgOy3EWA==
X-Received: by 10.223.170.78 with SMTP id q14mr22687022wrd.271.1520534531901;
        Thu, 08 Mar 2018 10:42:11 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s26sm17836867wrb.10.2018.03.08.10.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Mar 2018 10:42:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Takuto Ikuta <tikuta@chromium.org>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] fetch-pack.c: use oidset to check existence of loose object
References: <20180308120639.109438-1-tikuta@chromium.org>
Date:   Thu, 08 Mar 2018 10:42:10 -0800
In-Reply-To: <20180308120639.109438-1-tikuta@chromium.org> (Takuto Ikuta's
        message of "Thu, 8 Mar 2018 21:06:39 +0900")
Message-ID: <xmqqr2ouwgsd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Takuto Ikuta <tikuta@chromium.org> writes:

> In repository having large number of refs, lstat for non-existing loose
> objects makes `git fetch` slow.

It is not immediately clear how "large number of refs" and "lstat
for loose objects" interact with each other to create a problem.
"In repository having large number of refs, because such and such
processing needs to do this and that, 'git fetch' ends up doing a
lot of lstat(2) calls to see if many objects exist in the loose
form, which makes it slow".  Please fill in the blanks.

> This patch stores existing loose objects in hashmap beforehand and use
> it to check existence instead of using lstat.
>
> With this patch, the number of lstat calls in `git fetch` is reduced
> from 411412 to 13794 for chromium repository.
>
> I took time stat of `git fetch` disabling quickfetch for chromium
> repository 3 time on linux with SSD.

Now you drop a clue that would help to fill in the blanks above, but
I am not sure what the significance of your having to disable
quickfetch in order to take measurements---it makes it sound as if
it is an articificial problem that does not exist in real life
(i.e. when quickfetch is not disabled), but I am getting the feeling
that it is not what you wanted to say here.

In any case, do_fetch_pack() tries to see if all of the tip commits
we are going to fetch exist locally, so when you are trying a fetch
that grabs huge number of refs (by the way, it means that the first
sentence of the proposed log message is not quite true---it is "When
fetching a large number of refs", as it does not matter how many
refs _we_ have, no?), everything_local() ends up making repeated
calls to has_object_file_with_flags() to all of the refs.

I like the idea---this turns "for each of these many things, check
if it exists with lstat(2)" into "enumerate what exists with
lstat(2), and then use that for the existence test"; if you need to
try N objects for existence, and you only have M objects loose where
N is vastly larger than M, it will be a huge win.  If you have very
many loose objects and checking only a handful of objects for
existence check, you would lose big, though, no?

> diff --git a/fetch-pack.c b/fetch-pack.c
> index d97461296..1658487f7 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -711,6 +711,15 @@ static void mark_alternate_complete(struct object *obj)
>  	mark_complete(&obj->oid);
>  }
>  
> +static int add_loose_objects_to_set(const struct object_id *oid,
> +				    const char *path,
> +				    void *data)
> +{
> +	struct oidset* set = (struct oidset*)(data);

Style: in our codebase, asterisk does not stick to the type.

	struct oidset *set = (struct oidset *)(data);

> @@ -719,16 +728,21 @@ static int everything_local(struct fetch_pack_args *args,
>  	int retval;
>  	int old_save_commit_buffer = save_commit_buffer;
>  	timestamp_t cutoff = 0;
> +	struct oidset loose_oid_set = OIDSET_INIT;
> +
> +	for_each_loose_object(add_loose_objects_to_set, &loose_oid_set, 0);

OK, so this is the "enumerate all loose objects" phase.

>  	save_commit_buffer = 0;
>  
>  	for (ref = *refs; ref; ref = ref->next) {
>  		struct object *o;
> +		unsigned int flag = OBJECT_INFO_QUICK;

Hmm, OBJECT_INFO_QUICK optimization was added in dfdd4afc
("sha1_file: teach sha1_object_info_extended more flags",
2017-06-21), but since 8b4c0103 ("sha1_file: support lazily fetching
missing objects", 2017-12-08) it appears that passing
OBJECT_INFO_QUICK down the codepath does not do anything
interesting.  Jonathan (cc'ed), are all remaining hits from "git
grep OBJECT_INFO_QUICK" all dead no-ops these days?

>  
> -		if (!has_object_file_with_flags(&ref->old_oid,
> -						OBJECT_INFO_QUICK))
> -			continue;
> +		if (!oidset_contains(&loose_oid_set, &ref->old_oid))
> +			flag |= OBJECT_INFO_SKIP_LOOSE;
>  
> +		if (!has_object_file_with_flags(&ref->old_oid, flag))
> +			continue;

Here, you want a way to say "I know this does not exist in the loose
form, so check if it exists in a non-loose form", and that is why
you invented the new flag.

> diff --git a/sha1_file.c b/sha1_file.c
> index 1b94f39c4..c903cbcec 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1262,6 +1262,9 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>  		if (find_pack_entry(real, &e))
>  			break;
>  
> +		if (flags & OBJECT_INFO_SKIP_LOOSE)
> +			return -1;
> +

I cannot quite convince myself that this is done at the right layer;
it smells to be at a bit too low a layer.  This change makes sense
only to a caller that is interested in the existence test.  If the
flag is named after what it does, i.e. "ignore loose object", then
it does sort-of make sense, though.

>  		/* Most likely it's a loose object. */
>  		if (!sha1_loose_object_info(real, oi, flags))
>  			return 0;
