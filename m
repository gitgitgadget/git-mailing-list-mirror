Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0D3C33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 14:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FA820684
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 14:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="kM1a7RYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgAPOrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:47:41 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46753 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgAPOrl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 09:47:41 -0500
Received: by mail-qt1-f193.google.com with SMTP id e25so7716251qtr.13
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 06:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3CJ6ZCC3zvpxwky6qvdhFYD+ilwnujAKpTF3fHjuh8g=;
        b=kM1a7RYEsVvLL5DCenJY/JiIyjrJt1Z/61UJaRlzxbX3cDW/5zU9VS3LWS7qACUhnx
         t53fYxku3n/rldTlU/VMzssrDpgqiJv+BNDdyehcPSYxfgWftOrB87KLK6zIcIB0DiBv
         wpGmK/rVvdd+25B49lkpEaVmtyOzXsjquNlE/sc0U4Ri5vDXgUKnZiOIBT6GqIKsU4aM
         PPMTKlzedj/xaf+6Djv1WMo9F2zPotKrSh/0qzT9hWJUzNyPFtC70SI7EV3r263HtMyL
         A3FGFK1cWHqhhDDgfzwo2h9CzqZ10Oot9SW3PCirHiGcxJXeuAPVteN0iiKQDr4WjGdk
         wx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3CJ6ZCC3zvpxwky6qvdhFYD+ilwnujAKpTF3fHjuh8g=;
        b=Z1/stkpEmYoWMom1JvoYJKTQGnFMlnnFx5N5cE52kJj2qNEwuPIIr+07qVtQT38Zed
         nz+eFyw81C7ZMSr4N2/jrX/07s+Q/DuhB4RiOsS55GJHdd9JlMBA/AGIGBAFfBm2Cdcv
         7YfgSEM7qOEe2JNo+W+HXPhallRIUQldMwHpC1LOaOkBLQYctMNsYi0pTC3r/sALsYMD
         iy+eUo/bJ3gQsPUX2PxjxyZwGbIo9F+8ANiXMWVMnKBYV4f/G27stlez+wIMNCwS+buS
         6I4IPTsJpbfwv29mGbYnaQ/vmFMM29NdGMfJfjrFhdTKb8+FyyXVklOigMHDg7UNd0FL
         1bFg==
X-Gm-Message-State: APjAAAUjvFId03qD48VXiIIyCSBapUQJ4VBp6WTLJCeXYF7NX+VNZn2m
        LOc/loPKAqepErOIJRzJVyYvKg==
X-Google-Smtp-Source: APXvYqyPoT2lpvuFkeRJ/QkMn1DaxY62bgiVVnjwFKcb6yHbtzCGHZJ6oWVk71ZlufhGg1VziYy6Xw==
X-Received: by 2002:ac8:2ffa:: with SMTP id m55mr2710808qta.189.1579186059972;
        Thu, 16 Jan 2020 06:47:39 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id t29sm10032180qkm.27.2020.01.16.06.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 06:47:39 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     vleschuk@gmail.com
Cc:     alexhenrie24@gmail.com, artagnon@gmail.com,
        bwilliams.eng@gmail.com, christian.couder@gmail.com, e@80x24.org,
        git@matthieu-moy.fr, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        matheus.bernardino@usp.br, olyatelezhnaya@gmail.com,
        pclouds@gmail.com, peff@peff.net, vleschuk@accesssoftek.com
Subject: Re: [PATCH] grep: use no. of cores as the default no. of threads
Date:   Thu, 16 Jan 2020 11:47:29 -0300
Message-Id: <20200116144729.8033-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <CAGuA69ujsOBm2+RKEkGu8wLoEVvKxivY762Zokf9MWxDWrwWFQ@mail.gmail.com>
References: <CAGuA69ujsOBm2+RKEkGu8wLoEVvKxivY762Zokf9MWxDWrwWFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Victor

On Thu, Jan 16, 2020 at 10:11 AM Victor Leschuk <vleschuk@gmail.com> wrote:
>
> Grepping bottleneck is not cpu, but IO. Maybe it is more reasonable to
> use not online_cpus() but online_cpus()*2?

I also tried this approach, but the tests I ran with online_cpus() * 2
only showed slowdowns. The results can be seen in the commit message:

> On Thu, Jan 16, 2020 at 5:41 AM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
[...]
> > The following measurements correspond to the
> > mean elapsed times for 30 git-grep executions in chromium's
> > repository[1] with a 95% confidence interval (each set of 30 were
> > performed after 2 warmup runs). Regex 1 is 'abcd[02]' and Regex 2 is
> > '(static|extern) (int|double) \*'.
> >
> >       |          Working tree         |           Object Store
> > ------|-------------------------------|--------------------------------
> >  #ths |  Regex 1      |  Regex 2      |   Regex 1      |   Regex 2
> > ------|---------------|---------------|----------------|---------------
> >   32  |  2.92s ± 0.01 |  3.72s ± 0.21 |   5.36s ± 0.01 |   6.07s ± 0.01
> >   16  |  2.84s ± 0.01 |  3.57s ± 0.21 |   5.05s ± 0.01 |   5.71s ± 0.01
> > >  8  |  2.53s ± 0.00 |  3.24s ± 0.21 |   4.86s ± 0.01 |   5.48s ± 0.01
> >    4  |  2.43s ± 0.02 |  3.22s ± 0.20 |   5.22s ± 0.02 |   6.03s ± 0.02
> >    2  |  3.06s ± 0.20 |  4.52s ± 0.01 |   7.52s ± 0.01 |   9.06s ± 0.01
> >    1  |  6.16s ± 0.01 |  9.25s ± 0.02 |  14.10s ± 0.01 |  17.22s ± 0.01
> >
> > The above tests were performed in a desktop running Debian 10.0 with
> > Intel(R) Xeon(R) CPU E3-1230 V2 (4 cores w/ hyper-threading), 32GB of
> > RAM and a 7200 rpm, SATA 3.1 HDD.
> >
> > Bellow, the tests were repeated for a machine with SSD: a Manjaro laptop
> > with Intel(R) i7-7700HQ (4 cores w/ hyper-threading) and 16GB of RAM:
> >
> >       |          Working tree          |           Object Store
> > ------|--------------------------------|--------------------------------
> >  #ths |  Regex 1      |  Regex 2       |   Regex 1      |   Regex 2
> > ------|---------------|----------------|----------------|---------------
> >   32  |  3.29s ± 0.21 |   4.30s ± 0.01 |   6.30s ± 0.01 |   7.30s ± 0.02
> >   16  |  3.19s ± 0.20 |   4.14s ± 0.02 |   5.91s ± 0.01 |   6.83s ± 0.01
> > >  8  |  2.90s ± 0.04 |   3.82s ± 0.20 |   5.70s ± 0.02 |   6.53s ± 0.01
> >    4  |  2.84s ± 0.02 |   3.77s ± 0.20 |   6.19s ± 0.02 |   7.18s ± 0.02
> >    2  |  3.73s ± 0.21 |   5.57s ± 0.02 |   9.28s ± 0.01 |  11.22s ± 0.01
> >    1  |  7.48s ± 0.02 |  11.36s ± 0.03 |  17.75s ± 0.01 |  21.87s ± 0.08

I deliberately used somehow complex regexes for these tests. So I
decided to do one more test with a very simple fixed string ("abc"),
allowing git-grep to spend less time in the cpu-bound regex searching.
The results can be seen bellow (the metodology is the same as described
above and the machine is the Manjaro laptop, for which online_cpus()
returns 8):

  #ths |  Working Three |  Object Store
 ------|----------------|---------------
    16 |  3.22s ± 0.20  |  5.96s ± 0.06
     8 |  2.92s ± 0.01  |  5.73s ± 0.02

