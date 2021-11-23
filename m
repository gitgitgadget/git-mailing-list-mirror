Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA1FC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 23:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhKWXqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 18:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhKWXqp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 18:46:45 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E494C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 15:43:37 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id gf15-20020a17090ac7cf00b001a9a31687d0so460765pjb.1
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 15:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=7k3YXYn98zymHmbfGuyJWMe8K7mRZ4u9B0NpvVcqZh4=;
        b=gLvWpDXj7vhst6PCb6wIFyNiBvNAHWQsJu0+EKLTGIDBuUXR+thAdd2KaCMbvldMTl
         tzTxHV0SfkJ4hiO7C7pi8Slzr/B1yZFszeznnC1j5JgxspGW3QhkEsfUgj092oI396HF
         vNfOMgEjuY2X9u68i8AZU8u0qRsA8wJnsWesUNh9KOL2oyTCTa7LphkMy4ruDaqZRuVS
         ngTBjilvLcVxMSMZkg3JlmYX/MwB79TIP9ABR58AxT+oEJv3OawVOg36e4gfls4Z3wMQ
         4RsaELk3VOap/iPlZrUTbfELx0Allksv2TFrQ9olO7U5ugUsbg5SVdfOs+EFKB7/jkfo
         rh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=7k3YXYn98zymHmbfGuyJWMe8K7mRZ4u9B0NpvVcqZh4=;
        b=0nzLbJ6E41pFw/QgSOUdJSA04w54CDLsGddoUBTxI0Nz1r6zeuhFKywBra/p4Bv/zA
         AbMTGEqKinfvHgJNIXys8U7s3tIWbxN8ttP27k5U0e9ofXDXhvM1m1K3s8BPHrZoVELz
         Mpeq37zyAqR58GTrj3EKuFVdlCt12oFY1F907aWNwRpi6nLnOPPz74EE/lGds9gc2WVM
         Tob3I8DobASG6Xp3UnWlRkSXwIasJsjMPgiBsNUisTqCtUa3t/ZfoRI08hKt58d6w18J
         tw6iGIEMGp5HUGl3JFRksvkdcFi6NO0Or2spTPL0pM/IJYAqNvDQv5GyRPJCgFpYm51B
         pNRg==
X-Gm-Message-State: AOAM533NvkIW/vD2POghzIWJqMScm+ILTBCpsXVt54rIlTDh4WtiIeeK
        1eZ9ctBJRCZz38vnrWSC7QrM1SJhsDnCwA==
X-Google-Smtp-Source: ABdhPJwsm/JjSlhSWakdRueKMQnwJN44Tf65ywKOmAy7B7OH9yLZEl2kK+xyvWUoS+hbjhTwcGl/kTpXS4IIoQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:8ac4:: with SMTP id
 y187mr5470698pgd.462.1637711016913; Tue, 23 Nov 2021 15:43:36 -0800 (PST)
Date:   Tue, 23 Nov 2021 15:43:28 -0800
In-Reply-To: <3ad3941c-de18-41bf-2e44-4238ae868d79@gmail.com>
Message-Id: <kl6lwnkytp3z.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211122223252.19922-1-chooglen@google.com> <20211122223252.19922-5-chooglen@google.com>
 <3ad3941c-de18-41bf-2e44-4238ae868d79@gmail.com>
Subject: Re: [PATCH 4/4] branch: add --recurse-submodules option for branch creation
From:   Glen Choo <chooglen@google.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks for the thorough review! I really appreciate it, Philippe :)

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Glen,
>
> Le 2021-11-22 =C3=A0 17:32, Glen Choo a =C3=A9crit=C2=A0:
>> Add a --recurse-submodules option when creating branches so that `git
>> branch --recurse-submodules topic` will create the "topic" branch in the
>> superproject and all submodules. Guard this (and future submodule
>> branching) behavior behind a new configuration value
>> 'submodule.propagateBranches'.
>>=20
>> Signed-off-by: Glen Choo <chooglen@google.com>
>> ---
>>   Documentation/config/advice.txt    |   3 +
>>   Documentation/config/submodule.txt |   9 ++
>
> We would need to add the new flag to Documentation/git-branch.txt,
> and also probably update the documentation of 'submodule.recurse'
> in 'Documentation/config/submodule.txt'.

Yes, thanks for the catch.

>> diff --git a/Documentation/config/submodule.txt b/Documentation/config/s=
ubmodule.txt
>> index ee454f8126..c318b849aa 100644
>> --- a/Documentation/config/submodule.txt
>> +++ b/Documentation/config/submodule.txt
>> @@ -72,6 +72,15 @@ submodule.recurse::
>>   	For these commands a workaround is to temporarily change the
>>   	configuration value by using `git -c submodule.recurse=3D0`.
>>  =20
>> +submodule.propagateBranches::
>> +	[EXPERIMENTAL] A boolean that enables branching support with
>> +	submodules. This allows certain commands to accept
>> +	`--recurse-submodules` (`git branch --recurse-submodules` will
>> +	create branches recursively), and certain commands that already
>> +	accept `--recurse-submodules` will now consider branches (`git
>> +	switch --recurse-submodules` will switch to the correct branch
>> +	in all submodules).
>
> Looking at the rest of the patch, this just implements 'branch --recurse-=
submodules', right ?
> i.e. 'git switch' and 'git checkout' are left alone for
> now, so I think this addition to the doc should only mention 'git
> branch'.

That sounds reasonable. I can move this description into the commit
message instead.

>> diff --git a/advice.h b/advice.h
>> index 601265fd10..a7521d6087 100644
>> --- a/advice.h
>> +
>> +		if (repo_submodule_init(
>> +			    &subrepos[i], r,
>> +			    submodule_entry_list->name_entries[i].path,
>> +			    &super_oid)) {
>> +			die(_("submodule %s: unable to find submodule"),
>> +			    submodules[i].name);
>> +			if (advice_enabled(ADVICE_SUBMODULES_NOT_UPDATED))
>> +				advise(_("You may try initializing the submodules using 'git checko=
ut %s && git submodule update'"),
>> +				       start_name);
>
> Apart from what =C3=86var pointed out about advise() being called after d=
ie(),
> I'm not sure this is the right advice, because if repo_submodule_init fai=
ls
> it means there is no .git/modules/<name> directory corresponding to the s=
ubmodule's
> Git repository, i.e. the submodule was never cloned. So it's not guarante=
ed
> that 'git checkout $start_name && git submodule update' would initialize =
(and clone) it,
> not without '--init'.

After further testing, it seems that --init might be required for
recursive submodules, but as you note later on, it's not needed for the
test case I have created. Using --init is still good advice though, so I
will add that.

>> +	for (i =3D 0; i < submodule_entry_list->entry_nr; i++) {
>
> Here we loop over all submodules, so branches are created even in
> inactive submodules... this might not be wanted.

Yes, we should ignore inactive submodules. This is a bug.

>> @@ -713,9 +726,16 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
>>   	if (create < 0)
>>   		usage_with_options(builtin_branch_usage, options);
>>  =20
>> +	if (recurse_submodules_explicit && submodule_propagate_branches &&
>> +	    !create)
>> +		die(_("--recurse-submodules can only be used to create branches"));
>>   	if (dry_run && !create)
>>   		die(_("--dry-run can only be used when creating branches"));
>>  =20
>> +	recurse_submodules =3D
>> +		(recurse_submodules || recurse_submodules_explicit) &&
>> +		submodule_propagate_branches;
>> +
>
> OK, so we get the new behaviour if either --recurse-submodules was used, =
or 'submodule.recurse' is true,
> and in both case we also need the new submodule.propagateBranches config =
set.
>
> Why not adding 'branch.recurseSubmodules' instead, with a higher priority=
 than submodule.recurse ?
> Is it because then it would be mildly confusing for 'git checkout / git s=
witch' to also honor
> a setting named 'branch.*' when they learn the new behaviour ? (I don't t=
hink this would be the
> first time that 'git foo' honors 'bar.*', so it might be worth mentioning=
).

I am avoiding the prefix 'branch.' because that might suggest that the
functionality is centered around the 'git branch' command. I chose the
'submodule.' prefix because what we are feature flagging is an entirely
redesigned UX for _submodules_ that uses branches; we also have work
planned for other commands like push/merge/rebase/reset.

> Also, why do we quietly ignore '--recurse-submodules' if submodule.propag=
ateBranches is unset ?
> Wouldn't it be better to warn the user "hey, if you want this new behavio=
ur you need to
> set that config !" ?

Ah, yes this is an oversight on my part.

> I don't have a strong opinion about the fact that you need to set the con=
fig in the first
> place, but I think it should be mentioned in the commit message why you c=
hose to implement
> it that way (meaning, why do we need a config set, instead of adding the =
config but defaulting it
> to true, so that you get the new behaviour by default, but you still can =
disable it if you do not
> want it)...

It seems self-evident to me that experimental features should not be
shipped to users by default.

>> +test_expect_success 'should not set up unnecessary tracking of local br=
anches' '
>> +	test_when_finished "cleanup_branches super branch-a" &&
>> +	(
>> +		cd super &&
>> +		git branch --recurse-submodules branch-a main &&
>> +		git -C sub rev-parse main &&
>> +		test "$(git -C sub config branch.branch-a.remote)" =3D "" &&
>> +		test "$(git -C sub config branch.branch-a.merge)" =3D ""
>> +	)
>
> don't we have a "config is empty" test helper or something similar ?

Hm, I couldn't find one, but there is test_cmp_config(). That's probably
better than calling test() directly.

>> +test_expect_success 'should not create branch when submodule is not in =
.git/modules' '
>> +	# The cleanup needs to delete sub2:branch-b in particular because main=
 does not have sub2
>> +	test_when_finished "git -C super-clone/sub2 branch -D branch-b && \
>> +		cleanup_branches super-clone branch-a branch-b" &&
>> +	(
>> +		cd super-clone &&
>> +		# This should succeed because super-clone has sub.
>> +		git branch --recurse-submodules branch-a origin/branch-a &&
>> +		# This should fail because super-clone does not have sub2.
>> +		test_must_fail git branch --recurse-submodules branch-b origin/branch=
-b 2>actual &&
>> +		cat >expected <<-EOF &&
>> +		fatal: submodule sub: unable to find submodule
>> +		You may reinitialize the submodules using ${SQ}git checkout origin/br=
anch-b && git submodule update${SQ}
>> +		EOF
>> +		test_must_fail git rev-parse branch-b &&
>> +		test_must_fail git -C sub rev-parse branch-b &&
>> +		# User can fix themselves by initializing the submodule
>> +		git checkout origin/branch-b &&
>> +		git submodule update &&
>> +		git branch --recurse-submodules branch-b origin/branch-b
>> +	)
>
> Considering what has been pointed out above, I'm not sure why this test p=
asses...
> Unless I'm missing something.

As I understand it, --init is used to set values in .git/config. My best
guess is that 'git submodule update' doesn't use .git/config at all - it
looks for submodules in the index and .gitmodules and clones the
submodules as expected.

I still think that we should promote --init, but I still find this
situation very strange and inconsistent.
