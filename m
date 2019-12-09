Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBB5C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF1A2071E
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="GAJIUW09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfLIUT6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:19:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34345 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfLIUT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 15:19:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id m6so17185495ljc.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 12:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1d5npsbeeq/jDnVDNXIly0JE6weyhgw7LjrZDI+b7bQ=;
        b=GAJIUW09OuKisaZhKxvmrt8Rgd4f5BzVMMdQvvzZpuzipTvDwR1NdGKCrz3lSTWyCz
         I39Oe9woMfhN9xQhl5QmPTFy4J2xrGJ6P4Q9QzJFFSxq+Vhxoa3IOccr8+GWYH63n1cg
         w3INu+dy68es62UbNmftTbrjCHE9BbaOkFmK2x86q9SChM3pm0e5e4UCRpBG18D0Fp8D
         6FAaUjk+vSAqI4dXLZYX4yfCiPKekROTs9ACx/QTk40ct3g5jy1ZEnnH9A9IyANoS1FD
         4F+ypkt8e4fywzyLGnHp/ruDw97IGqlpeol1at5eC7qvJ9jdkKf3ry+iKVEA33fxH+BN
         g5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1d5npsbeeq/jDnVDNXIly0JE6weyhgw7LjrZDI+b7bQ=;
        b=EKGRBVzNhPLqD+Zd4BPoa9RN7Ig1aOPtniJiGJaRb+CJm0bU+RnJ49zxnp1tFMlz+Z
         2ivKLf5CBJ1/eje2NE4bACzThs5fCDY71lhDQyZfEtLruGP8/crvFGGyw+2RqcaHYm5N
         SyEwUFSk7mJWqFj9Igglm2+z6hH9tQriMYUuPp14KKP75BFnTKjme9ZzF+KcA1C1WmOJ
         GGqS6vw2YjuvKdCZ245g8F/RlIZ6qIXgZ9emFklrc5YfvH3/BomnJg9X4LBok6Z6YnB2
         28vYSAUkEVxGc0RiguxD1hr+uXjMH9jHnQ5p+CPU5DjZW/8DZwNs5sVb2x6yhvtO+2rE
         zo/Q==
X-Gm-Message-State: APjAAAU0RueYrmyQN23yLXdaxUEPb4k3LXHY17cLaJUHuPBxmljIf6Fd
        CdEiEJt4jyYRcXrK91r31iCCAPSdqtRM6s4Z7ptTwg==
X-Google-Smtp-Source: APXvYqwLh8ec+p48jSNtK5tURVbTGXqzmCb62MfMseov6m0vZgIHx6prH+XhB4IWyM/6Yk4Qmj3Gx48bru/08GsYKVs=
X-Received: by 2002:a2e:844e:: with SMTP id u14mr14556703ljh.183.1575922796050;
 Mon, 09 Dec 2019 12:19:56 -0800 (PST)
MIME-Version: 1.0
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
 <20191207010938.GA75094@generichostname> <CABvFv3+viMXJO0z5HAQbCya7MU9tWd7P_LxUhu66T74XGN99yA@mail.gmail.com>
 <b21d153a-02f9-b9a1-7388-59b5a882d4f2@gmail.com> <CABvFv3Jf9i06OmBqOC2zfS+7Sm88PRYa19_rB8rELtMoN2E8CQ@mail.gmail.com>
 <afa761cf-9c0e-cdcc-9c32-be88c5507042@gmail.com>
In-Reply-To: <afa761cf-9c0e-cdcc-9c32-be88c5507042@gmail.com>
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
Date:   Mon, 9 Dec 2019 12:21:37 -0800
Message-ID: <CABvFv3LAPPib-Lz+2MQvyZdq2qrmFTxN-Ya9ACnGg32d3tO9Rg@mail.gmail.com>
Subject: Re: [PATCH 00/13] git-p4: python3 compatibility
To:     Ben Keene <seraphire@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 9, 2019 at 7:03 AM Ben Keene <seraphire@gmail.com> wrote:
> I downloaded your code and it looks like it works for Python 2.7.  I'm
> seeing errors with the following tests:
>
> * 9816.5
> ...

I'm not sure why those would fail for your local environment but not in CI.

I've just pushed an updated PR to GitHub which is now passing all
tests on python-3.5. Give that a go.

If tests are still failing for you, it'd be good to get the verbose
output from the specific test scripts. They don't tell us much without
it.

e.g.:
  ~/git.git/t $ : ./t9816-git-p4-locked.sh --verbose

Thanks,
Yang
