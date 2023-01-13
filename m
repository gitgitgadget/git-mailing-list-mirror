Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66E4C6379F
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 19:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjAMTvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 14:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjAMTvB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 14:51:01 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE92D7D9C8
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 11:50:53 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z4-20020a17090a170400b00226d331390cso25404992pjd.5
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 11:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8dFeaae3nixIL/R6gb28qtyBMsEO7VtJuSpzmGzMIs=;
        b=bMf06CEvPWnlK9LX//MpfxORbzkSkcfur8DkWQAFPVa+55SCYRTt+MsX9I8e+cdsSI
         lUE2WnfFf+YvXM4ENbzlFwCT1Ufokw8zm7xEjJLYMy5AoHSa4qW0zs51dVBoxsOCQPwP
         jZnSzDWnc87G/+nzG0q9OEPzsEjNdzm3PjBzg9AmJJPz9hfumiS9TMk0+PvJ2v2hdzC4
         tJNjftPNrjIV0Y83ILMuPuoYYLOPGLIGsmV4A3cgohWyOxomogFOb/xzckNd3fTVtGvG
         zy/PHnrVuD4ASAqx1YK5mPvdQ5vWO/48EbRCIz6V49lnLpAj+ViExGpEia7SvzbG8zUL
         FOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8dFeaae3nixIL/R6gb28qtyBMsEO7VtJuSpzmGzMIs=;
        b=YNg99IfJpEkrjBn3SNJGWMiXRIyy+XNHnesUQNOIkjM3DhOVLjNC9Rh8I8PVYN1W97
         wDRifVLVQCUMNXAjPydgkUuJUtCL9J0P4iBUUgioec4CgOl9gGksSe5g0aUdLIrHbBVI
         2mzIJiYYqA9U+rldXT8cZsgpO3/O2nnFYSaqZr06bdwQ7WTy3D354aXqvP5xbbUmInr2
         BrtNCM288YggQKeMVZodaqOMNjOvWGQOIVn2BCC6kn3ynLtlAM0LfLl69kUaYkQLR0NR
         SWFHRXk7wKJX8yY7fQTd4rWnz7fMl74aPe26p57peROzQdn8XxY+4XdAFAAnbv1dqey1
         i7Eg==
X-Gm-Message-State: AFqh2krA6m7ZNV2P0k8jndG2vTi9YyGXR3jaw9C1kiJDzZLqtdWybQWB
        UZUVPkuTv/8uqf2JB05gmRA=
X-Google-Smtp-Source: AMrXdXuqYz3xMJ746vAUhmSr1go3IqA5/SjIS9YDe3+9EoYnff9rDOO5ItyUJ3SgqNkZINc4rGMEVg==
X-Received: by 2002:a17:902:9a87:b0:193:37c1:9b0d with SMTP id w7-20020a1709029a8700b0019337c19b0dmr16649853plp.55.1673639453356;
        Fri, 13 Jan 2023 11:50:53 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001895d871c95sm14572224plg.70.2023.01.13.11.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:50:52 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Phil Hord <phil.hord@gmail.com>,
        plavarre@purestorage.com
Subject: Re: [PATCH v2] date.c: allow ISO 8601 reduced precision times
References: <20221216033638.2582956-1-phil.hord@gmail.com>
        <20230111001003.10916-1-congdanhqx@gmail.com>
Date:   Fri, 13 Jan 2023 11:50:52 -0800
In-Reply-To: <20230111001003.10916-1-congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Wed, 11 Jan 2023 07:10:03 +0700")
Message-ID: <xmqqlem62oyr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:

> ISO 8601 permits "reduced precision" time representations to omit the
> seconds value or both the minutes and the seconds values.  The
> abbreviate times could look like 17:45 or 1745 to omit the seconds,
> or simply as 17 to omit both the minutes and the seconds.
>
> parse_date_basic accepts the 17:45 format but it rejects the other two.
> Change it to accept 4-digit and 2-digit time values when they follow a
> recognized date and a 'T'.
>
> Before this change:
>
> $ TZ=UTC test-tool date approxidate 2022-12-13T23:00 2022-12-13T2300 2022-12-13T23
> 2022-12-13T23:00 -> 2022-12-13 23:00:00 +0000
> 2022-12-13T2300 -> 2022-12-13 23:54:13 +0000
> 2022-12-13T23 -> 2022-12-13 23:54:13 +0000
>
> After this change:
>
> $ TZ=UTC helper/test-tool date approxidate 2022-12-13T23:00 2022-12-13T2300 2022-12-13T23
> 2022-12-13T23:00 -> 2022-12-13 23:00:00 +0000
> 2022-12-13T2300 -> 2022-12-13 23:00:00 +0000
> 2022-12-13T23 -> 2022-12-13 23:00:00 +0000
>
> Note: ISO 8601 also allows reduced precision date strings such as
> "2022-12" and "2022". This patch does not attempt to address these.
>
> Reported-by: Pat LaVarre <plavarre@purestorage.com>
> Signed-off-by: Phil Hord <phil.hord@gmail.com>
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>
> Since this is a complete re-implementation from Phil Hord's version.
> I'm reassigning the author to me.
>
> This version change the implementation to only treat the string as ISO8601 if
> a 'T' existed and date has been parsed. I also added a test for parsing
> RFC-822, which Hord accidentally broke.
>
> The commit message has been changed:
> * The example has been changed to be independent from local timezone
> * Remove the mention of adding test-cases, since it's obviously necessary.

Will replace Phil's patch with this (hence even under your
authorship, the topic name will be reused).

Thanks, both.
