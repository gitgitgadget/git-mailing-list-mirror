Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A0AC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D291C206B8
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eee0qs2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgDCTz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:55:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40221 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbgDCTzz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 15:55:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id a81so9000806wmf.5
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 12:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LNSSukgZtuiuWWpBEp7cxj4o/6/WLlX882A5R0i1Dw8=;
        b=eee0qs2uk0qHSbYb7h+gXJOkXrqPlYSjc4JUHE1dLDU77zjnZP/1e+rlaqRyt+kotC
         uNoIgApK2c8Z+NDPNTnbFU+e0iXlkMqBfOZPBzwIvOgS9lrmbx9EYx1G0pw8B2Y3KY49
         Bgb2OOruermFrbK8eG6fW3yO55HWbLoE/3wrW8NAth7Svw/aBVD2lrNPUnXUqOyeANDt
         0wd76+Nu2k4PVDz/taPUDgI0KFR5CWyknvacrUnEzICdLgllX8i8c+wWn+gaRIkQArkV
         JCFeXc4c4P7S9dikbxm9FLAJK2jXlvdhPSVScR8AiKSXmzH59BBIOsJGu9pi+XmMlCOA
         S8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LNSSukgZtuiuWWpBEp7cxj4o/6/WLlX882A5R0i1Dw8=;
        b=bK32uBBhVvtNTAGKRI3BLWTRVzq5qO5o9fNYcmzJ9ZOmnw9OTTIr+m75WcvGeKDCOQ
         zskz1l09V1vsi7RNhdDCX9HUhQeAeh9QKia4G7Dm8UkvJDRCZ9homD4Eo8LEn+elIQ8m
         9SitUqfepTBA+R+r5Ka5Ea9DHOHkaQzwyD8saESPJudiaLUH+VKHg9/E+/iQPp1imi4C
         vuP/pjt67GG9NG+6kApj3nnnD/yLhOYuAxMKDc4vxOh0DXNVWccxfP9O2CtE3dvbvglJ
         GJu99ilaSLr8Kt0UXw+00BhG5z1iwWcw6ud96Fcjx6xZ0M0JeBM/FNTyEpGCZYivmiGc
         RvFw==
X-Gm-Message-State: AGi0PuZH24lJOdvDtCc4up/9rcWUlFRFEFxQD0rbeczZmjl1o34mkyH5
        5rY+U8+BaaoUFbkQK+SvwRE=
X-Google-Smtp-Source: APiQypJ7eo5W3nC5nksWYNZDYbSr6bf5TE0nZaRzcUh95IYc7REI5No2Q6T0k1D3PqPAGC/IyeQ+aA==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr9963833wme.159.1585943753741;
        Fri, 03 Apr 2020 12:55:53 -0700 (PDT)
Received: from szeder.dev (78-131-17-192.pool.digikabel.hu. [78.131.17.192])
        by smtp.gmail.com with ESMTPSA id y15sm12919432wrh.50.2020.04.03.12.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 12:55:53 -0700 (PDT)
Date:   Fri, 3 Apr 2020 21:55:51 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/6] ci/lib-docker: preserve required environment
 variables
Message-ID: <20200403195551.GB7859@szeder.dev>
References: <cover.1585474409.git.congdanhqx@gmail.com>
 <cover.1585832270.git.congdanhqx@gmail.com>
 <b7b079f559a17b6d6cef037afd6ce023df8f90b0.1585832270.git.congdanhqx@gmail.com>
 <20200403082254.GJ2224@szeder.dev>
 <20200403100931.GA32101@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200403100931.GA32101@danh.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 03, 2020 at 05:09:31PM +0700, Danh Doan wrote:
> On 2020-04-03 10:22:54+0200, SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > On Thu, Apr 02, 2020 at 08:04:01PM +0700, Đoàn Trần Công Danh wrote:
> > > We're using "su -m" to preserve environment variables in the shell run
> > > by "su". But, that options will be ignored while "-l" (aka "--login") is
> > > specified.
> > 
> > This is not true.  See any previous runs of the 32 bit Linux job,
> > which worked as expected, because none of these environment variables
> > were cleared.
> 
> Different su have different behavior when combine "-m" and "-l"
> 
> util-linux's su has this as far as 60541961f, (docs: improve grammar,
> wording and formatting of su man page, 2013-10-12)
> 
>        -m, -p, --preserve-environment
>               Preserve the entire environment, i.e., it does not set HOME,
>               SHELL, USER nor LOGNAME.  This option is ignored if the option
>               --login is specified.
> 
> https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/login-utils/su.1#n120
> 
> Ubuntu (our Linux32 builder), ships su by shadow-utils:
> 
> 	Note that the default behavior for the environment is the following:
> 		The $HOME, $SHELL, $USER, $LOGNAME, $PATH,
> 		and $IFS environment variables are reset.
> 
> 		If --login is not used, the environment is copied,
> 		except for the variables above.
> 
> 		If --login is used, the $TERM, $COLORTERM, $DISPLAY, and
> 		$XAUTHORITY environment variables are copied if they were set.
> 
> There're no mentions of other variables, I _think_ our Linux32 works
> by accident.

We do know which image we use, and we do know how its 'su' behaves.  I
think relying on that is fine, and it's not just "works by accident".

> Alpine ships su from busybox, this su ignores "-m" if "-l" is set.

Then the commit message should specifically mention these behavior
differences between different 'su' variants.

