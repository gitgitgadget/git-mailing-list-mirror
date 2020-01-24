Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311B3C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 17:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0344E2071A
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 17:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="oGsE9Ny0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389865AbgAXRpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:45:24 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:32828 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390835AbgAXRpX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 12:45:23 -0500
Received: by mail-lf1-f42.google.com with SMTP id n25so1679953lfl.0
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 09:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aAPK2OKeJFMJudtkBsKtBuf55rqbWJZLS9a//k7qWy8=;
        b=oGsE9Ny0a3/LdTW6Aau7KGajjlmjVLpeTW2g97bTvmp/X8LF8F6wsj9MgfI9nZJ2rP
         z4ofeWiOnXnvZNygu2s4Ba2993mjpMW4j5Mwcc6UZtNmX3dRMG9Rbq1JE8+J6avhTf1q
         rfd+L6owbExaV0fxDs0S7zMPCf0A9xvc8WbHKXeYGJNCbENDlhuXb2Eg00k0Vag7cmNj
         4n2c1EyzjbSvqZ4byeHkyMY6pBjKZsfy7++iQp3H2Wqb9HvHQcPDdkjueEZHtjgvHOjb
         6+AHgaBMGV63gW2I9VtDl6x+Lm3nsvHZb8XyGfFjAP+J5gv0SmpXndAru34XihvATBMI
         mzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aAPK2OKeJFMJudtkBsKtBuf55rqbWJZLS9a//k7qWy8=;
        b=Jlv8Xx18CDT42UL+E77puNtYwmBp0V9DNLkdbdL+lyfjjYza3dUNVM1CoONQlgRIIC
         GEe3mul5/TA67VW8Ava6c88WEgtE/K4ld7tP8S8rw4PZJBuQtkGTNJWKfrolOj/aT1LS
         exwDgtld7lwJB9q90H8H4pUxa4IfV5Zr2ZJDyRkqGojXALxb9UKdx1gduV+fYNDP0bX9
         IvkBLJ4+8DVjcONGsApL8l7yC8fBsl8CdtKuTw7DGqnC7n1pWSGlmatjsGXTg30+vom+
         vm0v/zQVOMMMJH2NqI/PGua0NTDarGuurP/LjTbRXtiDipzR5xkzZlnGgKMvZC16Ygnq
         weyQ==
X-Gm-Message-State: APjAAAUn+3L1vYF6WZe9L/E6FsaesiZHseosdiN9tYG6VJPUqHkYZiuD
        6W7DkQZWwDqft8I4jfILHMatOI7WBD1it1l5eS610g==
X-Google-Smtp-Source: APXvYqwkJ+U//6GtApKPM5EgxENLvEOX6hxM91xOuY29VJ0c1Pyqxs9KfIqMWN4kNkfT6zYt4WQTGzmMPy0Id0Tga/E=
X-Received: by 2002:a19:2351:: with SMTP id j78mr1890452lfj.173.1579887921566;
 Fri, 24 Jan 2020 09:45:21 -0800 (PST)
MIME-Version: 1.0
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com> <20200122235333.GA6837@szeder.dev>
 <xmqqftg6671g.fsf@gitster-ct.c.googlers.com> <20200123141626.GB6837@szeder.dev>
 <20200123175645.GF6837@szeder.dev> <xmqq8slx51zu.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8slx51zu.fsf@gitster-ct.c.googlers.com>
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
Date:   Fri, 24 Jan 2020 09:45:10 -0800
Message-ID: <CABvFv3+OfzK_2Wo97dusaj5nomSJTNghJHJa3=+HKH=-Sw12qQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 23, 2020 at 12:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
> > Replacing that last patch of the series with the diff below works both
> > on Linux and macOS and both on Travis CI and Azure Pipelines.
> >...
>
> Yang, care to do the honors to wrap it up with summary of the
> decisions as a replacement patch for the last step?

I've done a new rebase on master, did the CI change as discussed, and
pushed the changes to the GitHub PR
(https://github.com/git/git/pull/673). osx-gcc test seems to have
failed something unrelated to these changes, but everything else still
passes.

The changes I've had to make to make it merge were minimal. I can send
a new revision to the list later today if that's more convenient.

Thanks,
--=20
yang
