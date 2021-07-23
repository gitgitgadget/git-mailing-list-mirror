Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F90C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C730760E91
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhGWG5s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 02:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhGWG5s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 02:57:48 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CFEC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 00:38:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a6so554028edv.11
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 00:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=M/qPZLUgls4pCMnqq2tDMIabL2x4cM5i+YA9/lXtuqs=;
        b=LmMs21f0NWuftH9erul7mEv/cYHH0SWV5sZsgm7kF1l4V5TY4YQi4hP14mUP9tAx/A
         YkvlceNbw6rx2jI6DJfwkZVtvAzgAXliym8nAiPhDWmizeLXqrpvwMlvaV7fJW/XWAya
         MbFrU1J6sN8hU4Qf2eeGLFLpXWVTLeyf8hN4UK7LZjdVySUazJwFy68kogZvq20G98MM
         /aIYSOwq3RlT7W01HSVPCHfXlFVZcDYmkY5bM1BwFDVqFQyZEY1bW6dPDe68bieoUOSJ
         ECJRRnffi2E42h5ysKRVJOD8NdMdvD8qd38nPqRkBskp06hnZ1c4O5Z74vD8cTM7W8EP
         u3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=M/qPZLUgls4pCMnqq2tDMIabL2x4cM5i+YA9/lXtuqs=;
        b=KTThSbmO5pMS9Y6AmboUBEqEuMjbB4NWQ+pW1bPTHhU4lpNcZmERnvl+i8jNH0qep5
         IOnHdTSUkfdlT/SOJ4sFuIFU5HvzsWqqbCjDRbKTeTe1ZV0VcshLTCQ90aBBs5cyJ73y
         mDSqYfWyO3uTwTwjf1Il9FwtYS6Stj7eYRXNI4iEeF6IlNwo0Fq/xdJsyRS7sm7bgh9H
         oxyj1iWrLx04q+YOkc46Ryf+v1LPXXa/1nbBvv2M03wfIyvWs5qR4jM+XzGiS7Bp3Y/G
         RNW5PTqAY2MopA1TejDIHRO6CI9XxzP3M71jaPKIlVz6WVO4Qt3CI7g3sEwpt4PFKxlS
         ZQYg==
X-Gm-Message-State: AOAM533Ot+EyoCeuTNN0lQqhBl92dt/VUtpziZW1m/weiQ5ADLdaIdB9
        1vd2+zFUK7XRf7nCcI5gZIk=
X-Google-Smtp-Source: ABdhPJwIb0QdaNNDSDXmxr0KSZnwcvJ9+16hJDewiEpOldpSRQoz9/7YYBlYrDeaj7ZNzW+6aLw85w==
X-Received: by 2002:a05:6402:40cf:: with SMTP id z15mr4226670edb.175.1627025900629;
        Fri, 23 Jul 2021 00:38:20 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id hb43sm10061004ejc.93.2021.07.23.00.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 00:38:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: What's cooking in git.git (Jul 2021, #05; Wed, 21)
Date:   Fri, 23 Jul 2021 09:32:23 +0200
References: <xmqqo8av9j7f.fsf@gitster.g>
 <87a6mevkrx.fsf@evledraar.gmail.com> <xmqqbl6u7z68.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqbl6u7z68.fsf@gitster.g>
Message-ID: <87eebptr7i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 22 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> * ab/refs-files-cleanup (2021-07-20) 12 commits
>>>  - refs/files: remove unused "errno !=3D ENOTDIR" condition
>>>  - refs/files: remove unused "errno =3D=3D EISDIR" code
>>>  - refs/files: remove unused "oid" in lock_ref_oid_basic()
>>>  - reflog expire: don't lock reflogs using previously seen OID
>>>  - refs/files: add a comment about refs_reflog_exists() call
>>>  - refs: make repo_dwim_log() accept a NULL oid
>>>  - refs API: pass the "lock OID" to reflog "prepare"
>>>  - refs/debug: re-indent argument list for "prepare"
>>>  - refs/files: remove unused "skip" in lock_raw_ref() too
>>>  - refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
>>>  - refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
>>>  - refs/packet: add missing BUG() invocations to reflog callbacks
>>>  (this branch is used by hn/refs-errno-cleanup.)
>>>
>>>  Patches are mostly good, but needs typofixes etc.
>>>
>>>  Will merge to 'next'.
>>
>> Yay, thanks!
>
> Yikes, I shouldn't have said Will merge when I clearly said "needs
> typofixes".  If you are employing the strategy to wear me out and
> mistakenly merge topics prematurely, it is succeeding X-<.

I read this as the "needs typo..." comment referring to v2:
https://lore.kernel.org/git/cover-00.11-00000000000-20210716T140631Z-avarab=
@gmail.com/

But it being outdated given the timing & you having picked up the v3
with those fixes in "seen":
https://lore.kernel.org/git/cover-00.12-00000000000-20210720T102051Z-avarab=
@gmail.com/

v3 only has the discussion about the "lock OID" being passed in, which
Han-Wen replied to (you and me CC'd) in saying:
https://lore.kernel.org/git/CAFQ2z_PuNJ_KtS_O9R2s0jdGbNNKnKdS3=3D_-nEu6367p=
teCxwA@mail.gmail.com/

    Reftable could easily read the current OID for the reference, if necess=
ary.=20

Except that last lore.kernel.org link doesn't work since that reply has
an HTML part. Will reply there.

>>> * ab/attribute-format (2021-07-13) 5 commits
>>> [...]
>>> * ab/imap-send-read-everything-simplify (2021-07-07) 1 commit
>>> [...]
>>> * ab/pkt-line-tests (2021-07-19) 1 commit
>>
>> Thanks!
>
> Thanks for all of these.
>
>>> * ab/bundle-doc (2021-07-20) 3 commits
>>>  - bundle doc: elaborate on rev<->ref restriction
>>>  - bundle doc: elaborate on object prerequisites
>>>  - bundle doc: rewrite the "DESCRIPTION" section
>>>
>>>  Doc update.
>>>
>>>  Expecting a reroll.
>>>  at least for the second patch.
>
> Sorry, I think we have a reroll that updates the second one and that
> is what we list here.  IOW the comment is stale.
>> My reading-between-the-lines of
>> https://lore.kernel.org/git/xmqqsg08hhs0.fsf@gitster.g/ and
>> https://lore.kernel.org/git/xmqqo8awhh5z.fsf@gitster.g/ is that you'd be
>> happy toh have this be merged down in its current form, no?
>
> As I commented, the tip one's mention of show-ref is rather iffy.
> I thought you'd be rephrasing it further in response to Philip's
> "what about list-heads?" (I am not sure if it is wise to stress on
> list-heads, which was a debugging aid, when ls-remote is available).
>
> Also, the second one talks about "object prerequisites" (I think
> calling them "prerequisite objects" would be more natural, though)
> and the third one uses "basis" (I take that the "bases" in "the
> given bases" is used as the plural for the word), but it is not
> clear to readers that these mean the same thing.  If we are touching
> the doc, we may want to make sure the end-result as a whole gives a
> coherent narrative.

Willdo, I misread the most recent discussion initially.
