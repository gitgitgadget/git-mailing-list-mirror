Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909B9C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0A261058
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhKATpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhKATps (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:45:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C714C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 12:43:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w15so68106930edc.9
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 12:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=OrpqhricrH/tg/qVsW9/OKSosPIHcmGgISiFxJF6J3U=;
        b=JAJ3Nfz4pYkITmUP5NFLAwIE80LCo9rhpOI1NguMtHiceNw2A7p2TMFNNwAl7tNEaP
         RNgTe4MNnWtdw02kdtn27GYWZuDm2rvbDumzqerPYPaDaJJWa3K1//IaYx76iqjCKQRw
         IIY+CKfOc861zkLD/tTaFy1eNGA0r5pD+MYKnMTSO8O1Scf1uUZ8Gfae1VFEIzDIwmbz
         5svg9a4MkxrYpEaXF8SnGJXpqVSbuPVrXt2TrKKkSZwATZRGbmjlk8hfLxNfklwYwRSE
         9ZFpw2oN0qjkGUraDUC4q7e/W0ZTrWxEXglPq+ht7fjPsbL/gJFuZGF1oUPWgcgCj0Im
         YskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=OrpqhricrH/tg/qVsW9/OKSosPIHcmGgISiFxJF6J3U=;
        b=QCsH7bI0Z4xclNypdw15p+ohJqPsOu2xXHNHkIrzWoEaYFy4/NYGNuBeO1MMi0nt3w
         6RVhZCskuwLW0L25/KqtUPP3x38cyRcPecggTEe7pIvL+Tu3l2zKwzTjxwwG27gSMlNo
         OiSOwnoI9lnR3n/sAV0L5ehcoAXUow2hJxJgRtSoHdDGz46fjBM+28LlthIh5X7tpSvD
         mgxi3rP3/RMiF1Uf3wKdyP5gq4o+X9WyI0oGnPYKctiJ9dUwYgFYyp/qj1Q5nudCx2bP
         dJo4JirGB7Zfm4wEiBy0kfmQMGFQzcyNkWHo+C2tCz3Sa8zD74PsTMiFD+iE719oGC7Y
         J1Hw==
X-Gm-Message-State: AOAM531nBt/dPlHb3clBX6oz9gCP7dFD6srOkyqYIwUZHSf6+n7k7KJE
        j/AlCZOXDi3vZKAZm7Y7lS6D/IJ8A3OrJRDM
X-Google-Smtp-Source: ABdhPJw6EP8AQ97HncbkDBBEW1aDlsEFbXPUgd59P9m0Qw7L4fs3nyqldMuXKp5t4BeHTruNcZa4vA==
X-Received: by 2002:a17:906:4b57:: with SMTP id j23mr17356280ejv.563.1635795792807;
        Mon, 01 Nov 2021 12:43:12 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ne33sm1094907ejc.6.2021.11.01.12.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:43:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mhdD6-002Bkg-2E;
        Mon, 01 Nov 2021 20:43:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Maksym Sobolyev <sobomax@sippysoft.com>
Subject: ms/customizable-ident-expansion (was: What's cooking in git.git
 (Oct 2021, #07; Fri, 29))
Date:   Mon, 01 Nov 2021 20:39:51 +0100
References: <xmqqr1c3e57a.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqr1c3e57a.fsf@gitster.g>
Message-ID: <211101.86fssf3bn3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 29 2021, Junio C Hamano wrote:

> * ms/customizable-ident-expansion (2021-09-01) 1 commit
>  - keyword expansion: make "$Id$" string configurable
>
>  Instead of "$Id$", user-specified string (like $FreeBSD$) can be
>  used as an in-blob placeholder for keyword expansion.
>
>  What's the status of this one?  Meh?

I reviewed this the other day, but that review didn't yield a mailing
list message.

I think some of the seeming re-invention of "struct strbuf" is a bit
nasty, but in trying to see if I could replace it I came to head with
existing code that this was extending, so it's nothing new.

But as for the feature it's clearly useful to some, and helps SCM
inter-op, so even if I'm also rather "meh" on it I think it would be
good to merge it down, it's clearly very useful to its (small) target
audience, and doesn't seem to be harming anything else.
