Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F483C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 15:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BECF20825
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 15:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSU3DXPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgHCPrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgHCPrY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 11:47:24 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF45C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 08:47:23 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i10so5411824ljn.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WdCjpCojhGnc7aFCvuPymFLwkb0H8Mla6T2A3YNPg20=;
        b=sSU3DXPqSSPkCNg/dcFbD12G5ANYV/nI8nvUKOaBCVwnvta6BSBOfl/unq/CtzJU+s
         fMNu4bEF4oO60rMxBXxGb60aPCoz5aPuaX72opfjbHifPosMRWgrPMXGc33I4aBB/ce7
         HRz9CsSyhUsLVyFtxz3y+875g4jDzw9kNbgz8TcNPRIVhWvWXXOcMIdiym43Opsclyb5
         gfFCrZL8eDHO1oFJDd+Okyg8TLfumbObEAbAM047h92sXQSjI0ncsaj1+emlOZybBcVn
         NCoTNTvjSG25/pb+0rOnxbMLqMcd0dfLZCZCkJKjaBttGecr1m/+/ywpexJYW7fGjigX
         hTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=WdCjpCojhGnc7aFCvuPymFLwkb0H8Mla6T2A3YNPg20=;
        b=Qr3mnAxOybRRFaNFjENz0KYWkwSzTWg07Bes5XOJiapcQSUj5y0DiChS/9vTKFdYlW
         1LeRRRq5rGoYGQjDzimHG9fW9gA/wEaqVsGX8LB8HPliS7Fvkjhw4lJGlC3QYlXv1KRQ
         PFd3RqJTlY0y3EEIbiAB3SZ/eYOsLhTvRYRfULK1k28LsqYSFXaDszlgtxqZLz0VOcKA
         glTDjKaMl0ZnRQd9YErNcDrpU4GTDBddbT9cnwUuQqv/l4yZJjDoeEmtAv72Q9VtVD8O
         AIw0Oa9MVw1YGmx3I6h0614zSs9JlYL54Lux/2oVDiQHoJZJ7g6lLaFasALK+Y4jYtPQ
         znzA==
X-Gm-Message-State: AOAM530Xwxfu6qZjiLfSAE1qSsLe3n8J14K/Jfy1+AgiBXrgHZr5TiaX
        PZfoFKYGwl+2RykjPSfQEEzJMKl5
X-Google-Smtp-Source: ABdhPJz6Fui6JtCIvnGNvKVTSK5mC2atLqkh+Lg1nt6oNc28l5h6MW/dffvf9Vr3o/OTdon+ormnHQ==
X-Received: by 2002:a2e:9550:: with SMTP id t16mr2239566ljh.372.1596469642241;
        Mon, 03 Aug 2020 08:47:22 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id a16sm4983601ljj.108.2020.08.03.08.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 08:47:21 -0700 (PDT)
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
Date:   Mon, 03 Aug 2020 18:47:20 +0300
In-Reply-To: <xmqqsgd5rlwi.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 02 Aug 2020 10:35:25 -0700")
Message-ID: <87o8nrybnb.fsf@osv.gnss.ru>
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
>> What I in fact have in mind is something like:
>>
>>   --diff-merges[=<parent-number>|c|cc|all]
>>
>> to have a single point of definition of the needed format of merges
>> representation.
>
> A command line option that takes _optional_ argument is evil; it
> hurts teachability (e.g. "why does this option always require
> "--opt=val" and refuses '--opt val'?").

Yeah, I sympathize.

> Making the optional value configurable is even more so (e.g. "teacher
> said to use '--opt', but it does not behave the way she taught---ah, I
> have this config").

OK, let's drop the suggestion then.

>
>> Then comes the question of the default. "all" is what'd make it behave
>> as "-m" behaves now. If it's too late for --diff-merges to have
>> different default, could the default possibly be a configuration
>> option rather than yet another command-line option?
>
> Introduce --diff-parent=(none|<parent-number>|c|cc|all) that is
> different from --diff-merges, and -m and --[no-]diff-merges can be
> defined in terms of that, at which point we can gradually deprecate
> them if we wanted to, no?

Sounds great, I only hoped we can do it right now, with this new
--diff-merges option, maybe as a pre-requisite to the patches in
question, but Jeff said it's too late, dunno why.

Thanks,
-- Sergey
