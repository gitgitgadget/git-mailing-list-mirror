Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F74C04EB5
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 15:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B1E20838
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 15:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmzLhIBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgBGPJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:09:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39406 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgBGPJB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 10:09:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id c84so3134115wme.4
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 07:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Zw7FfLmoUj/D5/+ZLEYvgnYQOwiDLMQvNyDQ6U3MziE=;
        b=lmzLhIBqjDTIncUksYSxozd69V0oS1QyipWo6Wv91Bak2cjeOAgTcx4A0GcYTFy+oo
         9hE+PJlwOKDXsK/QDrwDriHZPaaR2IyhHTKssISdHGrAbNKxHKTn6ZUlxrrFZ3CJijKa
         tKvlJTF8gZNVajhy8o6adx6v4a9d6OsG0cP6TSt9Kw+Q6Yv0cYzJGRKGokkVncORJles
         WQTwyv+BhWh057MRAu/g2KSCrf+nKqc9rJgXFHXltpZXHVn5Ealfxrc9M80MkpXEX9at
         2R27kIjVZP/+zmxCErYblARimihUe6MgKIpK0rNtkGnjR3W3T+EfcG8jzF+tsW6+cDQk
         Q1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Zw7FfLmoUj/D5/+ZLEYvgnYQOwiDLMQvNyDQ6U3MziE=;
        b=lawPpRljD/My+Fv17jbMiFmjcNsEOSonfh1KgUVn+jfYjTIptI9QdHSanhk4roVK7i
         j9Ca1xiEKgJAcLO1CkH7A7pMI47AhEUJnO7gKBCpONqdCVh2zY8yfDUrjH4EGo7ftt1w
         q965zApS7ZxzERqPLnsHaxrT3U3y+rXPNQp3Du/4h7iTtCtoFCJFaKiBTJ65jkG1tVqT
         H0HMJchkpCi6llyrbNSkSqv+lnSdkP7y6IA6lkIv44oAB+xQo67iPceIb6fxSbMt1rxd
         6A+EV/zKaMM4fxRA8cbTYKICEk9VHCaCZCOpub1QV/jeXhz1XlaMYaHX7A6axBjA0O1V
         SwTQ==
X-Gm-Message-State: APjAAAUWGwEkyhpnhturdbq5AlFWuotqgRXE11UfIbWVOmYuQeyax85c
        PytfPNLQ/66El87yIMawesI=
X-Google-Smtp-Source: APXvYqwJ7rVTqTjAtHmq17ZAuuCD+kkQYfHWtoCrHxZdBziZOuPSJMm5GZQLQAlsUCMmqZvS4+UAiQ==
X-Received: by 2002:a1c:1d09:: with SMTP id d9mr4983763wmd.91.1581088139460;
        Fri, 07 Feb 2020 07:08:59 -0800 (PST)
Received: from szeder.dev (x4db318d8.dyn.telefonica.de. [77.179.24.216])
        by smtp.gmail.com with ESMTPSA id l8sm3791127wmj.2.2020.02.07.07.08.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 07:08:58 -0800 (PST)
Date:   Fri, 7 Feb 2020 16:08:57 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 10/15] bugreport: add config values from safelist
Message-ID: <20200207150857.GH2868@szeder.dev>
References: <20200206004108.261317-1-emilyshaffer@google.com>
 <20200206004108.261317-11-emilyshaffer@google.com>
 <20200207144725.GF2868@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200207144725.GF2868@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 07, 2020 at 03:47:25PM +0100, SZEDER Gábor wrote:
> On Wed, Feb 05, 2020 at 04:41:03PM -0800, Emily Shaffer wrote:
> > +static void get_safelisted_config(struct strbuf *config_info)
> > +{
> > +	size_t idx;
> > +	struct string_list_item *it = NULL;
> > +	struct key_value_info *kv_info = NULL;
> > +
> > +	for (idx = 0; idx < ARRAY_SIZE(bugreport_config_safelist); idx++) {
> 
> GCC 9 complains about this loop condition:
> 
>       CC bugreport.o
>   
>   bugreport.c: In function 'get_safelisted_config':
>   
>   bugreport.c:66:20: error: comparison of unsigned expression < 0 is always false [-Werror=type-limits]
>   
>      66 |  for (idx = 0; idx < ARRAY_SIZE(bugreport_config_safelist); idx++) {
>   
>         |                    ^
> 
> I don't understand this error, that autogenerated
> 'bugreport_config_safelist' array clearly has a a non-zero size.
> What am I missing?

macOS 'sed', that's what I was missing :)

So that array is in fact empty on macOS, because the entries of that
array are generated with:

  # cat all regular files in Documentation/config
  find Documentation/config -type f -exec cat {} \; |
  # print the command name which matches the annotate-bugreport macro
  sed -n 's/^\(.*\) \+annotate:bugreport\[include\].* ::$/  "\1",/p' | sort

and the 'sed' included in macOS apparently interprets that '\+'
differently than GNU 'sed', and as a result won't match anything.

FWIW, that '\+' doesn't seem to be necessary, though, and after
removing it the resulting generated array looked good to me (and to
the compiler) both on Linux and macOS.

