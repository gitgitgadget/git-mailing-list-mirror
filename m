Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D346C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 14:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A7B761453
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 14:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhGFOqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 10:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbhGFOqR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 10:46:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F65C08EAC1
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 07:37:16 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id l2so8900887edt.1
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 07:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=H8K/MgZcSemhYY4WGMSX8qVDgs61t7TUrNBZ/JI99Ks=;
        b=arB4yi/dIEUdosT5zsJri0qAL7RTkgxPqiTVAubgWy5f/C1i89CLWV5lD5CZSB+NEG
         uG1fECbWMwBf58C8kVAeaMgucy4EI/HqFA5vE3m3hp94o3UWYCt8CX3xraseMqdRG79c
         SfXHRWS+2dCI26YqTWa8IKUZjkvEuNPvuKjWISBgrfKS/zpzP0s45Q1JAsSLLz+/sugp
         kvroi9GxxwLrXtNRzA9lFPY6SzZwvcYAWNas5/RDQ+x+WspapVH4IIN/t5l+10XexjfH
         MTZFlQz/AzHcnXbs3CYtDqrAVIWE7RuE6JGNowq11WvgLJ/5vZtIjIsGrkr/phP8kl4k
         J+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=H8K/MgZcSemhYY4WGMSX8qVDgs61t7TUrNBZ/JI99Ks=;
        b=AtbobkteRjz0kQmnUPILGcUfrx2DHL++Sa2CEDzQ7OAQEpgGRoUBxj4j9bONyS2FoW
         Qs8QZShNXtKXI26aEEE5W6hanfFfh+QL9OyMZAhQrLah+cDqHdxuAZ5rWwWTsBTqIoPW
         mVj0/3tTCHpVV2pRMxb85yp+C7iT5KnRzM10DkvbsTk/2d7hFhHrA5TvjFIaX0w+0Bs3
         hslK6C3h0JbGCz69lVvwo06UENzIcNa8A8EUHktay/GFEhVDbSlwXNBoTqVAYoriiO4y
         QVMQi+R+xjD/qNfeM1sgjG1oiPsxCTolrC7RJJ/NRP70VXrEiAyKwJe0gmxbp5i9gfdT
         DJ7g==
X-Gm-Message-State: AOAM533b7eVJA/T9jAtQXRFSUeyBLTYqVLfCQwQCyqpxtWReSIZMJzJa
        FYjWakNXCA0KyPC7Vb8cFBiEzhZatpo=
X-Google-Smtp-Source: ABdhPJynjzRRS+x6vS4C7Yug5qG2+plwcAdcKLaxcTJa/IpSDuAT5mpBnu4r82ppq3+kpoJULkj8Ww==
X-Received: by 2002:a05:6402:1a48:: with SMTP id bf8mr6665872edb.201.1625582234950;
        Tue, 06 Jul 2021 07:37:14 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h14sm5876927ejl.118.2021.07.06.07.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 07:37:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 0/5] refs: cleanup errno sideband ref related functions
Date:   Tue, 06 Jul 2021 16:27:08 +0200
References: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
 <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
 <87v95o5ku8.fsf@evledraar.gmail.com>
 <CAFQ2z_N_J499X_wd4RGR7jobs3O3NvQuobJ9UcQijkNYN712dw@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAFQ2z_N_J499X_wd4RGR7jobs3O3NvQuobJ9UcQijkNYN712dw@mail.gmail.com>
Message-ID: <87sg0r5x0m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 06 2021, Han-Wen Nienhuys wrote:

> On Tue, Jul 6, 2021 at 2:48 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>>
>> On Mon, Jul 05 2021, Han-Wen Nienhuys via GitGitGadget wrote:
>>
>> > v5
>>
>> v3?
>
> I erroneously closed out the github PR I used for the first 2 versions
> of this change series.  (https://github.com/git/git/pull/1011)
>
>> >  * address =C3=86var's comment; punt on clearing errno.
>> > [...]
>> >
>> >           Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>> >           Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
>> >      +    Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@=
gmail.com>
>>
>> FWIW per Documentation/SubmittingPatches:
>>
>>     . `Reviewed-by:`, unlike the other tags, can only be offered by the
>>       reviewer and means that she is completely satisfied that the patch
>>       is ready for application.  It is usually offered only after a
>>       detailed review.
>>
>> It's not that I'm hard to please, but I can honestly say that I don't
>> quite understand some parts of what you're gonig for, so that trailer is
>> probably premature :)
>
> oh, ok. Removed them.
>
> Does that mean you'd have to repost my patchseries just to add the
> reviewed-by header?

It's fine to keep it. I just noted this (with a ":)") since I
Reviewed-By is understood by Junio (I believe) to mean something closer
to "this person has fully understood this code & endorses it". So far I
was only confident to say I was on right-hand-side of that "&",
give-or-take suggested changes :)

With the below suggestions for a v4 you can keep my Reviewed-By if you'd
like.

>> To rephrase my comment on the v2 to hopefully better get at the
>> point/question I had.
>>
>> It wasn't that I don't get why you wouldn't save/restore errno in
>> general.
>>
>> It's that the pattern of doing so seems backwards to me. I.e. surely the
>> goal here should be to one function at a time, and from the bottom-up,
>> figure out where we rely on "errno" and convert that to a
>> "failure_errno".
>>
>> Instead not even files_read_raw_ref() resets "errno =3D 0" at the end, so
>> the errno /there/ can propagate upwards, and in this v3 we're not cleari=
ng it at all.
>
> I would really want errno to be an explicit output for more functions
> in refs.h, but I don't have the time to see that through, and it's a
> distraction from the reftable work, so I have changed the objective of
> the patch series.
>
> I'm limiting myself to explicitly propagating errno values that are
> used beyond error reporting. The EINVAL value for
> parse_loose_ref_contents is a borderline case: it has an extra "if ()"
> body in lock_raw_ref, but it's for an error message.
>
> This means that we should avoid clearing errno, because we'd otherwise
> have to track down all the places where it's being put into
> strerror(). The one case you found earlier is still there, and by not
> clearing errno, I can keep this series smaller by not also having to
> rework verify_lock/read_refs_full.

I really think your v2 (or v4?, whatever) that set "errno =3D 0" plus
eyeballing that grep command as we've done is justification enough to
keep the "errno =3D 0".

I just had the comment to the effect of "uh, oh, maybe we've missed more
of these" on v2, but I think since then with your grep we can be fairly
sure we haven't.

I.e. the codepaths involved return non-zero anyway, so any breakage
would be limited to ignoring that and directly checking errno, or using
errno to format error messages.

If there is something like that still it'll be fairly far up the stack,
I think it's unplausible that there's anything left.

We can do it in a follow-up series if you'd like, or not do it before
reftable. I just think it's cleaner to be assured that we're past this
particular hump, and are guaranteed not to gain future callers that rely
on the errno in some subtle way (without the explicit pass-in variable,
that is).

> In general, it's frustrating to observe that the files backend is a
> complex beast that nobody understands, but in order to replace it with
> something more principled, I have to spend lots of time cleaning it
> up.

Yeah, it sucks. Or more specifically, that our "abstract" API isn't very
"abstract", but basically a 1=3D1 mapping to the files backend.

>> Having dug a bit further, it seems what you're doing, whether it's
>> intentional or not, is relying on the parse_loose_ref_contents() setting
>> EINVAL, but you clobber your *failure_errno with it whether it returned
>> -1 or not.
>
> I've added a failure_errno argument parse_loose_ref_contents now.

Great, it's not clear if you picked up the full diff-on-top but I think
consistently using *failure_errno in files_read_raw_ref() instead of
"errno" and the "*failure_errno =3D errno" at the end also makes the code
much more readable (and allows for the removal of the "saved_errno" we
don't want).

By using "errno" itself for the body of the function it needs to be
really carefully read to assure oneself that one of the functions it
calls doesn't make a syscall, and even if we're assured of that now if
one of them has a new syscall added in the future it might be clobbered
at a distance.
