Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5DF91F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfAVVQK convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 22 Jan 2019 16:16:10 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:34422 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfAVVQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:16:09 -0500
Received: by mail-qt1-f182.google.com with SMTP id r14so18322qtp.1
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZVN3dkuDtuvijeqLI50UNHGcmJcXFWRmECk0prNeocs=;
        b=a9Q1F9F85EnO2H+a3Ynj6SEt7sxf5B73hogQW/zmEkr5R2P3e3xMS1ql+gDWuw0jqX
         c/46LU/3i+WWceQBocOYQmzsmNrkpTpyqtm8GXOhxIAYVxlEaaeO48OY1VUgog84H4J8
         dHF0M9eEQfGArCDAGqed4SMs+HbFv6rXwiKv8V7FCAt2E8lJ7GKUYlQmnKHqJVphHbZC
         0xPIc4V0vjvB5YHJNhWQwDD6TkThrWY2YQY6EFXGh1P4/hKz3Bigz6pGs57Y/DRET/Cq
         1iTD0vGZyitbXk/EMMCuaeg+yFlPbLidVjMQQP05UII6+3IYyXnJhqUkiEV4JX3eWOif
         Ej4Q==
X-Gm-Message-State: AJcUukc1cxgTSIzURileJl2xWiQjaXhLHRObmjq6UkzMu5lub2WWO7XC
        4Bv6RnPGZdD1T2tCQS9W+9IpP4NW2zFMUeLi37w=
X-Google-Smtp-Source: ALg8bN74OOMIcf1FAj8qXNbOoNN0Q9Ir3Wa4mVqQeU8sVmVpjTEIjlORzr+IJPYtsfTRcEtjWNch3R0T47VCtf3IV3E=
X-Received: by 2002:a0c:d29b:: with SMTP id q27mr31078809qvh.62.1548191768516;
 Tue, 22 Jan 2019 13:16:08 -0800 (PST)
MIME-Version: 1.0
References: <20190110115704.GL4673@szeder.dev> <20190120075350.5950-1-tboegi@web.de>
 <xmqqo988fpag.fsf@gitster-ct.c.googlers.com> <799c5063-b0a7-df6b-6f86-a92b8b6d679b@web.de>
In-Reply-To: <799c5063-b0a7-df6b-6f86-a92b8b6d679b@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Jan 2019 16:15:57 -0500
Message-ID: <CAPig+cSDnhvVCDE15koO9M1A8TBg+Mbn2OBsfXVvshmRyybApw@mail.gmail.com>
Subject: Re: [PATCH/RFC v2 1/1] test-lint: Only use only sed [-n] [-e command]
 [-f command_file]
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        zhiyou.jx@alibaba-inc.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 22, 2019 at 3:00 PM Torsten Bögershausen <tboegi@web.de> wrote:
> On 22.01.19 20:47, Junio C Hamano wrote:
> > tboegi@web.de writes:
> >> -    /\bsed\s+-i/ and err 'sed -i is not portable';
> >> +    /\bsed\s+-[^efn]\s+/ and err 'Not portable option with sed (use only [-n] [-e command] [-f command_file])';
> >
> > "sed -n -i -E -e 's/foo/bar/p'" won't be caught with this as an
> > error, but that's OK ;-).
> > Is this still an RFC patch?
>
> It seems as if everybody is happy with it,
> so it may be ready for for pu.

I'd still prefer to see a more terse[1] (and not capitalized) message
to be consistent with existing error messages and to keep the reported
errors more compact overall to make them easier to digest[2,3]:

    err 'sed option not portable (use only -n, -e, -f)'

But that's just a very minor nit.

[1]: http://public-inbox.org/git/CAPig+cSeDNYFGYC2WznjW3zYMJCWZbZFY1KM5H5ir2L=Jxwy7w@mail.gmail.com/
[2]: http://public-inbox.org/git/20180713055205.32351-3-sunshine@sunshineco.com/
[3]: http://public-inbox.org/git/20180713055205.32351-4-sunshine@sunshineco.com/
