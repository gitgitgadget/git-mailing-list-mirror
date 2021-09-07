Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D45C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E905961102
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhIGNyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 09:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhIGNyW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 09:54:22 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD9EC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 06:53:15 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 18so8207236pfh.9
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 06:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bHBpYFmhvme9JKj2vrKpJsgqPLm8IAgqkSh28vOzh+8=;
        b=YpH4sk7i2Wkizwv0w+SpzuiHFLKqDIqWMJdM9MvAYoDMIOfoZGiGiFsfzwavAqQkIN
         yC+21UrIoSFF4Q5BFk9FRQfGo0KH3++/bp+BTw/AxUTKK0bAscEFNmZKC9zx7hAz6EJb
         h59WAngQIeuPUH7z9HGj6ou/IF0hss6UGfW/a5XK7fv3JYvy8yuDZBTzTxEir1BVQND1
         RPnRU2H5D73+aoj4nHxkkfo1ekdBOqhHZCNjpIJSIw29nHI8bCfMGJRBwgUXem8alA45
         UapxQ3tUWluRKuYwVuCThJ4Duv4X3hve5Y5JVY0+LxFBG2hB9taLcIPELqnvy0oz5W8K
         0zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bHBpYFmhvme9JKj2vrKpJsgqPLm8IAgqkSh28vOzh+8=;
        b=NS/CO9zlnqEKPNXB4EnLw6oTUJM5qo1YYgF8qAss2zL562DQGSU1ZM2xvpr0hjk9NZ
         oFada4swnMZfIhc4/37C9riNyTdMLfPYGooOcRPMVSXczvWcOnNUIAOYVMGIzAiBVxBj
         Woi81414eMSxLWGbBn5yKU1Qm+M4VGnQKlHn/WZ6bDdaWS052bjLPyfzwKxhpqzxQ7cm
         dEspN1+WrWKI+imw/0t81RIzvMxsGgGMKEAUR5dpSbYlBYDkukGsmnzTP5MXjWVqgoKS
         02DUdPesuw/UQC0QRG7HFR3na3SmLoMEuvTlcsVBMsqlX+zxVD4YxdMNrdIETBt3y3Pb
         Cg8w==
X-Gm-Message-State: AOAM531YHcKR5aVTiepLgIt9MC08jLte8VTlFI6YYAob63+rsJf/LdpW
        Li5f1Papgl7B7KQXrd4xGeY=
X-Google-Smtp-Source: ABdhPJxzFzQLQtPkHWV6d3dYOLHGk6lyP/myRQetuVumps1hLTKfzxG0bYa3eopOgIgUzbi5vDmKng==
X-Received: by 2002:a63:558:: with SMTP id 85mr16772336pgf.45.1631022795138;
        Tue, 07 Sep 2021 06:53:15 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id p9sm14472304pgn.36.2021.09.07.06.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 06:53:14 -0700 (PDT)
References: <20210907115932.36068-1-raykar.ath@gmail.com>
 <20210907115932.36068-10-raykar.ath@gmail.com>
 <87k0jslf3p.fsf@evledraar.gmail.com>
User-agent: mu4e 1.6.3; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        emilyshaffer@google.com, gitster@pobox.com, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH 09/13] submodule--helper: remove update-module-mode
 subcommand
Date:   Tue, 07 Sep 2021 19:20:18 +0530
In-reply-to: <87k0jslf3p.fsf@evledraar.gmail.com>
Message-ID: <m2a6kolcfu.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Sep 07 2021, Atharva Raykar wrote:
>
>> This subcommand was once useful for 'submodule update', but now that we
>> have converted the shell code to C, it is no longer used.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Shourya Shukla <periperidip@gmail.com>
>> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
>> ---
>>  builtin/submodule--helper.c | 24 ------------------------
>>  1 file changed, 24 deletions(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index a628660d6b..e3e85600c3 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -1993,29 +1993,6 @@ static void determine_submodule_update_strategy(s=
truct repository *r,
>>  	free(key);
>>  }
>>
>> -static int module_update_module_mode(int argc, const char **argv, const=
 char *prefix)
>> -{
>> -	const char *path, *update =3D NULL;
>> -	int just_cloned;
>> -	struct submodule_update_strategy update_strategy =3D { .type =3D SM_UP=
DATE_CHECKOUT };
>> -
>> -	if (argc < 3 || argc > 4)
>> -		die("submodule--helper update-module-clone expects <just-cloned> <pat=
h> [<update>]");
>> -
>> -	just_cloned =3D git_config_int("just_cloned", argv[1]);
>> -	path =3D argv[2];
>> -
>> -	if (argc =3D=3D 4)
>> -		update =3D argv[3];
>> -
>> -	determine_submodule_update_strategy(the_repository,
>> -					    just_cloned, path, update,
>> -					    &update_strategy);
>> -	fputs(submodule_strategy_to_string(&update_strategy), stdout);
>> -
>> -	return 0;
>> -}
>> -
>>  struct update_clone_data {
>>  	const struct submodule *sub;
>>  	struct object_id oid;
>> @@ -3463,7 +3440,6 @@ static struct cmd_struct commands[] =3D {
>>  	{"clone", module_clone, 0},
>>  	{"add-clone", add_clone, 0},
>>  	{"update", module_update, 0},
>> -	{"update-module-mode", module_update_module_mode, 0},
>>  	{"run-update-procedure", run_update_procedure, 0},
>>  	{"ensure-core-worktree", ensure_core_worktree, 0},
>>  	{"relative-path", resolve_relative_path, 0},
>
> So in https://lore.kernel.org/git/87sfyglfl9.fsf@evledraar.gmail.com I
> suggested squashing the shell removal, but I see now that here later in
> 09-13/13.
>
> So yeah, having 08/13 stand-alone is easier to read then, but I think
> then squashing all of 09-13 together is better. I.e. there's no reason
> to remove these one at a time, let's just remove them all at once.

Okay, I shall do this.

> That also makes it clear that it's a remove-only change aside from your
> "refactor while at it" of renaming this function:
>
>     -static int do_run_update_procedure(struct update_data *ud, struct st=
ring_list *err)
>     +static int run_update_procedure(struct update_data *ud, struct strin=
g_list *err)
>
> We could either skip that, or split that later refactoring into another
> commit.
>
> Thanks for working on this, I'm exciting to see more of git-submodule.sh
> go away. Hopefully these comments I left are useful / will aid future
> reviewer readability of this series.

Thanks for your suggestions. I've gone through all of them, and I'll
reroll soon.
