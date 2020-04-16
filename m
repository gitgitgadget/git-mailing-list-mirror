Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFE2C2BB85
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 10:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7173321D7F
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 10:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHx1fUpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504558AbgDPKEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504310AbgDPKEb (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 06:04:31 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89809C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 03:04:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a32so1160294pje.5
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 03:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RBLHqhTYjzuz8Vu0GWQbzcD4heoWyr4VFX9RxzrXNbU=;
        b=UHx1fUpr3keLTzXYh6RppkD96UrNP6hcwkPW7wCyebB9TvnWjKa1pzflcqDExm3wsR
         vkXAUBltHY7Dvg4L/757s0SQvN0WdFA4tmFHIWAA374DPfTp0CN1M2rhxo2vrfY+4U4H
         gejRUQtFs1mi47AwPBa93rxnU5aNYBt9cHsMIp3iJxntUgYmTmanUqRMn7tddvdHKwxp
         xmdSI40gZsny5p2lD+DAGsBoOYUufWJkWCWz3ju9x2YyY1Y5G9iB593kBqoqxdqL8Jh/
         dr7XMmq41M+Et7aonyMchIl8pJfvlcVfrx1CicsBOSqJO+I5d1d3ZYy/VHm5HhNJXhLL
         XWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RBLHqhTYjzuz8Vu0GWQbzcD4heoWyr4VFX9RxzrXNbU=;
        b=R/m6ZvuYGnzP8BwcDBACr/c7ARG6BbPhmp292VpbTkcGEvlY0cmQXvz8xNgyYu1rmW
         leQiava3V6BcDGGyXU28nZrNa/EUAMiQG1SCPkmntZqYRx6IPBB16FNe4qwCNQsc7G3l
         YuntEeecgjOrWxiY7JYKHq6ucznK7tgh9Kt5b9VsOCim3CkXaMX94jTn/z6E1Dp4qbJ9
         //IgR/piG2DgOd0Cd4S8pzLycDsXZbV8jXoNQcVuPLL67P27p833lJu+tyB+XDlv07wW
         Gb82gmoBAWjJMqdKPGxpKE9kxqkYNVXtCRXbQE26Xvf9uAAUeBElraYV4kFWaA7xvVS1
         /CRQ==
X-Gm-Message-State: AGi0PuYulCk1610y3+ToMlYwIYePATG6ql/opvZVXaXAauqO7B4iRztE
        bxK/I6jGKSuJA6Vz0tE2eww=
X-Google-Smtp-Source: APiQypLUr9E4/jVY7drVoo7tafJapSK6wRDAYtXGI0f0Wd3WgtYsehZ7MQbqabFYMuzgPIL57jAV0g==
X-Received: by 2002:a17:90a:1202:: with SMTP id f2mr4189107pja.15.1587031468991;
        Thu, 16 Apr 2020 03:04:28 -0700 (PDT)
Received: from localhost ([2402:800:6374:5380:b9e1:93e1:68db:b9f6])
        by smtp.gmail.com with ESMTPSA id i10sm2813720pfa.166.2020.04.16.03.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 03:04:28 -0700 (PDT)
Date:   Thu, 16 Apr 2020 17:04:26 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/2] date.c: skip fractional second part of ISO-8601
Message-ID: <20200416100426.GA2285@danh.dev>
References: <cover.1586856398.git.congdanhqx@gmail.com>
 <cover.1586921235.git.congdanhqx@gmail.com>
 <03f3e9968bc29b758f2dd32434c9e8d19f624fdd.1586921235.git.congdanhqx@gmail.com>
 <20200415101747.ua22fjadmfxzri5n@tb-raspi4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200415101747.ua22fjadmfxzri5n@tb-raspi4>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-15 12:17:48+0200, Torsten Bögershausen <tboegi@web.de> wrote:
> On Wed, Apr 15, 2020 at 10:31:27AM +0700, Đoàn Trần Công Danh wrote:
> > git-commit(1) says ISO-8601 is one of our supported date format.
> >
> > ISO-8601 allows timestamps to have a fractional number of seconds.
> > We represent time only in terms of whole seconds, so we never bothered
> > parsing fractional seconds. However, it's better for us to parse and
> > throw away the fractional part than to refuse to parse the timestamp
> > at all.
> >
> > And refusing parsing fractional second part may confuse the parse to
> > think fractional and timezone as day and month in this example:
> >
> > 	2008-02-14 20:30:45.019-04:00
> >
> > Reported-by: Brian M. Carlson <sandals@crustytoothpaste.net>
> > Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> > ---
> >  Documentation/date-formats.txt | 2 +-
> >  date.c                         | 2 ++
> >  t/t0006-date.sh                | 2 ++
> >  3 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
> > index 6926e0a4c8..6f69ba2ddd 100644
> > --- a/Documentation/date-formats.txt
> > +++ b/Documentation/date-formats.txt
> > @@ -20,7 +20,7 @@ RFC 2822::
> >  ISO 8601::
> >  	Time and date specified by the ISO 8601 standard, for example
> >  	`2005-04-07T22:13:13`. The parser accepts a space instead of the
> > -	`T` character as well.
> > +	`T` character as well. The fractional part will be ignored.
> 
> When somebody has read the whole patch series, it is clear what
> "fractional part" means. Otherwise it is not clear, what fractional part
> means. The following may be easier to understand ?
> 
>   ISO 8601::
>   	Time and date specified by the ISO 8601 standard, for example
>   	`2005-04-07T22:13:13`. The parser accepts a space instead of the
>   	`T` character as well.
>   	Fractional parts of a second like `2005-04-07T22:13:13.091`
>   	will be ignored and treated as `2005-04-07T22:13:13`

Yes, this read better.
I think I'll rephase to

	Fractional parts of a second will be ignored, for example
	`2005-04-07T22:13:13.019` will be treated as
	`2005-04-07T22:13:13`

-- 
Danh
