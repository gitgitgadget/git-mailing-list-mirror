Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54ABE8FDBB
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 21:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjJCVkF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 17:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjJCVkE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 17:40:04 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A473B4
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 14:40:01 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-419628fb297so9212031cf.1
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 14:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696369200; x=1696974000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lhOojLNownMfZKSa/PlJe0cThQVEPMLtpd8unQvySsA=;
        b=RDjndjdEapuJ66GNrkGiqeZfQdjeRKST5gW1V3O7VUQTIoAGW+6xhtougCKvwTa1Z8
         eGnxRjsKHye2kGyPAvpB2VW1JV1ty5TyOZTikFX5mAftTVyuu8basRY7E9CdcvFpSCEj
         6q2fxFwFy3+HsG/UiEdp6jCtsZIdLRCYiome2d3NtaDsUfzHi7MaalTxusC3COfzVbvB
         /OLDqiFTScbYvjA6E/JT8vZVfUnSLFYiLI+tjfmvEpf1y1TTq3kCGf9Cm5xaXuYCZs74
         FCcMzHqfoCiSv73HWRtiTPDsjNQIfbCIV1vwxWJdHBiEP0S2Hc2V0+iXink2sS4hm4TC
         /NgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696369200; x=1696974000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhOojLNownMfZKSa/PlJe0cThQVEPMLtpd8unQvySsA=;
        b=WiLTzI2pdA7KS9wrbLw3hK6xF7ITwvBisdwCWIM2ErnSEdTiwLhI3CjnT2F1oL79QR
         iA+lve7SzImOy6V70cdUkpQ92Dvzm7mxORjeJVrMlLY4g0de7zdtSJ5iR8g8fznwJMaO
         V4yudeLADj+rUW3v3xYl2hGZWx/y7zywjGC1mNTiho9eTvATfL6JCRVf1hwwd6Kyj/+c
         0fUn3HaBrlHU1PT8ogOza9JSU4CkkCwvYRXTEuvMdl6sSu/KJEI8GR41CFUWc+W7OVkh
         ztw/XU1DpuceP0sWMbSQ8j4LYtUJU5AH6WGcPyryy5Lp3N3q8WHWzeUY/0ZgN4kNt44M
         RugQ==
X-Gm-Message-State: AOJu0YyUiNwUGSzuWrCZpdIXRhk2DZWrDFRpYuY3FZn+4E9W0oEFfXxW
        yAH+soNVRseXZ81crbtDdlORRqQkY2fvjTKlW2+5cw==
X-Google-Smtp-Source: AGHT+IEm17pHFwUTLHJLnATcPdHyOMIxEG5HR2NrOH58wZxNY61aamfRjoreCRA5SWPjwQ+GyJRQFg==
X-Received: by 2002:ac8:5c02:0:b0:412:bf83:e759 with SMTP id i2-20020ac85c02000000b00412bf83e759mr783856qti.42.1696369200112;
        Tue, 03 Oct 2023 14:40:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l13-20020ac848cd000000b0041520676966sm755202qtr.47.2023.10.03.14.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 14:39:59 -0700 (PDT)
Date:   Tue, 3 Oct 2023 17:39:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] builtin/repack.c: avoid making cruft packs preferred
Message-ID: <ZRyKLqpDs8K8lr4Q@nand.local>
References: <19d9aae08eab05c6b5dda4c2090236b1c3f62998.1696349955.git.me@ttaylorr.com>
 <ZRxBlrjyuBmJnx3p@nand.local>
 <xmqqa5szzcdz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5szzcdz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2023 at 01:20:24PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Tue, Oct 03, 2023 at 12:27:51PM -0400, Taylor Blau wrote:
> >> I've had this sitting in my patch queue for a while now. It's a
> >> non-critical performance fix that avoids the repack/MIDX machinery from
> >> ever choosing a cruft pack as preferred when writing a MIDX bitmap
> >> without a given --preferred-pack.
> >>
> >> There is no correctness issue here, but choosing a pack with few/no
> >> reachable objects means that our pack reuse mechanism will rarely kick
> >> in, resulting in performance degradation.
> >>
> >>  builtin/repack.c        | 47 ++++++++++++++++++++++++++++++++++++++++-
> >>  t/t7704-repack-cruft.sh | 39 ++++++++++++++++++++++++++++++++++
> >>  2 files changed, 85 insertions(+), 1 deletion(-)
> >
> > Oops, I should have mentioned that this is meant to be applied on top of
> > 'tb/multi-cruft-pack' to reduce the conflict resolution burden. Sorry
> > about that.
>
> Sorry, but I do not follow.  tb/multi-cruft-pack was merged to
> 'master' at c0b5d46d (Documentation/gitformat-pack.txt: drop mixed
> version section, 2023-08-28) but back then t7704 did not exist.  Do
> you mean the other topic in-flight from you about max-cruft-size?

My mistake -- this should be applied on top of the patches at this
series:

    https://lore.kernel.org/git/cover.1696293862.git.me@ttaylorr.com/

which is the other topic that you're referring to. I ran "git
for-each-ref 'refs/remotes/origin/tb/*' | grep cruft" and mistakenly
grabbed 'tb/multi-cruft-pack' thinking that that was that series and not
the one already merged to 'master'.

But it looks like the series linked above hasn't yet grown a topic
branch in gitster/git yet, hence my mistake. Sorry about that!

Thanks,
Taylor
