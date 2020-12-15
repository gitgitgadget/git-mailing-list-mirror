Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37300C2BB9A
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 17:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7072255F
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 17:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgLORji (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 12:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbgLORj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 12:39:28 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57764C06179C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 09:38:48 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id v3so11399453plz.13
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 09:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Sh6AE6VDoxML6ulB9chlTbiiu1HBFiUfqMdVhLlOSfI=;
        b=jHwH4If6wx8HSX9KZDdSCn/4PeDLCADntK8n57rq0g7llofLYpqEPOux368HnurqDj
         /fQJaCzHwA8qoU1Rs4j5OBSMVdCNXBmMCiyiMKFTLR7BGL+Z0CdejOFUDjgsUSWTY1X8
         FmVuXxjHiLL2bAI+lFB7hYAre/SJRjTPTg0yoK13pya5LO/FNcscNyZVVOqBXDKy2ftg
         Pv5Yezqx7GPyrqxJqlVX7EcnXwOL+gIQpWuvssbhu5WcQdA7zQIg9n1ivdTKzFDZ7OK0
         kJyPRhxChY55Oq3r2pKkdxNftPG5zio2oGqO7FzT36ZaOL5Za5TgFgsjmt0AhxW4HBaw
         YQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Sh6AE6VDoxML6ulB9chlTbiiu1HBFiUfqMdVhLlOSfI=;
        b=ptdsy0xoLbMonW5hSZ57vVjxfKWQytnUOGFTZklF9isVby/QnAKa5XmM/4AeDYG2ea
         h4OxuziV4dU5uD/otT/H19tG2G6g3UOlaavdbBm+8Mk2h9Racs8wbIrHCejL4uUK+Iyr
         +amr+qLoMkXn0JpNKsuEynbDi9nRQ6rBu6+JKvd8XfrOiZw7IY/pYSmWm6I0Vl98UIBt
         vMSw5ycDUX9jGAsrvXeh8+BUXZqOHiQ69byZowqYel1waVm8cHXttN39Nv2O3JgJEpc+
         a7F4QZv/u2MBeYxeMwyVWJXgw365knnNWChZoz26Z2vXoO0ybJuEYkJXNIgeUecqnV2S
         UcPg==
X-Gm-Message-State: AOAM533mU5S2wrYCQx00Rl29wu45Zl4wLvFtBhE/Hv7CmysA6z6CBtmU
        WKYNFolbWUajcWl4Svxipu0=
X-Google-Smtp-Source: ABdhPJz78UtZ76cEpfuSHrRpil/qQ9odf5J8mT2Al5OBd/QoqHSfPHqmvoLuVSbIZ7A0X2QL06rpjQ==
X-Received: by 2002:a17:902:bf44:b029:da:d0ee:cef with SMTP id u4-20020a170902bf44b02900dad0ee0cefmr3491429pls.12.1608053927908;
        Tue, 15 Dec 2020 09:38:47 -0800 (PST)
Received: from localhost ([2402:800:63a8:d2ec:a2b0:6089:8a5c:71e2])
        by smtp.gmail.com with ESMTPSA id b1sm24658562pgb.30.2020.12.15.09.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 09:38:47 -0800 (PST)
Date:   Wed, 16 Dec 2020 00:38:45 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: Re: [PATCH] doc: mention Python 3.x supports
Message-ID: <X9j0pf1lQQHZifvw@danh.dev>
References: <20201210143017.24615-1-congdanhqx@gmail.com>
 <xmqq4kkoat8v.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq4kkoat8v.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-12-14 15:00:00-0800, Junio C Hamano <gitster@pobox.com> wrote:

Sorry, I didn't receive this email, I found your reply when looking
into public-inbox's archive. (I guess it's because of Google global
outage).

> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> > Commit 0b4396f068, (git-p4: make python2.7 the oldest supported version,
> > 2019-12-13) pointed out that git-p4 uses Python 2.7-or-later features
> > in the code.
> >
> > In addition, git-p4 gained enough support for Python 3 from
> > 6cec21a82f, (git-p4: encode/decode communication with p4 for
> > python3, 2019-12-13).
> 
> I am not a Perforce user, so with that in mind, please help me make
> sure I understand the situation well.  The statement "not 3.x, which
> is not supported by Perforce" is from early 2013, and 6cec21a82f
> talks about the format of marshalled dict object that comes out of
> p4 (Perforce) tool that needs to be read in a certain way to be
> compatible with Python3.  Does that mean sometime in these 6 years,
> Perforce started supporting 3.x?

AFAIK, p4 is an executable binary (in the sense of ELF binaries) from
forever. And its {in,out}put is in arbitrary encoding, while Python 3
expects UCS-2 or UCS-4 encoding. 6cec21a82f adds code to decode to
Python 3 string to overcome this limitation.

Not related, but Perforce's official Python bindings supports Python 3
from at least 2013 [p4r13]. And they still maintain in [PyPI].
That binding requires compiling with Python Development files, though.

Anyway, I added Yang Zhao to Cc to clarify.

@Yang: Would you please verify what I've said?

> The change to INSTALL just drops the mention of 3.x; do we want to
> specifically say that any version of 3.x is OK, or is it generally
> accepted that Python 3.x is "later" than "Python 2.7"?

I think it's generally accepted since there're no Python 2.x version
that is "later" than Python 2.7.
I haven't check the whole git-p4 but in general, a lot of Python script
said support 2.7 AND 3.y with y is a specific number,
since some scripts can work with 2.7 and e.g. 3.4+ but not 3.3.
I can add them into "INSTALL" if it looks better.

p4r13: https://www.perforce.com/perforce/r13.1/manuals/p4script/03_python.html
PyPI: https://pypi.org/project/p4python/

-- 
Danh
