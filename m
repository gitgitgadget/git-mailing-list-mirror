Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DD1E784A6
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 01:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbjJBByh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 21:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjJBByg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 21:54:36 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F089DC4
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 18:54:32 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79fe99a5f29so249677739f.1
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 18:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696211672; x=1696816472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u7RDHJYiBicuUWnXeotL5RryEHd91t6NH+b5ebRJpbY=;
        b=GB2m/hFkIEGzF2f9NwDpsVnSu0CUb3qIm2IMVGMZ8MJRH13m2dqp6fFbtr+ZgLsqoJ
         dHsY3Y4nmjnQF+KQzJXxncUv4kqillUnKPdFl/MsLwwcFMITvljdgyzl4irUKdJNpckS
         Ghp+/m2BiqXAmfX2ZpfuMBVs3hTFdSaTzownpUYhWsdL6f/dI3uy6sSy4gH4z1jyPyND
         s/9UBHvM1nwQz/rlwCeGF/NYWjnQ0uwh8iZdG8KTwnoYL+V/hp5K8xi0jLD/m0GZbbkN
         4aC8nZHp/BkxWA0ZEmCCCoPPB5JEfFUuFLYWOEnP18VB5rVK2zNAE5onq99ggJTqFVKN
         be2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696211672; x=1696816472;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u7RDHJYiBicuUWnXeotL5RryEHd91t6NH+b5ebRJpbY=;
        b=wlBik/CddJQDKP0DEg3aX/ZHLRrPjft24XhvdHnodD/9LUTda2mAIQZhg89UAgf/O9
         1WPfftVjCAUmLXOwmFItiBMDYRvHMtuxDF1aGTBDItgn5+hSS2EcIXWYE8mhDJHdTcl9
         jLql/qU7jRKUFmCIdeBOoXDB4w6mAk1thPl1kPpVffasoeEhLns9+XvVoTEYlbg+XBA0
         JGQcgvs9KoS69Q4M4VnY6357nlAddylTQDfNDc+eIDhHFYsfswK8NP9vAG6KZB5UiPG6
         Awww+rh9kjF7VMqqGdVd3seAEbOBU9EycIdYO/Cm496dluk+2bql7gmrHngeeTT6KhYu
         cKeQ==
X-Gm-Message-State: AOJu0YwfsxTPobfGkvbTwgVibvKYHuLE7cdJY12HZuRcZHcuIwHhFEvB
        S5B8fluK7LNW3qbSq0nPGts=
X-Google-Smtp-Source: AGHT+IHKyvo0RvxeiiP2+/qdpVOIHYI8OSL1ACAf/2yUpLFJ/ibHWNuvTkypanwmcdQHb4GNaNcaHA==
X-Received: by 2002:a05:6e02:16cc:b0:351:57d5:51c4 with SMTP id 12-20020a056e0216cc00b0035157d551c4mr13276016ilx.1.1696211672055;
        Sun, 01 Oct 2023 18:54:32 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id fn9-20020a056638640900b004302370a169sm6444845jab.157.2023.10.01.18.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 18:54:31 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 03/30] object-names: Support input of oids in any
 supported hash
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
        <20230927195537.1682-3-ebiederm@gmail.com>
        <CAPig+cRHBxPZYQ5XYA5Un7LeS21NgqxZGg=Q8D+aQckrw9Ymtg@mail.gmail.com>
Date:   Sun, 01 Oct 2023 20:54:29 -0500
In-Reply-To: <CAPig+cRHBxPZYQ5XYA5Un7LeS21NgqxZGg=Q8D+aQckrw9Ymtg@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 27 Sep 2023 19:29:53 -0400")
Message-ID: <87il7paiwa.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Sep 27, 2023 at 3:56=E2=80=AFPM Eric W. Biederman <ebiederm@gmail=
.com> wrote:
>> Support short oids encoded in any algorithm, while ensuring enough of
>> the oid is specified to disambiguate between all of the oids in the
>> repository encoded in any algorithm.
>>
>> By default have the code continue to only accept oids specified in the
>> storage hash algorithm of the repository, but when something is
>> ambiguous display all of the possible oids from any oid encoding.
>>
>> A new flag is added GET_OID_HASH_ANY that when supplied causes the
>> code to accept oids specified in any hash algorithm, and to return the
>> oids that were resolved.
>>
>> This implements the functionality that allows both SHA-1 and SHA-256
>> object names, from the "Object names on the command line" section of
>> the hash function transition document.
>>
>> Care is taken in get_short_oid so that when the result is ambiguous
>> the output remains the same of GIT_OID_HASH_ANY was not supplied.
>
> s/of/as if/

Actually s/of/if/

Thank you for catching that.  When reviewing this to understand what I
was trying to say I found a bug.  The function repo_for_each_abbrev was
passing algo to init_object_disambiguation to properly initialize
ds.bin_pfx.algo, and then was resetting ds.bin_pfx.algo to GIT_HASH_ANY.
Oops!

>> If GET_OID_HASH_ANY was supplied objects of any hash algorithm
>> that match the prefix are displayed.
>>
>> This required updating repo_for_each_abbrev to give it a parameter
>> so that it knows to look at all hash algorithms.
>>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>> diff --git a/object-name.c b/object-name.c
>> @@ -49,6 +50,7 @@ struct disambiguate_state {
>>  static void update_candidates(struct disambiguate_state *ds, const stru=
ct object_id *current)
>>  {
>> +       /* The hash algorithm of the current has already been filtered */
>
> Is there a word missing after "current"?

No.  I forgot to remove "the" before current.

>> @@ -503,8 +516,13 @@ static int sort_ambiguous(const void *a, const void=
 *b, void *ctx)
>> -       if (a_type =3D=3D b_type)
>> -               return oidcmp(a, b);
>> +       if (a_type =3D=3D b_type) {
>> +               /* Is the hash algorithm the same? */
>> +               if (a->algo =3D=3D b->algo)
>> +                       return oidcmp(a, b);
>> +               else
>> +                       return a->algo > b->algo ? 1 : -1;
>> +       }
>
> Nit: unnecessary comment ("Is the hash algorithm...") is merely
> repeating what the code itself already says clearly enough

Fair enough.

>
>> @@ -553,6 +575,7 @@ static enum get_oid_result get_short_oid(struct repo=
sitory *r,
>>         else
>>                 ds.fn =3D default_disambiguate_hint;
>>
>> +
>>         find_short_object_filename(&ds);
>
> Nit: unnecessary new blank line

Naughty thing how did that sneak in there ;)


Eric
