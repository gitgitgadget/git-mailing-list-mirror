Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928EEC433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF14207FC
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3Qz3l9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgHDV6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgHDV6G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 17:58:06 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5488C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 14:58:05 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id v9so10860401ljk.6
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 14:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6MC+OizMixyqwySAL8sAXOdjRjbQkOgYOOal73+C3Hg=;
        b=L3Qz3l9iNaVliLry+WivUihB7JHZeeGtlEadgoJGxfHjt+omUZMzdX6JUHOc0GPAmZ
         m3wL2Me09flewd3R/o3wD5gWo5MiematMuYy74j8tm3upkDBkOB9qNTVFho9np99Bn9Y
         lI+VzPoGc4FKqS9+VHwrhOXWWCIp8k8Z08aVZojdHMLLFdMQtC1++W+Bd+zUY4d6TZqO
         l9GgosolO0uPwpGPbx2x+2/AsY0eerrAk30p6LUKjR3BMp87624bjPiO3p/IQdXgyFml
         MKPdxn0GYz5Mxtp6IV9fSu2O8XiW6mnZiNVhGwMwf4gm3EF10D0a749eNRMRZJpVW0Gf
         J9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=6MC+OizMixyqwySAL8sAXOdjRjbQkOgYOOal73+C3Hg=;
        b=ZS46rFR4Su6/R2WQZcOKaSwEd7QCnahDQChuV4F30Jkzed7RR/LUtJLUIxbvybsQ+4
         LL0K0xb2c4pAnE2cS3CFl6aCreDfOrZScsJsafhqB6I3uGf5pXr3m5leqLtk3sRpY6WO
         wBWTtI8ucPFPK7z7lafw38zaw5sKYTDuufb9I2i98ReQd+4m4p4WvOCxloD34wqA85Om
         nBGfUOsMN9Wka+I1mq5HVlkfWc1j0kkjD8r04qt9OFdYxulfJPyX+B8cRu6WbgcXqrRl
         wUUzP3DC4lCyiHj9lRB2Gxg0ug3VF+CRU4YtAUzXTYFtqtlu9IYDWn++W3fG//qZSBWM
         7yBA==
X-Gm-Message-State: AOAM530n/Nzq3s4dzsRKP//eDuv8NpKEXjACMDk2emqliUa9wrG6MQtH
        hVkOkADpBP/EzL5UyCNz/+U=
X-Google-Smtp-Source: ABdhPJygxT/7GEa3zBN+hcn0OKR7c6TQ9mc4BxlP2YNF4GlbTiHTsHALmvjRe4Mvu42wOG0Dnf+HQg==
X-Received: by 2002:a05:651c:216:: with SMTP id y22mr92618ljn.329.1596578284253;
        Tue, 04 Aug 2020 14:58:04 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b81sm114570lfg.60.2020.08.04.14.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 14:58:03 -0700 (PDT)
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
        <874kpi47xj.fsf@osv.gnss.ru>
        <20200804195830.GA2014743@coredump.intra.peff.net>
Date:   Wed, 05 Aug 2020 00:58:03 +0300
In-Reply-To: <20200804195830.GA2014743@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 4 Aug 2020 15:58:30 -0400")
Message-ID: <87imdyxedw.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Aug 04, 2020 at 08:50:16PM +0300, Sergey Organov wrote:

[...]

>
>> +		} else {
>> +			die("--diff-merges: unknown value '%s'.", optarg);
>> +		}
>
> A few nits:

I missed this the first time, sorry!

>
>   - we usually don't have a period at the end of our error messages

Oops, I got the dot from

  die("--unpacked=<packfile> no longer supported.");

in the same file. Will fix.

>   - this should probably be marked for translation, i.e.,
>     die(_("translated message"), optarg)

OK, will do.

>
>   - I think other similar messages are more like:
>
>       unknown value for --diff-merges: %s

Thanks, I'll change wording to this one.

-- Sergey
