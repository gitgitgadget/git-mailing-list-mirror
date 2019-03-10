Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ACA520248
	for <e@80x24.org>; Sun, 10 Mar 2019 03:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfCJDoL convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 9 Mar 2019 22:44:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34840 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCJDoL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 22:44:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id t18so1462166wrx.2
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 19:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kw6mI9BxQd6tXvYr4v/MJPzvvF6T/5zyvo6iMyUtX+A=;
        b=aN6aowCkGma6rePUh1ylTunwAQOVvEgconQdw+8pUNab0gbV0SxWMy+De1t0XEw9Np
         t0jx0RSbrwOHgd0b0PHeRZ29Tk3nJT4CRX3xULFJU4BPAXcas7avFUtOWfflam/S55bV
         4v7Cbe5fPeVjfmsmzT3hvrz0MlPmpTys1Je1cFASF+t2dS4NmvUz7r7HB+VKpQ6KElBV
         OJB3DZGHgLeqbBRAt0RuLTtZhADUilobvUA6hpeSK4PDmGkr6na5qqxt/v4Dv6g5pxFi
         8D+H6967si9OjW8U20FkS8o5jg+Fd4LCTfzXNAn/nev1pItKsaVupUFfTYWDqMlReMKy
         H91g==
X-Gm-Message-State: APjAAAUp2ufj3fKVaao93sAGYuIE6Huhxzm6+Ex52b6ViL0uKH3Ya4nk
        itpnlGoXFYdkWwkPboebgkTtE5OrsadPR/SgHDI=
X-Google-Smtp-Source: APXvYqzlpMG2Z+8iVlWNYOuVrQPFGa6fk4PbLBaL2m18mu7qqpMqW5b5oCddBYaTg1dj33s7fgGMucOgDOOA8A8TDVQ=
X-Received: by 2002:adf:f149:: with SMTP id y9mr15311576wro.282.1552189449643;
 Sat, 09 Mar 2019 19:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-19-pclouds@gmail.com>
In-Reply-To: <20190308095752.8574-19-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 9 Mar 2019 22:43:59 -0500
Message-ID: <CAPig+cTR8px1MCq0qXijt1x2+BAgpsKCiRR1hw3hHiVc2NkHAA@mail.gmail.com>
Subject: Re: [PATCH v3 18/21] switch: no worktree status unless real branch
 switch happens
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 8, 2019 at 4:59 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> When we switch from one branch to another, it makes sense to show a
> summary of local changes since there could be conflicts, or some files
> left modified.... When switch is used solely for creating a new
> branch (and "switch" to the same commit) or detaching, we don't really
> need to show anything.
>
> "git checkout" does it anyway for historical reasons. But we can start
> with a clean slate with switch and don't have to.
>
> This essentially reverts fa655d8411 (checkout: optimize "git checkout
> -b <new_branch>" - 2018-08-16) and make it default for switch,
> but also for -B and --detach. Users of big repos are encouraged to
> move to switch.

I like this last bit. The skip_merge_working_tree() function which
this removes was ugly, difficult to maintain, and difficult to get
just right (and easy to break -- even by changing parts of the system
which one might not expect to impact it).
