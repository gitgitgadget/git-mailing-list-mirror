Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C72C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 16:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjDRQ6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 12:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjDRQ6X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 12:58:23 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B980E7E
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 09:58:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w1so5183532plg.6
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681837102; x=1684429102;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Twvl4h8IXIJi5yhxuBjF58wB4ci/fRW4wC9TFRx29EA=;
        b=su2XpRDoPBvNFH+Z7L6akoBjtr/cVlyDJoXasfQ3/f5SAHEylSxFAJMJjmL4NhsExL
         /iwA1eyhgNcJZ89o2Q0v8EwXEfD5Fa3ucynTmn6M3BzkzOiw2Ir2eMLUQE7Bw3Hrybrv
         dlyYcpGcDn8Rb4jrMPZ+fabE8O4R3AeJFh9NbYDHJJTK9Ezx1KX9xezhHqzR+XHOADwH
         pht/eU4vT6/+TzQ+u1DRwUEypey2nZY/k2Nn72FD5svdqgE1XvTK1UeJ/dN9LXTIVuBf
         WFcWs29XL+zHVv3nMgvsk+5pRvi71yHzWcpRey2mJTYmXeMTKbm1jPxACCFi6mMUSNQ6
         JYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681837102; x=1684429102;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Twvl4h8IXIJi5yhxuBjF58wB4ci/fRW4wC9TFRx29EA=;
        b=F4wYM+12IRJHDV+jSFLMuPMw5y62dVE/AREb1kpT3InKK3a0IeAtFj40axP7dMty7n
         08EHEwfmk1FTHVuGtCoPXwzXqFjojMZtZsiIv/OMCdmyUga6UVyTQjowGPAwSZ5ZZsx3
         ZvexaXdQZxJEBGx4ZjoqHcOa6X4r3rjDnmSAyxTto/mO4bJCgk8oEW5EFeIo78ix/pY7
         aZzLK4UC4LB9DbB5PtcLsBLaSa0kHTKLra7Rw8DKVXK34V/htaGhVXJH7Z/peoiVK5r3
         suq4z1O5rVQxcAe3NP8YpwAmkk7rJpVfNGI1QV3we7qCm7TFtem8DCZ4GCcs+QVm5AVc
         Hc9w==
X-Gm-Message-State: AAQBX9dNgK0c6awThil/lT6hW6I+5AM1Sr4nMMNgVHQoaB0C2ZJ0xwoe
        dMCQNqfJSkN06DXFEh/WdhE=
X-Google-Smtp-Source: AKy350aTS6LzFCqtTYkas7ykCepubxdggh/p3FVCNqyHvqy/rN3BjcOmUm4Bw0aKD6ToezMPQyJqxQ==
X-Received: by 2002:a05:6a21:6d91:b0:ec:7705:2f18 with SMTP id wl17-20020a056a216d9100b000ec77052f18mr503268pzb.27.1681837101671;
        Tue, 18 Apr 2023 09:58:21 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id a12-20020a65418c000000b0051f17e4e1b2sm1635663pgq.68.2023.04.18.09.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:58:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: tb/ban-strtok
References: <xmqqfs8xfw25.fsf@gitster.g> <ZD6vu6H0xzLSF/2w@nand.local>
Date:   Tue, 18 Apr 2023 09:58:20 -0700
In-Reply-To: <ZD6vu6H0xzLSF/2w@nand.local> (Taylor Blau's message of "Tue, 18
        Apr 2023 10:56:59 -0400")
Message-ID: <xmqqo7nldt5f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>>  Mark strtok() and strtok_r() to be banned.
>>
>>  source: <cover.1681428696.git.me@ttaylorr.com>
>
> This one needs a reroll to remove `strtok_r()` from the proposed banned
> list, and to support slightly different semantics the new
> string_list_split_in_place_multi() function. Will send today.

I actually do not think we would seriously miss strtok_r(); as long
as the rationale for doing so is clearly described, I think we are
OK.  Just do not sell string-list as if it were the solution to
everything (which is not---it is a rather poor data structure), but
compare string_list_split() with strtok_r() and say our application
hasn't needed the flexibility of the latter.

Thanks.
