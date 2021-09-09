Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60DCC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 21:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB34061100
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 21:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345859AbhIIVOQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 17:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbhIIVOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 17:14:16 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45987C061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 14:13:06 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id x10so3395200ilm.12
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 14:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VmBvgdbFn873EKCp5NOCHVnVjWZdpDgLaSy65ymjwic=;
        b=zp6Jpud0CrgBtV0Rmh9sF66ORHu0W26P3SnHfu5oyz+q74+ilSRkgX7faJTJoKmr8Y
         UFo0OTwMQZh91Arz2WlDWCZ/z0JyznxibiG+kEjnRRB6e2KqLIOj6qqXUAbQ4gwUTsly
         PwU7D+r93Y94BcY5+48RR/OMiySI3L9qUIwRieJy7alQKztR75ZX3eupwI96B2Mn3xyS
         bgQ6orJn2Ylv6oN8zygBr+TdQbQDbDmFr2gMPxFTduTqc3a3AaTAGksusXvlFlwjUkTM
         TJWmoabzVkmm5X+1BwDFIwii+QJPOTzbeZM69XuUV+siidOxIhNo1MBeT+C+lECSMGrQ
         Cv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VmBvgdbFn873EKCp5NOCHVnVjWZdpDgLaSy65ymjwic=;
        b=0u+/xb9M4jzRFP6TH45pzDJeRqvbAF8WATcA+AFQrfn1xdrOxIqZDA9kQSu2CO8H/E
         SZLhKrcXqKvhXDUhlfDqzPzRZ4YcNaaNXOubQWn/jjbpvc6tRQTcRCnVZfrc0M5AJ4if
         4LjhBRkuMmZShy8umtBZqHUfQMICrkaYp+Sezq3ROyHB7gXk1nOpmoui6y1jRnmVHkNS
         t6kAQp+2ahiVlu6FdJNlK6vkJVJ2yFqOKbjQNVQKqKvHXOL9zm1ZnIrBxDdeicuAZybj
         0Mh0vj/ZDt8mkCpkK6nanKmLksH5Po+5D/R2kULYpVYK/hgw6P7c6m0LYZL1IB6Xbqm1
         XzXw==
X-Gm-Message-State: AOAM531kteg54tBb5zK26oXWYDALZkkrymrMYawHvHc6IlCrX1D6jaDr
        NBR/HnKM+6O8UWnXWlZ1+gvrYQ==
X-Google-Smtp-Source: ABdhPJzfeRtq1KnhtLKdMDRS4TtUYRO79F2J+ANYipMB9btaCfDz6+MHypl8ukKKS7tLODacpoemYQ==
X-Received: by 2002:a05:6e02:e53:: with SMTP id l19mr3835359ilk.108.1631221985681;
        Thu, 09 Sep 2021 14:13:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f13sm1460931ilk.45.2021.09.09.14.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 14:13:05 -0700 (PDT)
Date:   Thu, 9 Sep 2021 17:13:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 9/9] pack-objects: rename .idx files into place after
 .bitmap files
Message-ID: <YTp44A+kPOf8U+7w@nand.local>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
 <d8286cf1075dc85231128145c5abb0db3881032b.1631157880.git.me@ttaylorr.com>
 <878s06fa14.fsf@evledraar.gmail.com>
 <xmqqr1dxy1b0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqr1dxy1b0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 09, 2021 at 12:52:03PM -0700, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
> >     We fsync() the file descriptors we're writing out for all the
> >     auxiliary files, but we don't yet fsync() the file descriptor for
> >     the containing directory. Therefore our data might have been written
> >     out, but it's anyone's guess what the state of the directory
> >     containing the file is after we write the *.idx.
> >
> >     In practice modern OS's are known to be forgiving on that point, so
> >     this will probably solve races in practice for most users. It will
> >     almost certainly make them better than they were before when we
> >     didn't write *.idx files last. We should more generally improve our
> >     use of fsync() to cover containing directories, but that'll
> >     hopefully be addressed by some follow-up series.
>
> I'd probably drop the last paragraph, and replace it with a single
> sentence "we may want to fsync the containing directory once after
> placing *.idx file in place, but it is outside of the scope of this
> series", if I were doing this series.

Yep, I think that this makes things clearer, and I prefer it to Ævar's
suggestion (which conveys more information than I think is necessary
here).

Thanks,
Taylor
