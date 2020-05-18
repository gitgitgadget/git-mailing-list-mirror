Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B589C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34BE320657
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plDzfFP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgERTT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 15:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgERTT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 15:19:59 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0508C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 12:19:58 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b12so4615349plz.13
        for <git@vger.kernel.org>; Mon, 18 May 2020 12:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B2XTEIcHf9sc3A5ZAMZsvUM7Rv0qLyRrozZtkwIS4/k=;
        b=plDzfFP7nbB62H5vVppADT5F4xfNDlUNx4nC2GyD40mvCq6raPjlcKgUGMgMsX4hHP
         CRidCm9EgeS+XqRwvWdf6P1Lz+B2Xg8Vy7Q9c6B1a7xPXQh8bMiqt/t1xpYV7r+89ORN
         4DQKwHMotdf4yqZstcOSkwTmB/9Z5OcaTHY0YtDc3/7Ssya7m6OJIBY8pHdwpwvpcCef
         bF0sy7dhaPppaPUAIVNVvFyaZQ0LrrgfWSOPwrZsOPGhhMekebXt+sWF9LEtxC4CJDub
         AxYMIE1/IvVFmg74ttpvWqCaAsejSD6ROZdQ09wdqb/6/GqLRYkQvZWO/IhHCHRFFWYL
         JhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B2XTEIcHf9sc3A5ZAMZsvUM7Rv0qLyRrozZtkwIS4/k=;
        b=NVuy4ASZIQbXEgEWzlMsfJeEZrJ+ZAw+G/RKjf0jnc3+UVvh0CCZK4+AMKoEknMSOD
         UVLufrUb0A1lRCiL186OlAxWb/n7XqFozpcV+a5YW5tJlKVu8RRHUK7H6xs92XV+PEdl
         wmzYzPRK4UVBO25zh6uVR0x3szExFxaYsHCLKRk2Fj2cZcRmnj2nJM0BNHkoU8xK5EPM
         tK328Jaj0xMnBqpMTIQrkQ5z1LvYM71KNvvutoTJFuf2bR6dr1v2WES2JwpOLK0GbWL6
         vIB9G0U7iPT6kwII1iOpKQgAdNC1Z6xVdfwxK/rD3Hta/FfYJVLXYU0frf+kM1k5Mz2+
         KHBA==
X-Gm-Message-State: AOAM5305YddkC0ErgiQLdyrESeq+kSYjtBXA5kWZR+INJASzeJ+cfTvt
        3qgkL3xDZusfHF3mK7xBqZu/a1sf
X-Google-Smtp-Source: ABdhPJxH/7OVtrCYRfPnnLJSbjLnXCxs8YRtKh5ummgBf7i/hFXUJ0URERRFhCa7yHdNkJw1T/cuYQ==
X-Received: by 2002:a17:90a:bc4a:: with SMTP id t10mr982244pjv.104.1589829598516;
        Mon, 18 May 2020 12:19:58 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id d18sm267583pjv.34.2020.05.18.12.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:19:56 -0700 (PDT)
Date:   Tue, 19 May 2020 02:19:54 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Laurent Arnoud <laurent@spkdev.net>
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v6] diff: add config option relative
Message-ID: <20200518191954.GB1999@danh.dev>
References: <xmqq1rnk923o.fsf@gitster.c.googlers.com>
 <20200516173828.GB34961@spk-laptop>
 <92cb6302-09a8-6780-9398-890b1e766680@gmail.com>
 <20200516194033.GA2252@spk-laptop>
 <20200517021452.GA2114@danh.dev>
 <xmqqlflq7fyd.fsf@gitster.c.googlers.com>
 <20200518094021.GA2069@spk-laptop>
 <20200518135656.GB1980@danh.dev>
 <xmqqzha541la.fsf@gitster.c.googlers.com>
 <20200518172103.GA2110@spk-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518172103.GA2110@spk-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-18 19:21:03+0200, Laurent Arnoud <laurent@spkdev.net> wrote:
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index bb31f0c42b..167b451b89 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -651,6 +651,8 @@ ifndef::git-format-patch[]
>  	not in a subdirectory (e.g. in a bare repository), you
>  	can name which subdirectory to make the output relative
>  	to by giving a <path> as an argument.
> +	`--no-relative` can be used to countermand both `diff.relative` config
> +	option and previous `--relative`.

Nitpick:
Please mentions --no-relative in option list:

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 167b451b89..8761c04bc2 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -645,6 +645,7 @@ ifndef::git-format-patch[]
 	on-disk file to tree contents.
 
 --relative[=<path>]::
+--no-relative::
 	When run from a subdirectory of the project, it can be
 	told to exclude changes outside the directory and show
 	pathnames relative to it with this option.  When you are

Together with Eric suggesstion, this patch looks good to me.

-- 
Danh
