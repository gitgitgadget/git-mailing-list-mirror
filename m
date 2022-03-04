Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A844BC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 22:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiCDXAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 18:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiCDXAI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 18:00:08 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3289235322
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 14:59:20 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id x6-20020a1709029a4600b0014efe26b04fso5302357plv.21
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 14:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PVzy2uZbM/3sBuriWQxQq+mxYBCLaQYekJwCYo6tSPc=;
        b=AFKEA2dfZYvgCxxt2SFmfCtfRU+KBVL6nvwy9BgVH/zDkAupcPCWd4938rItZ1URdv
         Bz+hbH06kIPI/AcXNE/dvur1AeOMoK80mjd7eLKEqnYR+8I2OVJSzVzkH5TXtmRsY0ic
         AwBxsyK3/k+owwRZSed7b8I53Npaogun1lkiT3r2wHwyZ2X97vpd2wN1ovgKzhjr76Ts
         DZBqhb0IDFkgQRmUGdPaiMXqks760vx0kr7P/yxEgYBhl8KHV2sG3yELrvMqG8mZ7+VQ
         F1DMAyAJ5zYniai0xxG1BrnzrfGZtMqx3uOXBty70VFiy8ZCoiVBqsGwEa7KyQh4Tiup
         nIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PVzy2uZbM/3sBuriWQxQq+mxYBCLaQYekJwCYo6tSPc=;
        b=rPpXMawB12WaAj30Aht/X7gGMjYzLWYvxpP/03RHSwgqAZpT6kh509rPxTfuWfIfaN
         ab9V6ObCoqa5bLjSPG1BVGmyLrvqEoZsDId0K6j8sDSLXZQkBYqiDr9zX7ZVMXs634kU
         KqjUQNTWa+ZqBoNWdyST0XQExyYDPKTcyNCot0VbT/MP1DOQJ6RtIYqzQBhRV+ndiK7X
         kYPn2mwXbAPbtqucRs7QFAUyOSXggByNF8RCyzC1EIe0Jexr1bXRzBDQdyCfMb2VdL75
         Gs7GlDfgUUZW2A/6bJyvfcZ83O1emwmaFS+2FAAZDlm068aHmQ8nyKlSBUrtL8L7UFt1
         mxjw==
X-Gm-Message-State: AOAM530ejXzvk9VGmyfgBLf15edjOjEECtVQQAA/WFvV9q3sxEDfIlod
        gR/n7YLbA+X1lduzYYJWXAB06vaEjpic6g==
X-Google-Smtp-Source: ABdhPJwXahfddxbAgMXtAza8TjGcuazybDzk9fijc+NmAc4W4n2NxMB9Wbm2AhHVVCz7uFEeH2HMMqJBt+gHjA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:d252:0:b0:363:271c:fe63 with SMTP id
 t18-20020a63d252000000b00363271cfe63mr537464pgi.524.1646434760135; Fri, 04
 Mar 2022 14:59:20 -0800 (PST)
Date:   Fri, 04 Mar 2022 14:59:18 -0800
In-Reply-To: <xmqqsfry4f3z.fsf@gitster.g>
Message-Id: <kl6l7d99494p.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220224100842.95827-1-chooglen@google.com> <20220304005757.70107-1-chooglen@google.com>
 <20220304005757.70107-10-chooglen@google.com> <xmqqsfry4f3z.fsf@gitster.g>
Subject: Re: [PATCH v4 09/10] fetch: fetch unpopulated, changed submodules
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>>  		item = string_list_insert(changed, name);
>> -		if (!item->util)
>> +		if (item->util)
>> +			cs_data = item->util;
>> +		else {
>>  			item->util = xcalloc(1, sizeof(struct changed_submodule_data));
>> -		cs_data = item->util;
>> +			cs_data = item->util;
>> +			cs_data->super_oid = commit_oid;
>> +			cs_data->path = xstrdup(p->two->path);
>> +		}
>
> I do not quite get this change.
>
> collect_changed_submodules() walks a range of revisions in the
> superproject, doing an equivalent of "git log --raw" and feeding the
> differences to this callback function.  The above code looks at the
> path and uses the "changed" string list to record which submodule
> was modified, what commit in the submodule is needed, etc.
>
> What happens when the range has more than one change to the same
> submodule?  cs_data has only one room for recording .super_oid
> (which commit in the superproject touches the submodule) and .path
> (where in the superproject's tree the submodule exists).  "git mv"
> of a submodule might be rare and it may not hurt too much that only
> a single .path can be kept, but it looks somewhat iffy.

Yes, I agree that it looks odd, which is why I added this comment to
hopefully make it less opaque:

  + * (super_oid, path) allows the submodule config to be read from _some_
  + * .gitmodules file. We store this information the first time we find a
  + * superproject commit that points to the submodule, but this is
  + * arbitrary - we can choose any (super_oid, path) that matches the
  + * submodule's name.

I guess this only says that it is ok to store .super_oid and .path from
any commit, but doesn't go in depth into _why_. It's ok because we only
need (.super_oid, .path) because repo_submodule_init(..., path,
treeish_name) maps these args to the submodule's name and gitdir (i.e.
.git/modules/<name>).

This means we don't worry about 'git mv' (super_oid's .gitmodules will
tell us the correct name even if the path changed relative to some other
commit), nor seeing the submodule more than once (it doesn't matter
whose .gitmodules we look at so long as repo_submodule_init() derives
the correct gitdir).

And now that you've pointed this out, I realize that we could do away
with (.super_oid, .path) altogether if we had a variant of
repo_submodule_init() that takes the submodule name instead of (path,
treeish_name). (We have a similar submodule_from_name(), but that only
reads the submodule config, not a struct repository.) I would prefer not
to introduce such a function so late into the review cycle, but I could
clean this up later.

>>  		oid_array_append(&cs_data->new_commits, &p->two->oid);
>
> At least, we are not losing any submodule commit even when the same
> submodule is touched more than once by the superproject, but it is
> dubious why we have cs_data.super_oid and cs_data.path in the first
> place.

On the hand, we actually need to record every submodule commit, so yes.

> How are they used, or are they something that seemed useful when the
> code was first written but it turned out that they weren't and left
> unused?
>
> Or do we need to make cs_data an array of 3-tuple { .super_oid,
> .submodule_oid, .path } for each submodule name?

To conclude:

- The changed_submodules string_list is basically a map that tells us,
  for a given submodule _name_, which commits we need to fetch and where
  repo_submodule_init() can read the submodule name from.
- We only use cs_data as a string_list_item.util, and the
  string_list_item.string is the submodule name itself.
- .new_commits tells us which commits to fetch.
- .super_oid and .path tells repo_submodule_init() how to get the name
  of the submodule.

So we don't need to make this a 3-tuple.
