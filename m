Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95942C63777
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 10:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A2492072C
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 10:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXILPf0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgKWKSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 05:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgKWKSc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 05:18:32 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70393C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 02:18:32 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id gj5so22501736ejb.8
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 02:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=N/zE3UOM5nVxyfYJZwezFssrGSN3zBHsj2sIn7dxl50=;
        b=oXILPf0CsRcwUSL+bkF/u+1+0qAXE/EDwDt+S7jqFnPbt5W7UB2htuUZubcpDEIoHq
         SDuOmCNh1CVc2EaOcPC1BEAXXZl2S3bMJAifMsszDQ5vx9BbGxtdLNtw+898horKt7zf
         eDwtTn48PrXZzTcQmkEF/qiJC/c8W31kPa3rY3WON8DLgYmHz1ndXTNHdEdd1nUXyNaj
         zjLK7S/SRQ15uHGpwH4NtvQV/6N3Rm8DxFAQMo9S8LS+WPo1C0iHbPlpsDmUqKIzZFRr
         B0GwLuyfEljCp/7nx8NS+/wYdtBg0jn+l9yTW+hI15bNi5ISzZTSsIcHH7Iwjw4gWOyT
         Qytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=N/zE3UOM5nVxyfYJZwezFssrGSN3zBHsj2sIn7dxl50=;
        b=sZmsssReQHkxSDRQHh1w8MYV77ZGvcxAI0ro67JMHvSq+GY7wP/VLKWomcNaMRZbKx
         Sf2bRFgcPkas+4jaPi3ONg1QmAHNNHzeNzg6bmOdts4obeW78f0XpHGTA8M/Z3CE9lqL
         Dw5YY7ttfyi9TC/Mj6tXttRl3Z9Etv8FACBVOreCf0RjvhRa0hNoCI+Rsm47ozCHFANG
         vZ+2pD/1LyyICqW6vq7v0wfReyUCt3/uXKqSN+PScB0G/oSET3Kyxo7fHEpJHK2Kd560
         R+i0uEJlCFxg7nNwqkaap9bt6dmiRTHl9IGxt63odWKgBMrupNh7zB2Sjs0k5P+eu/3g
         /uXA==
X-Gm-Message-State: AOAM531mAIuEarB40xkscE8HeexmtyzCcxbO6UHdFwVL8SYuYlbim2A9
        dsDWG31VnQyJmDhSd/5huOQ=
X-Google-Smtp-Source: ABdhPJxpa/U9h5FX9ONHiZQXfugb9l16ENmv/clH2tAKS7JzUNATRA6axB98SikXfixUohnuRiyNwA==
X-Received: by 2002:a17:906:e0f:: with SMTP id l15mr15392960eji.518.1606126710986;
        Mon, 23 Nov 2020 02:18:30 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id u13sm4667429ejz.74.2020.11.23.02.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 02:18:30 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] gc docs: change --keep-base-pack to --keep-largest-pack
References: <20200806214929.22qgjg3o2noosjuo@ltop.local> <20201120115522.23617-1-avarab@gmail.com> <xmqqtutisdfk.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <xmqqtutisdfk.fsf@gitster.c.googlers.com>
Date:   Mon, 23 Nov 2020 11:18:29 +0100
Message-ID: <87h7pgpea2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 21 2020, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> The --keep-base-pack option never existed in git.git. It was the name
>> for the --keep-largest-pack option in earlier revisions of that series
>> before it landed as ae4e89e549 ("gc: add --keep-largest-pack option",
>> 2018-04-15).
>
> Is it a sign that this hasn't been used by or useful to our users
> that this documentation bug did not get noticed by anybody for the
> past 30 months, I wonder.

FWIW I used it in a major git deployment since before it landed on
"master" as gc.bigPackThreshold, but not the CLI option.=20

I think a lot of these CLI options for gc/repack are relatively unused
compared to the config, but it's still arguably useful to have them for
one-off testing (although you could also just use "git -c ...").

> "git gc -h" does report the option with correct name, which is the
> beauty of automation ;-)
>
> Thanks, both.  Will queue, together with [2/2] which also makes
> sense.

