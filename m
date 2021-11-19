Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FADC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 07:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B25D61AFD
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 07:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhKSHfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 02:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhKSHft (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 02:35:49 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1DAC061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 23:32:48 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y12so38791118eda.12
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 23:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=yC7ZM28u/HS/qd6j1+S2IQby27ICgsO0XEqudVVA51E=;
        b=AdMgLVxW+ojCKVdOyqx16xg/7wBOAU13lsLIAvJwC2Eao7o0tAhEyzCjWNvIE820zK
         2S9VYzeMt1i/U+87Ddi7d375x1LFAtkGq+jDXytFVH/bbaYgu/LeUuknal/bMS1rTg2z
         VfiIV5Xq9NrRjtBLqbsUU5xYCdBC9PzNOrr7wouuA1+cIGQg9W2Ik5ATwN8e/DYaqfT8
         FdtHHd4l7kkuSg90d2zIQf6msIcSw4i5KTicGHs45KBJ7MZNNUoqUZtjAa2XupvWcZJb
         toJ+3gZ0tLWFukCZEPoYKeN5KxSN9WmQNGmxXtApJHUEGn5VvAAWlCSGKcIORgfEspVg
         /ONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=yC7ZM28u/HS/qd6j1+S2IQby27ICgsO0XEqudVVA51E=;
        b=tV+M5n3aolmiwKv1D5uFHVVdTL5KUqthbM6ZdLqELFYFyxwmAYJu71Fh0PxtM8qvqp
         uHIl0MG89IHhGNfltY7A3TBFM/59baXJ/b9tpbAvFfuxYXCglzV3XGfUR4ZLB1PvVHlS
         08Q/wDI+HTGzmgM47GpgPDwIm4f+5ZQzn9bkfN5QpCkdx31HF2y0WCSz3Qg0ag66ewp3
         E95SwSEoOhFkuhhncn+pea0d47ynHx4ySCYpS53SAAISwbjYi51OgQpORRqMvzVVI+eE
         JqbQQ0jEZCBSDbzZI065MZHmHhdcIPuWiEaE9nNwgoGqgzp2FShcaRTWOOMKcESTmhlB
         8Qmg==
X-Gm-Message-State: AOAM530CS9XyCJMUOPfbhhGckgOOaYGZt4MD7p36m38AJcNf4ysEd/We
        2yKXvqmidBiq1L6Egzy5AMnWSQ+9oco=
X-Google-Smtp-Source: ABdhPJzKP3RF5SNUgsyUnEdWSPWQXIvO3TJ3PSaJ+yyMxt6Y3pPrhSZ8DjZpbaoFJpraWyxKIWrVHg==
X-Received: by 2002:a17:907:d08:: with SMTP id gn8mr4891914ejc.395.1637307166973;
        Thu, 18 Nov 2021 23:32:46 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id nd36sm817310ejc.17.2021.11.18.23.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 23:32:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnyO6-000akI-0X;
        Fri, 19 Nov 2021 08:32:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH v4 15/23] Makefile: add a "TRACK_template" for
 GIT-*{FLAGS,DEFINES,...}
Date:   Fri, 19 Nov 2021 08:30:55 +0100
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
 <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
 <patch-v4-15.23-337953e4994-20211117T101807Z-avarab@gmail.com>
 <xmqqbl2gskxm.fsf@gitster.g> <xmqq7dd4sket.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqq7dd4sket.fsf@gitster.g>
Message-ID: <211119.86a6i04n36.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 18 2021, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> @@ -2238,12 +2235,7 @@ SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):\
>>>  	$(localedir_SQ):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
>>>  	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(PAGER_ENV):\
>>>  	$(perllibdir_SQ)
>>> -GIT-SCRIPT-DEFINES: FORCE
>>> -	@FLAGS=3D'$(SCRIPT_DEFINES)'; \
>>> -	    if test x"$$FLAGS" !=3D x"`cat $@ 2>/dev/null`" ; then \
>>> -		echo >&2 "    * new script parameters"; \
>>> -		echo "$$FLAGS" >$@; \
>>> -            fi
>>> +$(eval $(call TRACK_template,GIT-SCRIPT-DEFINES,SCRIPT_DEFINES))
>>>=20=20
>>>  define cmd_munge_script
>>>  sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
>>
>> Attempting to apply 1-14 on top of 'master' gets stuck here, as
>> "GIT-SCRIPT-DEFINES: FORCE" appears after "define cmd_munge_script".
>>
>> Are you basing these patches on some unrelated work?
>
> Ah, I figured it out.  This wants to be applied after the
> ab/sh-retire-helper-functions topic graduates to 'master'.

It is noted in the v1..v3 cover letter of this series that it needs to
be on top of ab/sh-retire-helper-functions.

But I omitted it from the v4 by mistake. Sorry about wasting your time
on finding that out as a result, it really should have been noted there.
