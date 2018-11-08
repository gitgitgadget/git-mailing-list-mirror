Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BF161F453
	for <e@80x24.org>; Thu,  8 Nov 2018 22:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbeKIH60 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 02:58:26 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44185 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeKIH60 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 02:58:26 -0500
Received: by mail-ed1-f68.google.com with SMTP id n19-v6so193373edq.11
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 14:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+wmZ3xJifEe2pcpFpoaOe9XWKWmbel0qej3nkKppBRQ=;
        b=HeWFnW2275AnN+xsH624ndGNIdmcqzp/QoUZyUBoAD9m63kdDUTZwYZuHIbSQByqAC
         VN+YnrsJJIYhEs2cOaVbtnn2ICyqf/pzBVCQ3vtGDHB48B7UQ/ckki16pPyQfcneHXYy
         Nqn4Q9OzCMIHfpvfdcen5dgZ+7NqZef9WnnBbOCPDvoLjF+M0uG/L0dV6ug3XMmvkUaf
         b2mlERmX3GDbxD7+kKrlt3NKIxypdEb9jx2uEneGo/HgJbAaG35xhiys8ivHe/FUW0Es
         5kFRBDcFd7UcK0eBihveJFX6Tm44tZoSQRAfyA5OeNOsdyKQVLZSDowEM5SwkWJB37Vg
         QKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+wmZ3xJifEe2pcpFpoaOe9XWKWmbel0qej3nkKppBRQ=;
        b=TxXBVC9arINB6Ha4CBUZ1ck79cWL94SQus35FJxBIx8yngsW4EzoI2Gh9I5gwTbXe8
         Vzq84nGl/WE7epajE7J6cInLN3npn+8Uw+yQckujFgPPEoJIRpJC+YUQx4Pnmi+7rmp/
         bDeGjRtP46SqcfFrI+0K4oKJ9oYyU6rwHJUqbPNlZPZ6FV1DTsUgPJQvOZzaPB9Kl2Td
         vp8Xl4O3EvsuCjscS7HkOk9Vq9SB+rQqHpYhbyBqpwnjoqWTQWEp8+lvHMduztpnPffB
         VnU86Dam0KGY6nqdcfmLtsfUaRACcfyITPZsRFOND898PslmNtJnYzAP07AdAFUmwzI3
         jcXw==
X-Gm-Message-State: AGRZ1gLJAUWPufjvPGLPZlxanV11Q44l6Y/GqLVQzDaeJGbs68PGjxxN
        FU1STjTijjSGMLcznpOOTrA=
X-Google-Smtp-Source: AJdET5dUeY7LEMzXsPMWuG79X140YP7+WX3XYX/TwT97Z1ApazYT8F8smHH4Ug7gYh3cBzcmRlki0g==
X-Received: by 2002:a17:906:9410:: with SMTP id q16-v6mr136224ejx.208.1541715649260;
        Thu, 08 Nov 2018 14:20:49 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id o3-v6sm869629edc.95.2018.11.08.14.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 14:20:48 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com> <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com> <87o9bgl9yl.fsf@evledraar.gmail.com> <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com> <20181027093300.GA23974@sigill.intra.peff.net> <87lg6jljmf.fsf@evledraar.gmail.com> <20181029150453.GH17668@sigill.intra.peff.net> <87bm7clf4o.fsf@evledraar.gmail.com> <20181029232738.GC24557@sigill.intra.peff.net> <20181107225524.GA119693@amazon.com> <20181108120256.GA29432@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181108120256.GA29432@sigill.intra.peff.net>
Date:   Thu, 08 Nov 2018 23:20:47 +0100
Message-ID: <87lg635hz4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 08 2018, Jeff King wrote:

> On Wed, Nov 07, 2018 at 10:55:24PM +0000, Geert Jansen wrote:
>
>> On Mon, Oct 29, 2018 at 07:27:39PM -0400, Jeff King wrote:
>>
>> > On Mon, Oct 29, 2018 at 08:36:07PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> > >  * Re-roll my 4 patch series to include the patch you have in
>> > >    <20181027093300.GA23974@sigill.intra.peff.net>
>> >
>> > I don't think it's quite ready for inclusion as-is. I hope to brush it
>> > up a bit, but I have quite a backlog of stuff to review, as well.
>>
>> We're still quite keen to get this patch included. Is there anything I can do
>> to help?
>
> Yes, testing and review. :)
>
> I won't send the series out just yet, as I suspect it could use another
> read-through on my part. But if you want to peek at it or try some
> timings, it's available at:
>
>   https://github.com/peff/git jk/loose-cache

Just a comment on this from the series:

    Note that it is possible for this to actually be _slower_. We'll do a
    full readdir() to fill the cache, so if you have a very large number of
    loose objects and a very small number of lookups, that readdir() may end
    up more expensive.

    In practice, though, having a large number of loose objects is already a
    performance problem, which should be fixed by repacking or pruning via
    git-gc. So on balance, this should be a good tradeoff.

Our biggest repo has a very large number of loose objects at any given
time, but the vast majority of these are because gc *is* happening very
frequently and the default expiry policy of 2wks is in effect.

Having a large number of loose objects is not per-se a performance
problem.

It's a problem if you end up "faulting" to from packs to the loose
object directory a lot because those objects are still reachable, but if
they're not reachable that number can grow very large if your ref churn
is large (so lots of expired loose object production).

Anyway, the series per-se looks good to me. It's particularly nice to
have some of the ODB cleanup + cleanup in fetch-pack.c

Just wanted to note that in our default (reasonable) config we do
produce scenarios where this change can still be somewhat pathological,
so I'm still interested in disabling it entirely given the
implausibility of what it's guarding against.
