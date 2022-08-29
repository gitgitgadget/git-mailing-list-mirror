Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A47CECAAA7
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 18:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiH2ShK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 14:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2ShI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 14:37:08 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D13E7E03A
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 11:37:07 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s206so8469846pgs.3
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 11:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=X+uHigOrTGxd+ooyV4FXfAGMUdD/GqEuWFziF8mH4rs=;
        b=Ig9T/Rl+B4cORyiEyH7/A4L3ecCAG67W9YYYmRD7Nze7VZ6N4at59Y5tNdW625lEdZ
         krN9jTO7PQ+prm7I/8cNdm/xkO5VZXdCuCdFm34TXrbelrlr5RxXjp58Yc8oDKJtHprn
         AEZiZOuJGDrxXp06zOR4PGWUq/JRp1AWyaDfn+1fl39A7zy3oaSD+FfMELRvUoJlYx9a
         pVO9oCC2szbxk7hgVvUfsfuEqP/TVS5qREhzIPU1ZqoMJ1Flfa66JoqWcUeErQoykv1m
         q45jn7iTTTEILA9NVUFrL3gQxV+cbCD11tp0V+fIYe9muCPdXA5BdroUoD38gJF4qIlK
         wBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=X+uHigOrTGxd+ooyV4FXfAGMUdD/GqEuWFziF8mH4rs=;
        b=lHin/ZPpmeHyDdJR18jdo3HmGXUgL+NuYWoaZos5Ela0UdRghihMJDtxa/E4mj+uJ6
         3Uq+J3bSal9n+mZztxPwIhae9At1ptMxp0gVFvSz/UM2jXaiKZtfp6pj+vRP9wICHY/k
         07QWWVJPXjSidpEEeZgSC73uinu0axubI9JHM6dXWJsMzPd4Ig8To/D8wad4pGFCC5CT
         zTIx0P1I9QI0JAj/d7VtMqBjHSKwRTOhGMfYCbCflg/z5xvIoeKhpR6vKsyvgtgnQ2oi
         mGGSvSZK7zAcGK7U9E+cuULEVOKHwb34jNJW3bM5IttUOh5uakejox8lRl01dzSPs98X
         LitA==
X-Gm-Message-State: ACgBeo3kLIZoTaIc2czDVgnRszFeBVVXgyv0EEpIQqKMXgAUOKILoNiS
        fNJImNInn/mpJIPd4S3vjKA=
X-Google-Smtp-Source: AA6agR4dK0hoPnSTN3XKwxv+cMUgVV7fTV5HYrJstQFURWI1i8QM3z4Fp0JFO5/TldyYdw4EMBkI3A==
X-Received: by 2002:a63:6a04:0:b0:42c:13fe:d2da with SMTP id f4-20020a636a04000000b0042c13fed2damr5483173pgc.298.1661798226432;
        Mon, 29 Aug 2022 11:37:06 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h188-20020a6253c5000000b0052d46b43006sm7563326pfb.156.2022.08.29.11.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 11:37:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, alexander.s.m@gmail.com
Subject: Re: [PATCH v2 1/1] diff.c: When appropriate, use utf8_strwidth()
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
        <20220827085007.20030-1-tboegi@web.de>
        <0q921n79-sr17-2794-83r0-r59rnqq03pp2@tzk.qr>
        <20220829175425.cmbwtqpxrq4ppnnk@tb-raspi4>
Date:   Mon, 29 Aug 2022 11:37:05 -0700
In-Reply-To: <20220829175425.cmbwtqpxrq4ppnnk@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Mon, 29 Aug 2022 19:54:25
 +0200")
Message-ID: <xmqqwnaqnbfy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> This is caused by the logic in diff.c:
>   /*
>    * Find the longest filename and max number of changes
>    */
>    for (i = 0; (i < count) && (i < data->nr); i++) {
>        struct diffstat_file *file = data->files[i];
>        [snip]
>        len = utf8_strwidth(file->print_name);
>        if (max_width < len)
>           max_width = len;
> // and later
>     /*
>      * From here name_width is the width of the name area,
>      * and graph_width is the width of the graph area.
>      * max_change is used to scale graph properly.
>      */
>     for (i = 0; i < count; i++) {
>     /*
>      * "scale" the filename
>      */
>      // TB: Which means either shortening it with ...
>      // Or padding it, if needed, and here we need
>      // another
>      name_len = utf8_strwidth(name);
>
>>
>> Besides, since the simple change from `strlen()` to `utf8_strwidth()` is
>> so different from changing `strbuf_addf(...)`, I would prefer to see them
>> split into two patches.
>
> Hm, that is a possiblity. Seems to ease the burden for reviewers.

Another thing I remembered (this is a comment primarily on the
original I wrote based on 'all world is ASCII' mindset that led to
the use of strlen() as a display-width indicator) in the code is
that we "abbreviate" an overly long pathname and transform renames
that originally is in the a/b/c -> a/B/c form into a/{b->B}/c form,
and IIRC they are all byte based.  The latter may be OK because the
transformation is limited to '/' boundary, but the former may chomp
a single multi-byte letter in the middle, which would need to be
corrected as a part of this change.
