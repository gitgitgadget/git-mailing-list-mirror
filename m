Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACEFC433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 16:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FCAD611C9
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 16:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbhIVQ5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 12:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbhIVQ5C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 12:57:02 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E331C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 09:55:32 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id bl32-20020a05620a1aa000b004330d29d5bfso10844756qkb.23
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 09:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=7RZQv94K/Xkc5Ndzs0etQ0maYmEaDx+r4jbpXo02Dzo=;
        b=plNi0U5rmPXxWE39YhiVmyQhPPtC3E6MXDmcPU0PTtMveaI3ee4VDb2LyU7KuOEsr+
         3RgK7FyrKnCffqe7LDJ9t6dCmtNfaxZYwCBK0voUkozu+Aq9vHBufg37RMaQuv0lybX2
         qFeFnnOjTmZmM13I2MnnT2ocqb1xJGyhkPpz6cKdg0rEcNkISQGMEiA79JLZ6ZL0V2+y
         hpE6u0TKpvNfIfF8oAEO4vy0UE0R6Wr1EgCw/g2f3S1SVH4WMLf2eElcWXjUNtNtbAhw
         W89TCXEvaH0Mcrv1Yfy+0rfTHCEDNLdHVwIkuk0CoFvjtWQkbIdvHQQ0wRV4xcJ0EYhj
         Ebcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=7RZQv94K/Xkc5Ndzs0etQ0maYmEaDx+r4jbpXo02Dzo=;
        b=UvQlxZDOPk06zlPFkU/dKtFCbwHe3+CmPWSmeEvOv0utLHsuVfqP9c8xLjuSDSX9kU
         xwWzqU2Vl9la+nAFKnZ9e1pMiVWQawRz1HsewITDcUQmgalOFvPSJWTZ8kh8DCwAhVAJ
         CHQfRZPp8UujS2QJcguWmiQcSNA+CW01Iw1v2ePDh6VVOeDLkZSggfhqS9SF8CBsdx/F
         XikI4SFfrlDa8PL4r7xHbqptOcfl0l5YLYCy/au+nxOckjTM4pUin0RtdAcXK+xOE5rE
         cPZmDPXDVTLnx334st41m4cGWMqAD64U9qySS0+5skR7AdjrxykEeAkN3KaKNhzmb0aw
         /uoQ==
X-Gm-Message-State: AOAM531ru47oCzjS/1OiMPMnid0vCfHUU5qWaE8oGSVnN9oHk6kWncdS
        YsgSic1Cjxrjs9MzWrF59auZgvBHrPjAxw==
X-Google-Smtp-Source: ABdhPJy6VN54BnY6evmfL8C12AYzQWK/XUaIoPyDdKqGtpqW38dOwmD4jC8M66SmgdFBrY11WXyUGtnNzse6vw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a0c:e381:: with SMTP id
 a1mr855110qvl.42.1632329731261; Wed, 22 Sep 2021 09:55:31 -0700 (PDT)
Date:   Wed, 22 Sep 2021 09:55:28 -0700
In-Reply-To: <87k0j87tdw.fsf@evledraar.gmail.com>
Message-Id: <kl6lv92s35z3.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20210921232529.81811-1-chooglen@google.com> <20210921232529.81811-3-chooglen@google.com>
 <87k0j87tdw.fsf@evledraar.gmail.com>
Subject: Re: [RFC PATCH 2/2] branch: add --recurse-submodules option for
 branch creation
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>  static const char *head;
>>  static struct object_id head_oid;
>> +static int recurse_submodules =3D 0;
>
> Nit: just s/ =3D 0// will do here, and is the convention typically...

Thanks for the catch!

>> +	r_start_name =3D strcmp(start_name, "HEAD") ? start_name :
>> +		refs_resolve_refdup(get_main_ref_store(r), start_name, 0, NULL, NULL)=
;
>
> IMO clearer just as an if/else.

Sounds good, I'll use an if/else instead

>> +	if (!recurse_submodules) {
>> +		return;
>> +	}
>
> Can lose the braces here...

Ah, yes. Old habits die hard.. Thanks!

>> +
>> +	for (i =3D 0; i < r->index->cache_nr; i++) {
>> +		const struct cache_entry *ce =3D r->index->cache[i];
>> +		if (!S_ISGITLINK(ce->ce_mode))
>> +			continue;
>> +		sub =3D submodule_from_path(r, null_oid(), ce->name);
>> +		if (repo_submodule_init(&subrepo, r, sub) < 0) {
>> +			warning(_("Unable to initialize subrepo %s, skipping."), ce->name);
>> +			continue;
>> +		}
>> +		/*
>> +		 * NEEDSWORK: branch tracking is not supported for
>> +		 * submodules because it is not possible to get the
>> +		 * remotes of a submodule.
>> +		 */
>
> It isn't?
>
>     $ git -C sha1collisiondetection/ remote -v
>     origin  https://github.com/cr-marcstevens/sha1collisiondetection.git

Ah, my comment is ambiguous. I meant that we cannot get
submodule remotes in-process because remotes.c stores its state in
static variables I believe it implicitly refers to the remotes of
the_repository and can't be reused for submodules.

Of course I hope I am wrong, because that would make this task a lot
easier :)

> All this manual file checking should depend on REFFILES, but better yet
> is there a reason this can't use rev-parse? I.e. why can't we inpect
> this state with 'for-each-ref', 'rev-parse' and the like? Does this test
> need to assert that these files end up in these specific locations, or
> just the ref store? Ditto for the later ones.

> Use test_cmp, also for this sort of thing the test "x$y" =3D "x" idiom
> isn't needed unless you've got a computer from the mid-90s or something
> :)

The only reason the tests look this way is that I have copied the
surrounding tests. From your comments, it seems clear that these tests
are fairly out-of-date, so I should probably model them after something
else.

I will incorporate Philippe's suggestion

  Most tests for submodules are usually in separate test files. I don't thi=
nk
  this is a set-in-stone rule, but if more tests are coming in the future, =
maybe
  a new test file t????-branch-submodule.sh would be appropriate ? Just a s=
mall suggestion.

Then at least my new tests won't look so out of place with the other
branch tests.

>> In this patchset, branching works slightly differently between the
>> superproject and submodule (skip ahead for specifics). There are two
>> very obvious alternatives that can address this:
=20
>> * A: only implement --recurse-submodules behavior after we are able to
>>   eliminate any kind of dependence on the_repository/global state that
>>   shouldn't be shared.
>> * B: implement --recurse-submodules as child processes, which won't be
>>   bothered by global state.

I was wondering if you had thoughts on this bit in particular. It seems
unpleasant for branching to behave differently between superproject and
submodule, so I'd like to discard this RFC (or at least the 'disable
remotes' behavior) ASAP and start work on a version that serves us
better.
