Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17A1C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 18:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbjDYS5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 14:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbjDYS5y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 14:57:54 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1A418B84
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:57:26 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54f9e41dfa7so45341647b3.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682449044; x=1685041044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DjxMLuZl27Owvc8PJuBVwXOIeq5KSq0BPioTwVkqqkk=;
        b=egOQFduGGynXddlooyOp6Z6u6qII8RrOsAvSkzr+HPwSWO++44KrLUe1hacPoazUwZ
         aCydeilNSVWkUq6amc/T9oMkT3QdBhaPs1WPmJnNPG/ugAotXu7lFWzacqbi+tUfbZpW
         VF7F1Rvt77eopArAkH93LfmWwVVBNmDh5OkoxhTGLjanfRmpUWcizIF5iGVmEc9AuE27
         ZE/oVZH4mAQhPe2X5oCiWXySJJP9NTL2EkABxbwqcW5hycoi9KSC/3o3zq5J0ayfwMll
         eZ3zbZi6rF7m/fzBuad6WvJw73C7Vt1Bkk8gmDDTeQHj8M0MreRm9mOQEGDPJRufuRHw
         VM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682449044; x=1685041044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjxMLuZl27Owvc8PJuBVwXOIeq5KSq0BPioTwVkqqkk=;
        b=eHEPBSLby0gDu4Kw8eiwhJwXdfYelQESKd06ly8rlxTBsribEe66P1zIvGEc9ww3ZO
         qKCIVXrPuyyErpHiUtr1ipoJJaYR4JbxyyB1pk88mWK8DDAwTQuSOEU3tB+lq1Quv+l3
         Z48Uaza5z5c5w6wycqWGxMg68cAX8BYr64qYn//vwGytBOqQ5pa808izPKiJ2Kr14a3L
         HVnfLJiHGQUU8yj4HJRYoKA8ihIM5LPPFYCAQ5r/3L2D/o2uFs4DBfMvNfbBBl8+TMMf
         drn77eEZnBmGSZ78chA+e25I4gysEX1YOOSTL5I6r21ghVvGZUgnizdPpHPGJxmviBgd
         UqiQ==
X-Gm-Message-State: AAQBX9d3J5boQJksrkYxMhwasAHIeutHKPTi3jvTwt13cjU2V4w8tI2G
        hqtRgM0yOAVBqeKrRKIZZc22+yyklu7E4ipov3TgHw==
X-Google-Smtp-Source: AKy350Ykm+EbDYHEk0QL4Wyv9u5POpYRqYgvSRmvb1YQPAKYF+ejVd0pjlUncLg6cYyCXdsj9xy9WQ==
X-Received: by 2002:a81:4e0d:0:b0:543:1dc1:828b with SMTP id c13-20020a814e0d000000b005431dc1828bmr11361437ywb.33.1682449043509;
        Tue, 25 Apr 2023 11:57:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g195-20020a0dddcc000000b00545a081849esm3706502ywe.46.2023.04.25.11.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:57:23 -0700 (PDT)
Date:   Tue, 25 Apr 2023 14:57:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] pack-bitmap: boundary-based bitmap traversal
Message-ID: <ZEgikbdP8M2sDMlM@nand.local>
References: <cover.1682380788.git.me@ttaylorr.com>
 <xmqqy1mfzvpq.fsf@gitster.g>
 <1a09d246-5750-7d98-08f7-bad6d3dee3c9@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a09d246-5750-7d98-08f7-bad6d3dee3c9@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 02:30:01PM -0400, Derrick Stolee wrote:
> On 4/25/2023 2:02 PM, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> >> This improves many cases where using bitmaps was significantly *slower*
> >> than regular, non-bitmap traversal. In some instances, using bitmaps is
> >> still slower than the non-bitmap case, but it is a substantial
> >> improvement over the classic bitmap walk.
> >> ...
> >> In a large repository on GitHub.com, the timings to compute the objects
> >> unique to "master", as in:
> >>
> >>     $ git rev-list --count --objects master --not --exclude=master --branches
> >>
> >> improve as follows:
> >
> > Curious---when would it be significantly faster to use bitmaps?
> > "Most of the time"?  "In not-too-large repository?"
>
> This is an interesting question that is very difficult to predict
> in advance.

Indeed ;-).

> It would be interesting if we used the initial commit walk to the
> boundary as a predictor of whether bitmaps would be good, or if
> we should use the tree-parsing walk instead.

I think that this is tough, too. When making a prediction, it would be
good if we could avoid walking down to the nearest bitmap, since by that
point, you might as well have used bitmaps (if you found one before
reaching the root(s) of history).

I think the best heuristic we have available is if we have is something
like "# of UNINTERESTING commits between the tips and boundary", since
we OR those in ahead of time, and then the fill-in traversal will
(usually, not always) be cheap.

But I think that heuristic probably isn't too predictive, since it would
often give you the wrong prediction, say, when there are no
UNINTERESTING commits between the tips and boundary, but the boundary is
bitmapped.

Another approach you could take is to cut off the fill-in traversal at
some point, or start with whichever is presumed to be faster and then
dynamically switch to the other at some point during the walk. But that
also depends on repository shape/size, and machine configuration.

So I think it's extremely difficult to get "right", but if others have
suggestions, I would certainly be receptive to them :-).

> But perhaps this series gets the bitmap walk "close enough" in
> the typical case that it's better to use bitmaps in the chance that
> we have accidentally hit a case where we'd normally need to walk a
> lot of trees.

Yeah, that is definitely part of this series's goal. Another framing is,
for configurations that are using bitmaps everywhere, this should reduce
the number of cases where using bitmaps is *significantly* slower than
not.

Thanks,
Taylor
