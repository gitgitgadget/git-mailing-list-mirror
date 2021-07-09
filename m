Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FBAC07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 20:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB17C613BE
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 20:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhGIU3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 16:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGIU3X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 16:29:23 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE2DC0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 13:26:37 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d1so8498607qto.4
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 13:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VgwLti8FAG0N/0AjyLu+plADpFj39pEzBIHBuC2x+yA=;
        b=grsGT3sLxqisu1ZNkwFGhuW8ayfr8HkxM86+7Wj4KJJaWXKgU3hwMLXL/8fTQCyDou
         PVXeeA2hECFrUPe/16azQRbmtn2jwATyvr3ohrNK1VMkHvOGCIzYCB214inpTxqoORcZ
         YR3ndDSjUmG11rxeB3zGcDVKqqo9uzhBteiYVh1dTqn9xQunyPLbEmuR8hFKE2WUXD02
         uKklnWTNFa8kHqv8Z5E56NQJ0A9kLLpzt+FLS8RzWDNOM3V3JZhEYYc/gh2+JVgDc/wV
         /pcEfxr8eL8nj9TVxhTy2nzqm2Ylsz5Q7S+UwEDx5e0lyLOGS1WieMFg5LMecuXCvOmh
         m/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VgwLti8FAG0N/0AjyLu+plADpFj39pEzBIHBuC2x+yA=;
        b=gDaQewHxSQ+ujbUbEWJ5+RKnpdnjt/9QS5Hnu1smFmnMMBsXJuZHgfHrJqtN29Hm6O
         wQi+hwfcRGeOIAzCKGUQJyMOFdZIOE+oRHhgfosnmdDd7D4QsGNiU7eRrCOZrUBtZb1z
         36JFMVmUHm1IZzPfNZQpfpgfahEfCO5X5e7JjPoO5CI8/S9qCWY7H0ObhyQPzqcLFCp/
         FeaIIZLMa4VrTZSyqwNdi9QCbk/g8Kx4a0c7HJhkorqKBJB2Zgg+PSb1X4+E180ugm+9
         nrurOGjbVSecb3rMNSzxDzNY5Qim/7pYlnoyLzKQOgO36YpNBY73Rsuy2J+aFhR7ooMS
         OaPA==
X-Gm-Message-State: AOAM532p6aPfXjM4L7Ph5ePLEsEhbZ7azo3DYU96LwgJFa8Wxubwn/Ga
        N8CkoXCV0wg6Qa+0a8azUwY=
X-Google-Smtp-Source: ABdhPJwxE2NV5nTkxe4IdLzVNM8BcguRMRtTeXU6dMWQ+H678G3vyt1N3AYM70Y9wJ2m/EVO2KVJXw==
X-Received: by 2002:a05:622a:14c9:: with SMTP id u9mr23475154qtx.7.1625862396789;
        Fri, 09 Jul 2021 13:26:36 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id i21sm2541629qti.45.2021.07.09.13.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 13:26:36 -0700 (PDT)
Subject: Re: [PATCH v2] submodule: mark submodules with update=none as
 inactive
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Rose Kunkel <rose@rosekunkel.me>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <YMvgRjwyrwyLz4SC@camp.crustytoothpaste.net>
 <20210701225117.909892-1-sandals@crustytoothpaste.net>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <bf1893ee-6973-d8b2-659e-bb239a0a9ae2@gmail.com>
Date:   Fri, 9 Jul 2021 16:26:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701225117.909892-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

[re-cc'ing Emily and Jonathan who Junio cc'ed in <xmqqeed2sdwc.fsf@gitster.g>
but seemed to have been dropped when you sent v1 and v2 of the patch]

Le 2021-07-01 à 18:51, brian m. carlson a écrit :
> When the user recursively clones a repository with submodules 

Here I would add:

", or runs 'git submodule update --init' after a
non-recursive clone of such a repository, "

> and one or
> more of those submodules is marked with the submodule.<name>.update=none
> configuration, the submodule 

"those submodules" would be clearer, I think.

> will end up being active.  This is a
> problem because we will have skipped cloning or checking out the
> submodule, and as a result, other commands, such as git reset or git
> checkout, will fail if they are invoked with --recurse-submodules (or
> when submodule.recurse is true).
> 
> This is obviously not the behavior the user wanted, so let's fix this by
> specifically setting the submodule as inactive in this case when we're
> initializing the repository.  That will make us properly ignore the
> submodule when performing recursive operations.
> 
> We only do this when initializing a submodule, 

Here for even more clarity I would add:

i.e. 'git submodule init' or 'git submodule update --init',

> since git submodule
> update can update the submodule with various options despite the setting
> of "none" and we want those options to override it as they currently do.
> 
> Reported-by: Rose Kunkel <rose@rosekunkel.me>
> Helped-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>   builtin/submodule--helper.c |  6 ++++++
>   t/t5601-clone.sh            | 24 ++++++++++++++++++++++++
>   2 files changed, 30 insertions(+)

As I said in my review of v1, I think this would warrant a mention in the doc.

In general, I think 'git-submodule(1)' could be more precise about which submodules
are touched by which subcommands. Since the topic that introduced the 'active' concept
was merged in a93dcb0a56 (Merge branch 'bw/submodule-is-active', 2017-03-30), these subcommand
recurse only in active submodules:

- init (with a big caveat, see below)
- sync
- update

The doc makes no mention of that for sync and update. sync says it synchronizes 'all'
submodules, and update says it updates 'registered' submodules ('registered' in not
defined formally anywhere either). And 'active' is mentioned in the description of
'init', but not defined. It would be good to explicitely say "see the 'Active submodules'
section in gitsubmodules(7) for a definition of 'active'", or something like that.

I'm not saying we need to fix that necessarily in this patch, I'm just noting
what my reading of the code and of the doc reveals.

> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index ae6174ab05..a3f8c45d97 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -686,6 +686,12 @@ static void init_submodule(const char *path, const char *prefix,
>   
>   		if (git_config_set_gently(sb.buf, upd))
>   			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
> +
> +		if (sub->update_strategy.type == SM_UPDATE_NONE) {
> +			strbuf_reset(&sb);
> +			strbuf_addf(&sb, "submodule.%s.active", sub->name);
> +			git_config_set_gently(sb.buf, "false");
> +		}
>   	}
>   	strbuf_release(&sb);
>   	free(displaypath);

I did more testing with this patch applied and I fear it is not
completely sufficient. There are 2 main problems, I think.
The first is that the following still triggers the bug:

     git clone server client
     git -C client submodule update --init
     git -C client submodule init       # should be no-op, but isn't
     git -C client reset --hard --recurse-submodules

That's because:

1) 'git submodule init' operates on *all* submodules if 'submodule.active' is unset
     and not <path> is given.
     (see submodule--helper.c::module_init), or the doc [1].
2) 'git submodule init' sets 'submodule.$name.active' to true for the submodules
     on which it operates, unless already covered by 'submodule.active'
     (see submodule--helper.c::init_submodule)
3) the code we're adding to set 'active' to false if 'update=none' is only executed
    if 'submodule.c.update' is not yet in the config, so it gets skipped if we
    repeat 'git submodule init'. (I think this behaviour is sound).

So that's unfortunate, and is also kind of contradictory to what the doc says
for 'git submodule init':
"This command does not alter existing information in .git/config.".
And just to be clear, the behaviour I describe above is already existing, the current
patch just makes it more obvious.

I think we could manage to change that behaviour a bit
in order to have 'submodule init' not modify the config for submodules which are already marked inactive,
*unless* they are explitely matched by the pathspec on the command line.
So we would have:

     git clone server client; cd client
     git submodule init      # initial call sets 'submodule.c.active=false'
     git submodule init      # does not touch c, it's already marked inactive
     git submodule init c    # OK, we really want to mark it as active

To do that, we could use the same trick that we do in update_clone, i.e.

     if (pathspec.nr)
         info.explicit = 1

where 'explicit' (tentative name) is a new field in 'struct init_cb', so that 'init_submodule'
knows if the current submodule was explicitely listed on the command line.


Then there is a second thing. As stated in the commit message,
'git submodule update --checkout' should override the 'update=none'
setting and clone and checkout the submodule. But this behaviour
is broken by the code we're adding, because 'submodule update' only recurse into
active submodules! (see the call to 'is_submodule_active' in
submodule--helper.c::prepare_to_clone_next_submodule).

So this does not clone the submodule:

     git clone --recurse server client   # recursive clone
     git -C client submodule --checkout  # should clone c, doesn't

Neither does this:
    
     git clone server client                   # non-recursive clone
     git -C client submodule update --init
     git -C client submodule update --checkout # should clone c, doesn't

But because of the first problem above, this works(!):

     git clone server client
     git -C client submodule update --init
     git -C client submodule update --init --checkout

Because in the third call, c is set to 'active' by init_submodule,
then is *not* skipped by prepare_to_clone_next_submodule.


So it's all a little bit complicated! But I think that with my suggestion above,
i.e. that 'git submodule init', in the absence of 'submodule.active', would
only switch inactive submodules to active if they are explicitely listed, then
we could get a saner behaviour, at the expense of having to explicitely init
'update=none' submodules on the command line if we really want to '--checkout' :
     
     git clone server client
     git -C client submodule update --init        # first call: set c to inactive
     git -C client submodule update --init        # no-op
     git -C client submodule update --checkout    # does not clone c (currently quiet)
     git -C client submodule update --checkout c  # does not clone c, but warns (current behaviour)
     git -C client submodule init c               # sets c to active
     git -C client submodule update --checkout    # clones c

where the last two command could be a single
'git submodule update --init --checkout c' and ideally the
4th command should also warn the user that they now have to explicitely 'init'
c if they want to check it out, which could simply mean tweaking the already
existing message in next_submodule_warn_missing to also check if
the current submodule has 'update=none' and then display the warning
(instead of just showing it if the submodule was listed on the command
line, which is the current behaviour). Additionnaly, the warning should
say "Maybe you want to use 'update --init %s'?", i.e. specify the path.


What do you think of my suggestions ? I can help push this forward
by contributing patches if we agree that we should go forward with
this slight behaviour change in 'git submodule init' ...


> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index c0688467e7..efe6b13be0 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -752,6 +752,30 @@ test_expect_success 'batch missing blob request does not inadvertently try to fe
>   	git clone --filter=blob:limit=0 "file://$(pwd)/server" client
>   '
>   
> +test_expect_success 'clone with submodule with update=none is not active' '
> +	rm -rf server client &&
> +
> +	test_create_repo server &&
> +	echo a >server/a &&
> +	echo b >server/b &&
> +	git -C server add a b &&
> +	git -C server commit -m x &&
> +
> +	echo aa >server/a &&
> +	echo bb >server/b &&
> +	git -C server submodule add --name c "$(pwd)/repo_for_submodule" c &&
> +	git -C server config -f .gitmodules submodule.c.update none &&
> +	git -C server add a b c .gitmodules &&
> +	git -C server commit -m x &&
> +
> +	git clone --recurse-submodules server client &&
> +	git -C client config submodule.c.active >actual &&
> +	echo false >expected &&
> +	test_cmp actual expected &&
> +	# This would fail if the submodule were active, since it is not checked out.
> +	git -C client reset --recurse-submodules --hard
> +'

I think we might want to also test the non-recursive clone case as well,
i.e. 'git clone' and then 'git submodule update --init', as well as
subsequent calls to 'git submodule init' in light of my analysis above.

Also, the only place in the test suite that I could find where
'update=none' is tested is in t7406.35-38 in t7406-submodule-update.sh
so maybe it would make more sense to put the test(s) there ?

Thanks,

Philippe.

[1] https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-init--ltpathgt82308203
