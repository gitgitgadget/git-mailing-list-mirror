Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4183DC43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 11:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbiGVLc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 07:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiGVLc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 07:32:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A0583203
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 04:32:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b11so8025885eju.10
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 04:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ii0uHwgrOzuop2FkLwCeH794PNgnYaa5RJiaRieJayc=;
        b=if9mkDvwWXvAJAkdURqXqnslJOpQ+0doRYKGiYToC4paphgcAfdJvtTgYwMwhOCBAV
         kCgG8afjb16ix/CT7s5M0uwYscpoelzz5edSFtF9uswRF+0Z+CvppU4aWOayga3cKV3k
         phHE04Sl3EQZnM22WYS80AcmUJeorMY8IEYnwuCV1squ6YPEJ/hKVfDeyCUbtZ836rsq
         NdFyD2gTGU2IvuELYl84PyVdQEDF6PZvGc0X36GFkTB7t303K9VLC2neRMdq+yze0hm4
         YAE+UKvEfQH3zFbtbbokN2hlOLDkGl86mVe+9nO3IOWd+ElZO6T8p0zzvJqb6R1+xvht
         M+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ii0uHwgrOzuop2FkLwCeH794PNgnYaa5RJiaRieJayc=;
        b=HxoHc6AHRYk39kroUQ7p4dj0K1ZWKggoPMYigZ+Ty5CCLGoX04/KWW4NE+lW3DeJjD
         7y1DBDjPrSBOdOzgQgHknvkRyUIyP1jV9h368i9Xww0onEO6DHxF3Xy28C4ThpzE1Vr8
         dJkVMHhiXeLTr1yFCHA/1MyixeGFYPBlEF6rPv5ZP6zSyKk26WjvblNlmNnRoFKNbhad
         nMxAdtTqLcMZ1uZxYQpf8MsOE6VDROY3wYzfL5YCcZriOwc43/wXy4eL/C/UMf4MMIHK
         V2V9FXLzSp7fYIjP58koNSX2nFlOWwHTXjDnkWOC70RvGkNashcTtYdKylQGP8goxp5p
         8ugQ==
X-Gm-Message-State: AJIora/r4ilxk8LFQnHXadeVBmVQCjy16HnZiMQ5t3i44LVsPwf8IqQ5
        y+xvNuyACQBDvEewC1P0JX8=
X-Google-Smtp-Source: AGRyM1srcR60O3bYO1s/sEh9IbkRG6MmlDFysmPXnHPujxaykZUc20gdbE3v0RZg6/A3ve/faie6EQ==
X-Received: by 2002:a17:906:5a51:b0:72b:5cdf:ed77 with SMTP id my17-20020a1709065a5100b0072b5cdfed77mr83581ejc.505.1658489575148;
        Fri, 22 Jul 2022 04:32:55 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id d18-20020a170906305200b006feba31171bsm1932552ejd.11.2022.07.22.04.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 04:32:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oEqtp-005IxS-Hi;
        Fri, 22 Jul 2022 13:32:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v3 04/26] submodule--helper: fix a leak in
 "clone_submodule"
Date:   Fri, 22 Jul 2022 13:30:07 +0200
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
 <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
 <patch-v3-04.26-26f0caf0386-20220721T191249Z-avarab@gmail.com>
 <xmqq35euf92d.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq35euf92d.fsf@gitster.g>
Message-ID: <220722.8635ets7q2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 21 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 7d5ee6a6261..1ddce8e19c1 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -1658,14 +1658,15 @@ static int clone_submodule(const struct module_c=
lone_data *clone_data,
>>  	char *sm_alternate =3D NULL, *error_strategy =3D NULL;
>>  	struct child_process cp =3D CHILD_PROCESS_INIT;
>>  	const char *clone_data_path;
>> +	char *to_free =3D NULL;
>>=20=20
>>  	if (!is_absolute_path(clone_data->path)) {
>>  		struct strbuf sb =3D STRBUF_INIT;
>>=20=20
>>  		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
>> -		clone_data_path =3D strbuf_detach(&sb, NULL);
>> +		clone_data_path =3D to_free =3D strbuf_detach(&sb, NULL);
>>  	} else {
>> -		clone_data_path =3D xstrdup(clone_data_path);
>> +		clone_data_path =3D clone_data->path;
>>  	}
>
> Heh, the bug I noticed in the previous step is silently fixed here.
>
> This is why I do not trust a series that is artificially split into
> steps and sent out without self reviewing or even compiling them.

Sorry for that mistake, will fix it in a re-roll. It was a result of
dumb search-replacing.

But FWIW I did (and do generally) test my changes with "git rebase -i -x
make..." before sending them out.

But as you note this doesn't seem to have test coverage, and which gcc
yells at me about this, clang (13.0.1-3+b2) does not.

I generally test my changes with both gcc & clang before sending them
out, but usually only use clang for the incremental compiling, I'll
switch back to gcc...
