Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B1861F453
	for <e@80x24.org>; Sat, 20 Oct 2018 10:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeJTTC1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 15:02:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39556 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeJTTC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 15:02:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id d15-v6so33642146edq.6
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 03:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=BzrbZmhjsyUVX/m0aEGy/CMfPz+90dDcYDVMwa2crAA=;
        b=DOkaB+cJ5BF+32wTcK5pt94GzdUjZkipzABH/gbqgmWE8gYhXD0ykNbkXjHHgfhDMA
         MGdzIP7pVRrddGeZ2KjaEdoJ5Pwy8tcAe3M2IcfLMmLZmu8PvFj6CIEVjBEulVgPCE3d
         ozUNLk690d2cEmPvrEdvEVjdk66FXYz2t0P887279LOevnX5FXD856D0UOrQc3+4cjkz
         ulSbKDCNIbY5dvwjLa2Kkyt+kcF+vbx2wzAv7DA4Wq6DIqsW2yoclhJ3b4ssYlJ+unaP
         DsBwuAULzNczVzhN8Cm3w8uZathkJ188kKyr+dnyzdrzE36K2SuBHvxlnTU5W5afx3O9
         f5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=BzrbZmhjsyUVX/m0aEGy/CMfPz+90dDcYDVMwa2crAA=;
        b=QhjMLgZacO15u5c2PrHt3ZOIgoUHM9lZaTvAXbNBh8fRINkd1pccIYGTWfphCVc2xj
         CPQcZwslUZDmZdWXmt86HNtamHr+8T0MyTh8W2qSaFkCJPSvwBeU+x1A7NVXA5IjuDt6
         bf2bGT7BpqZKtlTd2wX/1l7n0PlJe868ymwYLMociopdAv7/0u8bphmngU9zuBhQv1j8
         TsCv9af1gmSIdtcL8BU+4vxeCK4VqFY5MBwU9ibVp0C2ITnxCm/Ly2+D90lWI/p8FX2N
         xCkP5Ywgv4Kf38C8aZNPsHC2rV8nWu/tBvsClsVFC/7IJnPGp/chTAeZEuBsBtl8XkDY
         yCqA==
X-Gm-Message-State: ABuFfogWw03XAejF1pcG7PTVlgb3amUf/5vOx5k2sxQY07wNuYpNX+R7
        zHBt0QsjoQFRpk7MK1MY2KE=
X-Google-Smtp-Source: ACcGV63+U6cJ7EeIH2lV0JipEOXorBX7fLcJHzU3PUQUaayFqtvYaIuXo6rl8mDOfdHM6x6CtuflRQ==
X-Received: by 2002:a50:8ca7:: with SMTP id q36-v6mr8344931edq.3.1540032743780;
        Sat, 20 Oct 2018 03:52:23 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id d12-v6sm11041342ede.32.2018.10.20.03.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Oct 2018 03:52:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Tim Schumacher <timschumi@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] alias: detect loops in mixed execution mode
References: <87o9dar9qc.fsf@evledraar.gmail.com> <20181018225739.28857-1-avarab@gmail.com> <87pnw6cpcp.fsf@evledraar.gmail.com> <20181019220946.GB31563@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181019220946.GB31563@sigill.intra.peff.net>
Date:   Sat, 20 Oct 2018 12:52:21 +0200
Message-ID: <87h8hgdh5m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 19 2018, Jeff King wrote:

> On Fri, Oct 19, 2018 at 10:28:22AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> > -		string_list_append(&cmd_list, *argv[0]);
>> > +		add_cmd_history(&env, &cmd_list, *argv[0]);
>> >
>> >  		/*
>> >  		 * It could be an alias -- this works around the insanity
>>
>> Just to sanity check an assumption of mine: One thing I didn't do is use
>> sq_quote_buf() and sq_dequote_to_argv() like we do for
>> CONFIG_DATA_ENVIRONMENT. This is because in the case of config we need
>> to deal with:
>>
>>     $ git config alias.cfgdump
>>     !env
>>     $ git -c x.y=z -c "foo.bar='baz'" cfgdump|grep baz
>>     GIT_CONFIG_PARAMETERS='x.y=z' 'foo.bar='\''baz'\'''
>>
>> But in this case I don't see how a command-name would ever contain
>> whitespace. So we skip quoting and just delimit by space.
>
> Alias names cannot currently contain whitespace, because it's not
> allowed in the key. However, we've discussed making the syntax
> alias.<name>.command, which would then make it possible.
>
> Whether anyone would use that is a different question, but hey,
> apparently some people think "My Documents" is a good name for a
> directory. ;)

I'll just leave this part as it is for now. If we ever have commands
with whitespace this'll be the least of our worries.
