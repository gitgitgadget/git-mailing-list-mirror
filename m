Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4512E784A7
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 01:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjJBBW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 21:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbjJBBW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 21:22:56 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647C9B7
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 18:22:53 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-35135f69de2so39696355ab.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 18:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696209772; x=1696814572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lXYHv4JEhXo1bajsORvVOSfWdNwC1cyEgNSfQjYKaAM=;
        b=Tfsh8MVTs25CBXhkyikqYbEloRbK014q+Y+yVFPWfAFdEP3WUTbK6me4TwMQZEBd6H
         MSHzD1MsNDQFAiSEv60rF2SyUc1FSSlkeeCDtPgHrnRQxoGlYW6w9LCcCyc1JaIN+Nke
         DSKQPJEKcLC5tZyruEB1cXnMiVc/es7cSb/6hINP4RnepXwhvyAHfgMPnu+r7GmicJ6G
         A5P3ctRJBgtTIAMVQ8MT+o1I5GhjsnQrA8KA7D9g7bLjXGEapFu/X6QGEN6TLCFzChYY
         T8KuPq5S/60nklQmC/xL5ha3eufPNLs78mK/bsbUtRY6o6dOHAOU6COZNHrJvMsIKmw2
         ZJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696209772; x=1696814572;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lXYHv4JEhXo1bajsORvVOSfWdNwC1cyEgNSfQjYKaAM=;
        b=vIiG0jbvSXDPQ+ANaVBg3ckVUkIymBe/T6yHgnmri2m3GdH3zmIi2Dwe+uxETj947P
         hQ3lzzi92pBM6jveHmINvdyti8huWHBj3Ov73eKPkWzKh9NDCB1QFclK823xOz21IboP
         +pD+nqcaToyBRHMpv6llwtJpcRBW/nLo31NsLIwzw9R8xueGbmtz8mpzpArYVYRMJd7b
         NB5zqnpAHQtk3yKmdIe3sW0H5W9VYGkLO0ytyShddbb2KcwQzQBetnlTANZTyuUxkxEa
         lCcr01dRrWzrv0YFHowBuoMao2y18QtKc72UOSpKIaEFXurIoZ4+mtry31WrS+ahBmYA
         V7/A==
X-Gm-Message-State: AOJu0Yy9nzypy0eNVS1pznq/QOpCG4aIE9W2rnAAxv5o2ndrBlTNL7Sg
        enmPCi2QKYBDaZOMZI3uLWk=
X-Google-Smtp-Source: AGHT+IHzLS9s0BE7HmqrOrHwKGsx0/02G//Cyzv+GwLLrUwqnml97O0m0iMSlwk4IoCR7PgMPYqUUw==
X-Received: by 2002:a05:6e02:1022:b0:350:f956:91c4 with SMTP id o2-20020a056e02102200b00350f95691c4mr11468398ilj.4.1696209772632;
        Sun, 01 Oct 2023 18:22:52 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id fj35-20020a056638636300b004165ac64e0asm3350004jab.40.2023.10.01.18.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 18:22:52 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 01/30] object-file-convert: Stubs for converting from
 one object format to another
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
        <20230927195537.1682-1-ebiederm@gmail.com>
        <CAPig+cRshiUNXfU=ZY4nZXgBgTJ_wF0WVDxWpqkEKPAT9pjX_w@mail.gmail.com>
Date:   Sun, 01 Oct 2023 20:22:49 -0500
In-Reply-To: <CAPig+cRshiUNXfU=ZY4nZXgBgTJ_wF0WVDxWpqkEKPAT9pjX_w@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 27 Sep 2023 16:42:03 -0400")
Message-ID: <87o7hhbyxi.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Sep 27, 2023 at 3:55=E2=80=AFPM Eric W. Biederman <ebiederm@gmail=
.com> wrote:
>> Two basic functions are provided:
>> - convert_object_file Takes an object file it's type and hash algorithm
>>   and converts it into the equivalent object file that would
>>   have been generated with hash algorithm "to".
>>
>>   For blob objects there is no converstion to be done and it is an
>>   error to use this function on them.
>
> s/converstion/conversion/
>
>>   For commit, tree, and tag objects embedded oids are replaced by the
>>   oids of the objects they refer to with those objects and their
>>   object ids reencoded in with the hash algorithm "to".  Signatures
>>   are rearranged so that they remain valid after the object has
>>   been reencoded.
>>
>> - repo_oid_to_algop which takes an oid that refers to an object file
>>   and returns the oid of the equavalent object file generated
>>   with the target hash algorithm.
>
> s/equavalent/equivalent/
>
>> The pair of files object-file-convert.c and object-file-convert.h are
>> introduced to hold as much of this logic as possible to keep this
>> conversion logic cleanly separated from everything else and in the
>> hopes that someday the code will be clean enough git can support
>> compiling out support for sha1 and the various conversion functions.
>>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Just some minor comments below, many of which are subjective
> style-related observations, thus not necessarily actionable, but also
> one or two legitimate questions.
>
>> diff --git a/object-file-convert.c b/object-file-convert.c
>> @@ -0,0 +1,57 @@
>> +int repo_oid_to_algop(struct repository *repo, const struct object_id *=
src,
>> +                     const struct git_hash_algo *to, struct object_id *=
dest)
>> +{
>> +       /*
>> +        * If the source alogirthm is not set, then we're using the
>> +        * default hash algorithm for that object.
>> +        */
>
> s/alogirthm/algorithm/
>
>> +       const struct git_hash_algo *from =3D
>> +               src->algo ? &hash_algos[src->algo] : repo->hash_algo;
>> +
>> +       if (from =3D=3D to) {
>> +               if (src !=3D dest)
>> +                       oidcpy(dest, src);
>> +               return 0;
>> +       }
>> +       return -1;
>> +}
>
> On this project, we usually get the simple cases out of the way first,
> which often reduces the indentation level, making the code easier to
> digest at a glance. So, it would be typical to write this as:
>
>     if (from !=3D to)
>         return -1
>     if (src !=3D dest)
>         oidcpy(dest, src);
>     return 0;
>
> or even:
>
>     if (from !=3D to)
>         return -1
>     if (src =3D=3D dest)
>         return 0;
>     oidcpy(dest, src);
>     return 0;
>
> This way, for instance, the reader doesn't get to the end of the
> function and then have to scan backward to understand the condition of
> the `return -1`.

The "return -1" is there only because it is a stub, and it is there
where the rest of the code needs to go.

As for simple cases the "if (from =3D=3D to)" case is a simple case I am
getting out of the way.  It unfortunately is cluttered by the fact
that "oidcpy(&oid, &oid)" is not valid so it has to guard the copy.

if (from =3D=3D to) {
	if (src =3D=3D dest)
        	return 0;
        oidcpy(dest, src);
        return 0;
}

Could be used but is wordier.  And duplicates the return code
for the same case so I am not enthusiastic about it.


>> +int convert_object_file(struct strbuf *outbuf,
>> +                       const struct git_hash_algo *from,
>> +                       const struct git_hash_algo *to,
>> +                       const void *buf, size_t len,
>> +                       enum object_type type,
>> +                       int gentle)
>> +{
>> +       int ret;
>> +
>> +       /* Don't call this function when no conversion is necessary */
>> +       if ((from =3D=3D to) || (type =3D=3D OBJ_BLOB))
>> +               die("Refusing noop object file conversion");
>
> Several comments...
>
> Style: we usually reduce the noise level by dropping the extra parenthese=
s:
>
>     if (from =3D=3D to || type =3D=3D OBJ_BLOB)

I honestly can not be confident of C code that does that.

The precedence of the operators in C has been wrong for longer than I
have been programming, and I can never remember exactly how the
precedence is wrong.  So for the last 30 years I have been adding enough
parenthesis that I don't have to remember.

> Does this condition represent a programming error or a runtime error
> triggerable by some input? If a programming error, then use BUG()
> rather than die().

Agreed BUG would be better there.

> If a triggerable runtime error, then...
>
> * start user-facing messages with lowercase rather than capitalized word
>
> * make the user-facing message localizable so readers of other
> languages can digest it
>
>     die(_("refusing do-nothing object conversion"));
>
> On the other hand, don't make BUG() messages localizable.
>
>> +       switch (type) {
>> +       case OBJ_COMMIT:
>> +       case OBJ_TREE:
>> +       case OBJ_TAG:
>> +       default:
>> +               /* Not implemented yet, so fail. */
>> +               ret =3D -1;
>> +               break;
>> +       }
>> +       if (!ret)
>> +               return 0;
>> +       if (gentle) {
>> +               strbuf_release(outbuf);
>> +               return ret;
>> +       }
>
> This function appears to be a mere skeleton at the moment, so it's
> difficult to judge at this point whether you are using `outbuf` as a
> bag of bytes or as a legitimate string container. If the latter, then
> the API may be reasonable, but if you're using it as a bag-of-bytes,
> then it feels like you're leaking an implementation detail into the
> API.

It is a string that represents the entire object.

It might be arguable if tree objects are text given that trees represent
oids in binary, but for tag and commit objects they are definitely one
big text string.

This is an implementation detail that makes the code simpler, and less
error prone.

I have not encountered anything where a string buffer would not be
a reasonable fit.

>> +       die(_("Failed to convert object from %s to %s"),
>> +               from->name, to->name);
>
> s/Failed/failed/

I don't understand wanting to start a sentence with a lower case letter.
Can you explain?

> For people trying to diagnose this problem, would it be helpful to
> present more information about the failed conversion, such as object
> type and perhaps even its OID?

I expect some of that context will come from the conversion functions
themselves.  Those messages are almost certain to give the type
information one way or another because they are type specific.

That said it requires some version of corrupt repository to reach this
error.  Either missing mapping tables, or a corrupt object.

So I don't know how much it matters to get this perfect the first
time.  We can improve the error message we gain experience.

I would agree that including the OID makes sense.  Unfortunately the
code does not have the OID at this point.

>> diff --git a/object-file-convert.h b/object-file-convert.h
>> @@ -0,0 +1,24 @@
>> +int repo_oid_to_algop(struct repository *repo, const struct object_id *=
src,
>> +                     const struct git_hash_algo *to, struct object_id *=
dest);
>
> I suppose the function name is pretty much self-explanatory to those
> familiar with the underlying concepts, but it might still be helpful
> to add a comment explaining what the function does.

I could use words that repeat what is in the function signature.
But I don't think I could add anything.

I would have to say something like:

Look up the oid that an equivalent object would have in a repository
whose object format is "to".

Is that helpful?

Eric
