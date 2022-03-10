Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707F9C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 00:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiCJAeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 19:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiCJAem (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 19:34:42 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C4D6D197
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 16:33:40 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qx21so8600742ejb.13
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 16:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=UAzHuTQvh18EUUjR70MkFRE6t15lbrQje5Xhu+ltT44=;
        b=Ma43DEatO0z1aDGDoSQIoTUcItzM/2qRa5Evd8R8/DBBUfesEFja2YBSZec9LBdIqA
         mnU2Kdsm5eCSccnuLQKmTP1VRYOOLne2+K9ZrzN1e9sJJz7wJTbEIERKbB1B1pIP8Q5V
         Bchd/e6Hxg47Jkguj5j+uTZb4VMKXdA9mQtGDdYUNGXe+irfL1jCKNKos8kTdZb4sMHO
         u3+eSCS0eXzxBJiHG1o/pV3x/z7NpOVmB2ToajlFyXMePr2uDirjav1O0fbH7oDLAoYL
         n62jM+hm2lx2LMWbqraDIZ26zj+LEGEouqnpYfSDJYg/qWTtATJ4h+QATmsunMEr9nCe
         rn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=UAzHuTQvh18EUUjR70MkFRE6t15lbrQje5Xhu+ltT44=;
        b=Hs62n96MR2425MXX+cgcn9MD5QaD68Us8eFkja3gSwfHjD+9O7pmsQLM607KRD+O7e
         ipCc7RyB3Aw2urkrorTPzHegjRv+pfHSkg+trG4lgS5KTXdOAQB7ckRr6NlRgQYMC8jI
         +2hvE760FNR29oScXgzkPWDzOp23/ifLMIZKX9jCFQRp1try2qhx39E4rn/lk5Bhz3OG
         //GR0j/aHWWIkDx8PO/KoL2fZBpaxzF07UeZJUnpsIQAwx4anOHpLmLeGa+IXmmUTOCU
         79fHIk9E5ddkKTF+Uabw9LK5/effF5jni/ZATdldNbTsFuBBRNv9GYcepo2yGyTPbNrc
         kNiA==
X-Gm-Message-State: AOAM531kw/l9O22xIDHZkeP9A2KeIy6m2KI1F0Mh8dF4LMXC7vZ+zFl6
        jazZnnzqiI7vd7Yh4riL6LM=
X-Google-Smtp-Source: ABdhPJy+rlS0lElX7CAbgeSQgJl0iqF+7IJvQ9grgTCwrTlY87xZHd1PgK63lnCdcLC7Eq5f/FjLCg==
X-Received: by 2002:a17:907:3f25:b0:6b0:5e9a:83 with SMTP id hq37-20020a1709073f2500b006b05e9a0083mr2133784ejc.659.1646872419285;
        Wed, 09 Mar 2022 16:33:39 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c786000000b00410d2403ccfsm1419939eds.21.2022.03.09.16.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 16:33:38 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nS6kM-000Nxe-6p;
        Thu, 10 Mar 2022 01:33:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 05/24] revision.[ch]: provide and start using a
 release_revisions()
Date:   Thu, 10 Mar 2022 01:28:04 +0100
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <patch-05.24-b89dcadcc22-20220309T123321Z-avarab@gmail.com>
 <xmqqmthylonj.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqmthylonj.fsf@gitster.g>
Message-ID: <220310.864k46lk7x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 09 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index 9244827ca02..ed993383531 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -629,7 +629,7 @@ static void show_local_changes(struct object *head,
>>  	diff_setup_done(&rev.diffopt);
>>  	add_pending_object(&rev, head, NULL);
>>  	run_diff_index(&rev, 0);
>> -	object_array_clear(&rev.pending);
>> +	release_revisions(&rev);
>>  }
>
> I very much like this.
>
>> -	object_array_clear(&rev.pending);
>>  	clear_pathspec(&rev.prune_data);
>> +	release_revisions(&rev);
>
> But this makes readers wonder why .prune_data still needs a separate
> call to clear.  We are making it unnecessary to clear .pending
> separately, which was what made me say I very much like this in the
> first place.
>
> At least surviving clear_pathspec() now deserves an in-code comment?
> We'll know when we see what release_revisions() actually does.

I'll note it in a commit message. Generally in this series I then loop
back and remove the clear_pathspec() (or similar) once I start clearing
"prune_data", but in this case I seem to have missed this specific case
later in the series...

>>  	run_diff_index(&rev, 1);
>> -	object_array_clear(&rev.pending);
>> -	return (rev.diffopt.flags.has_changes !=3D 0);
>> +	has_changes =3D rev.diffopt.flags.has_changes;
>> +	release_revisions(&rev);
>> +	return (has_changes !=3D 0);
>
> This is necessary because release_revisions(&rev) is a way to
> release all resources held by rev, and .has_changes is stored
> as a part of a resource that will be cleared.

Yes, but...

>> diff --git a/revision.c b/revision.c
>> index 5824fdeddfd..831f2cf977b 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -2926,6 +2926,13 @@ static void release_revisions_commit_list(struct =
rev_info *revs)
>>  	revs->commits =3D NULL;
>>  }
>>=20=20
>> +void release_revisions(struct rev_info *revs)
>> +{
>> +	if (!revs)
>> +		return;
>> +	object_array_clear(&revs->pending);
>> +}
>
> Whoa.=20=20
>
> Earlier, we saw a code that indicates that a call to this function
> will invalidate the revs->diffopt.flags.has_changes but that is not
> the case, at least at this point in the series.  Is this a result of
> an incorrect "rebase -i"?
>
> Regarding the clear_pathspec() earlier we saw, it is OK to leave the
> call there without any extra comment, if the plan is to first start
> by introducing release_revisions() that does nothing but .pending
> field.  But then the diffopt.flags.has_changes thing we saw earlier
> should be postponed to a step where release_revisions() clears the
> diffopt structure that is embedded in rev_info.
>
>> @@ -2568,8 +2568,9 @@ int has_uncommitted_changes(struct repository *r,
>>=20=20
>>  	diff_setup_done(&rev_info.diffopt);
>>  	result =3D run_diff_index(&rev_info, 1);
>> -	object_array_clear(&rev_info.pending);
>> -	return diff_result_code(&rev_info.diffopt, result);
>> +	result =3D diff_result_code(&rev_info.diffopt, result);
>> +	release_revisions(&rev_info);
>> +	return result;
>
> Ditto.

...indeed, those don't do anything yet.

I thought it better (and will explain so in a re-rolled commit message)
to start adding release_revisions() to existing API users, and not to
have those individidual users assume anything about what is and isn't
cleared yet.

Some users that end up with the release_revisions() don't need it at
all, because in those cases we just so happen not to actually allocate
anything.

But just like with strbuf_release() et al we generally just add it at
the end, and just have the destructor worry about the NOOP-ing.

So I'd prefer to keep this part of the general structure as-is,
i.e. even if we do nothing with "diffopt" *yet* we can assert that the
mere addition of the nascent release_revisions() isn't breaking anything
by merely existing as we add it to all "struct rev_info" users.

Then as we add more things to release_revisions() we get a nicely tested
before/after where we can see if/how adding new free()'s there breaks or
doesn't break.
