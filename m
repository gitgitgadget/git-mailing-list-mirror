Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33363C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 09:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCHJrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 04:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCHJrf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 04:47:35 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF0E22A1F
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 01:47:25 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id j11so43714392edq.4
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 01:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678268844;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JNYfCtvpBzz3LqdXV4hso2vodUlSgex4G4kTjO7OkWM=;
        b=OoqGJtoNoGhMk/ay0FQYgu50813/0dLnjUnXDK29qoNGjodxfIzTRB27B4nPb22LcC
         ufxGL6QJ4rvkRDV7x1j6Gomi4fStgRME5bsrb/oPrS0ggIlOK6SHkooW5twGpdT0BhQT
         ZWzIuwLPUiDFgxHVyJoNieG4nF7qppW6EMOeMHW6uH0fdb4mPWWgg9tw4T3i2AUhacEL
         FteCRSX3RMpF246w+qiOtDwBTyWF71yVNOltHd2pQ0bQH/Ce5Y6z6TLoWnY1g2mIzg3b
         UY+HNFUGYHD6/3sgaI5JPQonfUWPsOYn+6FccoawvvmHPshsiA5vFZS4tcRfk7T5BgbQ
         O0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678268844;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JNYfCtvpBzz3LqdXV4hso2vodUlSgex4G4kTjO7OkWM=;
        b=dFN4v7RrZmlHiCpvBtsQq1wC7XjfhvHOtkAt27VFKytU4aojDNanSFE+TVPwDiipGG
         CgC7IWFSwK72SQhlph+uuTLkU//qu2VOu3CleOCdBO4t8mS/RZB03qm9fzKiHCqUbYIq
         BISC85g19p6DET12xm/FwqIvQZvt1gyV8bcetKM+snUYgaadfs0nRgkxb2kVgRIFtzmN
         D5vcdcSOhjdmlLA+QyHS/ogbeLt8ZRIkQQpHIDZ9okCGLiU/26BNQTUgKlNguAH4itA+
         sDHF5VuPCFKeuqVFtrgNE1cQX+GMIWhmMPJ4ny91QYaa7cUtjrWZWKgcbMkbzEwJRgIZ
         ACNg==
X-Gm-Message-State: AO0yUKVKVRqkkax2QyRSFAQEGBaT0gOzqC6LmsrCsI5xQhRgtPL58ghH
        SatSqAlrp7EdyCKcXXyM97BMZ8PkHdycLg==
X-Google-Smtp-Source: AK7set/VLEaRTIDYyNWxFGBCNlYeoGVS3C5WTP4cC1yevor9JJPKMmYoxPTs3SBs0023SuawDah+BQ==
X-Received: by 2002:a17:906:3b92:b0:8d6:ed70:991b with SMTP id u18-20020a1709063b9200b008d6ed70991bmr20225196ejf.15.1678268844141;
        Wed, 08 Mar 2023 01:47:24 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id a25-20020a509b59000000b004c0eac41829sm7841680edj.63.2023.03.08.01.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:47:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pZqOJ-000tEK-0k;
        Wed, 08 Mar 2023 10:47:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/6] [RFC] config.c: use struct for config reading state
Date:   Wed, 08 Mar 2023 10:17:35 +0100
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
        <230307.86wn3szrzu.gmgdl@evledraar.gmail.com>
        <kl6lfsagifpc.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqbkl4xsj2.fsf@gitster.g>
        <kl6lcz5ki36g.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <kl6lcz5ki36g.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <230308.867cvrziac.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 07 2023, Glen Choo wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> If you include "populate from system-wide, per-user, and repository
>> specific configuration files" as part of the API being libified,
>> your configsets cannot avoid being tied to a repository.  But I do
>> not think the reader needs to be in the repository.
>>
>> [...]
>>
>> Isn't the use of the reader object purely transitory while you
>> populate the keys and values in a configset from a single file?  At
>> the layer to read and populate a configset from a single "source"
>> file, you still do not need repository.
>>
>> [...]
>> Only when you say "I have a 'repo' instance and I want to read the
>> config variables from appropriate places", you call such a "read and
>> populate configset from a single source" helper three or four times
>> to populate repo->config.  Once a configset is populated, it or its
>> contents do not depend on the reader instance to function, so I do
>> not see how it benefits to have the reader in the repository object.
>
> Yes, exactly. Having a config_set on the repository makes sense, but I
> don't see a good reason to have the reader on the repository.

Isn't Junio suggesting something different here?

I hadn't looked closely at this aspect of it, and just took it as a
given that we needed to persist this data outside of the configset
lifetime.

If that's not the case then we don't need it in the file scope, nor a
"struct repository" or whatever, and could just have it materialized by
git_config_check_init(), no? I.e. when we create the configset we'd
create it, and throw it away after the configset is created?

I.e. to address this note in your initial RFC:

	I think we can get rid of global state in-tree as well. That requires a fa=
ir
	amount of work though, so I'd like to get thoughts on that before starting
	work.

> If =C3=86var sends his series soon, it would be fruitful to see how that
> series interacts with this one :)

I tried merging this topic with that, and it didn't conflict textually
or semantically. I just raised it because I think with your 3/6 you're
needlessly tying yourself in knots, i.e. with this part:
=09
	A more typical approach would be to put this struct on "the_repository",
	but that's a worse fit for this use case since config reading is not
	scoped to a repository. E.g. we can read config before the repository is
	known ("read_very_early_config()"), blatantly ignore the repo
	("read_protected_config()"), or read only from a file
	("git_config_from_file()"). This is especially evident in t5318 and
	t9210, where test-tool and scalar parse config but don't fully
	initialize "the_repository".

Out of those examples read_very_early_config() and
read_protected_config() already call config_with_options(), which
optionally uses a "struct repository" via the "repo" member of "struct
git_config_source".

I think we may have gotten lost in the weeds over what amounts to an
asthetic preference about how to do polymorphism in C. I'd be fine with
mocking up the "struct repository", but you could equally prepare and
pass some new "config_state" struct that would contain the required
information (including the configset).

As well as this in the CL:

	The catch (aka the reason I stopped halfway through) is that I
	couldn't find a way to expose "struct config_reader" state
	without some fairly big changes, complexity-wise or LoC-wise[...]

I didn't look into exactly why config_fn_t would need your new "reader",
but if you accept that we could stick such a thing into "the_repository"
then there's no catch or need for the churn to change all those
callbacks.

Of course something that wants to use the API as a "real" library would
need to use some alternate mechanism, as you reference in adding a new
"config_state_fn_t". You note:

	but I couldn't find a great way to do this kind of 'switching
	between config callback types' elegantly.

So, I don't know, but I was suggesting looking into doing that based on
"the_repository" in play...
