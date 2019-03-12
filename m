Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42DB920248
	for <e@80x24.org>; Tue, 12 Mar 2019 21:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCLVSA (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 17:18:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37167 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfCLVSA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 17:18:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id m12so3594101edv.4
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=zzMNArNYwb6dI4sGvlGBrIK07alVJgbEO6n6q0/Tbr4=;
        b=fIB5qA9BVbN2Vw9oQQxUpTT/vuY2MXY5AwZKBsSJ57Df25uM14MeA9H4zePY+SvdEc
         vCbhiEAXdONT6I0r86C8NkmbRx1bbgRms0IktSMNrsxtuhjyWO23DwYgPYxOtG8tf88Y
         GxmNs5Xz0MHGUt2/eHFxroyOTxT7qreO7fywmJ6hDZ/1cGglg2cJwtWHzYJFCirCRAJw
         Zd4TbkA6LQDuxftjDWEjpYkRyzmXGk2t9g39OriqC+8aYmQfvkuBta29GimUwcgedVsj
         8SEYey/wI+ty9WPjEWTsEO+SNFvS5GaCHKld69USVONUqqhkF9ETf3IoPjGn9xT0Co5W
         DbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=zzMNArNYwb6dI4sGvlGBrIK07alVJgbEO6n6q0/Tbr4=;
        b=KrAmpTewPJ5jfig8wubUA2vQIh9M6RvarMNYCbOwUWPNCR02flqPW7QsKFqehRYc9v
         w/251PRfbFR8JkjUADZ2i6Q7TiCcr00/PqIf9rNfeiCTT6Qb++YMgTQ0d/ttIQVv/bwq
         KIQJKXFZohw79v0I2LAMhMFeh8OYdMJIARaCbpsQsrj0VrEopzEZ1L7/s+lhCUKJFAID
         tcZlKnkJRjsbuNt+/l7ySSYNQ70KuTNStrCHr6SmWVb7ICiOyzAe3ZxxKCfE8TUUJJP0
         QBGyjmuVcNExOANzmsNqvcygntT1dZaE87C7b1oKTTqMhp6H8U/QT7PULsKBEVHjEVKd
         MImA==
X-Gm-Message-State: APjAAAXbm9C5KwzTuOOT1WSGREYfh8nM9xxtmlsbWylmlKfm6BVJIhRq
        bcoUPa2YfVIX6vxPmXxoLmc=
X-Google-Smtp-Source: APXvYqzIbzq4wKKUHClvq0uKPLK74OGXgEFtP4NiI+A85uxS95d7i8rmEXwEbeMA6ns0vZh/h6kswA==
X-Received: by 2002:a50:9984:: with SMTP id m4mr5039621edb.279.1552425478188;
        Tue, 12 Mar 2019 14:17:58 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id me7sm3924380ejb.46.2019.03.12.14.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 14:17:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: fix unaligned loads in sha1dc with UBSan
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com> <20190308174343.GX31362@zaya.teonanacatl.net> <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com> <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com> <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com> <20190311033755.GB7087@sigill.intra.peff.net> <20190312210626.GA5157@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190312210626.GA5157@sigill.intra.peff.net>
Date:   Tue, 12 Mar 2019 22:17:56 +0100
Message-ID: <87va0nbxmj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 12 2019, Jeff King wrote:

> On Sun, Mar 10, 2019 at 11:37:55PM -0400, Jeff King wrote:
>
>> Unfortunately, I don't think sha1dc currently supports #defines in that
>> direction. The only logic is "if we are on intel, do unaligned loads"
>> and "even if we are not on intel, do it anyway". There is no "even if we
>> are on intel, do not do unaligned loads".
>>
>> I think you'd need something like this:
>> [...]
>
> The sha1dc folks gave us a very nice and quick turnaround on this.
> Thanks to them, and to Jeffrey for opening an issue there.

Thanks. Good to have it resolved this way.

> Here's a commit which updates Git to use the new feature. I've tested it
> with both the in-tree and submodule builds like:
>
>   make DC_SHA1_SUBMODULE=Yes SANITIZE=undefined && (cd t && ./t0001-*)
>   make DC_SHA1_SUBMODULE=    SANITIZE=undefined && (cd t && ./t0001-*)
>
> both of which fail without this patch and succeed without it.

FWIW I've reproduced this testing and found the same thing. Looks good
to me.
