Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63628C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3223761057
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbhEFPUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 11:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhEFPUx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 11:20:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B2CC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 08:19:55 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x19so8343713lfa.2
        for <git@vger.kernel.org>; Thu, 06 May 2021 08:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=AI00TPq4rKMTMWE0HD+WX3879Yczo8a0Xyw/8mEMwTg=;
        b=ioX8y/uxX21UWIL0JHSFKMa7kN2VUc5IEFszXJ7CNzUlvAI3pXKQnvijR/DW518j4z
         ShMCTgKl5Z4zLewQoyhOOBoHXUCHwiCl1CLiaQSeV0gOFW7OKoOMc8QhO+MibJu9AIXU
         CTV/D2GTnbn43yGRJnaJcswjiE5YxgxEKI2B7d3qAnHLAUK6+h68reVYj3SMNV2xO5p3
         PRmDz85Q/WPCn5tgM9JTNCa1npIeGEN9yxDrKDk/Gqewh5LlgHy9FqlaVsHQCw1nlueq
         yqz0KRciS/OjTeEkUmuaGI9kUTEV5ELc8mjLorV6CDh12vuqoNbvUZ4Gpfvfpk6YvEBi
         YReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=AI00TPq4rKMTMWE0HD+WX3879Yczo8a0Xyw/8mEMwTg=;
        b=ZFD5jS5s2U8P0ZJDron6lQzqA6EFRYKQsJGH/NFsKnJZs64hCnoHSLd2KcO8Dwd3Et
         woBmYJaQjlr5LUCsyBvm3ESX6X10lTdtJkwDONJ2Oe52gN5wP/huX9eV5+cNgGxs/jiq
         9uymEEbiNaWManAo/TGcP/49lit6oN+nEUNLe1IPCdsQUuP0XTEABELRygWSVRXec597
         CfdnG+rEdfkQikYQDObaYHUxSheYU1y5L8Q1tC+1YYQ0cIxQdU/K7nUXgOUoRvY/TDe2
         InVemdRV0XwgKJpBjlPadHmy0gm1ROt0ZvShZOMcpOCH7D+sggJNMVHo1YmWrwx9mT8V
         96CA==
X-Gm-Message-State: AOAM533gqgFXF/TEDWhN+qkwKTWOuGA32woiXUbtmUSS1/mxtW/qmFWo
        gUAv3pTStqQ+hdKnzQcFL85nLkXmomg=
X-Google-Smtp-Source: ABdhPJzAfX0NtvMa4FdIsXlsmqOJA6xjEmZYaYYoovOifyiNAdk/lKDNR9wCpeyFVEXZP4vfVmSgXA==
X-Received: by 2002:a05:6512:118c:: with SMTP id g12mr3341360lfr.316.1620314393467;
        Thu, 06 May 2021 08:19:53 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d5sm735458lfi.144.2021.05.06.08.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:19:52 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?G=C3=A1bor?= Farkas <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git switch/restore, still experimental?
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
        <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
        <877dkdwgfe.fsf@evledraar.gmail.com> <87sg3155dt.fsf@osv.gnss.ru>
        <xmqqk0oc1vzj.fsf@gitster.g>
Date:   Thu, 06 May 2021 18:19:51 +0300
In-Reply-To: <xmqqk0oc1vzj.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        06 May 2021 10:39:28 +0900")
Message-ID: <87k0obvqi0.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Isn't --merge a different (and inferior) way to achieve what we already
>> have elsewhere with --autostash? Does it make sense to get rid of --merge
>> here in favor of --autostash?
>
> Not really.

I tend to disagree. 

> The "--autostash" might appear to be applicable to cases that can
> induce larger conflict,

To me (auto)stash is not about amount of possible conflicts, and even
not about conflicts at all, but rather about data safety. (Auto)stash is
reversible: just get to original branch, apply the stash, and you are
basically back where you was.

Besides, --autostash shouldn't necessarily even imply --autorestore. I
can easily imagine a mode when --autorestore is fired only when one
returns to the branch where --autostash has been performed, leaving to
the user the responsibility of applying the stash to the new branch, if
she really needs it.

OTOH, --merge sounds more like infamous "cvs update". Keep fingers
crossed (or rather do a backup) and push the button, – Git will do its
best not to clobber your content, but all bets are off.

> but once the diversion gets larger than what one comfortably can deal
> with "checkout -m",

The problem is that I suspect there is no such margin. I'm simply
uncomfortable with -m. It doesn't sound safe to me no matter what. I'll
rather stash manually than use -m.

> the user is better off to work by forking a branch there and create a
> WIP commit, than deal with the stash.

Why? This looks like unjustified complication. All this is temporary
enough for the stash proper, – one just forgets about it immediately
most of times, as things typically go rather smooth anyway.

> So if anything, I'd rather get rid of "--autostash" than "-m", to help
> users get in a better work habit.

I have as much as 3 points to oppose to this:

1. Who decides which work habit is better? At the same time, data safety
and recovery are unprejudiced goals to be aimed at.

2. Unlike --merge, --autostash is universal. Whatever job is to be done,
get your changes to a safe place before continuing, to be able get them
back later. It'd be excellent if we had global autostash mode support,
especially if stash were capable to save/restore entire state of
everything. Sounds like "Undo" in text editors, or like automatic backup
before OS update.

3. Dunno about --merge, but I'm sure --autostash came from real life. I
see it all the time how users do "git stash; git pull; git stash pop"
sequence. It's just natural, and if it suits them, who are we to decide
what's "better" for them? I believe Git should continue to provide
convenient tools that help to get the job done, rather than trying to
fight "improper" habits and/or workflows.

Overall, to me --autostash is clear winner :)

That said, I somehow feel this has been already discussed to death when
--autostash was introduced.

Thanks,
-- Sergey Organov
