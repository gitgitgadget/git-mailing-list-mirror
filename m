Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86A461F597
	for <e@80x24.org>; Sun,  5 Aug 2018 03:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbeHEFgz (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 01:36:55 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33576 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbeHEFgz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 01:36:55 -0400
Received: by mail-yw1-f67.google.com with SMTP id c135-v6so2444104ywa.0
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 20:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uS4bwKLd4F+3XNRyY1k4/0O0y7NAWayJzczxt7mUxiY=;
        b=NsEH3uYqk93W87Yo3UnxQjCvlxspZnNEPDeg5FD/FVg2sBH44PPrJqhwI4h2xdwbQc
         MySyiOghIP4KZYMMtqUhBW1PGuxKYRzZLCo7V7lgL+g580+Fe9FREonb9rycWVmlK6NG
         ihwkCxAKqk8Pm+NH4T2XGi9F70n2S3ZAsPcVXhZ/RO0he9s+xIOXdkvi9rhjvaBfvBv1
         pSzL5L08lc+7XeaabhQj2z5XAE+eyL42W6BUOK49uwk+1xZSDZTxv4wBZvIVWG2GQGw9
         vpiqsv6PLVBecsfzi7IKmCk33aytd2eec/waFdrVlDmsNSbpVjhvX0M3s3gzp/gsvvQ5
         NyNQ==
X-Gm-Message-State: AOUpUlEBdrug7MeBxtqQ2GGYXV71fO9Z1S/LOTBLHPuVODl/UzBrCtre
        kNLSMW1gde9uw9ASPKopRd9SSq5TybRbqN/sCn8FZw==
X-Google-Smtp-Source: AAOMgpcwq/pIEIGRULA05kYLaOGunScPmMIGponAk93a2rC0L522HcHUAl0YYInoK8u773TgkNyzzqtNLBsxDIxnzUk=
X-Received: by 2002:a81:ae66:: with SMTP id g38-v6mr5334352ywk.74.1533440032899;
 Sat, 04 Aug 2018 20:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180804020009.224582-1-sbeller@google.com> <20180804020255.225573-1-sbeller@google.com>
 <20180804060928.GB55869@aiede.svl.corp.google.com> <CACsJy8DxSDLD7B8Z+GBFOuU7d7VQ4-M=BP=wptra5rBiZGspSQ@mail.gmail.com>
 <CAPig+cRA87UZsynme-by+s2ZmQW2Aus9KQscCU9mXmALCBKkKQ@mail.gmail.com> <20180805031709.GF258270@aiede.svl.corp.google.com>
In-Reply-To: <20180805031709.GF258270@aiede.svl.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 4 Aug 2018 23:33:42 -0400
Message-ID: <CAPig+cRjxLgGZbROZAuH-VF3xLVUxQTRj7gKPFurypbwz2zzjg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: enable DEVELOPER by default
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, git-packagers@googlegroups.com,
        Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 4, 2018 at 11:17 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> > utf8.c:486:28: warning: passing 'iconv_ibp *' (aka 'const char **') to parameter
> >       of type 'char **' discards qualifiers in nested pointer types
> >       [-Wincompatible-pointer-types-discards-qualifiers]
>
> Oh, good catch!  POSIX documents iconv has having signature
>
>         size_t iconv(iconv_t cd, char **restrict inbuf,
>                size_t *restrict inbytesleft, char **restrict outbuf,
>                size_t *restrict outbytesleft);
>
> config.mak.uname contains
>
>         ifeq ($(uname_S),FreeBSD)
>                 NEEDS_LIBICONV = YesPlease
>                 OLD_ICONV = YesPlease
>
> So it looks like FreeBSD has modernized and we need to make that
> conditional in config.mak.uname on $(uname_R).  Do you know which
> version of FreeBSD changed the signature?  Care to write a patch?

Unfortunately, I don't know in which version of FreeBSD that changed.
I rarely fire up that virtual machine (only in rare cases when I want
to verify some change to Git also builds/runs/whatever on FreeBSD), so
I haven't really been paying attention to it. I know that this warning
was present in 11.1 (and I'm guessing all of 11.x), but I don't recall
if it manifested in 10.x. I guess it shouldn't be too hard to install
various versions of FreeBSD to determine this, but it would be quite
time-consuming. I'm not very familiar with FreeBSD-land, but I would
hope there would be an easier way to determine when it changed than by
installing old versions. Does FreeBSD have historic package
repositories (containing headers, for instance) which one could
consult instead?
