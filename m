Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA904C4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 10:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A15C021924
	for <git@archiver.kernel.org>; Fri,  1 May 2020 10:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYljRAQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgEAKWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 06:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728229AbgEAKW3 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 06:22:29 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5A8C08E859
        for <git@vger.kernel.org>; Fri,  1 May 2020 03:22:28 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id j3so2201165ljg.8
        for <git@vger.kernel.org>; Fri, 01 May 2020 03:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ggWDg1FRNSTc5AOXjGR4HwiShADl8XrlJBpnbA+LnPg=;
        b=FYljRAQ1uGzR9mxhoNI1rl+ENwapUjOQ1oceQdrVB3lsInMxzhK50Kn/qww6eeQ01a
         9bF1Fv1MPD2XLlMb3guzg+q/mpYqq3H2tepA9NDgjhIvlq7Ist2pxQUwESIILWkI14e5
         NoCmnW9b905dSsxPwC3O0k2BR3QGMOCAcw/p0rdgBTAGyZoDyKJyf7FcJ6ID0rjRAc8c
         PA8Y2Y3bJqUXGmpdE3uRUATq270Q0mHp13k9xNQ9FBwWUB0foqV2J8dW4HnvjJloWa3k
         G1OIYezZ7ylGa+zG58LZbTP+hxYNmy4vEKMw3TXYNqzPYKIFBWB42StVnlN7PT155cKD
         qjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=ggWDg1FRNSTc5AOXjGR4HwiShADl8XrlJBpnbA+LnPg=;
        b=eSN1NFLSCL4Bk0L9jvRplwitF72aIvbTdGrR5QQwNeAf9cPj6M5HlUHnqMIzUFZS1Z
         RL6WbKJanolWHPS+1W0rdXe7y2ybXpXVCAfWP9rRA+Vun7IuS3+o2z7ygoDY6ZRMRwMf
         0iSyXtinwJAT63aJtUnLP/TMWiWEWpQME7o829a6MVyKI0Fg5EOk80nNR65UQBhbOck1
         cAMH5Hh5VNJYCQXoqWKEKxThs8wy3x9Tu34nHCKoym3C3H2qFb1SqUN1mPnStItDA+Yu
         PCC4YeffD+qvMlsRvr3jHRVLDY1VrT8z7LsL5esRebeCGcZOxBo2OUVOqS4rcKyPYh9h
         rqlg==
X-Gm-Message-State: AGi0PubW0QbzyM2xtqkjtv1JVpdAXF0YMtsro4wc5fC32a5cjG2wLCTe
        BZpHDI0tVdkacZ993X064Yc=
X-Google-Smtp-Source: APiQypKavRTJKTWJw7BI2hq2nYeUDbP5fMUGsoUnvRz6ihxWG093eP2vUh0aHp4USMWwbgmtpISg/w==
X-Received: by 2002:a2e:910e:: with SMTP id m14mr1863214ljg.141.1588328547132;
        Fri, 01 May 2020 03:22:27 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id n14sm1903713lfe.31.2020.05.01.03.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 03:22:26 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Ivan Tham <pickfire@riseup.net>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
References: <20200429130133.520981-1-pickfire@riseup.net>
        <877dxyo1k8.fsf@osv.gnss.ru> <20200429190013.GG83442@syl.local>
        <87v9likr5a.fsf@osv.gnss.ru> <20200429195745.GC3920@syl.local>
        <87imhihwbw.fsf@osv.gnss.ru> <20200430162753.pg6kpm6jlubotjlk@carbon>
        <xmqqbln8sqcv.fsf@gitster.c.googlers.com> <87zhas3teg.fsf@osv.gnss.ru>
        <20200501094432.u3bl24qou5sgbgxk@carbon>
Date:   Fri, 01 May 2020 13:22:25 +0300
In-Reply-To: <20200501094432.u3bl24qou5sgbgxk@carbon> (Konstantin Khomoutov's
        message of "Fri, 1 May 2020 12:44:32 +0300")
Message-ID: <87r1w43qfy.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Khomoutov <kostix@bswap.ru> writes:

> On Fri, May 01, 2020 at 12:18:31PM +0300, Sergey Organov wrote:
>
> [...]
>> >> I would speculate that `git checkout -` may have learned about "-"
>> >> simply from the `cd -` ...
>> >
>> > You do not have to speculate.  You only need to read what has been
>> > already said in the thread ;-).
>> 
>> Should I expect "git checkout ~" to get me to my "home" branch then? ;-)
>
> Heh, no you shouldn't: the '~' is expanded by the shell itself according
> to its parameter expansion rules, so `cd` never sees the bare tilde
> in this case ;-)

Yeah, but then git could compare its argument to $HOME and "do the right
thing" ;-) Just kidding, obviously.

That said, bare "cd" also changes to home directory, so bare "git
checkout" could become as useful.

>
>> Actually, that could be a good idea. I mean, to have "home" branch
>> notion and a short-cut for it.
>
> I have no say for the idea per se but you would have hard time using
> bare tilda character for that precisely because of it being special to
> Unix shells - you'd need to escape it all the time (though something
> like unquoted @{~} would work just OK).

Yes, plain '~' won't do.

-- Sergey
