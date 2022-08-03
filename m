Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA45C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 13:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbiHCNIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 09:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbiHCNIX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 09:08:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC12DEDC
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 06:08:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a7so18418210ejp.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 06:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=0nyC1Ds00wj88sRHcKJXlJbNG3222Q3xu7TdwSxuEg8=;
        b=E4dQV5e/2pVSqF0fk1gomJV/XVREy3aj06x4BAE/8uTe7lJma2ktkE85S1i9b4nxmw
         v/sAVvTn8muIVsmGHcaqYte10NcrizQ8AUPBSTBKiv/ZZLqakcHrdDbdJEvLYo3SDBBl
         JvUdqlFjXf9Pzrj8sMftTKK+KejyznpVZT3wSU74wgEv9Nr5YWukazZKDoIP5f8xI3qW
         aKMV3nR/BdynAVp/8DN/kt4pOGdE3qp27Xqcm3F7dfMKkR5BahWCKdiHSOzwn1XMHI63
         uuuI0QTMmcs/w5oL0TBqwca9VHMo4IPPDV50Pgc31yshyrNsxNIEnxyHcGkF9UTi3T/q
         WwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=0nyC1Ds00wj88sRHcKJXlJbNG3222Q3xu7TdwSxuEg8=;
        b=Wp6dvlwAx72hkOynfr5rgFjw4THg1rFBmehx2/HXBZGxWZf/Jhihrq4m4E2prdRg30
         0Pt70XenomAIysKipZDRnVw2MWZhM693WhvYTSvEgl2EpsnyVe0FvXy3gI6xCcwAAZTV
         ioXgiKcoHtS9s1j8RhOx/R06pUFs5DehVBpyFGk+S4QJ8XKJf8y700kosKcNabKlbN/2
         oB4pBWMBihkgeMKDTFD+7zR+jZKyvAWrR8pun3F5HTQueJJb+WRT+3NDw6Io0j8+xCEf
         3X/SvOKY+WvFssBov1Nnd/IXikhJcPMahzGsTp4iPAY6r6Vkv8UwEu7QMdajpatuNTts
         mwhg==
X-Gm-Message-State: AJIora9t1nQ8OwgOgMpK6iuiH8LeLR4z+dF43grQQJ/mYZ4/557nb92T
        cU4utPgFD4mXl0cKDHL6fGw=
X-Google-Smtp-Source: AGRyM1tgJHsJqFsPXywvuGdak+MajEZPqU5KcJr2GzvOfXMpBLdmnhn6IKrd0O1+NfFYcKgnyMZU2g==
X-Received: by 2002:a17:907:a40f:b0:72b:64ee:5b2f with SMTP id sg15-20020a170907a40f00b0072b64ee5b2fmr21061832ejc.268.1659532097907;
        Wed, 03 Aug 2022 06:08:17 -0700 (PDT)
Received: from gmgdl ([2a02:a213:23c2:bf80:c530:8f19:38e6:f393])
        by smtp.gmail.com with ESMTPSA id ku19-20020a170907789300b007309d640484sm2000545ejc.91.2022.08.03.06.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 06:07:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJE5T-009TC0-1s;
        Wed, 03 Aug 2022 15:06:59 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v2 22/28] submodule--helper: move
 submodule_strategy_to_string() to only user
Date:   Wed, 03 Aug 2022 15:06:01 +0200
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
 <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
 <patch-v2-22.28-98c3e562c82-20220802T154036Z-avarab@gmail.com>
 <kl6lles6te9q.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <kl6lles6te9q.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220803.86h72tfpcc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 02 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Move the submodule_strategy_to_string() function added in
>> 3604242f080 (submodule: port init from shell to C, 2016-04-15) to its
>> only user.
>>
>> This function would return NULL on SM_UPDATE_UNSPECIFIED, so it wasn't
>> safe to xstrdup() its return value in the general case, or to use it
>> in a sprintf() format as the code removed in the preceding commit did.
>>
>> But its callers would never call it with either SM_UPDATE_UNSPECIFIED
>> or SM_UPDATE_COMMAND. Let's move it to a "static" helper, and have its
>> functionality reflect how it's used, and BUG() out on the rest.
>>
>> By doing this we can also stop needlessly xstrdup()-ing and free()-ing
>> the memory for the config we're setting. We can instead always use
>> constant strings. We can also use the *_tmp() variant of
>> git_config_get_string().
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/submodule--helper.c | 29 ++++++++++++++++++++++++-----
>>  submodule.c                 | 21 ---------------------
>>  submodule.h                 |  1 -
>>  3 files changed, 24 insertions(+), 27 deletions(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index b49528e1ba9..d787c0fead4 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -413,12 +413,32 @@ struct init_cb {
>>  };
>>  #define INIT_CB_INIT { 0 }
>>=20=20
>> +static const char *submodule_strategy_to_string(enum submodule_update_t=
ype type)
>> +{
>> +	switch (type) {
>> +	case SM_UPDATE_CHECKOUT:
>> +		return "checkout";
>> +	case SM_UPDATE_MERGE:
>> +		return "merge";
>> +	case SM_UPDATE_REBASE:
>> +		return "rebase";
>> +	case SM_UPDATE_NONE:
>> +		return "none";
>> +	case SM_UPDATE_UNSPECIFIED:
>> +	case SM_UPDATE_COMMAND:
>> +		BUG("init_submodule() should handle type %d", type);
>> +	default:
>> +		BUG("unexpected update strategy type: %d", type);
>> +	}
>> +}
>> +
>
> This function is meant to convert from an update strategy back to the
> string that the user actually provided in their gitconfig.
>
> The change in behavior makes this function BUG() out on types that
> aren't "magic" tokens, i.e. "UNSPECIFIED" (which is obviously not
> expressible) and "COMMAND" (which allows users to specify an arbitrary
> command using "!", like "!cat"). It shouldn't be difficult to teach
> callers to handle "COMMAND", so this seems like an ok change, though I
> think we should probably amend the function name to
> submodule_update_type_to_string() and change the UNSPECIFIED and COMMAND
> arms to something like BUG("type %d has no corresponding string").

Makes sense, will rename it.

> I'm not so convinced that this function should be static, though. I
> think it's more natural for submodule_update_type_to_string() to have
> the same visibility as enum submodule_update_type. Today, we only have
> one other caller who uses this enum, and it doesn't even need this
> _to_string() fn (fsck.c calls parse_submodule_update_type() and doesn't
> need _to_string() because it has the raw config values). But it feels a
> bit inevitable that this will get moved back to submodule.h.

I'll re-roll & leave it in submodule.[ch].
