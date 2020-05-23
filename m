Return-Path: <SRS0=yx/J=7F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625C6C433DF
	for <git@archiver.kernel.org>; Sat, 23 May 2020 02:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 242AC206DD
	for <git@archiver.kernel.org>; Sat, 23 May 2020 02:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMRWFSpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbgEWCOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 22:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387413AbgEWCOk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 22:14:40 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2222C061A0E
        for <git@vger.kernel.org>; Fri, 22 May 2020 19:14:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 5so5828471pjd.0
        for <git@vger.kernel.org>; Fri, 22 May 2020 19:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YaMfLWyIHE0MI2jocNUXWW3nAzSrOFM4KTPDie8++bE=;
        b=CMRWFSpGiuJZ+pJW4xDREp5Dix3B9Lfuzhvv2PQECwJUKjen+moVng3WBQpdEDiDp5
         Qe6XlOlwl4sj9SPBMizkownFB59g0nwwqumQWsJoyIQpBz3IOpkLh6oQFbT0Kr37Z0Ty
         BJyrvnZlxe+wxuTB8U7EB4N+qiITfgxxBks5XCINR5t2ScKyNYS6/4UlC76IhL1AQwYw
         1ul4MJRQMLZhyijKUGx+OYfJ6eogfbuiTEbnbUDwaL1iEK9KfryDY7B2wQpYFeQ6lwju
         TOEDSuczicbxthvkXO6zNIazDWC9y0Oajd0svDkGU4JRBgfvJZuTfbtuLtz2bGfjELKt
         kOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YaMfLWyIHE0MI2jocNUXWW3nAzSrOFM4KTPDie8++bE=;
        b=taj5JxUHcvlNdUVXIOqT5CKZb0zl0HBc5FmBRn7o8CqsUD2E9VYg9uaqud5xvuoL0Z
         Nqywz6/8DE95PDrqTS/jHKbYZaAkaFx4WdSDXcwbwHwLS3X6WhlJbrNVjUtR5ekRGkhZ
         hRKGl7MPgU8luddSnrB4MnzMAdR0i4iUXcZyOXvSSq07SDoxAUQ2QX/fzLL9LDdNPS1B
         alFmTpWoOBNqa2g46Hs2Tctwn6GfL1inua1bDgO9H3GvXw/gHj4M/brQSXYEcRlKyQ7N
         Ur8dLPAs1e23M/P3aCbaWIk8QerIGV+F6eQLOCBknVnixqndxMCVqhJOwdGhL0iRsKyc
         XwMg==
X-Gm-Message-State: AOAM532U7NnEMki1ZwfeHBB50y4Z7UTdfMnFSlrYzRdgmFr85u93y2TK
        Bi19pBJXIefiTW5NRaSjHyA=
X-Google-Smtp-Source: ABdhPJwyHr81Kh3E5RqqCsIcEiQ+A18GSsQeC40ptsWnVvmIeGul8x4w8RP9qwnsNhN8oE9XG48rEw==
X-Received: by 2002:a17:902:bd47:: with SMTP id b7mr18251054plx.79.1590200080171;
        Fri, 22 May 2020 19:14:40 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id z1sm7690728pjn.43.2020.05.22.19.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 19:14:39 -0700 (PDT)
Date:   Sat, 23 May 2020 09:14:37 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Laurent Arnoud <laurent@spkdev.net>
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v8] diff: add config option relative
Message-ID: <20200523021437.GE3283@danh.dev>
References: <20200518094021.GA2069@spk-laptop>
 <20200518135656.GB1980@danh.dev>
 <xmqq4ksd5ggq.fsf@gitster.c.googlers.com>
 <20200518191205.GA1999@danh.dev>
 <xmqqo8ql0yjg.fsf@gitster.c.googlers.com>
 <20200519003006.GC1999@danh.dev>
 <xmqqv9krztwp.fsf@gitster.c.googlers.com>
 <20200519193902.GA202573@spk-laptop>
 <20200519230124.GA12509@danh.dev>
 <20200522104618.GA2050@spk-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522104618.GA2050@spk-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Laurent,

On 2020-05-22 12:46:18+0200, Laurent Arnoud <laurent@spkdev.net> wrote:
> The `diff.relative` boolean option set to `true` shows only changes in
> the current directory/value specified by the `path` argument of the
> `relative` option and shows pathnames relative to the aforementioned
> directory.
> 
> Teach `--no-relative` to override earlier `--relative`
> 
> Add for git-format-patch(1) options documentation `--relative` and
> `--no-relative`
> 
> Signed-off-by: Laurent Arnoud <laurent@spkdev.net>

Look good to me, I also run those tests and manually tested some
usecase I'm interested in.

-- 
Danh
