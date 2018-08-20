Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 040131F954
	for <e@80x24.org>; Mon, 20 Aug 2018 21:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeHUAVI (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 20:21:08 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:52693 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeHUAVI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 20:21:08 -0400
Received: by mail-wm0-f50.google.com with SMTP id o11-v6so874867wmh.2
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QYyGgPNgN3J0aRH9aM8zfbaepbxF0BRVmIb78F/eT8A=;
        b=Rfeh7Tg8Ho/HVuzUEFs82pK/JEFmkGeCiSmvhvSSyAJl5I5aHV/iQl4C57IfR58KH1
         5KQ0WDKnPGWvkCAETet2+grrm1Lb+3keewDdEwJyVY2BvAHuGSKxUaLHFk/qOavfJzDs
         j7ie9YJiewTL1s4UzkYwrtTf3UHGsYH79mtQa+GFrZmX9J9Dk6hY5mzb7twHFlr2AX4N
         G27eTd76rdKxK0OStvn72odKgR9RebtWxb8K23XsL9SbQJqLc2VJn/oSrAvfUqNMBRUe
         cnpOWdAgkzxXGqIWpIhatW/MpeA0gqROckv7CXxQDcrXAvEnzClpXm8SfukwztemGfYD
         6FGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QYyGgPNgN3J0aRH9aM8zfbaepbxF0BRVmIb78F/eT8A=;
        b=rD1MCjNKjZCuj6+NEQyj0NOjVTnIEDkuUQlbl20y9wjqu/lsyd7NhtSU6v91GVkiv8
         a/J+vmCQXgPZA+0lYkPtpE1yO1gvTCi8sv2JbZuxiT2zVU6HISzyj/00brqYZ4dXWoK5
         qr5jBnAngZS0ua6/c1tMFJe/l5Fa5bEbSiI8sHlOLnY8HiUHQL9tPRgC2ObKg9W9LMKz
         FnBIg+DvT/k5LcTAaQlWOkkbLk713TX119/hYlPVoQ/cESVzQfEFsxjy+gjudiK3GasP
         KvozIyNhEroPi/pXe+lk0IvLqoikLu5GtLSJS/8YXTeCn+HpGwPl5kcH8eDE3YMm5Pga
         HF7A==
X-Gm-Message-State: AOUpUlGt2wZGlTsDCwDD9as8hlV9ncNR9KKp5N8Yzf9nSQlRmJzuaZQ7
        7I17Ao1QKWhF2K0Ty5xd7LIZ4VOF
X-Google-Smtp-Source: AA+uWPwrQQXbJRSoNB9LK31kKiSt86y0aHUh4qZk6C6ynnV1FrGHTH5hjpKJ9KxgnYtHk5URtogM2A==
X-Received: by 2002:a1c:92:: with SMTP id 140-v6mr24928865wma.87.1534799036062;
        Mon, 20 Aug 2018 14:03:56 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n12-v6sm7753036wrm.62.2018.08.20.14.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 14:03:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] pack-objects: reuse on-disk deltas for thin "have" objects
References: <20180817205427.GA19580@sigill.intra.peff.net>
        <20180817210604.GF20088@sigill.intra.peff.net>
Date:   Mon, 20 Aug 2018 14:03:53 -0700
In-Reply-To: <20180817210604.GF20088@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 17 Aug 2018 17:06:04 -0400")
Message-ID: <xmqqa7pgbvie.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> And that's exactly what this patch does: when we're
> considering whether to reuse an on-disk delta, if bitmaps
> tell us the other side has the object (and we're making a
> thin-pack), then we reuse it.

That's really the natural extension and logical consequence of the
"reuse existing deltas" mechanism from Feb 2006 ;-)

> So taking all of those options into account, what I ended up
> with is a separate list of "external bases" that are not
> part of the main packing list. Each delta entry that points
> to an external base has a single-bit flag to do so; we have a
> little breathing room in the bitfield section of
> object_entry.
>
> This lets us limit the change primarily to the oe_delta()
> and oe_set_delta_ext() functions. And as a bonus, most of
> the rest of the code does not consider these dummy entries
> at all, saving both runtime CPU and code complexity.

Tricky ;-)

I wonder if we can move the preferred base objects that we are not
going to send also off of the "main packing list" to this new
mechanism?

> +static struct bitmap_index *bitmap_git;
> ...
> +static int thin = 0;

Please trust what BSS will do to your static vars.
