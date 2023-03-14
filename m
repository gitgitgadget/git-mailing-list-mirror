Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C739C6FD1C
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 11:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjCNL0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Mar 2023 07:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjCNL0I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 07:26:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F1175846
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 04:26:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cn21so30430146edb.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 04:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678793164;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IEvBIGKDNSkZ1kt0q4U04y5EPffeQkZsJKpiEiXgwaw=;
        b=EiKNGeSXLZuLM5geoO/LxOhdFoPTOQk/uLK9DO7bbLYP+IByOdxqg+nANJdGG88G5P
         xkAi5UYBi9B1lyWvJPimZ6pOo1jWeb5cybtSyVWMIZ5nsu6fUj6oLsNSNZnOQIrTKacn
         OW8zViawLxxVHn0s7XZXALK4rAbjGTqNRoq/iqh9kPXCab2Z1MeqJuxiaYOjrB36K/No
         Rhg/Dyw/QOv6fejYitgFYsNDst4LODXKGRRB3Ipc5B81de25E2/cYwKAqJ0BKHG67kqZ
         BulY6O1UHllUFjiGp90mL8keDf8npH2Haqil7+SzOTThGKsBAHNJ86eqzN9f3DLMwyhv
         NKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678793164;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IEvBIGKDNSkZ1kt0q4U04y5EPffeQkZsJKpiEiXgwaw=;
        b=MiuAGC2lWxAd5OMu7A2FGH1Lsnd37t257JAvj+QSx1CkAUpIIRmQzviCQAs5sdy6R1
         Msy6RnSVLMBdS91R2DQ4Fjyyrr2wjL7XqBNFyl4sZoUhpRkCncFCxPyvJpdovRYMsehZ
         FQCtdElhWjJZtIlbvgv8S5a7Qg0dSsUjkAwMwlwYJuSBcickxEPcp9krr1o4ZBi3pSY5
         T3eWNVUN9yMni2axr3xIhbdWr7EeISe+gll27BHpsMV4fzA8kacr/6E13ZPh0qAToCIW
         ZLZgiqC9xlA36fT6yQsX3Q+Z2g+ix7UAtnWRDpB//KFzNQX4X6mxdaNtFP2oP9tDDj50
         ng3Q==
X-Gm-Message-State: AO0yUKX6h6CsHjDcM90o3wGSRtg8qGBw2xSldfC6xviGvPddB3l7hmh8
        6GV3QeL3HYl2yoCG/7YZtkqnNNWEl/Q=
X-Google-Smtp-Source: AK7set/NlbBDwJX3y8LH4ryY5D1s4sDsG0nu6jkiXUIA9lYChIuXcVwV/ysz4+pUcjlEVdbjO7epXw==
X-Received: by 2002:a17:906:55b:b0:8b1:3d04:c2da with SMTP id k27-20020a170906055b00b008b13d04c2damr2900185eja.45.1678793164222;
        Tue, 14 Mar 2023 04:26:04 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id c34-20020a509fa5000000b004f9ca99cf5csm870740edf.92.2023.03.14.04.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 04:26:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pc2n6-002Bzk-0J;
        Tue, 14 Mar 2023 12:26:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1b?= =?utf-8?Q?or?= 
        <szeder.dev@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com
Subject: Re: [PATCH v7 3/9] config API: add and use a "git_config_get()"
 family of functions
Date:   Tue, 14 Mar 2023 12:21:47 +0100
References: <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com>
 <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
 <patch-v7-3.9-a977b7b188f-20230308T090513Z-avarab@gmail.com>
 <kl6ledpxhi3t.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <kl6ledpxhi3t.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <230314.86pm9by3oz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 09 2023, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> diff --git a/config.h b/config.h
>> index 7606246531a..7dd62ca81bf 100644
>> --- a/config.h
>> +++ b/config.h
>> @@ -465,6 +465,9 @@ void git_configset_clear(struct config_set *cs);
>>   * value in the 'dest' pointer.
>>   */
>>=20=20
>> +RESULT_MUST_BE_USED
>> +int git_configset_get(struct config_set *cs, const char *key);
>
> IIRC, feedback on v4 [1] mentioned that since git_configset_get() can
> return negative values, it probably shouldn't come under this comment:
>
>   /*
>   * These functions return 1 if not found, and 0 if found, leaving the fo=
und
>   * value in the 'dest' pointer.
>   */
>
> I think moving it to before the comment would suffice, maybe with a
> pointer to the corresponding repo_* or git_*.
>
> 1. https://lore.kernel.org/git/xmqqv8kjpqoe.fsf@gitster.g/

I'll fix this, FWIW I was trying to juggle this so that I'd avoid future
churn for a subsequent cleanup of the interface & documentation...

>> @@ -485,6 +488,14 @@ int git_configset_get_pathname(struct config_set *c=
s, const char *key, const cha
>>  /* Functions for reading a repository's config */
>>  struct repository;
>>  void repo_config(struct repository *repo, config_fn_t fn, void *data);
>> +
>> +/**
>> + * Run only the discover part of the repo_config_get_*() functions
>> + * below, in addition to 1 if not found, returns negative values on
>> + * error (e.g. if the key itself is invalid).
>> + */
>> +RESULT_MUST_BE_USED
>> +int repo_config_get(struct repository *repo, const char *key);
>>  int repo_config_get_value(struct repository *repo,
>>  			  const char *key, const char **value);
>>  const struct string_list *repo_config_get_value_multi(struct repository=
 *repo,
>> @@ -521,8 +532,15 @@ void git_protected_config(config_fn_t fn, void *dat=
a);
>>   * manner, the config API provides two functions `git_config_get_value`
>>   * and `git_config_get_value_multi`. They both read values from an inte=
rnal
>>   * cache generated previously from reading the config files.
>> + *
>> + * For those git_config_get*() functions that aren't documented,
>> + * consult the corresponding repo_config_get*() function's
>> + * documentation.
>>   */
>
> After rereading config.h, I really appreciate comments like this that
> try to control the documentation load. We have configset*, repo* and
> git*, _and_ the comments are spread out hapzardly around config.h with
> no pointers to the corresponding comments. I think we're overdue for
> reorganization, and this sort of comment helps a lot with that.
>
> As a suggestion, it seems like the git_config_get*() functions are
> actually the better documented ones - nearly all of them have comments,
> whereas the repo_config_get_*() ones typically don't, so maybe adding
> the comment to git_config_get() instead of repo_config_get() would be
> better for this series:
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
>   diff --git a/config.h b/config.h
>   index 7dd62ca81b..aa9bdf8df4 100644
>   --- a/config.h
>   +++ b/config.h
>   @@ -489,10 +489,10 @@ int git_configset_get_pathname(struct config_set =
*cs, const char *key, const cha
>   struct repository;
>   void repo_config(struct repository *repo, config_fn_t fn, void *data);
>
>   -/**
>   - * Run only the discover part of the repo_config_get_*() functions
>   - * below, in addition to 1 if not found, returns negative values on
>   - * error (e.g. if the key itself is invalid).
>   +/*
>   + * These repo_config_get*() functions each correspond to to a git_conf=
ig_get*()
>   + * function. Consult the corresponding git_config_get*() documentation=
 for more
>   + * information.
>     */
>   RESULT_MUST_BE_USED
>   int repo_config_get(struct repository *repo, const char *key);
>   @@ -532,12 +532,13 @@ void git_protected_config(config_fn_t fn, void *d=
ata);
>     * manner, the config API provides two functions `git_config_get_value`
>     * and `git_config_get_value_multi`. They both read values from an int=
ernal
>     * cache generated previously from reading the config files.
>   - *
>   - * For those git_config_get*() functions that aren't documented,
>   - * consult the corresponding repo_config_get*() function's
>   - * documentation.
>     */
>
>   +/**
>   + * Run only the discover part of the repo_config_get_*() functions
>   + * below, in addition to 1 if not found, returns negative values on
>   + * error (e.g. if the key itself is invalid).
>   + */
>   RESULT_MUST_BE_USED
>   int git_config_get(const char *key);
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
>
> Though in the long run, I'd prefer having the docs on the more "general"
> APIs (configset_*, repo_*) instead of the more "specific" ones (git_*).
> Perhaps you had a similar intent while making this change, but I think
> this might be better left as a cleanup.

...yes, that's why I put the primary documentation on the repo_*()
version here, as with other implicit "the_repository" and "the_index"
migrations I think we should be moving towards using those, and
eventually removing the non-repo_*() ones (in some cases they're almost
unused, or it's easy enough to migrate the rest).

But let's leave that for some future cleanup, but for now I think it's
OK to leave this slight inconsistency in place, with an eye to such
future consolidation.

> As an aside, I really appreciate your effort in sticking with the config
> interface work. I think it's grown quite unruly, and it's worth trying
> to tame it.

Thanks, hopefully a trivial & upcoming v8 will be the last version...
