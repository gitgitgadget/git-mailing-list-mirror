Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DFCC433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 09:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3DA561105
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 09:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhDBJ0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 05:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbhDBJ0E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 05:26:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48A1C0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 02:26:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n2so401202ejy.7
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 02:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=TnSEBhLJcB7MVZ2N+UlFrxZEp65HVZMRF3R3HaZoV1Y=;
        b=Y8/xtJHBknZDkQlbXQMz8Ub832XCMZrQWTzTpvN4c/Dhz7YtDxP1YqgXqg7jC0pde9
         tEK+IhCzSZozN9OJXG05lJD5ZVJb3w+RjN33holvjcu4egKLfFrkZ6rwj+jjR78TZMW6
         8woouYKYPCNAyi5ij659l8V/teU9R9PNUE2ifIIM5VZo6k66PtJVYMArNxw1qlsJU4og
         Q0+y97Q+tY3dygB6kl7oExr3hD7jhuNOE6gi8QYZ5GxyC5rETfETgea98K1N1bg8zWHm
         yO6jprx1tiSn7dYeTRZTZ0I4Tdv7bGwC9D8jBWtlZsA2olHJmsSIoPgiDTNJvf5KLjV+
         69mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=TnSEBhLJcB7MVZ2N+UlFrxZEp65HVZMRF3R3HaZoV1Y=;
        b=auBsXImszkaU2u2YeUdsjaZniZJ47OYNeGNohrdFAUcRrcfPC3VI7PUwQG+wYAD5JV
         LAkMTt4+J+pGDLdjqeOH85y0/+gukkA7Ob4eILLF4b7Zb4yIahIYQkJ8UUXsGhql3gHR
         Cv8jFqLuUVSLFF0uWMs1Tom9HJ4nV6NC+CCn2JZb/qOQdqs2qoTp9Wy7tLuqcmEgwKa0
         GHGIFZB7yTa4/wmcJ3B6WmZavbWGY762SsXhVNw14PzfSNs10844pAQBSpqA5kkFSEE0
         f+Mv+Ygb8F36bnnc9yhYF7yOKvaqUUsiWUHHTmIKrf3yMEcnQwKlz8skQIw6StwHlP9f
         0Zmg==
X-Gm-Message-State: AOAM530d8N0qvsMXcxMPe4CBQmn89ESadmKixJFwN/b7CxdSgflw2a52
        fYLtQAkG9HDrHY028njIMKA=
X-Google-Smtp-Source: ABdhPJxAW/akuqZjnE3aPpcKNc4nSUFnyePE6iMtkv7dCUDhrO1lkrIXqaw9l5fVNAU8wc665gTbEA==
X-Received: by 2002:a17:906:2759:: with SMTP id a25mr13441573ejd.122.1617355562557;
        Fri, 02 Apr 2021 02:26:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m1sm419361ejl.35.2021.04.02.02.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 02:26:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 08/18] blame: emit a better error on 'git blame
 directory'
References: <87o8fcqrg8.fsf@evledraar.gmail.com>
 <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
 <patch-08.19-3c2ca98716d-20210331T190531Z-avarab@gmail.com>
 <xmqqwntm52ht.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqwntm52ht.fsf@gitster.g>
Date:   Fri, 02 Apr 2021 11:26:01 +0200
Message-ID: <87blaxkpg6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 01 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change an early check for non-blobs in verify_working_tree_path() to
>> let any such objects pass, and instead die shortly thereafter in the
>> fake_working_tree_commit() caller's type check.
>>
>> Now e.g. doing "git blame t" in git.git emits:
>>
>>     fatal: unsupported file type t
>>
>> Instead of:
>>
>>     fatal: no such path 't' in HEAD
>
> Sorry, but I fail to see why "unsupported file type t" is quite an
> improvement.  Is this one of these irrelevant clean-up while at it
> whose benefit is unclear until much later, I have to wonder.

Because "t" is directory we can stat() and which exists in the index, so
it makes more sense to fall through to the stat() codepath.

I think the "unsupported file type" message is a bit odd, but it's the
existing one, perhaps changing it while we're at it to something like:

    fatal: cannot 'blame' a directory

Would be better, but in any case I think saying "no such path X in HEAD"
when you can "git show HEAD:t" to see that there is such a path doesn't
make sense.

I don't have a test for it here, but this change also makes this error
better:

    rm -rf contrib
    git blame contrib

Before we'd say:

    fatal: no such path 'contrib' in HEAD

But now we'll fall back to:

    fatal: Cannot lstat 'contrib': No such file or directory

Which could also be reworded, but aside from the specific wording I
think not aborting early when we see "this is not a blob" is better.

>> The main point of this test is to assert that we're not doing
>> something uniquely bad when in a conflicted merge. See
>
> "this test" refers to the logic "it is OK to skip the check if one
> of the parents does have it as a blob", introduced in 9aeaab68
> (blame: allow "blame file" in the middle of a conflicted merge,
> 2012-09-11)?

Yes, will clarify.

>> -		if (!get_tree_entry(r, commit_oid, path, &blob_oid, &mode) &&
>> -		    oid_object_info(r, &blob_oid, NULL) =3D=3D OBJ_BLOB)
>> +		if (!get_tree_entry(r, commit_oid, path, &blob_oid, &mode))
>>  			return;
>>  	}
>
> At least, the original logic makes sense to me in that if an early
> parent has the path as a directory we do not declare it is OK but
> keep going until we find a blob in a later parent before deciding to
> short-cut.  I am not sure what the updated "in this case we can
> bypass the real check" condition even means.  Mechanically, it says
> "if any parent has the path as any filesystem entity, even if it
> were a directory, then it is OK", but why?

Because we'll fall down to code that's better at doing the rest of that
check.

Looking at this again, another thing this changes is the behavior of
--contents, which I again think is an improvement. Let's say you:

    rm Makefile &&
    mkdir Makefile &&
    touch Makefile/foo &&
    git add Makefile &&
    git commit -m"foo"

I.e. turn a random file into a directory, then:

    git show origin/master:Makefile | git blame --contents - Makefile

We'll now say:

    fatal: no such path 'Makefile' in HEAD

With my patch we'll do what the user asked (and I think consistently
with the documentation) and pretend as though the stream on stdin was
the contents at the "Makefile" path.

The blame we show doesn't make much sense, it's all the lines in the
file with "Not Committed Yet", but that's another matter to do with the
blame algorithm in general, e.g. if you flip Makefile back & forth
between a file->dir->file it won't traverse past the dir->file move.
