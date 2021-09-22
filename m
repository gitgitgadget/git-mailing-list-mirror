Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC034C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC92161100
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbhIVToe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 15:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhIVTo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 15:44:28 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C400C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 12:42:57 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id b15so3990544ils.10
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 12:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aEzDYHo94eUxBAakI8zF6xj1wb8Iy5LCFKBGuv3a4KA=;
        b=zYVTSo+c3B/FPymhMTeWufNZa+wYX2s9s9VHMtTtUEZrvFBH0lNq0TkMzHjU12XqQ4
         MEssppXWW+ju75YcrjdwMrEU5prCi6JXHhJUetM80gvIU8kDHa6NgB043hJ1+lJ6/Xpw
         0eDOROAsB/NLFcvUUySiqX7zPzPVWyDV0deT6mSZ4LQvefEVVnsjeCra45g1VWS9ViTU
         JfYAH/DYlCTLEUF33YaN8XwtbM9Sg1Q7AWjq0Jbz4Z8k5d17jmea1emHQ4SyCtbHFl9K
         auZIjqjkx4nEUES0htarBIenN+vLoLi4skxFZqwDKWA+mZes5jj02pcVi174pkZoO2uy
         xwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aEzDYHo94eUxBAakI8zF6xj1wb8Iy5LCFKBGuv3a4KA=;
        b=v+D5WIfDt4oF7ufFPnHSG97Mj5DuYP/GBI6Z7U41d42jSSrU7S/3d3TmH4tu6xhJ/i
         x7lBg01v/JBNsRwObfqJfT7nfT8XxM/I7kgcxjLVJHafK24gi9R/+j6g0QA4/OYi/FRm
         /Fl3ninzqPvhkChcsOzE+9v8CjtRSbl7RIgg2TvqvpyoWpvPKtgybDojZj8DD3lpiHbT
         vfPuJHrknlJ260SoYy5e7+ncokQujpXYZ5OrInaCGiHwBWxB4KYGedSVYdICoHKovIPx
         xPKVsg4jHBh1Y7UpKTs76O0L8HlKaapQkDxkrk1GXcFyj2eecHErMJdXLkat4bL8/3Ar
         HILg==
X-Gm-Message-State: AOAM533hZs98rlnbDKi1/tHPfx/eYH5nLKenJmng3tR8QQwkidFLv7a9
        HevlaYcxB8g5bVn6CTh5Y0xe7g==
X-Google-Smtp-Source: ABdhPJwECydOTZ8O3llxN+DynUjUqbBAK5n33szws3YqQ0FYo4j0m/6UvvEOsrQVcXehKTNSOB9i1Q==
X-Received: by 2002:a05:6e02:13d4:: with SMTP id v20mr577415ilj.247.1632339777058;
        Wed, 22 Sep 2021 12:42:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z4sm1426032ioj.45.2021.09.22.12.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 12:42:56 -0700 (PDT)
Date:   Wed, 22 Sep 2021 15:42:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        wolf@oriole.systems
Subject: Re: [PATCH] rev-parse: fix mismatch quoting of separator in the
 message
Message-ID: <YUuHP41V9m7cIEBL@nand.local>
References: <20210922111744.675326-1-bagasdotme@gmail.com>
 <YUtqp+1Mwl2v0kuh@nand.local>
 <xmqqzgs45s15.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgs45s15.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 12:28:22PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Wed, Sep 22, 2021 at 06:17:45PM +0700, Bagas Sanjaya wrote:
> >> There is a quoting mismatch quoting `--` separator in "no usage string
> >> given...." message (`' instead of ``). Fix it.
> >
> > For what it's worth, I think that the `' style is typographic, since the
> > pair look like English "smart quotes" (as opposed to straight quotes). I
> > have no opinion about which is better, but I don't think the pre-image
> > was necessarily a mistake.
>
> I thought that we try to avoid "smart quotes" in our messages.

I think UTF-8 smart quotes are generally frowned upon in source code,
but I didn't think we had any hard-and-fast rule about whether to prefer
'this' to `that' (for what it's worth, I prefer the former and it seems
to be more common).

> And we do not expect our users to be expecting to read their error
> messages in markdown, so `--` is not a "Fix", either (do we have
> many instances of such uses of backticks in messages already?).

There are many in code comments, but I could only find a handful in
error messages or the description of command-line flags.

Thanks,
Taylor
