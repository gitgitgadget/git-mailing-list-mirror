Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC42DC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3DE8610C7
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhFGLdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 07:33:08 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:36505 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhFGLdI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 07:33:08 -0400
Received: by mail-ej1-f50.google.com with SMTP id a11so25355646ejf.3
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 04:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=pgDNlr0635cWAace4dF81ts0rp3k8E/TmBSrpP9UAa0=;
        b=I5aTMMVivEXH67dYN45dhwLirLVa5gMWLBHbBWyAONkqyGuQuNF21VzrrT6uhm/iY6
         0p4G/tnIB1CL8aknf95eyP7csyRkUqTV692BrGeeO2O9O5QfMDIs0NLRfJ2bNCPnR0w5
         /U5x8oYt8OjqxuN/8fAwTHdhQo7uaFqUZ4T4Af0+paypFuA7YiSqcTpRv5CLATYGiQ65
         qtx536h06o9rku0wObh2CY30CwGP6LoM5HMhHs+8fWCG90eYm2RXPMEV4/YPQGpbM5HT
         2cnRqo6errDA4weabX6fxX6sGh515jo80h8NBNH1pwaSuR+YhPEs6JOL3LMaFJWN9HC8
         2ofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=pgDNlr0635cWAace4dF81ts0rp3k8E/TmBSrpP9UAa0=;
        b=SjldRv6IESFo/+81HMScNYmr7rJUVPx4knP09ZYS37yD+7KwPAx1u4q3QYlVUIozK1
         Ix8Z+4T+OEoB+1tlsCN2+0/NSlIdcWR+tx0gTKx63bJaGoQMTr23d/ZSDG5pz+YLCOfP
         g5cI/BZvjl3sOMq2bGqkFLzv9dkjq6dXVlh05F1vliX+8DXMfL4GFnOAu1yXiyv6nJY/
         thijBEToWS3+fLzsSXM8rm2YgzMywmJXf+BU3pqnZ0KbX0bLFMSs3W5fepswr4fnTnJm
         d75+N3Lr6zSMQ2mjapA9GWMVUBSQqAR+XGpIRKloC9I6csURZhMWDaBGIuA+7rNrNnOw
         sHRw==
X-Gm-Message-State: AOAM533g+LeYvXsEB4zHw7ZT0oktL959O90qlLP+r3XLzmmVcFuwHeFK
        l4ECvlkQzSZKsC+8kKa797o=
X-Google-Smtp-Source: ABdhPJzO5711xiQ3eAOXw+152zrTdaAviWC6HSQ2ymEOI0LFskUbdthar1xi+APe2OdbssCzVhu2Ww==
X-Received: by 2002:a17:906:dc8d:: with SMTP id cs13mr3063558ejc.422.1623065410022;
        Mon, 07 Jun 2021 04:30:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c11sm7586834edr.80.2021.06.07.04.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:30:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        David Coppa <dcoppa@openbsd.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] t0001: fix broken not-quite getcwd(3) test in bed67874e2
Date:   Mon, 07 Jun 2021 13:29:18 +0200
References: <cde6c1a5-3dfc-9710-bab9-b847a5dd960b@web.de>
 <patch-1.1-c70791bbd3-20210601T003743Z-avarab@gmail.com>
 <b650bef5-d739-d98d-e9f1-fa292b6ce982@web.de> <xmqq4kehs2nt.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqq4kehs2nt.fsf@gitster.g>
Message-ID: <87y2bl52v4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 02 2021, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>> On AIX under both bash and ksh this test breaks because "pwd -P" will
>>> happily display the current working directory, but getcwd(3) called by
>>> the "git init" we're testing here will fail to get it.
>>>
>>> I checked whether clobbering the $PWD environment variable would
>>> affect it, and it didn't. Presumably these shells keep track of their
>>> working directory internally.
>>>
>>> Let's change the test to a new "test-tool getcwd".
>>
>> Makes sense.
>>
>> If /bin/pwd can figure out the path to the current working directory
>> without read permissions to parent directories then it might be possible
>> to teach strbuf_getcwd() the same trick, though.  How does it do it?
>> ...
>> If strbuf_getcwd() were to learn any of these tricks, then so would
>> "test-tool getcwd", via its xgetcwd() call.  At that point we'd better
>> rename GETCWD_IGNORES_PERMS to XGETCWD_IGNORES_PERMS.
>>
>> But I guess we need none of that because we never got a request from
>> an AIX user to support a /home directory without read permissions,
>> right?
>
> Nice "thinking aloud".

I see (well, rc/release period and all) that you didn't pick this up. I
think per my just-sent
http://lore.kernel.org/git/871r9d6hhy.fsf@evledraar.gmail.com that it
makes sense to just leave this at s/pwd(1)/getcwd(3)/ as this patch
does.
