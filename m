Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5354EC433F5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 21:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiAZVwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 16:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiAZVwe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 16:52:34 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B30C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 13:52:34 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id y84so1374008iof.0
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 13:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OE0Jk7PCG/s4buPmSEPxFDz3Op1G5aXEQ7j0Dm/zFmE=;
        b=y7ssmOYr464Hy6LkxMPQ3ZuqnUcnCw1jKo3xO6ZyfaT5oE8fDGhOKbEZnxyHgkqOcY
         ov7U3sY3LmNnqy4zAhokaViewY9HO7HQbUnrO9F4iw7R6e47KfBz20rOfzP0MpNtHLG/
         1uEaedFG0BO3XOBoznBblifTSsj2tFIst43ZO4/1FNigrpEgCmh2qXmPUp6PyUMWgw0T
         o6+THi00H4BS5xgoD4dWanPesmjtXZ+JTnQ8R2hGD7U5opQOD7Y/WO3a9jfRaqfPf65Q
         tIa48pIche5DXMyvNz9KvDgZ+DI/4YVw3KE2WE1jSHtzxXemOdhuAjF1dpWSj3nWm9w2
         F23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OE0Jk7PCG/s4buPmSEPxFDz3Op1G5aXEQ7j0Dm/zFmE=;
        b=gC2gFZVF56/caAGZKJE1aN0pngbB4x6nkiyhgMYMo2NUczTzmPm6TSoob6PbSx3/GH
         y+6zr2f7BbfdJoaKVL5VlShja0+4Gn2ZdRdKOmdBmiQ2FrYQq6tcV5dIkhnwC54trPJo
         rpGTkeVZBpeuOCHqd/f9dPV8guzMiKbQJ7DfTMPoGukT7uTytBpGbauGIb/nOaGRkDhT
         MXBTEYFwGf7DitDU1s+zc1dW1cQgIpbtdej6GVsB+PSwXFzVnRCbdrhoU878OBI3XQ8O
         +5BoMlIWHIk4H90V+ZQUc7h6obC7B9IgtbGxB1/TG8am04I61Y77zw5zjLnzTmEUtKWA
         85pw==
X-Gm-Message-State: AOAM530//xzrzUdlDZEMmctHNrkhUTMwUSUMR/l2ZLTYB2q4khoLJ6tF
        VINh8GAmJTH+0aPnA85MlrSUXg==
X-Google-Smtp-Source: ABdhPJxcB4N1+hhXF+ifmaD4x25n5BQT8OSwLNCh+uCsdM6iv+Rq/fkjyyTlA2kz1bm41Hwk0BJjQA==
X-Received: by 2002:a02:9645:: with SMTP id c63mr360896jai.260.1643233954022;
        Wed, 26 Jan 2022 13:52:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r2sm1625278ilt.73.2022.01.26.13.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 13:52:33 -0800 (PST)
Date:   Wed, 26 Jan 2022 16:52:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Konstantin Khomoutov <kostix@bswap.ru>, git@vger.kernel.org
Subject: Re: [RFC] shell: local x=$1 may need to quote the RHS
Message-ID: <YfHCoR2VSad95Cpu@nand.local>
References: <xmqqsftc3nd6.fsf@gitster.g>
 <20220125092419.cgtfw32nk2niazfk@carbon>
 <xmqqa6fjzlm0.fsf@gitster.g>
 <YfBbRca0Rjl59MM0@nand.local>
 <xmqqo83zt54a.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo83zt54a.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 25, 2022 at 09:53:25PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> >
> >> The manual page for recent dash may need an update.
> >> Can you perhaps file a bug on their documentation?
> >
> > Yes, I agree that dash.1 is out-of-date after cbb71a8. Konstantin:
> > please feel free to use any of this if it's helpful to you in creating a
> > bug report for the dash folks.
>
> I doubt that we can write off dash v0.5.10 as too old to matter, as
> the tagger date seems to be mid 2020 at
>
> https://kernel.googlesource.com/pub/scm/utils/dash/dash/+/refs/tags/v0.5.11

That isn't quite what I was implying. What I meant to say was that the
dash _manual page_ is out-of-date w.r.t. the dash patch I linked, not
that that version is something we could ignore.

Thanks,
Taylor
