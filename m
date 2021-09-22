Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A0FC433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3366F61211
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbhIVUME (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 16:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237408AbhIVUMA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 16:12:00 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E3BC0610CC
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 13:08:26 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h20so4033346ilj.13
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=60zcqkPtCeV/p1RGEbincQxBCgY/NdVoCzMPOp4sW9Y=;
        b=wjmgJ1aGGn/yHWMnUY3bHkR72dR6a4dnl67vOsmpEaYj5QGfS2J2BNEAF0oiv6TcWe
         qvUzbCh3jYlBS8eeqi3hundp/VjE53gwf3ZPzsIe5hu68dbBfvdg+mNufLQmxXjHfAeP
         rx9fO8p2jJphsQbpxiI60JUN76J5T8jqxZwugVGk8v1kBB2n3MdpYI2nsO16LlgSUH4+
         59VpBHPEQFCwBBXG43rcfZVKX4amCibQbcnlLNbSnYwNWSP/oVw+mUFXTDgg4iMhgz5v
         7ZLw22UralbJFeclptJBrlacwqUumtY1pg85dJTVLQPMgzAXsQIAhYilbDocCQvSZFD9
         2rWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=60zcqkPtCeV/p1RGEbincQxBCgY/NdVoCzMPOp4sW9Y=;
        b=lfUmdxNR9X6vKm40Q/81XhSaVrHUw88TyE+xeC45kIdk1nBJueYUeIWlsawHa4nSLP
         Fh+psU5tLV8qRpfFRyhEz/VQDq+TgDLfj1PfEDkzm6w7nW5dUQsssq8zjqAUOTyHyxRg
         gcG7BDfCIiNBKF/6inSotyrTB5E0EHgVGLr0VXKQHDWGWhagDJ+zTEA8VTzKmX1Lz6UT
         kU06HToBrpHV65rdEJ6KckPEpIbmXqwJZnaB5IKr3mHsxJOrzL+lEezaRTAr4OW1FIGF
         9aF4KaKkEIKxrN12nC/s9sLXMGHW+b7cY8UIedEzbvsCe8omj6r9PyGjjRCYIBUGNYHQ
         yHRg==
X-Gm-Message-State: AOAM531tcMlOmtk7pRpDrvkNqXUmmhm8w91HFvmIZ+OOp08n9nVmcrqk
        Od42UU/zMUwjpS1qoUo8OsE+xw==
X-Google-Smtp-Source: ABdhPJyRULa1QmQL2xTYhZac2eQXB9uh1iT8umZlHOh6owJ4tKwq1SAiyq51Sa5Fn7Oqr6kSl7cMpA==
X-Received: by 2002:a92:c54c:: with SMTP id a12mr649024ilj.81.1632341306267;
        Wed, 22 Sep 2021 13:08:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d10sm1519210ilu.54.2021.09.22.13.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:08:25 -0700 (PDT)
Date:   Wed, 22 Sep 2021 16:08:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        wolf@oriole.systems
Subject: Re: [PATCH] rev-parse: fix mismatch quoting of separator in the
 message
Message-ID: <YUuNOcqClVjQamYh@nand.local>
References: <20210922111744.675326-1-bagasdotme@gmail.com>
 <YUtqp+1Mwl2v0kuh@nand.local>
 <xmqqzgs45s15.fsf@gitster.g>
 <YUuHP41V9m7cIEBL@nand.local>
 <87bl4k7532.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bl4k7532.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 09:59:51PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Wed, Sep 22 2021, Taylor Blau wrote:
>
> > On Wed, Sep 22, 2021 at 12:28:22PM -0700, Junio C Hamano wrote:
> >> Taylor Blau <me@ttaylorr.com> writes:
> >>
> >> > On Wed, Sep 22, 2021 at 06:17:45PM +0700, Bagas Sanjaya wrote:
> >> >> There is a quoting mismatch quoting `--` separator in "no usage string
> >> >> given...." message (`' instead of ``). Fix it.
> >> >
> >> > For what it's worth, I think that the `' style is typographic, since the
> >> > pair look like English "smart quotes" (as opposed to straight quotes). I
> >> > have no opinion about which is better, but I don't think the pre-image
> >> > was necessarily a mistake.
> >>
> >> I thought that we try to avoid "smart quotes" in our messages.
> >
> > I think UTF-8 smart quotes are generally frowned upon in source code,
> > but I didn't think we had any hard-and-fast rule about whether to prefer
> > 'this' to `that' (for what it's worth, I prefer the former and it seems
> > to be more common).
>
> No comment on what's preferred, other than I wish we'd pick a style and
> stick to it. Just a note that this used to be the way to do it in
> e.g. the GNU guidelines, I see it isn't anymore though: [1].

I agree. But for what it's worth, I think we should:

  - accept patches, such as this one, which move things in a positive
    direction

  - not spend a ton of time or reviewer bandwidth on conversions
    throughout the tree

In other words, I'm happy to see patches like this, or little clean-ups
along the way in related areas, but I would be unhappy to see a massive
patch to change all instances from one to the other.

> 1. https://www.gnu.org/prep/standards/standards.html#Quote-Characters-1

Thanks,
Taylor
