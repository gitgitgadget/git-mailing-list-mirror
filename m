Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6D3C2D0C6
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 11:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8E020CC7
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 11:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMBw5Pq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfL0LjC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 06:39:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44100 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfL0LjC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 06:39:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id x7so14315746pgl.11
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 03:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VTETEeFwmEB0tsbV7BDyNMn/7mkvaw+g2pheSL1/Uig=;
        b=kMBw5Pq+c4k4YcEpqiYn9Xy8Xdm+ZJRAodZMxwMyPk5m7z1euOQyMkqx2G9REvQemO
         5jMBeXtGYV8CLJkOpPFu2llyz+cvAzdvfeHjGcwc9qOpMRyXNCKe3gaR7mTUBYVWpeol
         hxQjTgtJoh29pOP0GZTrgf7+sOg9pq+Sw3b3+qjOR2B57U127+AH3YVFK5IAfJKQQOsP
         Uwy4BNZqjSvnxl+2oUDC3+Gj7fqTGdIXI4hrSibPTky+YI5CG7X6ETyydlV5ATIboJwa
         fjL1d7XvYpyZueSplqtEpIk8sd71JxYD2kgB+VOQY2pRXGtbUDTsTZVlKvZI6lKonED5
         MtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VTETEeFwmEB0tsbV7BDyNMn/7mkvaw+g2pheSL1/Uig=;
        b=MbspAjW0he671WVQjeLSKsgPNuLJCi9CTGEvXAgcxetfteeckKLyMIAWYpaKRkWINK
         pEyiQIyC8+upQYGqjwwpCWHNtWDCQAgpkcZQJVSFZu08FxLKMziwQivcfNvKw7/PRlcB
         1H8HMO2NCd82AF/r//9blfVHfF8upGky/78/4HkMdQk2uzpCJ7rvPcA1QqP0RTl4D8eS
         IRuEEpPVKmW9r4cZCoG1DVZi0/I4cPDvFxmAjvBA6qiJXbJMXYnnivsuntL3CHe4xms5
         7HZHWx3R4BoFQ/ZgADzZBaIqItn/D1NSEXFpdfGHYP1K1peZb2Pm0w6+MGmu1BhKzR6n
         JlLg==
X-Gm-Message-State: APjAAAUyyRZgD/cbE6NbZNSNEb83mR96ITfMsS0jKFHdZwZ91LlIj4+b
        d+R/MOa5n5JQDQ3WyRWAXXxpDJjP
X-Google-Smtp-Source: APXvYqxdZrYqkaO9ev1567u2RZAMXa64KLrheR7qKPBcVcONM/hGoy15h8MMmZDQQbGxbH8b9pvmBg==
X-Received: by 2002:a63:c207:: with SMTP id b7mr54278115pgd.422.1577446741386;
        Fri, 27 Dec 2019 03:39:01 -0800 (PST)
Received: from localhost ([2402:800:6374:a714:860b:62b8:d6c5:f06c])
        by smtp.gmail.com with ESMTPSA id f30sm37043875pga.20.2019.12.27.03.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 03:39:00 -0800 (PST)
Date:   Fri, 27 Dec 2019 18:38:58 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.25.0-rc0
Message-ID: <20191227113858.GB24268@danh.dev>
References: <xmqqblrwm65l.fsf@gitster-ct.c.googlers.com>
 <20191226143527.GA24268@danh.dev>
 <xmqq4kxnm0w6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4kxnm0w6.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-12-26 09:50:49-0800, Junio C Hamano <gitster@pobox.com> wrote:
> Danh Doan <congdanhqx@gmail.com> writes:
> 
> > My name should be moved down to next paragraph,
> > since I was lazy to type my name with all accents.
> 
> Your first contribution was back in v2.20 days, and then the recent
> ones are all within this cycle for v2.25.
> 
> I am a bit curious why you need to avoid being lazy just to give the
> correct name to your commits, though.  Isn't 

Some of my projects requires ASCII-only user.name,
instead of doing the right thing

	git config user.name <simplified-name>

I decided to set it globally instead.
I rarely need to type in my native language,
hence I don't have the IME software start with Xorg.
It's all about my fault.

-- 
Danh
