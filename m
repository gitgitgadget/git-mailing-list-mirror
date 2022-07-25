Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8E8C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 22:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiGYWLb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 18:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbiGYWLY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 18:11:24 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C412E24BD5
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 15:11:17 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id x11so9275530qts.13
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 15:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2C82a6f1nY+eHEnD1N3e4Qdxrb5mIutp8X/x8Sie0Dk=;
        b=L4tAIjJhUp9oziCerSYF4vWns96uitrvBNm4YfjHW/iDzUIMVTSMRTq/+baPhACXf+
         ZyBjPFfYPDh67rMMdUB3bGY76hk0d65hAQ5fGVaUOVXUvFCL4pgkIkGmo3/L1+NJNLl5
         ReKMIsoJBLYk9WGb20chdj5X2QPnysDz9vwvVVQ3eioMvPdNuzTi/+y3pIJkcxIrIWpN
         3yadmXFMhZo3mfdPt7uzSinzu23gEBLV8IdM8DuDM9mNjEWnN/2vGeMdqZXPOqxvfOWR
         oztHiLmREiRArEmAipJMCegItZNTk2MUTtNGkljDTgm/VlG7xnT5a8ZiKRIT8d4ixGa5
         cP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2C82a6f1nY+eHEnD1N3e4Qdxrb5mIutp8X/x8Sie0Dk=;
        b=xgL4wtLsnjWhT3YXLSs3hxyW/zUfhnEheSpAL877di/WDgyhFz2PqAHmF1mjlNjB7N
         +9HKe4Bo2bh80RHA75hJHzSbRm2dvoNpFJiq9YiG/CI+NTqCHPKW297bwICSjytQN/dU
         oSHzle4kQjnoOZPzl5BsL3o34AGEp8eK2JJzxPGzeiUyLSbOB103Erkw8hx9E6x5yZFu
         2QGKpsO0HzmZhnVBs/y9JktfMnIQMhX94eXNr8+lIarm/iJSIOMLXa9Nv/6EqwQeHYpJ
         Fj2+JqDSBeEEVjVr4ayXyKzfEsSvktgDzAmhdJV8hVnojnPjV7DY+5hisG2mD78+Dh6E
         8Sgw==
X-Gm-Message-State: AJIora/G0aSyAcMLTcUpx1I/YoUnlTk9CMiJTQjVX6QIChrd2mQMSPLC
        557G5fevPecKzv0+DfDMa75YJg==
X-Google-Smtp-Source: AGRyM1s/cp9o7lTnSLtucbjmdR14eWregz28TfYEuccap+KR/YtpKnJV4Nfrj4goXX2y5txOinJHRQ==
X-Received: by 2002:ac8:7d4e:0:b0:31f:33db:69bc with SMTP id h14-20020ac87d4e000000b0031f33db69bcmr8462546qtb.482.1658787076899;
        Mon, 25 Jul 2022 15:11:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k7-20020a05620a414700b006b5e5ebfff8sm10862743qko.62.2022.07.25.15.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:11:16 -0700 (PDT)
Date:   Mon, 25 Jul 2022 18:11:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: Can I use CRoaring library in Git?
Message-ID: <Yt8VA22wz9BlzzMN@nand.local>
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
 <220716.86y1wtxhok.gmgdl@evledraar.gmail.com>
 <CAPOJW5zNsETYwD=MXCFLn91qaemgooPN-JB1sx7KagkKxOXTnQ@mail.gmail.com>
 <e574ac20-c287-c395-5bc3-b481d81764c7@gmail.com>
 <xmqqzgh7v1q3.fsf@gitster.g>
 <YtSMVcc59LP1j+Ys@nand.local>
 <CAPOJW5w+6jaHJe8FBVzjAfRBATYuV=+uv4HeA_fpRKFbRtKXcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPOJW5w+6jaHJe8FBVzjAfRBATYuV=+uv4HeA_fpRKFbRtKXcw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 18, 2022 at 02:27:59PM +0530, Abhradeep Chakraborty wrote:
> > I assume that Abhradeep will want to pursue some format redesign as part
> > of the transition, though, at least to see if changing the format beyond
> > a version bump and new compression scheme is worthwhile.
>
> I haven't thought much about it until now. As far as I think we don't
> need Xor Flag anymore.

I think that would be an interesting experiment to run. I suspect that
XOR-compression is helping us quite a lot with on-disk file size with
EWAH bitmaps, but that may or may not be true with Roaring.

If Roaring can compress the same selection of bitmaps to a comparable
size without the additional layer of XOR-offsets, then I think they are
additional complexity that can be eschewed for now.

(Keep in mind, we can always revisit that decision if we decide that we
want to add XOR compression back in through another version bump. But it
would be good to make backwards-incompatible changes as infrequently as
possible. So this is a good opportunity for us to be as thorough in our
experimentation as possible).

Thanks,
Taylor
