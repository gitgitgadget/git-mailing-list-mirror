Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADD5C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 13:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99DD7613B3
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 13:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbhHWNBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 09:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhHWNBY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 09:01:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20838C061757
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 06:00:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a25so10165550ejv.6
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 06:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=cJLDaXAaU4gRS4JWKseC3bWuDKu/kpmiOwBmGr2QKUs=;
        b=O2pF1aU7az0OD1k05W5oSVEr0UqcWe2J/Ozeqlt3kI6RBbo0rC3G6SdUHwvnNhCJ9N
         oEjEj1BL+qQwg8Znp90SLrV969s49nm9TwYqERsBuufYIojZ/XLpi6g8Q0AmBp9bF27z
         t3lTSfAyJlDcQkCnakDNBDWoTGFMbwPzU5Ok4Bl+XugXUR+Irm6Hg+RpXlzvCBbTpqmi
         NHGvMhpUmnd2E/C8ROyGg4wGeHReuYsq4L+iRfljlWW2av9ORb2zdzJ4Xo1GCTNKjb0+
         fDNZ04zntxfk3bG47ByoVti3e8jxFE/C02q7CEyq6rWByP48ELTsLeiEyUbjBessAc3R
         7q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=cJLDaXAaU4gRS4JWKseC3bWuDKu/kpmiOwBmGr2QKUs=;
        b=ZCG9ouqWFrSM9txPVH3tSyPxrpmH6CkLm5YzM1e96WzMtdbrF8rjkl+JPfqQLeRswi
         2Oeu9ig/1YDx4KcXv3zPYigz/rtoEQCL3+ZVLBYjE96act45OsKPtO+JaTCKHy6hdB01
         6ElnVxe5xmmB7ka+BGGU6Ku1cXc+wxl+5D2DRn1sYO22wfRBlkaI+KJkH7UXdF9EilpI
         gLiiiIn+0hiL299D6iYn5LjQYAaUb0QMpApIJGwn/xRAl8OmdQ3RwY1anVwGuTdPfDH4
         /BIw8tw1ItU9JOL5Is2DhTT4oRx8GckJGlWccgPHGFtYFeysYyuB8mh5vmRvMyKSZD4n
         ZJKw==
X-Gm-Message-State: AOAM530SVlhZpaXwVA32xp6GfKn9B9osThcqtFk3YlJvnLAx7bnozh7s
        7jaEMxZmk0KKlAqhE1mZErI=
X-Google-Smtp-Source: ABdhPJyDGS8DilqVZ+46ncyQaiFA0tLih8rG4YIhguQlNsTTEP+8WIzDTAMSIY7RLoTCS4GpXgt0tA==
X-Received: by 2002:a17:906:11c7:: with SMTP id o7mr35695244eja.480.1629723640503;
        Mon, 23 Aug 2021 06:00:40 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p2sm4684148edr.65.2021.08.23.06.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 06:00:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>
Subject: Re: [PATCH] test: fix for COLUMNS and bash 5
Date:   Mon, 23 Aug 2021 14:59:10 +0200
References: <20210805194825.1796765-1-felipe.contreras@gmail.com>
 <20210806144911.GA1388237@szeder.dev> <xmqqmtpuik5m.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqmtpuik5m.fsf@gitster.g>
Message-ID: <87sfz0fh8o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 06 2021, Junio C Hamano wrote:

> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>>> @@ -419,6 +419,12 @@ COLUMNS=3D80
>>
>> COLUMNS is set just before the start of the hunk context ...
>>
>>>  export LANG LC_ALL PAGER TZ COLUMNS
>>>  EDITOR=3D:
>>
>> ... so these two "commands" above are executed while COLUMNS is
>> already set but checkwinsize is not yet disabled.  The reason I put
>> quotes around that commands is that while exporting and setting
>> variables are indeed commands as defined in the POSIX Shell Command
>> Language specs, Bash with checkwinsize enabled only "checks the window
>> size after each extern (non-builtin) command" (quoting 'man bash').
>>
>> So even though it is safe to execute these variable setting and
>> exporting commands after setting COLUMNS but disabling checkwinsize, I
>> think it would be prudent to disable checkwinsize before initializing
>> COLUMNS.  (And perhaps adding "non-builtin" to the comment below.)
>
> OK.  I tend to agree that a less invasive solution like this is
> preferred over adding new code to only help tests in the everyday
> binary, especially this close to the final.  Taking the above, I'd
> queue this and hopefully I can merge it by -rc2 at the latest.

Now that we're post-release are you interested in a re-roll of
https://lore.kernel.org/git/cover-v3-0.3-00000000000-20210804T230335Z-avara=
b@gmail.com/
+ removal of the bash-specific checkwinsize added here, or would you
like to just keep Felipe's version which you integrated as 390b44eb2bc
(test: fix for COLUMNS and bash 5, 2021-08-05).

Either works for me, just poking to see whether I should drop this from
my local TODO list or not...
