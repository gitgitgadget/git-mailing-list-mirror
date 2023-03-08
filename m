Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D041AC678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 08:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjCHIg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 03:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjCHIgd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 03:36:33 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F582F784
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 00:35:45 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id i34so62521062eda.7
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 00:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678264543;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fmCyzME4iNp5v1+chwngNkr07c7eoK7CI7zkNsySCyg=;
        b=qII2K3W4WNA+2+QPSI+kafmJsbBE8JEpNd3MxbQHOl+zRopT8wVz3jo27/uVLeqVe/
         ktclrwWwmtmAOvlU1tKp3M9hCW6WjPNGKH0GTXNUXaRoU57g6LXFgKJ/nAL+I4tGk+Id
         ysN94GEWVJGshuUOLdrLMV/bAeCf3tBcU9IOUtz47T/Jc80gTvDWAQUZ04ghXBQoCkUm
         8MCPh9xCppwHTd7IjMOwJoDeslx8PIGRBRWKU5UtkmmgDw9cc4m+0f5EedEEaLQu/wIp
         ITAuZZjPq5y90mMOJzmCrkCslBLCjvTPQargwP+sOY3S0Ukip2EFV/hfUhwr1gyDpCfL
         VUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678264543;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmCyzME4iNp5v1+chwngNkr07c7eoK7CI7zkNsySCyg=;
        b=DMeIQZepTeq9XEjyIJPutH4RwvO7yV8F9cqkIjP2IUbG9q3Ac5gt5V6srkqqnD2xUo
         vMx5qQtgUImlgAMq7ZwWXhVUagYgCDRK9C5dW1U3kc9AAbfpnPMKIO59abXWcQDBFuNj
         x6MN/ied0OdPN8f/+e5MpJJuBvVAyanHiCGU1qj5a65RxhhIyJW036XaMWMWQsxrpQZI
         yO1wBiDkatbydohLdoUw7SjdGgIpWCA+txS3WsuogeHIbPrUHpJMsz7KjEdbU7EHId1c
         X/vBref8cTnDzOn/ybC7vLvsdIUu6NNXXM8eiVDXKMcDMbpAUcniMoElinhXqEbj6vzd
         4Vzg==
X-Gm-Message-State: AO0yUKXStLnkkPQoX4oXNI9eUfkvSijwW9d+vn7gAUhkt02UwjFQzU/h
        wLAPu1WFNKJiF2tP16zz5KE=
X-Google-Smtp-Source: AK7set/jOOO5ltWjbk3PETCiY20ryrTFtDzvEaE/A2Ghwnq87MJtdbZbQkhJH/Q1G1Uq6GzedLVPtg==
X-Received: by 2002:a17:906:948:b0:87f:5d0a:c610 with SMTP id j8-20020a170906094800b0087f5d0ac610mr17081924ejd.32.1678264543193;
        Wed, 08 Mar 2023 00:35:43 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ch10-20020a170906c2ca00b008cf8c6f5c43sm7105336ejb.83.2023.03.08.00.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:35:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pZpGv-000qyU-2r;
        Wed, 08 Mar 2023 09:35:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] gpg-interface: lazily initialize and read the
 configuration
Date:   Wed, 08 Mar 2023 09:34:15 +0100
References: <Y+PGRaiTTaZ/DtlJ@work-laptop-max>
 <Y+PRTYtFDoE73XEM@coredump.intra.peff.net> <xmqqmt5orqgv.fsf@gitster.g>
 <xmqqh6vwrpce.fsf@gitster.g> <xmqqlel7rj9z.fsf_-_@gitster.g>
 <Y+Tr1g+HTn45rsTq@coredump.intra.peff.net> <xmqqwn4qokug.fsf@gitster.g>
 <xmqqpmaimvtd.fsf_-_@gitster.g> <Y/vf7n2+LN/3Nddi@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y/vf7n2+LN/3Nddi@coredump.intra.peff.net>
Message-ID: <230308.86fsafzllu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 26 2023, Jeff King wrote:

> On Thu, Feb 09, 2023 at 12:24:14PM -0800, Junio C Hamano wrote:
>
>> Instead of forcing the porcelain commands to always read the
>> configuration variables related to the signing and verifying
>> signatures, lazily initialize the necessary subsystem on demand upon
>> the first use.
>>=20
>> This hopefully would make it more future-proof as we do not have to
>> think and decide whether we should call git_gpg_config() in the
>> git_config() callback for each command.
>
> Sorry, I seem to have missed this when you originally posted it. And I
> saw it marked as "will merge to next?" in the latest what's cooking. It
> looks good to me, and I think we can proceed with it (though of course
> it is not urgent and can probably wait until post-2.40).
>
>> A few git_config() callback functions that used to be custom
>> callbacks are now just a thin wrapper around git_default_config().
>> We could further remove, git_FOO_config and replace calls to
>> git_config(git_FOO_config) with git_config(git_default_config), but
>> to make it clear which ones are affected and the effect is only the
>> removal of git_gpg_config(), it is vastly preferred not to do such a
>> change in this step (they can be done on top once the dust settled).
>
> Yes, I think it is good not to do so in this patch. If we want to do it
> now on top, here's a patch. Though I could also see the argument for
> just leaving them.
>
> -- >8 --
> Subject: [PATCH] drop pure pass-through config callbacks
>
> Commit fd2d4c135e (gpg-interface: lazily initialize and read the
> configuration, 2023-02-09) shrunk a few custom config callbacks so that
> they are just one-liners of:
>
>   return git_default_config(...);
>
> We can drop them entirely and replace them direct calls of
> git_default_config() intead. This makes the code a little shorter and
> easier to understand (with the downside being that if they do grow
> custom options again later, we'll have to recreate the functions).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I looked over the output of:
>
>   git grep --function-context 'return git_default_config'
>
> to see if there were other cases, not caused by fd2d4c135e. But I didn't
> see any.

As added review: This is the same patch diff as I sent on February 9th:
https://lore.kernel.org/git/patch-1.2-d93c160dcbc-20230209T142225Z-avarab@g=
mail.com/;
my local range-diff to my previously submitted topic & next being:
=09
	229:  cc5d1d32fd4 !   2:  d93c160dcbc drop pure pass-through config callba=
cks
	    @@
	      ## Metadata ##
	    -Author: Jeff King <peff@peff.net>
	    +Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
=09
	      ## Commit message ##
	    -    drop pure pass-through config callbacks
	    +    {am,commit-tree,verify-{commit,tag}}: refactor away config wrapper
=09
	    -    Commit fd2d4c135e (gpg-interface: lazily initialize and read the
	    -    configuration, 2023-02-09) shrunk a few custom config callbacks s=
o that
	    -    they are just one-liners of:
	    +    In the preceding commit these config functions became mere wrappe=
rs
	    +    for git_default_config(), so let's invoke it directly instead.
=09
	    -      return git_default_config(...);
	    -
	    -    We can drop them entirely and replace them direct calls of
	    -    git_default_config() intead. This makes the code a little shorter=
 and
	    -    easier to understand (with the downside being that if they do grow
	    -    custom options again later, we'll have to recreate the functions).
	    -
	    -    Signed-off-by: Jeff King <peff@peff.net>
	    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
	    +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com>
=09
	      ## builtin/am.c ##=20=20
	     @@ builtin/am.c: static int parse_opt_show_current_patch(const struct=
 option *opt, const char *ar
	  -:  ----------- >   3:  c099d48b4bf gpg-interface.c: lazily get GPG conf=
ig variables on demand

So this LGTM.
