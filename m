Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9CEC433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 13:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768F622B43
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 13:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgLUNRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 08:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgLUNRE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 08:17:04 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90FCC0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 05:16:24 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b5so6458547pjk.2
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 05:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9yONtl0m8GdD2M9S0AlXkXnRCsZMW3lAVdFarFJKSaU=;
        b=dIfcIYyJFAWMWqWFU3mGYsJLsRLhu8AymPFR1Lx3Pi+jfUInJeysY7rm8WToigHgsc
         aTDYJQV8LaYU56/VRn+/bG+V8j3PmWqKirkvmru0tBwLZnLwWLJA/uGcsBLLuD329cDK
         VI4oh4gpdZj9ayC6Tu1PqSM1YsfIfb1PgX8m7/ImIPP40ueDnEXmDMebG0cYH9DIP4Ud
         RxsHbncqHK2CSCe59emY3xa8UEUMsvSYXi1FOZD9tYepx1e89KyJsIsVaGtuk83+HPml
         5uWATyzdm8YFeCgDT5JAiYdYxI4r/siws2ZHdd6j3Vm29NYqxeFNwYPH0dav/25ooCg1
         1x5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9yONtl0m8GdD2M9S0AlXkXnRCsZMW3lAVdFarFJKSaU=;
        b=ZzqhOesXliPt0PlGNwRZZduQrSfcTna9/IEahGz69YRCNRcFQZ9QI/IQz5qZPqSK8T
         2tueOItFZD4cKzsUuzUoi9HwHEgqIxUsbsrWk9dRifgy8/Mwr9C6JN8T0tkD5o/XGapr
         U091hrOBzUjfkviIh9Ibzq9b3cildyWZnVvkWvPA9UHm1CYst+ZJXpgyAUgCkq/7dkct
         Y/XVFC/p3D2pwZrsvpJbfqgjTFFpe0cW6994bVWlJITLYDVWmjkN0ef/IOPiIxvnyBXy
         seV/Ea2MqgLB1wzNXbQK08WKof7vMkDWAfmAEw+c4lLqDJ63ro+ZfSBDyQUGVJ0uESJ4
         Jptg==
X-Gm-Message-State: AOAM532l60ErZmb45uu4+jVqVhYzO3XqpdKsUkSX7Z7oLCbMAWs0amJW
        t5QjnfmR81097tLQXZfFvnk=
X-Google-Smtp-Source: ABdhPJy5G7Nq46ZNH20y0K2S5NUh79aYEkG26EJm1IeaqNm+Ka5SqxlwLP49uf+hL07LAw9ol9kqcg==
X-Received: by 2002:a17:902:ee52:b029:da:4dee:1a54 with SMTP id 18-20020a170902ee52b02900da4dee1a54mr16388598plo.29.1608556584083;
        Mon, 21 Dec 2020 05:16:24 -0800 (PST)
Received: from localhost ([2402:800:63a8:c764:b10d:95e8:e1a5:df80])
        by smtp.gmail.com with ESMTPSA id p15sm17188325pgi.40.2020.12.21.05.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 05:16:23 -0800 (PST)
Date:   Mon, 21 Dec 2020 20:16:20 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4lyaWNv?= Rolim <erico.erc@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] In git-log, --name-status flag overrides the --patch flag
Message-ID: <X+CgJCj7/tadldUg@danh.dev>
References: <CAFDeuWOit1vKUT38Uvbj2wAsb5CBo59p2h=SE6FGNb6XGOGG-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFDeuWOit1vKUT38Uvbj2wAsb5CBo59p2h=SE6FGNb6XGOGG-w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-12-20 01:23:05-0300, Érico Rolim <erico.erc@gmail.com> wrote:
> Hi!
> 
> When using the command
> 
>   git log --patch --name-status
> 
> It seems the name-status flag somehow overrides the patch flag, by which I mean
> that I get the same output as simply running
> 
>   git log --name-status
> 
> It would be nice for the combination of these two flags to work, as it would
> allow one to view both a summary of changed files as well as the changes
> themselves, at the same time.

I'm not arguing if this your expectation is make sense or not,
however, the Documentation says something about "Show only"...

Anyway, --patch-with-raw provides more information than
--patch --name-status combined.
I guess it's too much information?

-- 
Danh
