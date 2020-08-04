Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B32CC433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 20:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7792086A
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 20:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGb19iQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgHDUz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgHDUzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 16:55:25 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B044EC06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 13:55:24 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d2so17479041lfj.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 13:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wgdV/trZ5j4Jlv+O48FbwfwaNQTQIFn06/0TXelKcOM=;
        b=sGb19iQdVcVa6rMAHhK0k5CjjuxwLIoidBR/fLYwgQa+yFLqupV87bKqzZBJXTsjj8
         /K5shhrvfzFtk+a5loHxd1Z3IBNh/quafAYVlfFZbB+sDRPHbR9dJEAk9TGgnlUiKEL5
         DhZUURSWIpu2/KqW37HuGvizoKEDDiCcjJduxygyabjtZ1zMTMwMD9u8IPFCDZ+oTYab
         uf8KU7XWX/Tnb1n2/VxOPfJCDR4OJIrz5qT4zwOK6Jmmq8q2EpCpK84/1OpN8Kd2M8hO
         EwHcFYQQ9zxak9noweZliiRt4pjIwNqyBucmiUaoWd9HYYcL1G60PGBu7WMEvExYRWpN
         ZZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=wgdV/trZ5j4Jlv+O48FbwfwaNQTQIFn06/0TXelKcOM=;
        b=fpVve2l+I4INclCjrgI8MfkTVAZeAHG99A7Jl+WvLACkkuii2E++iDSqKDvVv/r1sT
         DNH0izaCsGdL5mSqK6JR4mtvDPxt65Froi+bivJUWAcwdTwSqY8Hqd+NGlpbfnUqtkUU
         ZiriFAE+VQLyucZl8dLmOxcUOKSxaCsJuv6SmSn7lSq8TEgp6fyH3vB6HzDEBvObVpCt
         c0phTUJcjSOVvt75uqksdI6W3EHOT9WG7Dr2whweZF2K0TmZDc8PnZInq/nra4Z/K+6B
         yzhJQxvfmjg9jPdFToxx/iQ1KxIy6tBeU6D2OoohILBB/LbIm1Q5n/kcv9V80kbn6CoE
         1bhg==
X-Gm-Message-State: AOAM530CUvaTlHAE1VEGwj8uaqkUbQ0Be4TxsMZBzA56prpnScBRD0u3
        c5BbBSDfniWGZe4U2fD5JEo=
X-Google-Smtp-Source: ABdhPJwXn0FAFg+Mffk1s4sAu+h94rgcHLSt20R24YuuaPxh7am6T7Xn86DaQfSI7Sw0G98kmhil/Q==
X-Received: by 2002:ac2:4d31:: with SMTP id h17mr23591lfk.144.1596574521345;
        Tue, 04 Aug 2020 13:55:21 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j26sm1608539lja.111.2020.08.04.13.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 13:55:20 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru> <xmqqbljqrydm.fsf@gitster.c.googlers.com>
        <20200804200018.GB2014743@coredump.intra.peff.net>
Date:   Tue, 04 Aug 2020 23:55:19 +0300
In-Reply-To: <20200804200018.GB2014743@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 4 Aug 2020 16:00:18 -0400")
Message-ID: <877due1688.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Aug 04, 2020 at 12:42:45PM -0700, Junio C Hamano wrote:
>
>> As a minimum patch, I think it is OK to have just 'all' and 'none'
>> (not even c or cc, let alone the one with ultra-long name whose
>> effect is mystery) before we let the result graduate to 'master'.
>> Others can be added on top, as the primary focus of Peff's series is
>> to make sure "-m" can be countermanded, for which being able to say
>> "no" is sufficient, and the primary reason why we are further
>> futzing with the series with this addition is to leave the door open
>> for later additions of different "modes" in which how
>> "--diff-merges" option can operate (iow, Peff's was merely on/off,
>> but you are making sure others such as <num> can be added over
>> time).
>
> I like that suggestion very much. It solves the "optional arguments are
> evil" problem without having to worry about the other bits.

So do I,  will do in a few minutes.

I only don't like --diff-merges=none (even though it sounds great for
--diff-parents=none) and used --diff-merges=off instead. It's not a
strong feeling though, and I'm fine with whatever we decide.

Thanks,
-- Sergey
