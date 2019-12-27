Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6613BC2D0C6
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 11:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2BF20828
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 11:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJBSpq0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfL0LEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 06:04:37 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:53839 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfL0LEh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 06:04:37 -0500
Received: by mail-wm1-f46.google.com with SMTP id m24so7797012wmc.3
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 03:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LJkOTpaPs0/BnvkpN4Vo2N3DT8d5IOefB1iArggW4aA=;
        b=uJBSpq0xisCi5M2M50VzKpRF17VRD7I5KAybtYJRcY4xPrE3Hdi93aOILcJDOnvtB0
         QGT/OqLf6MMMT3FO3cTLHisdva0OXZSPOnD0nKtQ2gEgRgdjWVf6gJJEGL0yewJ1Olah
         sRIH9yS4wnHvaTT/zpFWg10aore6w7MPMZO0ZTLmxTOHXDzlr4AmzZBlIag8z4NCiciK
         7HHMw1OF1o3I2sR7wXHVcI//UiGjBa7UfSX1Oh1OLM+DX+8WJhw7ANPy7yZNsWk3k1ci
         R5ctAbPeT6X6kt/U1HA/GcjGfStIMrUDWO5eeLdxNinoBWdCXhYm7gHwrieOx8AeMst4
         XAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LJkOTpaPs0/BnvkpN4Vo2N3DT8d5IOefB1iArggW4aA=;
        b=I/ctmnO9tsO/2g1BY0CUsisHKosM7jv8bqUJ5Xp9FxWv2bmP5T2WIvA1f111+ZELna
         TDY1MVfMhwzvjQiltgu2i8fiErHiejHPS34zSKLOb8qL4f36tEKL6C/lkNwIX5gNKksP
         P6/ijGnFhHqjB0d9vCdPwvGcfZJTEDjqVUNPFhgezGcQkCWl5qGnFt+VoYTAQLOpD0tw
         8DDukj7UbH8bS20S9BwbCZs8r86ZRR+X2GhnsvHnRQgJHA/6XsTBSmLmpOCcseYoM0H0
         0vEuMMF68NJR0yqkY9S00RHumiuYUQ2IyC1Ilz433xmM645J7hFkjh+GGTQZZngwWgG4
         OYFA==
X-Gm-Message-State: APjAAAXKdKSEGq9L9gG+F7O5hiBbNGs7BjUV4f2W5Gna9H5Ud3jZYTaG
        G+xKJTc1VbrRK5ZwPJg5VxhSr27T
X-Google-Smtp-Source: APXvYqwn6Sf3PjLQW+EHpWOpe4LaK5XRjzX7vJYuF1gXsPYpoHq/2gfYeOa8Wwb/t3AZwRmpsMlGaQ==
X-Received: by 2002:a05:600c:409:: with SMTP id q9mr18556164wmb.19.1577444675073;
        Fri, 27 Dec 2019 03:04:35 -0800 (PST)
Received: from szeder.dev (78-131-14-29.pool.digikabel.hu. [78.131.14.29])
        by smtp.gmail.com with ESMTPSA id z124sm11471381wmc.20.2019.12.27.03.04.32
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2019 03:04:34 -0800 (PST)
Date:   Fri, 27 Dec 2019 12:04:31 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Subject: bogus config file vs. 'git config --edit'
Message-ID: <20191227110431.GC32750@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's suppose I somehow ended up with a bogus config file:

  $ tail -n2 .git/config 
  [section]
          foo bar baz

and now I try to rectify the situation, but I know that poking around
in the .git directory is a no-no, so instead of 'vim .git/config' I
try:

  $ git config --edit
  fatal: bad config line 81 in file .git/config

Uh-oh.

Furthermore, if I don't remember quite clearly the finer points of the
syntax of the config file, then I might want to look it up:

  $ git help config
  fatal: bad config line 81 in file .git/config

I think bith 'git config --edit' and 'git help ...' should just work,
no matter what nonsense might be in the config file, even if they then
launch a different editor or pager than what are set in the
configuration.

