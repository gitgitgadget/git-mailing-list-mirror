Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AE4C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 05:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E168E604DC
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 05:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhGZFAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 01:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhGZFAc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 01:00:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64639C061757
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 22:41:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ga41so14500836ejc.10
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 22:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=u576BD0UHiCj95fG4EX/26cw/XRZM/oruh8nHyZjy0Y=;
        b=rubDD84Wi/o/SzN1k7UY9Sdm6BuPIA1DgHeW7b3xWw/kfxhwX/A6QO6J6x/SVISAgN
         2Cb+1tKOLkryzpjvU8CByRQKNHfmjT0szKSwBGvduxx2otk1alForYizYnJrscYIDDTj
         N6du00yFQWY32xLF1bgIB+CNnpRJawOTxEAGG7XhfEa4895dNG/D64FWODZFTP7KupLK
         q0wYXr2xgJq1rSAFjENEj0V9zOqzypcBQ4rsgP9c+MSkBwQsjx8R9dkomKjys62Bjg0h
         5nNxgqTo/YfgUKrtKpgMVGDK9w1LkxXLiGYALnwXwzzxzAECARRYWBl5mqzr2S6XP38c
         Qh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=u576BD0UHiCj95fG4EX/26cw/XRZM/oruh8nHyZjy0Y=;
        b=V+VM9tTYEyQTuJWAPnw/s8MnE+NhJu03zO6RdO4NUOTbBatcXsJxiWgf9+efoa1Dmi
         gZv34174mlVojzQ9dxfpWnDqaORUWiOLup8k1x+BZQEJ2YKJ9o2sCX6nfU2cZMnV7K39
         OXQu8DmUjRXzJTqGc+GTzc+AcWBe2NVDwK91LcGHq/xW/vvpImcWAfD10yLKAzx4umXT
         YJT8ZkZ0/8F0t3xOQES5XURTya3jDG/0QfUKLMImtl8ViWxqMBG/h2xeuucy9t7NoY3H
         qfn3gizGfcoOrEg7/YtpLyOuqILjSFpWCbagNMzwxaHS7FTIjy2gTv9UJ38IRrRQ+cZc
         5D9A==
X-Gm-Message-State: AOAM533Yfgud2QvMPAX5seD6+dq94t5pMvGGLRTuzscnV8Gf83Bs/CKs
        CZswZJFPCCQDtHyARC8vjFs=
X-Google-Smtp-Source: ABdhPJyqQmbRC9+9eQuhcQh9n3j3emQXIh3ntwfZGmMP1cz3cYuXSrt+SgV1u4L/rQpj5gzIpeXrlw==
X-Received: by 2002:a17:906:2c19:: with SMTP id e25mr16136419ejh.477.1627278059253;
        Sun, 25 Jul 2021 22:40:59 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id q9sm13823448ejf.70.2021.07.25.22.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 22:40:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 06/12] refs API: pass the "lock OID" to reflog "prepare"
Date:   Mon, 26 Jul 2021 07:39:47 +0200
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
 <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
 <patch-06.12-295594fe8ae-20210720T102051Z-avarab@gmail.com>
 <xmqq35s7efb3.fsf@gitster.g> <xmqqy29zd0dv.fsf@gitster.g>
 <CAFQ2z_PuNJ_KtS_O9R2s0jdGbNNKnKdS3=_-nEu6367pteCxwA@mail.gmail.com>
 <87lf5wstlv.fsf@evledraar.gmail.com> <xmqqzguclpr2.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqzguclpr2.fsf@gitster.g>
Message-ID: <87fsw1skcb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 23 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, Jul 21 2021, Han-Wen Nienhuys wrote:
>>
>>> On Wed, Jul 21, 2021 at 7:48 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
>>>
>>>  Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>  > This obviously breaks the latest round of reftable topic, as it
>>>  > still wants this type to take const oid, and I do not think using
>>>  > on-filesystem lock as if we are using the files backend is not a
>>>  > good solution.
>>>
>>>  Sorry for redundant negation.  "I do not think it is a good solution
>>>  to have everybody pretend as if they are files backend when they
>>>  lock refs." was what I meant.
>>>
>>> Reftable could easily read the current OID for the reference, if necess=
ary.=20
>>
>> (I'm replying to a mail of Han-Wen's that didn't make it on-list due to
>> inline HTML, quoted here in its entirety sans signature, see
>> https://lore.kernel.org/git/87eebptr7i.fsf@evledraar.gmail.com/)
>>
>> Junio: I can change the const around if desired. I thought we weren't
>> particularly concerned about it in general except to avoid the verbosity
>> of frequent casting, and in this case the lock API doesn't have "const".
>>
>> But as for the reftable incompatibility it seems to me irrespective of
>> backend that a reflog API that supports expiry is going to want to have
>> a callback for "give me a lock to expire this branch" and give you a
>> reply of "OK, you have the lock, you can expire the log, and it's at
>> this OID".
>>
>> Why would it be file-backend specific?
>
> If you feed const oid to *_reflog_expire() method of any backend
> (including the ones that that are *not* files backend), and if you
> expect they all will use lockfile API to copy it into lock->old_oid
> so that it can be fed safely to prepare_fn(), then the arrangement
> for constness you have set up in your series would work out OK for
> everybody.  But for any backend that does not use one-file-per-ref
> filesystem mapping, it is rather strange to use lockfile API for
> locking refs, no?  THat is what I meant by files-backend specific.

It won't be using the lockfile API, but as an implementation detail the
non-const old_oid is where the "struct object id *" you get passed comes
from in the file API.

Is that what you mean by the behavior being file-backend specific?
