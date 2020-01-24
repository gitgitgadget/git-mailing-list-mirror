Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D634FC2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 14:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32D320704
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 14:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FojJQTxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387729AbgAXOpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:45:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38655 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgAXOpY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 09:45:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so2286398wrh.5
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 06:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iHLCQ6VITQ3SGNk7cLGsnvgINX2HeixvPq9O96e73Uw=;
        b=FojJQTxnZL1I2nrIPvazg2750Y0rjtY1BOETmJ0ZMwE8l0gQksAA/Jdv2PlIM5W+nw
         eOlXEJP3QMU+616EXE/n2OSWFfg0349liF9M8VqQH3yZ5s9sn/RoEqydKXTkzIl5No+4
         zCx+QSYKL3gyhY8QjCqOaCp5bAEwg4I3dboFWMPnXK2lC0gZBpbnPCw5tleeC/8kPmRB
         /hVPgOjhRdhD4gEJINq/4AWEey2yFYYWelsulGyzRJnI/10rhZENzse1aVoVg/mjlDLA
         +RLDCkOqMFy5dLWxNsf9YCD6E74iPy3jC4QFCeDYuvZPzOOPyOSHTmqZFKfG/JM7cb/p
         Vrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iHLCQ6VITQ3SGNk7cLGsnvgINX2HeixvPq9O96e73Uw=;
        b=eXygz3DwozGrIK8OEZ1KUCRFRzjfb35649rnXsTR3QC0/AgwDN1yWI+4HGBEOJf4c7
         EaMTxiPSo5ScLZ/YqvLwYcYZ/mNnIq5xCyIGOzoX8Sld145Ren+9S4EWFs4Ufqlr9Ulf
         0E4al/na5eM9WS7DVrWIAcWJGPZ9j0ppVh3pSFKj5tm5WvpD7v07eoibq62tth0IEm6m
         +y8l7QaLae8kAHGdF/HYG6logSpGdYV0rBUMgEu8aBGeHCmeWkVuf8TVe2zGkPRHZhJr
         dkDekYe2gj2ODx9G23whVNGMbSH3tGU7486yveq+1J7T3jDLK2KIUowPG0w58eIwPoOc
         lreA==
X-Gm-Message-State: APjAAAUbiVDy+havsMzwKtYz6snTPfT2HqxnSMDaOmG4cUQpWr4oFm0P
        8bMB4Ik7zKbKaEQCVG9dj8s=
X-Google-Smtp-Source: APXvYqyb+nmfYDfynxTNcEkePDDxXiHZi/zXO0Dor7AgLHh0KSMWaaV+VF7MpoAk3f+Y1ImsacJduA==
X-Received: by 2002:a5d:6ac5:: with SMTP id u5mr4970675wrw.271.1579877122993;
        Fri, 24 Jan 2020 06:45:22 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-551-1-75-233.w92-146.abo.wanadoo.fr. [92.146.226.233])
        by smtp.gmail.com with ESMTPSA id 2sm7675432wrq.31.2020.01.24.06.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 06:45:22 -0800 (PST)
Subject: Re: [PATCH v1] rebase -i: stop checking out the tip of the branch to
 rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Jeff King <peff@peff.net>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
References: <20200109150332.GF32750@szeder.dev>
 <20200121191857.23047-1-alban.gruin@gmail.com>
 <xmqq5zh36wx1.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <4142ab55-3311-4be2-2173-5cdacafb17f3@gmail.com>
Date:   Fri, 24 Jan 2020 15:45:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq5zh36wx1.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 22/01/2020 à 21:47, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>> One of the first things done by the interactive rebase is to make a todo
>> list.  This requires knowledge of the commit range to rebase.  To get
>> the oid of the last commit of the range, the tip of the branch to rebase
>> is checked out with prepare_branch_to_be_rebased(), then the oid of the
>> HEAD is read.  On big repositories, it's a performance penalty: the user
>> may have to wait before editing the todo list while git is extracting the
>> branch silently (because git-checkout is silenced here).  After this,
>> the head of the branch is not even modified.
> 
> Hmph.  One curious thing in the above is why this is specific to
> "rebase -i". The need to know the commit range to rebase is shared
> across any rebase backend, and it would be the most natural to parse
> the optional second argument (i.e. the branch or the commit to
> rebase) before builtin/rebase.c dispatches to a specific rebase
> backend, wouldn't it?  So, the question is why a normal "rebase"
> does not need the same fix?
> 

That's a problem shared by all rebases using the sequencer, so -m and -r
are also affected by this.  `am' is not.

> If the answer is "rebase in general was fine without extra checkout,
> but 'rebase -i' was doing an unnecessary checkout" (or any other
> answer) that is something that would help future readers to record
> in the commit log message.
> 

So yes, the answer is that the am backend does not perform this
checkout, unlike all others rebases.

I will resend this patch very soon.

> Thanks.
> 
> 

Cheers,
Alban

