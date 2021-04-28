Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199D3C433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 08:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA88F61419
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 08:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbhD1IMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 04:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1IMt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 04:12:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C71C061574
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 01:12:04 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u17so93394636ejk.2
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 01:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=CGtWt4AEOWr3v6y5Z0F7pfuidQpsUjMGOgK+nrJ2AvI=;
        b=Zb5OJ2VfXgtMUlhLHG2LxCDdGRk5AIzoyv2QoQk88zgWagGq3qr3Z95XwGm7KyVWay
         esu8diuSuaRSrOXvmLkv4FY1+mIJuxXj+u6arfdbnuHGTUJ2EOIymOoNSwdDabMK3E0Z
         OwkT+bP1wsG5Dc9vs2YjYrrA+npkwBvRDgmGGwjXCNgI/ADgA7XzrSgZyxetMGCO/kpL
         3A1WIxzwoktLkzcD0Y8KxL/iz53VoIl59V8xZQ/KPtsnxcYHMeQE/7wT+TAMN3U/qtYY
         b1rDMP2RGxmPY4uJO+wFlliQNrZoSrWCaeDZX1z9EEzmRDpBx8d1MhM90g491GuE2H/a
         Bf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=CGtWt4AEOWr3v6y5Z0F7pfuidQpsUjMGOgK+nrJ2AvI=;
        b=SVPJZ7wVYRwF3+9x2ndlOoH6skRmV0xLgaLb6U1l/F5TaTZ8KXQ5FeDHea5UhXHP54
         mwBrPz1seOuDPJMI62ZpodOaQb72r3lmB44FqvKbnmpTY0Irac4J0ttSrD8Dr08G4Uvr
         1Rjs8fQp96JjIFZWDDGcGLjnLdKoac8ahiEs67EXNZ08MEqn8cKwtB2sojNlPoRQ74Xf
         mJc7HE7FYIzcQfVLcsARvSOE4SP3YNq7AEN3TZsE4BniYYpr8M6HfEKIMvUVK8HtKzxf
         W4bwTM2Qhv05PGAl2/hG4RxuufQWlEt/ke3xcf/2wjIgnXX+QLeJL3f3gsrVvG0ugtTH
         gqjw==
X-Gm-Message-State: AOAM530KrbeoN5rIvclnRECHZJFdPgjsQrX2UDwKxSGakLu65HjZiZuZ
        OuCoU+8F4aAveApLXmEQH0M=
X-Google-Smtp-Source: ABdhPJwWguBrCmhFn3OEjKfvVLGg5OSUVQ7tST1eHdazX6gaGhXdz2XIoPXrXxleMFCEaVfi2iIZXw==
X-Received: by 2002:a17:907:2d0f:: with SMTP id gs15mr11016316ejc.113.1619597523480;
        Wed, 28 Apr 2021 01:12:03 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id hp29sm1384364ejc.47.2021.04.28.01.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 01:12:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 04/23] fsmonitor: introduce `core.useBuiltinFSMonitor`
 to call the daemon via IPC
Date:   Wed, 28 Apr 2021 09:59:24 +0200
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <7082528d8f7c1afa33e1146e3d274e044735f6a1.1617291666.git.gitgitgadget@gmail.com>
 <f77457d0-925d-2ea1-4ad4-b3315532b37f@gmail.com>
 <87mttkyrqq.fsf@evledraar.gmail.com>
 <03b4def9-3435-bd44-69f9-1e037df83aaa@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <03b4def9-3435-bd44-69f9-1e037df83aaa@gmail.com>
Message-ID: <87k0omzv3h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Derrick Stolee wrote:

> On 4/27/2021 5:20 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Mon, Apr 26 2021, Derrick Stolee wrote:
>>=20
>>> On 4/1/21 11:40 AM, Johannes Schindelin via GitGitGadget wrote:> @@ -25=
15,6 +2515,11 @@ int git_config_get_max_percent_split_change(void)
> ...
>>>> --- a/repo-settings.c
>>>> +++ b/repo-settings.c
>>>> @@ -58,6 +58,9 @@ void prepare_repo_settings(struct repository *r)
>>>>  		r->settings.core_multi_pack_index =3D value;
>>>>  	UPDATE_DEFAULT_BOOL(r->settings.core_multi_pack_index, 1);
>>>>=20=20
>>>> +	if (!repo_config_get_bool(r, "core.usebuiltinfsmonitor", &value) && =
value)
>>>> +		r->settings.use_builtin_fsmonitor =3D 1;
>>>> +
>>>
>>> Follows the patterns of repo settings. Good.
>>=20
>> It follows the pattern, but as an aside the pattern seems bit odd. I see
>> it dates back to your 7211b9e7534 (repo-settings: consolidate some
>> config settings, 2019-08-13).
>>=20
>> I.e. we memset() the whole thing to -1, then for most things do somethin=
g like:
>>=20
>>     if (!repo_config_get_bool(r, "gc.writecommitgraph", &value))
>>         r->settings.gc_write_commit_graph =3D value;
>>     UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
>>=20
>> But could do:
>>=20
>>     if (repo_config_get_bool(r, "gc.writecommitgraph", &r->settings.gc_w=
rite_commit_graph))
>>         r->settings.gc_write_commit_graph =3D 1;
>>=20
>> No? I.e. the repo_config_get_bool() function already returns non-zero if
>> we don't find it in the config.
>
> I see how this is fewer lines of code, but it is harder to read the intent
> of the implementation. The current [...]

That's exactly the reason I find the existing version unreadable, i.e.:

> layout makes it clear that we set the value from the config, if it
> exists, but otherwise we choose a default.

The repo_config_get_*() functions only return non-zero if the value
doesn't exist, so the pattern of:

    if (repo_config_get(..., "some.key", &value))
        value =3D 123;

Is idiomatic for "use 123 if some.key doesn't exist in config".

Maybe I'm missing something and that isn't true, but it seems like a
case of going out of one's way to use what the return value is going to
give you.

> Sometimes, this choice of a default _needs_ to be deferred, for example w=
ith
> the fetch_negotiation_algorithm setting, which can be set both from the
> fetch.negotiationAlgorithm config, but also the feature.experimental conf=
ig.

Don't FETCH_NEGOTIATION_UNSET and UNTRACKED_CACHE_UNSET only exist as
action-at-a-distance interaction with the memset to -1 that this
function does?

I.e. it's somewhat complex state management, first we set it to
"uninit", then later act on fetch.negotiationalgorithm, and then on
feature.experimental, and then set a default only if we didn't do any of
the previous things.;

I.e. something like:

    x =3D -1;
    if (fetch.negotiationalgorithm is set)
    if (x !=3D -1 && feature.experimental is set)
    if (x !=3D -1) x =3D default
    settings->x =3D x;

As opposed to a more (to me at least) simpler:

    int x;
    if (fetch.negotiationalgorithm is set)
    else if (feature.experimental is set)
    else x =3D default
    settings->x =3D x;

> However, perhaps it would be better still for these one-off requests to
> create a new macro, say USE_CONFIG_OR_DEFAULT_BOOL() that fills a value
> from config _or_ sets the given default:
>
> #define USE_CONFIG_OR_DEFAULT_BOOL(r, v, s, d) \
> 	if (repo_config_get_bool(r, s, &v)) \
> 		v =3D d
>
> And then for this example we would write
>
> 	USE_CONFIG_OR_DEFAULT_BOOL(r, r->settings.core_commit_graph,
> 				   "core.commitgraph", 1);
>
> This would work for multiple config options in this file.

I came up with this:

+static void repo_env_config_bool_or_default(struct repository *r, const ch=
ar *env,
+					    const char *key, int *dest, int def)
+{
+	if (env) {
+		int val =3D git_env_bool(env, -1);
+		if (val !=3D -1) {
+			*dest =3D val;
+			return;
+		}
+	}
+	if (repo_config_get_bool(r, key, dest))
+		*dest =3D def;
+}

Used as e.g.:

+	repo_env_config_bool_or_default(r, NULL, "pack.usesparse",
+					&r->settings.pack_use_sparse, 1);
+	repo_env_config_bool_or_default(r, GIT_TEST_MULTI_PACK_INDEX, "core.multi=
packindex",
+					&r->settings.core_multi_pack_index, 1);

It works for most things there.

Using that sort of pattern also fixes e.g. a bug in your 18e449f86b7
(midx: enable core.multiPackIndex by default, 2020-09-25), where we'll
ignore a false-but-existing env config value over a true config key.

>> I see the UPDATE_DEFAULT_BOOL() macro has also drifted from "set thing
>> default boolean" to "set any default value".
>=20=20
> This is correct. I suppose it would be a good change to make some time.
> Such a rename could be combined with the refactor above.
>
> I would recommend waiting until such a change isn't conflicting with
> ongoing topics, such as this one.

I'm not planning to work on it, but thought I'd ask/prod the original
author if they were interested :)
