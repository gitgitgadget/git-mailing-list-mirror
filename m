Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888B5C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6531F61059
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFGQA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:00:58 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:42801 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFGQA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 12:00:57 -0400
Received: by mail-ej1-f53.google.com with SMTP id k25so22029060eja.9
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Wpm5vyDnlASYIFnGmB5tAy+TnQ01UsAFq9bDKGvrraM=;
        b=DpqtQrlaZ9n8i9cCxLnWFqrIVPKQUTuCzpatvl+Ws7U7yAc7XlQIMYNQVJxLVKqQPt
         yxhRh18/uAbV+BORERXQll2bnO++5Thg/98s82l7JSSWFI1CnhbihuHR1lTCWrdvOyE8
         rkXtHm8MpOfZSj71Ek2Go/A6qd3wQolAZ64BLs+V4SKF9vRohK37pMMajq5kHE/OfB1m
         AcnI9oOnq8KA+cr2jmxXTthBi9BlOrnAXOkrTYpPzpVeEtpvPUjmTje3kiZJNba2z6HX
         yY2jDtn1xYbeNiJZ8qyqtPzoo6/7gxD43RTLwSK6tdQCWh0ln6rFMhTXNcSViQpp0dhW
         pMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Wpm5vyDnlASYIFnGmB5tAy+TnQ01UsAFq9bDKGvrraM=;
        b=qo7XCputrx33f1s4N597wiPCssRAbt3tayYuR3r0581ANVgFGhWDX6Is4DXxFUz6Zx
         4CXlaRxUNCAhiVqtcBVzGa3dOwM5xcwFa0BqYIhUxCGnloez5t0bNj97AsWzbKg+wYDx
         w34JcXVcySIch287rHtWO8E9EZAGmH7U8nb1Xo3xxDnZW04fmgXXxnSkfHa7Q8j4SKwt
         j3EfrPhnfhCjGj4IlV35w2zq1y3Znd/DnXMssv9bmVALEu2NFwlFNBMR9dwpaOOGbtHS
         a8d0fJoJYzftEwMzknBOu9jMBEVEweOfneCfIVhsSFhgJ6uw+dNMsSXOHRFTP7rrtAfV
         I0GA==
X-Gm-Message-State: AOAM533nMJsqL4+L5boJwEhN2EJGyDeZjyHlt1UHwhkm2CLBr9eRJW6v
        IbAvQqQPaOyR2KNIYi+coSnPMolMa0eS5w==
X-Google-Smtp-Source: ABdhPJxIVvuLLfPtGmTyOwC8xvedC5t+zQI/phH3lN4+HpwYYYGYoIzD6lY1okqJsTWEzK/mFiXozQ==
X-Received: by 2002:a17:906:51d8:: with SMTP id v24mr17935501ejk.264.1623081469826;
        Mon, 07 Jun 2021 08:57:49 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h6sm4364306edj.91.2021.06.07.08.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 08:57:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] read-cache.c: don't guard calls to progress.c API
Date:   Mon, 07 Jun 2021 17:52:13 +0200
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
 <patch-1.2-1680109655-20210607T144206Z-avarab@gmail.com>
 <51e00403-dcab-c57f-b77a-de01a61a60eb@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <51e00403-dcab-c57f-b77a-de01a61a60eb@gmail.com>
Message-ID: <87mts14qgz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 07 2021, Derrick Stolee wrote:

> On 6/7/2021 10:43 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Don't guard the calls to the progress.c API with "if (progress)". The
>> API itself will check this. This doesn't change any behavior, but
>> makes this code consistent with the rest of the codebase.
>
> Since stop_progress() closes a trace2 region, this actually
> does make a change in behavior, I think. In a good way.

I don't see the behavior change.

Yes start_delayed_progress() will call start_progress_delay() which
mallocs and enters the trace2 region, and then if you don't call
stop_progress() at all you won't leave it.

But in read-cache.c both before & after my change we only malloc & only
enter the region if we're actually displaying the progress, there's an
isatty() guard on it.

Once we start that progress bar we will leave the trace2 region, via
stop_progress(), but note that stop_progress() will exit early if the
pointer you dereference is NULL and not do that, and since we'll have
"*progress =3D NULL" in the case of not wanting the progress bar we won't
leave the region we didn't enter in the first place.

The change here is just to remove the needless nano-optimization of
guarding the calls with a NULL check of "progress", which the API itself
does, no?
