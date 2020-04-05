Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F128C2BA1E
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 23:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E856220672
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 23:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EW551gMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgDEXmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 19:42:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34439 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgDEXmO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 19:42:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id 14so11285839qtp.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2020 16:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5QYaPyULqjbkQsq/i8+mTTUIY4GFTehqUbNWUbUoSaY=;
        b=EW551gMUDqD8ajnZv3MN0QyHyTPoCb5l0sCpd+r3ZUzYSlGbdgQ8OUZB8ol8C00Sjb
         54YNNl3Vk/v5ynRZzttFaw9LyRZudey8vacLQ59pcc3PikGvv9BzHMCNa3R3KFOixtKX
         6H7YdTVARMIZBoNNFncUGu9jkbGKBSj5fjzPoCWhol6dQ06F91X5UvmAutmx7/WPYSr8
         i8OHB4ZpdU8HAZnm3XLcHM67SBW1E4KTghJsaI+xqAN0xNSMepf7s16OK7JJ9uJObLKV
         hBCku5G1LtwP62/ZYIph87JEUSLPOxq8mL7c6rrzc7TK2xEtzp8xLxWT40FrZYKOnnD8
         pYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5QYaPyULqjbkQsq/i8+mTTUIY4GFTehqUbNWUbUoSaY=;
        b=qhDLh10afmSY1vTNUnLk/2c5sYtRT96TmWxzQXi09PFv3wWYgfp0syNKUsXgys5K8M
         7yv8sAkJF7EAL/dxphrVU/Vc1U9Ubuy+BMwXn9yXgpP8VRlV0kFNPaX7HnHIVkwalAHF
         LXt6QHZB7ZUhZN8+4xORHzJxMM3gUVV3gl/EpkSWr05Zn5uIEINyjdvCtqMp4juitOgM
         9iUIhJnUQxwOF5ztjMEOQfhtZMw2WupoVdquZbCbSXMA+sXntaNnoC2OOlSatkjcDhJM
         mGMxT8SFLh4DNkTnbnkv4ToZ+0e/8AtEMa2Hbmw/MSgCRRUD0y1npH4sI+5jxR6kP9Z4
         67MA==
X-Gm-Message-State: AGi0PubDX7t69xLVN/S4f0YOh0j/fouolGBNNaXDv2jPg1LuwlIG9cWn
        kiXeo6qMx95AA09bC1iPrV0=
X-Google-Smtp-Source: APiQypLxc/Y0ywBS7nlJW8lNFVF2Z4Z492lnNuaQMw3R9R/+DHKdiU4/JcdxTG9SsyObBjtFRsnfJQ==
X-Received: by 2002:aed:2518:: with SMTP id v24mr16646290qtc.138.1586130132173;
        Sun, 05 Apr 2020 16:42:12 -0700 (PDT)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id p38sm14281186qtf.50.2020.04.05.16.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 16:42:11 -0700 (PDT)
Date:   Sun, 5 Apr 2020 19:42:09 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 03/23] sequencer: stop leaking buf
Message-ID: <20200405234209.GA1346725@generichostname>
References: <cover.1584782450.git.liu.denton@gmail.com>
 <cover.1585962672.git.liu.denton@gmail.com>
 <76585e5b1367a3adf18d761b2af9356ee64b46fd.1585962672.git.liu.denton@gmail.com>
 <xmqqzhbpwrcb.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzhbpwrcb.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, Apr 05, 2020 at 02:33:08PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > In read_populate_opts(), we call read_oneliner() _after_ calling
> > strbuf_release(). This means that `buf` is leaked at the end of the
> > function.
> 
> I do not think the above makes much sense.  _release() will free the
> piece of memory occupied by .buf and reinitializes the strbuf, and
> in doing so there is no leak.  read_oneliner() called after it
> allocates and reads into there.  Freeing the resource needs to be
> done after the caller is done with what read_oneliner() has read.
> 
> There is a leak, because read_oneliner() gets called and before the
> code has a chance to do strbuf_reease() there is an error return.
> That does not have anything to do with the call to strbuf_release()
> in the middle of the function.

There is also a leak in the case where we don't take the early return
since, before this patch, the read_oneliner() has no strbuf_release()
following it which means buf gets leaked.

> But that leak has nothing to do with the release called before
> read_oneliner().

What I meant to say in my paragraph is essentially, "strbuf_release() is
placed too early, there is a read_oneliner() after that nullifies the
effects of strbuf_release()". I can rewrite this to be more clear.

Thanks,

Denton
