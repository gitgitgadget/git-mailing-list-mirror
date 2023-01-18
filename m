Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962EDC38159
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjARQUt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjARQUX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:20:23 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361B855BF
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:16:43 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id bj3so33077001pjb.0
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNx5NwGLUEiUvxwPbo/ynyQ5VyM6Gix68wpidK3pygE=;
        b=dKrILsBj2+Tc8OgwlHoi9jm8TfWRdZF6kyyRC38NXLLEP0IuoT4zWRTlR245qoSWLo
         hsG0R6V1GZ28X7DcH5nSPQPWfEPaka+cq+cHLohi50ojCLV6ms6EhZLNeWNpTdVrxKRB
         sQ2T5JuzcNl3+fRku8lzZvHKAjev7XEREtDCA7bl6LHz5o3C923+08Y6Jvt61fhK4F4c
         Utwm2q0016GcZh9FF2sVALygon3Qz8xsMd5H/I+YKkDzxHQx5pB1+kl3wvFnONqmbfXQ
         jLTYq0M4oy4ERijTWy26maWvSn4z2JNCTU5dLoRaQZTOqb9pjsg2a/3DRYm0wn6m54/3
         iTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNx5NwGLUEiUvxwPbo/ynyQ5VyM6Gix68wpidK3pygE=;
        b=HqwdMoDWr7w154HhVhPUnpnJgfK3Pg1VlV9QSyT4bZpF18nmAgym8VbPUsZE0kktcu
         IWwn3L41b79LEaKKPexuh7zqYQJX0z+w/KSyXyHTGQYHUuX/pvqt4nUz0y2SaQKAR9wU
         W5SDskxjL5iQhEyAnOECifczmaCi+7e8/kWVHTFkP4NeAicuUkvksumb5tz4frn3VTBC
         iEe9PpDmnt9H7m5iU+u4GDz5L/rEguWxzw6TZC2leOKYLUaj+TdButOopex7lcpZ3D8Y
         8Du8wa32U/sy1eCM0gPaSRo5xyIvhc9vTN2sfNMe4fFMWS/RosM+IHy58TRExOVQAdE5
         k2cg==
X-Gm-Message-State: AFqh2kpIQ4stwYz2zjsE6kSOG5VcGZylgowakwU3nybJcA5q2gh1sNwX
        3Fw8HW6G4Uii5hJZmj3iBEE=
X-Google-Smtp-Source: AMrXdXum1PueRSqO/wfJVC/Lmf20L4DQ99EbjOe9foFGrD3SOpD4MEmVunqoTG8JbNYfp6ZyAAB4aA==
X-Received: by 2002:a17:902:f2ca:b0:193:2303:c9e5 with SMTP id h10-20020a170902f2ca00b001932303c9e5mr7179864plc.20.1674058602637;
        Wed, 18 Jan 2023 08:16:42 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id l17-20020a170903245100b001890cbd1ff1sm23415523pls.149.2023.01.18.08.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:16:42 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 08/19] worktree: fix a trivial leak in prune_worktrees()
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
        <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
        <patch-v4-08.19-1fe25bc6981-20230117T151202Z-avarab@gmail.com>
        <xmqqedrs8igj.fsf@gitster.g>
        <230118.86o7qwxg4e.gmgdl@evledraar.gmail.com>
Date:   Wed, 18 Jan 2023 08:16:42 -0800
In-Reply-To: <230118.86o7qwxg4e.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 18 Jan 2023 11:57:16 +0100")
Message-ID: <xmqqedrr6cnp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> diff --git c/builtin/branch.c w/builtin/branch.c
>> index f63fd45edb..4fe7757670 100644
>> --- c/builtin/branch.c
>> +++ w/builtin/branch.c
>> @@ -742,6 +742,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>>  	if (filter.abbrev == -1)
>>  		filter.abbrev = DEFAULT_ABBREV;
>>  	filter.ignore_case = icase;
>> +	UNLEAK(filter);
>>  
>>  	finalize_colopts(&colopts, -1);
>>  	if (filter.verbose) {
>
> I'll send a v5 re-roll without this change, sorry.

I'd rather see your reroll with the above addition of UNLEAK() than
without it, to fix the breakage.
