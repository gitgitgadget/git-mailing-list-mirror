Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD17C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 19:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4494961454
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 19:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242537AbhDUTZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 15:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbhDUTZl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 15:25:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F14C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 12:25:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so1811224wmf.3
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 12:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=KYPrf9x4/46PzW4ZFL+FJAd3/zm9okxaVnWjFE7gZJQ=;
        b=BCtgERxwgSB4kIEFe6PkRf9fm9OaqpUEf+4/aE6GH1FFQ+q9xGbHDSiL+FyG0KRvCv
         kGwFNjGacKlKDp3HXibidgp9kZVQ3hknNqhWxEAleoZYh4fMn0BX5ELjEMN+AwVbM98c
         qqlWJfP+G1VY8+kEINU+x6BAn/WgmxTCXwmgRBlLaBCFiZxVJ2s0gkliEoW9zbj1mnlE
         VGqtCnI2rXKFuKvnJ6Wu+aC+6k4fhK6y9Ec1k7QU1+MJ1VfsclLZ7nYXuhvaCLJzYCBF
         89KE68liIAGh+jJfR6AXkqfilDnT/eaOP/t3wkWagfGKrYWScUCBJvBEo9wl4jvLvTGY
         2O/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=KYPrf9x4/46PzW4ZFL+FJAd3/zm9okxaVnWjFE7gZJQ=;
        b=F/YsnWQtI6neMtvFvV4shZgcFFXMrySPLxWpRzmAd/sK3Zpn0TwklNp9cuZW4Tbff6
         ZBJoRnrUbGRq8eewePFluU4YKXNxRUEhwb1h1S5LMWx/4BOz0Bam1glBjHBnMHdzFnKg
         /2MyqgbXFcZzatt0yMeT1ttRPRBBw1pbG76fu4k5vu5/qbbrOKJwNDLy0gyVfm4bcv68
         8W3hK0m265cEz/gU0lNoBObidqSkRk7zdRYhrMWAdqrJQLCzIcwsG/nvcbfULybVBXBZ
         4uVHjCIc6Tp1YrTrXXIadtngsJS8BhgzoL+udxEXTtFC/0DFm4r056Ckghm4cO2bIlWq
         Z1Yg==
X-Gm-Message-State: AOAM530iCGP9GvMx/qyV/3Z3L++DlfMqVrHTtKQFw6CJl2sDhZ4axyKS
        0XvnHv1nryUaIaYcufA4KoU=
X-Google-Smtp-Source: ABdhPJzjG+2Qg+0y/kjRRJREI0/W1CunfHUyhZSUT9pIvLoM8ZuBtutgM38bdKjzqWi8Kj5NwgdNWg==
X-Received: by 2002:a7b:cc11:: with SMTP id f17mr11611105wmh.159.1619033106370;
        Wed, 21 Apr 2021 12:25:06 -0700 (PDT)
Received: from cpm12071.local ([79.140.123.236])
        by smtp.gmail.com with ESMTPSA id w7sm327309wru.87.2021.04.21.12.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 12:25:05 -0700 (PDT)
References: <20210414191403.4387-1-rafaeloliveira.cs@gmail.com>
 <20210418135749.27152-1-rafaeloliveira.cs@gmail.com>
 <20210418135749.27152-2-rafaeloliveira.cs@gmail.com>
 <xmqqa6pt98j4.fsf@gitster.g>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/1] repack: avoid loosening promisor objects in
 partial clones
In-reply-to: <xmqqa6pt98j4.fsf@gitster.g>
Message-ID: <gohp6kim4fl9tc.fsf@gmail.com>
Date:   Wed, 21 Apr 2021 21:25:04 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:

> Rafael Silva <rafaeloliveira.cs@gmail.com> writes:
>
>> When `git repack -A -d` is run in a partial clone, `pack-objects`
>> is invoked twice: once to repack all promisor objects, and once to
>> repack all non-promisor objects. The latter `pack-objects` invocation
>> is with --exclude-promisor-objects and --unpack-unreachable, which
>> loosens all unused objects. Unfortunately, this includes promisor
>> objects.
>>
>> Because the -d argument to `git repack` subsequently deletes all loose
>> objects also in packs, these just-loosened promisor objects will be
>> immediately deleted. However, this extra disk churn is unnecessary in
>> the first place.  For example, a newly-clone partial repo that filters
>
> "in a newly-cloned partial repo", I'd think.
>

Thanks, will fix on the next revision.

>> For testing, we need to validate whether any object was loosened.
>> However, the "evidence" (loosened objects) is deleted during the
>> process which prevents us from inspecting the object directory.
>> Instead, let's teach `pack-objects` to count loosened objects and
>> emit via trace2 thus allowing inspecting the debug events after the
>> process is finished. This new event is used on the added regression
>> test.
>
> Nicely designed.
>

Thanks :)

>> +	uint32_t loosened_objects_nr = 0;
>>  	struct object_id oid;
>>  
>>  	for (p = get_all_packs(the_repository); p; p = p->next) {
>> @@ -3492,11 +3493,16 @@ static void loosen_unused_packed_objects(void)
>>  			nth_packed_object_id(&oid, p, i);
>>  			if (!packlist_find(&to_pack, &oid) &&
>>  			    !has_sha1_pack_kept_or_nonlocal(&oid) &&
>> -			    !loosened_object_can_be_discarded(&oid, p->mtime))
>> +			    !loosened_object_can_be_discarded(&oid, p->mtime)) {
>>  				if (force_object_loose(&oid, p->mtime))
>>  					die(_("unable to force loose object"));
>> +				loosened_objects_nr++;
>> +			}
>>  		}
>>  	}
>> +
>> +	trace2_data_intmax("pack-objects", the_repository,
>> +			   "loosen_unused_packed_objects/loosened", loosened_objects_nr);
>>  }
>
> OK, so this is just the "stats".
>
>> diff --git a/builtin/repack.c b/builtin/repack.c
>> index 2847fdfbab..5f9bc74adc 100644
>> --- a/builtin/repack.c
>> +++ b/builtin/repack.c
>> @@ -20,7 +20,7 @@ static int delta_base_offset = 1;
>>  static int pack_kept_objects = -1;
>>  static int write_bitmaps = -1;
>>  static int use_delta_islands;
>> -static char *packdir, *packtmp;
>> +static char *packdir, *packtmp_name, *packtmp;
>>  
>>  static const char *const git_repack_usage[] = {
>>  	N_("git repack [<options>]"),
>> @@ -530,7 +530,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>>  	}
>>  
>>  	packdir = mkpathdup("%s/pack", get_object_directory());
>> -	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
>> +	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
>> +	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
>
> Just a mental note, but we should move away from ".tmp-$$" that is a
> remnant from the days back when this was a shell script, and use the
> tempfile.h API (#leftoverbits).  Such a change must not be part of
> this topic, of course.
>

Indeed. This should be move tempfile.h API.

>
> Thanks.  Will queue and see what others say.

Thanks for reviewing it.

-- 
Thanks
Rafael
