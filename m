Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C5920248
	for <e@80x24.org>; Thu, 14 Mar 2019 04:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfCNEvj (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 00:51:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33884 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfCNEvj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 00:51:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id k1so3811243wre.1
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 21:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4c2bjXabx5+28PkzElqu4Hpp0z25erpqqMC2pSofa0I=;
        b=WC3ze8EPx+qeRd4zTaMG6DRiSndri1hmInH9S0hmb8RjC483aZcURY1ONCi5BlA9oV
         OXw22gaCFaO5NJVfsS0dTHu2MbLHI+owqeE+XtgV73I593cgV6/GaeOxo+G0GHr/ClFp
         WdcSi6j4gXb6XVQq/zeYtxopYvDe+L75GuMKL1RcndELtlXhfraqZaMeJag8GqVSm9bO
         cOBVtd/3qvmMkSZutUTHsAkwzVIScMoYcoWHLSBg3zjQneBzR5cwD7Nw/DjS4S2xcnuV
         b1mHpEvKaDSxhRKkzgtnIbccVaeijJ6FldueSkEvHujoZiH8a40VP3Ufrevbr12AubPh
         iQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4c2bjXabx5+28PkzElqu4Hpp0z25erpqqMC2pSofa0I=;
        b=mX7ZfNSEf/aCQebQwRVVubNP28AVzUYB7jgc6B0MpXXllFWqgXVTkmZI7SJbYq/irt
         BUdKkKHN1CFT7kdHHzQqUdrDbUMJX+5sjCuCTcLyoRze/rXuMotYC9hTzxclT0juoUuu
         +qHdHZq76ztGRdTBwdXimB5F7BaMpzwHdpAKo4GlZss5RI+I773RKkJRgtCPuFLu8xUt
         S+jQn9y2W8vZlLuPnQdqS5gax1BVqRSfMrBYfKKAQ+2FnWL1ATS4Q7SCgOIF6tq29/KE
         d0G0g8kzUkskWIVvU31jg1XLNb++/IJvq/LgXnM4/x8VyFcePuxqwmL6kN0CkXZf7Isq
         BBVg==
X-Gm-Message-State: APjAAAXH1M0Qm1s0TTxq7f/AfejIj4sJ+nDuRxXAe3fq5cI8FRTbIkSX
        pmAO6RWnfdrMPpx+kg9iDdyVZdsKr4s=
X-Google-Smtp-Source: APXvYqzlhw7MP4pdjc/3e6S0Vwai9ZUhy3EmimUM7rimAajr8rTdsn8dReR6eC2XiTW4XpUlJya0Pg==
X-Received: by 2002:adf:9d92:: with SMTP id p18mr25141138wre.119.1552539097124;
        Wed, 13 Mar 2019 21:51:37 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z9sm15244721wrv.59.2019.03.13.21.51.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 21:51:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] gc: don't run "reflog expire" when keeping reflogs
References: <87imwmbv7l.fsf@evledraar.gmail.com>
        <20190313235439.30439-5-avarab@gmail.com>
        <20190314004006.GI31968@sigill.intra.peff.net>
Date:   Thu, 14 Mar 2019 13:51:35 +0900
In-Reply-To: <20190314004006.GI31968@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 13 Mar 2019 20:40:06 -0400")
Message-ID: <xmqqmuly9hyg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Seeing "--stale-fix" again reminded me: that may be the "oops, we can
> spend tons of CPU walking history" bit that I mentioned in the other
> part of the thread. But I don't think git-gc would ever run with that
> option.

The option was a purely transitional measure to recover from a bad
reflog state that could have been left by earlier versions of
"prune" and "repack" that did not pay attention to the reflog.
Perhaps we should plan to deprecate and remove it by now?
