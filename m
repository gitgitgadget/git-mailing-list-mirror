Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6481EC43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 15:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiK1Pxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 10:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiK1Pxd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 10:53:33 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DB52252B
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 07:53:31 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id n21so26902774ejb.9
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 07:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=20mngwDzWtnMAZeqeUdYn9tgPng9lSBLh6MBX2UTFqk=;
        b=U8/CfpfD7r+r0DzXyxMh6gMS4c8r7plkPSVsrp5WGMeK+4f3NUkZWOieVNevcZ8Y2s
         YAGizbpmJd2++oW7ze31lCZF6UmC+zugHDpn7ZoS9dWbJUwkX6k55w0mb2KW7k5CCona
         Xh0jaxDCu28Fdzp8q3OqZJR09bL3MzzeArsX4iyYMVZNFAdWoUKD8bSj4h3zbQIOLmIr
         CaoZSkpeS85IkgXnGs+80hFF1KHp1Ho3nlEQNw+CMSz9gkk3xTLAC6yOLu4m/+lB0hKj
         MYIptn04sLlVQjDgrzvMoEtaA6aUoum2a4JZnyuXYaNYgmNH8XqZCAFPKg1e187c8EXJ
         6wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20mngwDzWtnMAZeqeUdYn9tgPng9lSBLh6MBX2UTFqk=;
        b=qLaIMmQW+FXD1CGtK0MwEqwYW2VLG8SjzE+a6ndlO3Xho+17/hKnvOwVRRZKam0/Jo
         pSAGFTXjH/V6EDlaA3G37JJBWJqZcdq0tCTo+b4U9M68/SnCkFs39qKOtZ7KtKUEtg9b
         IxQ/kEc0XF6qJpxU1HJxe26qBR9Ja39rHZm9hL+tDa0zI9cNCVIBp0IKHwJe30lRSl7n
         78FS6Et7p9PXd0iOcRe0uOW7qFSokqvWOsqjPprQx+N3+JhZ1GG08A3oOUoJe4sAAb9a
         JwYeEqQSbsHI+4wM3ydL9DNJl13nflWP9LXPcTaXlcSZSAPXCaA2JX3LzKI7PGvJUCMq
         PsVw==
X-Gm-Message-State: ANoB5pkE3kQvkneDGo5FkIfEtThrKXCZtH1hZ1g+ji8qMEqXywKg5crs
        kgUIZEH826gqQs6uPEITs0c=
X-Google-Smtp-Source: AA0mqf43LZHZQ2uyp0kgokC6pJB1leN5Qud7BKGSXQ4Q+glxjaMB15d89DXm+JQ6KzSRf9sJ9pxspQ==
X-Received: by 2002:a17:906:745:b0:7bd:f50f:a51c with SMTP id z5-20020a170906074500b007bdf50fa51cmr9768120ejb.285.1669650809937;
        Mon, 28 Nov 2022 07:53:29 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id o5-20020a170906768500b007ad96726c42sm5124473ejm.91.2022.11.28.07.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 07:53:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ozgRk-0019Cz-1K;
        Mon, 28 Nov 2022 16:53:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] Revert "pack-objects: lazily set up "struct
 rev_info", don't leak"
Date:   Mon, 28 Nov 2022 16:27:57 +0100
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
 <f5779e19-813c-cda9-2f84-9fe58f745e89@web.de> <xmqqv8mz5ras.fsf@gitster.g>
 <d10de9b5-e5ff-18d6-d950-1d090d87b113@web.de>
 <221128.864jujmhgp.gmgdl@evledraar.gmail.com>
 <221128.86zgcbl0pe.gmgdl@evledraar.gmail.com>
 <9bea523d-93d1-953b-a136-3f00844c880a@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <9bea523d-93d1-953b-a136-3f00844c880a@web.de>
Message-ID: <221128.861qpnkrd3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 28 2022, Ren=C3=A9 Scharfe wrote:

> Am 28.11.2022 um 13:24 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Mon, Nov 28 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> Ren=C3=A9:
>>
>>> On Mon, Nov 28 2022, Ren=C3=A9 Scharfe wrote:
>>>
>>>> Am 28.11.2022 um 11:03 schrieb Junio C Hamano:
>>>>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>>>
>>>>>> This reverts commit 5cb28270a1ff94a0a23e67b479bbbec3bc993518.
>>>>>>
>>>>>> 5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't lea=
k,
>>>>>> 2022-03-28) avoided leaking rev_info allocations in many cases by
>>>>>> calling repo_init_revisions() only when the .filter member was actua=
lly
>>>>>> needed, but then still leaking it.  That was fixed later by 2108fe4a=
19
>>>>>> (revisions API users: add straightforward release_revisions(),
>>>>>> 2022-04-13), making the reverted commit unnecessary.
>>>>>
>>>>> Hmph, with this merged, 'seen' breaks linux-leaks job in a strange
>>>>> way.
>>>>>
>>>>> https://github.com/git/git/actions/runs/3563546608/jobs/5986458300#st=
ep:5:3917
>>>>>
>>>>> Does anybody want to help looking into it?
>>>
>>> [I see we crossed E-Mails]:
>>> https://lore.kernel.org/git/221128.868rjvmi3l.gmgdl@evledraar.gmail.com/
>>>
>>>> The patch exposes that release_revisions() leaks the diffopt allocatio=
ns
>>>> as we're yet to address the TODO added by 54c8a7c379 (revisions API: a=
dd
>>>> a TODO for diff_free(&revs->diffopt), 2022-04-14).
>>>
>>> That's correct, and we have that leak in various places in our codebase,
>>> but per the above side-thread I think this is primarily exposing that
>>> we're setting up the "struct rev_info" with your change when we don't
>>> need to. Why can't we just skip it?
>>>
>>> Yeah, if we do set it up we'll run into an outstanding leak, and that
>>> should also be fixed (I have some local patches...), but the other cases
>>> I know of where we'll leak that data is where we're actually using the
>>> "struct rev_info".
>>>
>>> I haven't tried tearing your change apart to poke at it myself, and
>>> maybe there's some really good reason for why you can't separate getting
>>> rid of the J.5.7 dependency and removing the lazy-init.
>>>
>>>> The patch below plugs it locally.
>>>>
>>>> --- >8 ---
>>>> Subject: [PATCH 4/3] fixup! revision: free diffopt in release_revision=
s()
>>>>
>>>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>>>> ---
>>>>  builtin/pack-objects.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>>>> index 3e74fbb0cd..a47a3f0fba 100644
>>>> --- a/builtin/pack-objects.c
>>>> +++ b/builtin/pack-objects.c
>>>> @@ -4462,6 +4462,7 @@ int cmd_pack_objects(int argc, const char **argv=
, const char *prefix)
>>>>  	} else {
>>>>  		get_object_list(&revs, rp.nr, rp.v);
>>>>  	}
>>>> +	diff_free(&revs.diffopt);
>>>>  	release_revisions(&revs);
>>>>  	cleanup_preferred_base();
>>>>  	if (include_tag && nr_result)
>>>
>>> So, the main motivation for the change was paranoia that a compiler or
>>> platform might show up without J.5.7 support and that would bite us, but
>>> we're now adding a double-free-in-waiting?
>>>
>>> I think we're both a bit paranoid, but clearly have different
>>> paranoia-priorities :)
>>>
>>> If we do end up with some hack like this instead of fixing the
>>> underlying problem I'd much prefer that such a hack just be an UNLEAK()
>>> here.
>>>
>>> I.e. we have a destructor for "revs.*" already, let's not bypass it and
>>> start freeing things from under it, which will result in a double-free
>>> if we forget this callsite once the TODO in 54c8a7c379 is addressed.
>>>
>>> As you'd see if you made release_revisions() simply call
>>> diff_free(&revs.diffopt) doing so would reveal some really gnarly edge
>>> cases.
>>>
>>> I haven't dug into this one, but offhand I'm not confident in saying
>>> that this isn't exposing us to some aspect of that gnarlyness (maybe
>>> not, it's been a while since I looked).
>>>
>>> (IIRC some of the most gnarly edge cases will only show up as CI
>>> failures on Windows, to do with the ordering of when we'll fclose()
>>> files hanging off that "diffopt").
>>
>> This squashed into 3/3 seems to me to be a proper fix to a change that
>> wants to refactor the code for non-J.5.7 compatibility. I.e. this just
>> does the data<->fp casting part of the change, without refactoring the
>> "lazy init".
>
> That works, but lazy code is more complicated and there is no benefit
> here -- eager allocations are not noticably slow or big.  Laziness
> hides leaks in corners, i.e. requiring invocations with uncommon
> options to trigger them.

Yes, sometimes it's easier to just set everything up at the
beginning. As for hiding leaks I think the empirical data here is going
against that, i.e. your change introduced a leak.

I don't think it's realistic that we'll have the side that assigns to
"have_revs" drift from the corresponding code in cmd_pack_objects().

>> But I think you should check this a bit more carefully. Your 3/3 says
>> that your change "mak[es] the reverted commit unnecessary"
>
> No, it says that _your_ change 2108fe4a19 (revisions API users: add
> straightforward release_revisions(), 2022-04-13) made it unnecessary.

Yes, I'm saying that's not correct, because if you run the command that
5cb28270a1 prominently notes we'll now leak with this revert:

	echo e83c5163316f89bfbde7d9ab23ca2e25604af290 | ./git pack-objects initial

But yes with just 5cb28270a1 didn't add release_revisions(), that came
shortly afterwards in 2108fe4a19.

>> , but as I
>> noted if you'd run the command that commit shows, you'd have seen you're
>> re-introducing the leak it fixed. So I wonder what else has been missed
>> here.
>
> 5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't leak,
> 2022-03-28) did not plug the leak.  It only moved it to the corner that
> handles the --filter option.

I think we're using "the leak" here differently. I mean callstacks that
LeakSanitizer emits & tests we have that do & don't pass with
SANITIZE=3Dleak.

But yes, there may be multiple paths through a function, some of which
leak, some of which don't. I'm not saying that the entire set of API
features that builtin/pack-objects.c uses in the revision API is
leak-free.

> That leak is only interesting to Git developers and harmless for users.
> But if the goal is to become free of trivial leaks in order to allow
> using tools like LeakSanitizer to find real ones then pushing them into
> the shadows not yet reached by our test coverage won't help for long.

It's clearly helping in this case, as our CI had multiple failing tests.

>> I vaguely recall that one reason I ended up with that J.5.7 dependency
>> was because there was an objection to mocking up the "struct option" as
>> I'm doing here. I.e. here we assume that the
>> opt_parse_list_objects_filter() is only ever going to care about the
>> "value" member.
>
> It's probably fine, but unnecessarily complicated compared to calling
> repo_init_revisions() eagerly.

I'm leaving aside the question of whether we should go for some version
of the refactoring in your 3/3.

What I am saying is that such refactoring should be split up from the
more narrow bug fix to the existing code. I.e. this as a replacement for
your 3/3 is all that's needed to pass the test you're adding in 2/3.

-- >8 --
From: =3D?UTF-8?q?Ren=3DC3=3DA9=3D20Scharfe?=3D <l.s.r@web.de>
Subject: [PATCH] pack-objects: support multiple --filter options again

5cb28270a1f (pack-objects: lazily set up "struct rev_info", don't
leak, 2022-03-28) broke support for multiple --filter options by
calling repo_init_revisions() every time "--filter" was seen. Instead
we should only do so the first time, and subsequently append to the
existing filter data.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c                 | 3 ++-
 t/t5317-pack-objects-filter-objects.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 573d0b20b76..c702c09dd45 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4158,7 +4158,8 @@ static struct list_objects_filter_options *po_filter_=
revs_init(void *value)
 {
 	struct po_filter_data *data =3D value;
=20
-	repo_init_revisions(the_repository, &data->revs, NULL);
+	if (!data->have_revs)
+		repo_init_revisions(the_repository, &data->revs, NULL);
 	data->have_revs =3D 1;
=20
 	return &data->revs.filter;
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-=
filter-objects.sh
index 25faebaada8..5b707d911b5 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -265,7 +265,7 @@ test_expect_success 'verify normal and blob:limit packf=
iles have same commits/tr
 	test_cmp expected observed
 '
=20
-test_expect_failure 'verify small limit and big limit results in small lim=
it' '
+test_expect_success 'verify small limit and big limit results in small lim=
it' '
 	git -C r2 ls-files -s large.1000 >ls_files_result &&
 	test_parse_ls_files_stage_oids <ls_files_result |
 	sort >expected &&
--=20
2.39.0.rc0.993.g0c499e58e3b

