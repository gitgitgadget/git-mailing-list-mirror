Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF0EC636D6
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 11:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjBGL5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 06:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjBGL5A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 06:57:00 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E316B17CFB
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 03:56:58 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id sa10so12100006ejc.9
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 03:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wf1qFIqkjweiLyCEx2kLDaPKEkM97qydWclzsyGL9Xw=;
        b=T2MpvDN11iJM58ahf3NWkcToYoVNZ7XgmZmR1uzqTb5u9NQ3gTDMkCUh74OjUZzw+q
         0Ps9KA5Qdnpp4VqBTRGhyV4J2qgbzj+MgsPbCeuhFbk60WtejlbW/jsvASctRtD6z0yE
         vmmITja2rUr6BaZOaU3w3d1XFWOi0PjN/QqjtjbXkRVrnAGjuoMePw5mP5cb6IzorQr5
         3R82F9PPto35sx6e1lR5yyMr3v5y4ErwLG2sWz6HqFa8cR1m9Hv/RIh3GwTeYfAVW1kj
         9zFf3ze57YBYfjZwBnFrqt9cm8+xXWFzE2i13wpbu9pcIaEIPrQund4D+vgg7hYokA4u
         3oSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wf1qFIqkjweiLyCEx2kLDaPKEkM97qydWclzsyGL9Xw=;
        b=Oe9AhB8vixsBFg8g9TC8rnAGgm2bW57Q1kClfRELo80/BL+vWMf2Um15rlXNGOM4nE
         yzgW8LQOWEqGM13WlLIw7DA0gFEW2twfvNFSdd0E13D4JxEaBri1/1qxletjg8pO5ZdA
         qe+b9wVsU6luwCUt/PR703HbwtWxCDx2vvWuyk+aPZBHEcekvjdCB1FL9syJtOYbN3dv
         x7awLEJxHmG0bUXICdYrfYiosnGDM7g/tWPyCHYFg5wVkd+VuDi84+u3aURviwS3Xy29
         2vAAiC7B1QldiwZxRvcGUH6tm2LtvE3sB2DFaeEMbS0Rn8nh2aGhiqD7S7C2RcBCgAWs
         mdjQ==
X-Gm-Message-State: AO0yUKVAVkmo7aJuOJl///mT3f+bcBTY+mZ4Fvxt/7uJ+Hv42UTxsHQs
        kX8tFbq8xhvUwL8a1/GURktMP+pBvaMomo5n
X-Google-Smtp-Source: AK7set/yD/5yyKKbiNgfUgzbhzpGVSqdV/eWMqvVIUHORnnQ+NacShfw8pDdoeA03ZZVp4Af7ArJJQ==
X-Received: by 2002:a17:906:2dc1:b0:89b:66b9:1b71 with SMTP id h1-20020a1709062dc100b0089b66b91b71mr3195841eji.60.1675771017054;
        Tue, 07 Feb 2023 03:56:57 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id o20-20020a1709061b1400b008787edd2f74sm6780532ejg.50.2023.02.07.03.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 03:56:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPMal-000kF4-2R;
        Tue, 07 Feb 2023 12:56:55 +0100
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
Subject: Re: [PATCH v4 3/9] config API: add and use a "git_config_get()"
 family of functions
Date:   Tue, 07 Feb 2023 12:52:07 +0100
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
 <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
 <patch-v4-3.9-998b11ae4bc-20230202T131155Z-avarab@gmail.com>
 <kl6lttzzgebw.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <kl6lttzzgebw.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <230207.861qn14rjs.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 06 2023, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> We already have the basic "git_config_get_value()" function and its
>> "repo_*" and "configset" siblings to get a given "key" and assign the
>> last key found to a provided "value".
>>
>> But some callers don't care about that value, but just want to use the
>> return value of the "get_value()" function to check whether the key
>> exist (or another non-zero return value).
>
> [...]
>
>> We could have changed git_configset_get_value_multi() to accept a
>> "NULL" as a "dest" for all callers, but let's avoid changing the
>> behavior of existing API users. Having an "unused" value that we throw
>> away internal to config.c is cheap.
>
> There is yet another option, which is to teach "git_config_get_value()"
> (mentioned earlier) to accept NULL to mean "I just want to know if there
> is a value, I don't care what it is". That's what the *_get_<type>()
> functions use under the hood (i.e. the ones that return either 0 or 1 or
> exit).

I've clarified the commit message, but that's the same as what this is
describing. I.e. I meant "git_config_get_value_multi() and the functions
that are wrapping it", which is "git_config_get_value()" etc.

> This amounts to implementing the "*_config_key_exists()" API you
> mentioned, but I think this is better fit for the current set of
> semantics. At the very least, that would be an easy 1-1 replacement for
> the *_get_string[_tmp]() replacements we make here. There's also the
> small benefit of saving one function implementation.

I think this is the wrong approach, and have updated the commit message
further to advocate for this one.

>> Another name for this function could have been
>> "*_config_key_exists()", as suggested in [1]. That would work for all
>> of these callers, and would currently be equivalent to this function,
>> as the git_configset_get_value() API normalizes all non-zero return
>> values to a "1".
>>
>> But adding that API would set us up to lose information, as e.g. if
>> git_config_parse_key() in the underlying configset_find_element()
>> fails we'd like to return -1, not 1.
>
> We were already 'losing' (or rather, not caring about) this information
> with the *_get_<type>() functions. The only reason we'd care about this
> is if we using git_configset_get_value_multi() or similar.
>
> We replace two callers of git_configset_get_value_multi() in this patch,
> but they didn't care about the -1 case anyway...
> [...]
> As Junio pointed out, git_configset_get() can now return -1, so this
> isn't so accurate any more. git_configset_get() is really the exception
> here, since all the other functions in this section are the
> git_configset_get_*() functions that use git_configset_get_value(). I'd
> prefer returning only 0 or 1 for consistency.

I really prefer not clobbering these return values, but I take your
point that the end-state here is inconsistent.

I figured that I could fix it for the APIs added here, and follow-up
(with a patch I already had mostly ready) after this series to fix the
remaining config API warts.

I won't fix all of those in the incoming re-roll of this, but I'll fix
this issue, i.e. we'll consistently ferry up "ret", and stop normalizing
non-zero-non-1 to "return 1".
