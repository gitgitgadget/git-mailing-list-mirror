Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE07C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 20:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E6672086A
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 20:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3FnVNSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgHCUZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCUZI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 16:25:08 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396BFC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 13:25:08 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i19so21142011lfj.8
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 13:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/H8E6cmsfzbQwq4clpswdGaZy5Sg1t3ofU6R/aBzbxo=;
        b=C3FnVNSpp/QJ5V9i81ua8xqZluyxiztqekwf9GdzMCHJL0LDI37l4Y7UDFzIF+xkJr
         6F9RFJMkplSb2HrS9Ee8FnM8uI+uaEs16FCUixiEL8qWXuj7xmECK5fFZlvAnGluM4VP
         zDVIqF8TsINKsZ7O4a9WZlxZ8ztFJ96Xu2HnXzBJCcotVUmiM9FIlH8qkIKz+VZXeeMp
         ZQcMdPt6JnxA4aySIXIEnsM8M9uiXqn9PlakJvc28iIkbdbqustw7cxO4RkL5aXeWM8O
         JLHXFe0kHq4ud36s5m8nuad2LGaB9EOv4Rw0UbQLFdF4sKBswFttgU9Vdws6MYPa4GaI
         zLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=/H8E6cmsfzbQwq4clpswdGaZy5Sg1t3ofU6R/aBzbxo=;
        b=kTCp+Ct+OVhLQ3XmYuaj320gn5wW9a1HE5AAZsbpDRVhd8tyxjah/+j/osrcogAqR8
         MpZ9ahSuNac74/hfl/w8tk28nOgRlDTzyHhy0B1ZemP9mb8+RZubznsSxFALRjxGOuX7
         MheZEcHcMzpJVLKjt+ESGBGcIQfdxIA7dBaDpauMQRJ+gzLkCWSUnmOWS/Wr1M42qG0j
         mySI2HHwRLPKUywygXOfXi1NRm5ZmdUp4I+yQsKuoAYYcO6lHOrCzlnpf18vy5jRD3pl
         OtLGKX8Q7DxLd1R119E6Y8UeJL5uV9C3DI/JsaJ1PS6fwOyagrc/CSAtJVOtnSVTTaMc
         cFow==
X-Gm-Message-State: AOAM531M/iwScQqpf8GaPEocNOJg+B5M08vbB5x9XkKZ0W2dY95Zfa6q
        jp+mt7DVO6+59MEgK3JHr2k=
X-Google-Smtp-Source: ABdhPJxNlM+53mVyU8riQDW73kBtiSZztINJsoZ5g2DcXXoVNt5Egto4KC0vzXu97Rs/Kil/ACsEFQ==
X-Received: by 2002:ac2:546f:: with SMTP id e15mr9480615lfn.133.1596486306707;
        Mon, 03 Aug 2020 13:25:06 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m20sm4599617ljg.107.2020.08.03.13.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:25:05 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru> <xmqqd047wuuh.fsf@gitster.c.googlers.com>
        <87pn87smw3.fsf@osv.gnss.ru> <xmqqy2mvve65.fsf@gitster.c.googlers.com>
Date:   Mon, 03 Aug 2020 23:25:05 +0300
In-Reply-To: <xmqqy2mvve65.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 03 Aug 2020 10:21:06 -0700")
Message-ID: <87y2mvqxy6.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Sergey Organov <sorganov@gmail.com> writes:
>>>
>>>> Sounds great, I only hoped we can do it right now, with this new
>>>> --diff-merges option, maybe as a pre-requisite to the patches in
>>>> question, but Jeff said it's too late, dunno why.
>>>
>>> A follow-up patch or two to remove the "--diff-merges" option and
>>> add the "--diff-parents=(none|<number>|c|cc|all)" option on top of
>>> the jk/log-fp-implies-m topic BEFORE it graduates to 'master' is a
>>> possibility.
>>>
>>> But is it worth the delay?  I dunno.
>>
>> I don't think it's worth the delay, provided yet another new
>> --diff-parents is to be implemented rather that using --diff-merges for
>> that.
>
> I was responding to your "it's too late, dunno why", as you seemed
> not to want to waste an option "--diff-merges" that will become
> unused when "--diff-parents" come and also wanted it to happen right
> now.  If you no longer want to see it happen right now, that's OK by
> me.

Eh, no, as I see it, I suggested to have

  --diff-merges=(none|<number>|c|cc|all)

right now rather than introduce yet another option (--diff-parents)
later, as well as to make --first-parent imply --diff-merges=1 rather
than "-m" (the latter in turn being synonym for --diff-merges=all), and
I thought that's what was rejected by Jeff on the ground that it's too
late, but as he clarified in his recent response it was not.

I mean, why introduce --[no-]diff-merges in the first place, if we do
agree --xxx=(none|...) is where we'd like to end up? I thought the
answer was "it's too late", but in fact it was an answer to changing
semantics of -m that I don't think I suggest.

As a side-note, my secret hope is for pure "git log -p" to give me diff
against first parent for all the commits, no matter how many parents
they happen to have. This desire still sounds like a job for
configuration option though, rather than, or in addition to,
--diff-merges or --diff-parents? We well can later introduce a
config to assume --diff-merges=<config> when no explicit
--diff-merges=<value> is specified, right?

Thanks,
-- Sergey
