Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFB7CCA479
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 20:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbiGMUeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 16:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237091AbiGMUeK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 16:34:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5291658E
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 13:34:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ss3so15858183ejc.11
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 13:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=+3/eFpaVdoCsIGYB77eYmLrQoKuMjDOvLUU3QF8fFAo=;
        b=pt8CgsQZrC878qUSGUSiST31XEVs0Ta2NoDwJQHjxRFpJJQ7prgo1fsmxhg7fuLEfv
         jKSxPezP3qYYaggsgiLN6LMU6WACJ1BwiSh2gupSw9feLOG8H8omUBKIVzmcTa0DS5Nk
         hpXW2mdHmpnpoJWeYWcqo6QK4Q7Jz9/vxtjZI+dr4sEg56nVzagkBOheGPBLLyPdiWfZ
         +Wv+VBqCuwvBoVhMDtDk3pCgJjV0zTtGbYh0x/++DyhXUGyRMZygOnbXmfxErFGR3XWz
         sRDgBwlQYcZlHs+5YaetpKjxWqO4vS9mHoevdnt5y6r6MCq23iY/74b0+An3JCrr64pw
         TJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+3/eFpaVdoCsIGYB77eYmLrQoKuMjDOvLUU3QF8fFAo=;
        b=tYo2C6yWU581LJFpzzW77KY0HBZVh5gYdsvUEUyrFjoSvLbupAoULwQP44j3yVeON1
         CjGAL3rj3fhQMTRtN5IDth0P1tdUT2u0QBt5/2SVyQFQjXE7AXNxr4jQeJ9+pbKVJmPj
         +KKdVv3IQO/zLhRPNrBR/HnEtUo3tLXhUX9NzfQ0S2FKY8B7cBkdivkLtE2EAc0XcUMW
         pa3QCA5ISbpBy6+HFPAVvlLtKJllSWl8KyYXgT8UJ/PNYYxritc3kxHsKcyseuNnuT/3
         NUD/+Je/zOu+mHzLEnSzGmRG7/6WHmbivB8/v2TnqWt4CU5C4Whsf1DI9GpPppaQLc+J
         eJHA==
X-Gm-Message-State: AJIora8AN0UHbavbwoyz6c5yshM7C+4sGuTL1otVs+ZRuO7olfp8IZ74
        zfsNm0+/EaKLVrZPpOXeR8M2yvJaALsJaA==
X-Google-Smtp-Source: AGRyM1sQajp/fjDvha5v3ySMb8F7sR+vt9+1K8WgaWqanEqSBMFokA0y5nvhinp+hzUN6NWrKNf8IA==
X-Received: by 2002:a17:907:8a14:b0:72b:76d0:520 with SMTP id sc20-20020a1709078a1400b0072b76d00520mr5412182ejc.468.1657744447903;
        Wed, 13 Jul 2022 13:34:07 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b0072b55713daesm3740569eja.56.2022.07.13.13.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 13:34:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oBj3d-001wtp-VJ;
        Wed, 13 Jul 2022 22:34:05 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH 03/11] submodule--helper: fix "module_clone_data" memory
 leaks
Date:   Wed, 13 Jul 2022 22:30:53 +0200
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
 <patch-03.11-e5ec6945409-20220713T131601Z-avarab@gmail.com>
 <kl6lmtdc6hhp.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lilo06g82.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <kl6lilo06g82.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220713.86o7xs3g76.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 13 2022, Glen Choo wrote:

> Glen Choo <chooglen@google.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>>> index 73717be957c..23ab9c7e349 100644
>>> --- a/builtin/submodule--helper.c
>>> +++ b/builtin/submodule--helper.c
>>> @@ -1511,6 +1511,7 @@ static int module_deinit(int argc, const char **a=
rgv, const char *prefix)
>>>  struct module_clone_data {
>>>  	const char *prefix;
>>>  	const char *path;
>>> +	char *path_free;
>>>  	const char *name;
>>>  	const char *url;
>>>  	const char *depth;
>>> @@ -1527,6 +1528,11 @@ struct module_clone_data {
>>>  	.single_branch =3D -1, \
>>>  }
>>>=20=20
>>> +static void module_clone_data_release(struct module_clone_data *cd)
>>> +{
>>> +	free(cd->path_free);
>>> +}
>>> +
>>>  struct submodule_alternate_setup {
>>>  	const char *submodule_name;
>>>  	enum SUBMODULE_ALTERNATE_ERROR_MODE {
>>> @@ -1651,9 +1657,9 @@ static int clone_submodule(struct module_clone_da=
ta *clone_data)
>>>=20=20
>>>  	if (!is_absolute_path(clone_data->path)) {
>>>  		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
>>> -		clone_data->path =3D strbuf_detach(&sb, NULL);
>>> +		clone_data->path =3D clone_data->path_free =3D strbuf_detach(&sb, NU=
LL);
>>>  	} else {
>>> -		clone_data->path =3D xstrdup(clone_data->path);
>>> +		clone_data->path =3D clone_data->path_free =3D xstrdup(clone_data->p=
ath);
>>>  	}
>>
>> Hm, having .path_free doesn't seem necessary. If I'm reading the code
>> correctly,
>>
>> - in module_clone() we set clone_data.path from argv
>> - then we unconditionally call clone_submodule(), which does all of the
>>   hard work
>> - in clone_submodule(), we always hit this conditional, which means that
>>   past this point, clone_data.path is always free()-able.
>>
>> which suggests that we don't need clone_data.path_free at all. I suspect
>> that just this
>>
>>    static void module_clone_data_release(struct module_clone_data *cd)
>>    {
>>    	free(cd->path);
>>    }
>>
>> is enough to plug the leak (though admittedly, I haven't properly tested
>> the leak because it's been a PITA to set up locally).
>>
>> That's a pretty hacky suggestion though, since we're still using the
>> same member to hold free()-able and non-free()-able memory....
>
> Ah, here's a wacky idea (whose feasibility I haven't thought about at
> all) that would make things a lot cleaner. If we had something like
> OPT_STRING_DUP, that xstrdup()-s the value from argv when we parse it,
> then we could drop the "const" from clone_data.path and just free() it.

I suppose so, it might make some things simpler, of course at the cost
of needlessly duplicating things.

But we also have various common patterns such as string_lists where some
elements are dup'd, some aren't, and need to deal with that. I think
just having common idioms for tracking the dupe is usually better,
e.g. in the case of a string list stick the pointer to free in "util".

I think in this case the patch as-is is better than your suggestions,
because it's a less fragile pattern, we explicitly mark when we dup
something that's sometimes a dup, and sometimes not.

Whereas if we do it with the xstrdup() at the start it requires more
moving things around, and if we have a new user who parses the same
argument we'll bug out on that free().

What do you think?
