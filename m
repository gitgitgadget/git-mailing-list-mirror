Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC70BC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 11:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE2B60FE7
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 11:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245557AbhHFLd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 07:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245540AbhHFLd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 07:33:59 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15A7C061798
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 04:33:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u5-20020a17090ae005b029017842fe8f82so7970049pjy.0
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 04:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version:content-transfer-encoding;
        bh=Du0K7KLhhp5KjajBsLb3BttNvy4lmV0b64+GAwZqs1M=;
        b=oNT5Z6YfcE70+DYiMqeEe5LmrHjrbyw+MnKLsKp6/axfoUniUkbktVznxp6Y2uKCGN
         6QxIG1PNFhkPITsmy/v/GcLDjVGzDkrWL/w4+x2WznXPvsAMXAJeNubKUPsjRL0WKnrW
         skDpZ8tAs8RHLCXXQCNcTbNQBQEcFzUoK6uGoUKRPXZUYfmzVlq1fjyBfl3VGY4rd9jy
         auZwwjHPK+NJESKQAlzARFz9OyyHd8Aa1MDoS2Sn8UYU9KaCYRTe0MeQzgXxaIeOT9UW
         LvNJfVbWDbA2TN5Wt9quIfZH7HQhQdnkTrvjDwoHx3Pg3IM7L1GrTnQqS08GlgTxToBb
         5JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version:content-transfer-encoding;
        bh=Du0K7KLhhp5KjajBsLb3BttNvy4lmV0b64+GAwZqs1M=;
        b=QP49DMhS+wI0MnSsl3xtO5cwldyYfQawtn0L3QI1niygMQYZXWSasl8I9wPdchFmkN
         INwftHbjJx1G0InZk6LvPIVD1xUqROZ0+OgjjCOkytvq79TVVVtfXaLZJPPqMJnOix2b
         uCY7qf9iQ68Y4eEVvGX5FgX/UuDDrL501vDY85NEVjrJ3GQRF9YcpRUPT7JUhvm6t7Od
         qvIircxit8LUsf2zg5eFlzTFmSYllpJME8ohcyG7EbVztaTS2PoltPgva87aE88wBcYU
         A1mDtsIwHSz2tB7tahbRJ72f2S+ClTHQhKzNcfNn4xmh01byFbFwzkmzI0517BHXVG3+
         EDCg==
X-Gm-Message-State: AOAM531vzqKHbHZCnqf23yELagkAAGMiUp3cuZ69rEk9jcGzq0HJuDCu
        uYlkEuTYsRmlqvC1VV05vXM=
X-Google-Smtp-Source: ABdhPJz6QdymI3qoxutFz0EKb1Yl6K83sDobiawpRy205DnH0tsyKTEJcbaB9HuUNYze+SFwuY2ubQ==
X-Received: by 2002:a65:6704:: with SMTP id u4mr370682pgf.40.1628249622313;
        Fri, 06 Aug 2021 04:33:42 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id g25sm10396153pfk.138.2021.08.06.04.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:33:41 -0700 (PDT)
References: <20210805071917.29500-1-raykar.ath@gmail.com>
 <20210805074054.29916-1-raykar.ath@gmail.com>
 <20210805074054.29916-7-raykar.ath@gmail.com> <YQyNDv3bzVZwpAVl@danh.dev>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [GSoC] [PATCH v2 6/9] submodule--helper: convert the bulk of
 cmd_add() to C
In-reply-to: <YQyNDv3bzVZwpAVl@danh.dev>
Message-ID: <m2wnoyu7sf.fsf@gmail.com>
Date:   Fri, 06 Aug 2021 17:03:36 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.com> writes:

> On 2021-08-05 13:10:51+0530, Atharva Raykar <raykar.ath@gmail.com> wrote:
>> [...]
>> +		add_data.sm_path =3D xstrdup(argv[1]);
>
> add_data.sm_path is allocated in this block (regardless of legs).
>
>> [...]
>> +		if ((exit_code =3D pipe_command(&cp, NULL, 0, NULL, 0, &sb, 0))) {
>> +			strbuf_complete_line(&sb);
>> +			fputs(sb.buf, stderr);
>> +			return exit_code;
>
> But, we don't free it when return from here.
>
>> [...]
>> +
>> +	if (add_submodule(&add_data))
>> +		return 1;
>
> And here.
>
>> +	configure_added_submodule(&add_data);
>> +	free(add_data.sm_path);
>
> However, it will be free()-d here, is it intended?

Yeah I meant to have it free()'d wherever possible, although I suppose
it isn't strictly necessary since we exit.

> I think we may use UNLEAK above (for now) because we will exit process
> after this function.
>
> However, I anticipated we may need to do more stuffs after this
> function in the future.

Right. So it's better I ensure that it's freed properly everywhere.

>> [...]
>> --
>> 2.32.0
>>
