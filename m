Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CF5C352A3
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 02:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25142187F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 02:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv5Cnfzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgBNCKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:10:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42696 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgBNCKa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 21:10:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so4061128pfz.9
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 18:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QWtvL6Rgj1Bx4w/VZwaWjU/Bymgp+fbasN6v8ZaRpmE=;
        b=Hv5CnfzfHk+Pd9eAjWaluso/qr5SuZe+9TiCCiVzU2+oqzcbuzE/SpOMAf3/KQ6ttf
         denRm2ABIxNJ0HHeph5JaztryIeFm6p5N4DcE59NUscR9EsKxMb3dBI/vh7WAERbIm+A
         E6A2DCkntB2wrnutxSVaYu6D0IxupS6tWrboarrvXnY4y1OGUyYRRzb2vI5zVnf2P7zV
         jYd1aH35fXWP9ra5/uDGll2i8tZbeLDJhE+eIL3fNTcgGF/gNc4MYdVB+kUCSrAZm7tN
         SVoFrQP5d1d8x3ITZ/rQCtMks1zobmN4eKCaQ+LGZ0AH37Ir4QOzpGApizny5NXgdr2i
         ysPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QWtvL6Rgj1Bx4w/VZwaWjU/Bymgp+fbasN6v8ZaRpmE=;
        b=T+gWD/kF+LzKkOWqNtXPf+L9gMLC/ZKm+RkiHHYvDH3Z+QgnA/2GvQXQm3QhXX8lio
         FJBJatP21w1/EFpa4OIeO3tGmBsE0qQlREDR7VevGF6G3qJ4A47HrN6IgeRbMBPAajmP
         SwHigSyboyOmzSLVXPovuGd/VGhyL+1WgG6k3yLmQYjFtNGZVNPU2CL808rHmNCR+fP8
         DqvB1zLRUuUVWedHIvA0PKyIZO4w4VaK7MC0fckVcLjrmzISIjpW/4XD8Ui44wWPCIfz
         uOJVuu8SFa0tXixzPvd/gFJ0QSFmt8trKaExwGFgPXydJ6hg3gfNehj0rqNUxGd2uphx
         gjOQ==
X-Gm-Message-State: APjAAAXO2EGfJiwCqg6SofR4WJdma+Xb74Sep2IObTM2DurvsaNo9RS9
        4hQXmAwIhltLUOtRXPiv1T8=
X-Google-Smtp-Source: APXvYqy24DJxt7++ddD+w+bTFVSbOuEvRVzYD166NvVhQVRRVWpSI5s54kFvO8QpGtnWlNdPhClXVA==
X-Received: by 2002:a62:e414:: with SMTP id r20mr930009pfh.154.1581646230078;
        Thu, 13 Feb 2020 18:10:30 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id t11sm4394689pgi.15.2020.02.13.18.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 18:10:28 -0800 (PST)
Date:   Thu, 13 Feb 2020 18:10:27 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] MyFirstContribution: rephrase contact info
Message-ID: <20200214021027.GA191976@google.com>
References: <xmqqh803fzf1.fsf@gitster-ct.c.googlers.com>
 <20200214020359.17463-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214020359.17463-1-emilyshaffer@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:

> Make an effort not to discourage new users from mailing questions to
> git@vger.kernel.org, and explain the purpose of the mentoring list in
> contrast to the main list.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Documentation/MyFirstContribution.txt | 29 +++++++++++++++------------
>  1 file changed, 16 insertions(+), 13 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for tying up this loose end.
