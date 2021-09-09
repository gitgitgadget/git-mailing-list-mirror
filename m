Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380A5C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 21:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF5061186
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 21:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345763AbhIIVMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 17:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbhIIVMj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 17:12:39 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F2DC061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 14:11:28 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id g9so4159768ioq.11
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 14:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iZYnF+wxjlEAZuRmwOW11JS0eVneyzs55jSkcIpc/YE=;
        b=xqDq1F7IG4VrBNkZx8Ry7uw4mZQj61NyqppRtSMT+mxi+AdwltFIFIz8i7Zfdui/Q+
         ZO12sJn2vlpjoa5uH88oAxPwcq5WzQ8K96EJRsK3zyg5QJdAnxIx6d8Vd+4d8hOzKcKo
         85DSCkwlPWKgTxP4PsjAXIdvNCALg3LD35jr88iCAf52X0PgclnmLfvUSlVkgewrxmm8
         bVK93vmaQskW7OiMnugmPnO40A28lNdJioUDqQavYhk09NIp6/PYcF/qXxD/J92h9M9j
         0ITqoZ36GLAd22G1l74BjfS+odaNrxltdyrnKT1z36SGpNKE18Phx0ZehpuVfXv1XZ50
         qSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iZYnF+wxjlEAZuRmwOW11JS0eVneyzs55jSkcIpc/YE=;
        b=tP/XRYKGX0+KPqI2SeZjTXWHHZz/6xJBwFoN8+XjqrLZIvYjmsiT/rlC4hBSn23FqM
         v6HHwwSeT+7geYD9yVxrhl/i+CoOYBN35uF7E2OXcyWo0doQWL9pmT/n8BxR5EU8DI8g
         4/AUbhDoSLoZUaN5n/iSqGmdyywsBLeBuU6WKQC+HIwcykRzxHliluGCb1opuv/t+PtK
         coyQZQt5sIp6WeA3ujg4lZD6ifG2GE+Ex0BHOyaDgt5Jyh0+yKbNDq7g2gdvFiM1/jT8
         VQ5lNXuL6DEnixQCHJc1S51CE+MajuYRP35kiQv+rmAL/qAnVZl79YsCs02CCKfFgcVW
         7nHA==
X-Gm-Message-State: AOAM531mDpmp0+2Q0QW6rfQV0n75oR61cS0lYq5mCqbk3WPCmPuMGnOP
        Yo521z+vFOdD5KExFg6RHfRAKw==
X-Google-Smtp-Source: ABdhPJxmhtSEI7dsJFVbuJE9ihzYtfuUQVq42ozD8pVXa57zn8WrWHGUSqdjMqrMbgNhgVRNEDh6eg==
X-Received: by 2002:a05:6638:1301:: with SMTP id r1mr1662926jad.32.1631221888109;
        Thu, 09 Sep 2021 14:11:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b19sm1462194ile.88.2021.09.09.14.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 14:11:27 -0700 (PDT)
Date:   Thu, 9 Sep 2021 17:11:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH 6/9] index-pack: refactor renaming in final()
Message-ID: <YTp4foh7gyIl3h1k@nand.local>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
 <3c9b515907ecb632faf73ce8db83efed1493d1f1.1631157880.git.me@ttaylorr.com>
 <xmqq35qdzg73.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35qdzg73.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 09, 2021 at 12:45:04PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > But since we've got "rev" as well now, let's do the renaming via a
> > helper, this is both a net decrease in lines, and improves the
> > readability,...
>
> xyz_ may be cute, but is distracting.  I do not think it loses any
> information if we used final_name, current_name, etc.; it may make
> the result even easier to read.
>
> [...]
>
> make-read-only-if-same or somesuch?

Both of these suggestions (dropping the "xyz"s and renaming the last
parameter to "make_read_only_if_same") make sense. Will apply.

Thanks,
Taylor
