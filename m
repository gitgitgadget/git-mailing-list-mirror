Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA8CC433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 20:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiAYUTV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 15:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiAYUTT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 15:19:19 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC196C06173B
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 12:19:18 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id o10so17904037ilh.0
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 12:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HRWOQJ9tZspNMBK3DWcFftIrzIX/KmmGEc0UWs00Dyg=;
        b=LJD3kURW1GZdWV9Ww/pfKWG9gRbIyditTw3b0nh/CtRi62k1a3Nu95OtTdIZ0jrdQu
         3ZNsdpp3YMsALD+YeNLMp9Hprf9H4SEvKMjmlCzpeYjOD1heUCg4gzV2x4JjuQXaTZQn
         7MxliyJcyIBK6fW6CY3vuqcyh+pIvxQamOxfrKeojnZ8oF2jB+U71dGk5uMRM7FTS7+M
         7vI3bjXTG2k856piRG+825CxfS5EJeuisjhQYj690LqAQcqOQUxknMQK6q062jjuB+pV
         lxHOdMHaQY0rgRr5fbDVebgMrSjP78OTxDyTPGSVSRLg6o0tTqrsxmNV0DX8filKBoqY
         Q+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HRWOQJ9tZspNMBK3DWcFftIrzIX/KmmGEc0UWs00Dyg=;
        b=vPYYcDyg0FvuCDo3p3h7H8qRLIJh/1DfbNhxUvuEpq2q4j9WYnhVhiKRIQHYlhSMEk
         HcJ5YaRs85wJa9ihXZo726eExW4EM3HQVJPqX7Nz8Z98ZmtT5ZyacF0QrPggQqPdBdIH
         +Fztdz4h+c6WEn/1gJvUEWLysa/gYqhcdAmUMI5tdXPKt6uc5BMRk2TEPJBCieZM/SiD
         S6fRIjJZrkjdeLKQZynZgDiKFzD+Jl6UGfW+WrfsES7cUkJvI9u/J1v/SaCi8prMdnTZ
         VVzY6KjlFKWxpJM3VR2MLUUAa9ulZKEDYk575lT2xGFu9OK091C69QOtil2OMtjC/Yrz
         pSNg==
X-Gm-Message-State: AOAM532wU5hmyPkXyn/mWT48gAZ8mSZfch2wnIjdcEQqPIin6GVhIe7E
        EyWSZXVnmhZzC8Qk0vhOv8FIGuQw4kJpwg==
X-Google-Smtp-Source: ABdhPJxzKuPjavLR67yVlwn3cNtbAP3waSTNR5v16aqwUWiCsg1KZTfK3Q4DPaRRDncNiofNXYelRw==
X-Received: by 2002:a05:6e02:152b:: with SMTP id i11mr12895406ilu.188.1643141958264;
        Tue, 25 Jan 2022 12:19:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x17sm904833ilo.21.2022.01.25.12.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 12:19:17 -0800 (PST)
Date:   Tue, 25 Jan 2022 15:19:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Konstantin Khomoutov <kostix@bswap.ru>, git@vger.kernel.org
Subject: Re: [RFC] shell: local x=$1 may need to quote the RHS
Message-ID: <YfBbRca0Rjl59MM0@nand.local>
References: <xmqqsftc3nd6.fsf@gitster.g>
 <20220125092419.cgtfw32nk2niazfk@carbon>
 <xmqqa6fjzlm0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6fjzlm0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 25, 2022 at 11:00:39AM -0800, Junio C Hamano wrote:
> Konstantin Khomoutov <kostix@bswap.ru> writes:
>
> > Sorry, I might have not followed the entire thread, but assignment in
> > `local` is a bashism, and dash can only handle the declaration part with
> > `local`, not assignment; hence the safe code should read
> >
> >   local x
> >   x="$1"
>
> Interesting.  As "local" is not in POSIX but we still use it for
> convenience, we must limit our use to a reasonable subset of
> features common to the shells we care about.  Knowing what each
> shell can and cannot do safely is essential to us.
>
> The patch posted seemed to run fine with a more recent dash than
> what I had trouble with (0.5.10 would work fine with "$1" quoted,
> 0.5.11 would work fine without $1, just like the RHS of a regular
> assignment).  In addition, there are many existing tests that
> already use "local var=initial-value" (the message you are
> responding to has an output from "grep") and we haven't got problem
> reports from dash users about them.

Yeah; bisecting dash with your example script pointed me at cbb71a8
(eval: Add assignment built-in support again, 2018-05-19), which indeed
appears in v0.5.11 (and all subsequent versions).

cbb71a8 points at release 0.3.8-15, which predates Git (and a tag
pointing at it was never created, since it's behind the big "initial
import" commit at the beginning of dash.git's history). But skimming
ChangeLog.O, we see:

    * Removed assignment builtins since it is at best undefined by the
      SuS and also can't be implemented consistently.

So this probably didn't work at all between that 0.3.8-15 up until v0.5.11.

> The manual page for recent dash may need an update.
> Can you perhaps file a bug on their documentation?

Yes, I agree that dash.1 is out-of-date after cbb71a8. Konstantin:
please feel free to use any of this if it's helpful to you in creating a
bug report for the dash folks.

Thanks,
Taylor
