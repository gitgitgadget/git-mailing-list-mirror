Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEECDC433DF
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 16:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D1E207DF
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 16:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a02IBFjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgGTQzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgGTQzm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 12:55:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1A3C061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 09:55:41 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a14so3704817wra.5
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 09:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=z0DyPYJct7sJy5vE54XhqZyouEjzzMxCe9bXXWnZqnE=;
        b=a02IBFjNjLJGZbzEjLWNnqifJvWDa9zJr8h+TTZjAD0xDPyf7hGSnKp4iU10lXpz3a
         CRJLDlvL87V0UHuZs70E9bcGEpk4LVcC4DTMx8ilEane6bQxDh3doEOOs0Rl8pDPPCGl
         hnIDef6QPuikliDxyZ9XvtxBww0NCsXcdfTiO4L2gaVfRWO/lgHbvFHNYPXJmW3QGW6K
         aEiJ/waSFfGYTDk+HRN7B4afmw+cDbZOcgIz+KfiO/LedpivqAKMNhYvRab8ld+fgrSw
         oGO5HgGgg0bAmoD8G+BA9nhNFQWQZl9DxE7X2CSeRPBU2HWRyCj9x51iqBl7OtzrzXKS
         pT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z0DyPYJct7sJy5vE54XhqZyouEjzzMxCe9bXXWnZqnE=;
        b=KPgAXkAZjG7kG+9Y4LSVwpfIVNNuKuck/lTrahtfhHVbiBTQj3//M/p6gI6y5Fszks
         in3s1+P8AksqinHdMXjPXFRb070pBQivzVa5Amznt+P6OgNS02x7+QdBkKh961d2eNCT
         ILT05Cd0Uvd+pHHa25qKgVdX8Z0Y9EAsFA8JkXHs/Ax40y1Oam7InXS8GZ0m6F/ELhyV
         pkMmpSxGeVDGXaRjRpTisJ/XO5VStz3wozP+nxOri3TQebdI7RjWH7W5P4SmW7ls4KXs
         WUvDLEOfsn7Fi86w8DSRouXBOoSonMqap8g2rDV/cE6MFkyfWsI3HehGkQ/aiUo+4eYO
         Berw==
X-Gm-Message-State: AOAM530SChAs28SioyAiQw5bXlULQf9tdm3b7Ucb3M2iDBOtLJrGGeHr
        RzwqCryhnPpWURsT+zvs16w=
X-Google-Smtp-Source: ABdhPJxvSGr6sCejYv2RZG78kb6Rckm24/K3Sv/Fgo7YZJz58OwySKc75VuAQy3x+tWbHlqOdFdPwQ==
X-Received: by 2002:adf:f682:: with SMTP id v2mr11550848wrp.90.1595264139919;
        Mon, 20 Jul 2020 09:55:39 -0700 (PDT)
Received: from szeder.dev (78-131-17-71.pool.digikabel.hu. [78.131.17.71])
        by smtp.gmail.com with ESMTPSA id p11sm10134504wre.32.2020.07.20.09.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 09:55:39 -0700 (PDT)
Date:   Mon, 20 Jul 2020 18:55:35 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Martian Chronicles <martian.chronicles@yandex.ru>
Cc:     git <git@vger.kernel.org>
Subject: Re: BUG: Cannot use bright colors
Message-ID: <20200720165535.GI11341@szeder.dev>
References: <6244191595262309@mail.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6244191595262309@mail.yandex.ru>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 20, 2020 at 07:29:52PM +0300, Martian Chronicles wrote:
> Cannot configure git to use brightred, neither on Windows nor on Ubuntu. 
> 
> Steps to reproduce: 
> 
> 1. Create ~/.gitconfig with the two lines (or add to them to this file, if it exists):
> 
> [color.status]
>         untracked = brightred
> 
> 2. run `git status` from a directory with untracked files
> 
> Expected: output in brightred
> Actual on Linux:
> error: invalid color value: brightred fatal: bad config variable 'color.status.untracked' in file '/home/<username>/.gitconfig' at line 2 
> 
> Actual on windows:
>  brightred=normal=white.

Bright colors are supported since v2.26.0.  What Git version did you
try?

