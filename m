Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392FCC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 21:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhLUVjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 16:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhLUVjp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 16:39:45 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA10C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 13:39:44 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id k21so333000ioh.4
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 13:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ny5Jimq1ro1WBo6HtJTWa5H5/gTlMyqZyxmEWWvpMR4=;
        b=tVJWu7/ve7W+3rJkhy7YsLykT1rGPLwQxCHcvkjPYalhJJSvbM7vSDdYxR1aOUNVPt
         TsuqJ51hZxuglcJF+/scrjRClvTigqm/upykbtzLo54xYvi6N03+CoeKoxO0JR4UNZId
         7j5kTvqnDZXgEuHTZJKjuFnl0ai9KdqDRTwbY6ZJObDvwFdStSA/T3g6r8YYwtlPh1oJ
         NbXRNd/286ClCDzLfPSDfP0c7MFOWZ5St/V+KaZhO7TrajOounf5TqtrNTCdvJt9wXeG
         rU6wzTxFK3vgF2VjWMfRojRIgJPddI3oCdO5+B7hEZKUK1NM7Aqm5omIQB6zwNLyXHAz
         YMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ny5Jimq1ro1WBo6HtJTWa5H5/gTlMyqZyxmEWWvpMR4=;
        b=ZJF6NWvAure7mRjrG0zoM8/KYXqrw4Ba8U8MQ4YRW9BhqD1bLyUJ9/redWOt8JslsB
         MnoZxm7gjxDB9wcABgBZkXZmmJDy+QEnJKY5YyJCBb2kk2kWQk706hf91JClRvb0vbOQ
         7GbcYLgy7dWOtik/XgWy/NNiQDkPphvHYFVODqkUXTHTR6Vu+hR9Mv3LuwY8tZpiS4Zi
         9WjTGnAzu/TQPvsn5TJ0q6pMmt4lfQuElduNawsmaS6xkA0kwJKjx8/SuPG7NrvHTzI/
         NhMu/W9b/PrcpEGPA90DMfP7/hAGSKOyCtv9CWy8/uDuIh/DDPWfzASFqZA9+5jlha2d
         dH4g==
X-Gm-Message-State: AOAM530cu+LlNJdpB/AXb+yo3ofDkFNAsGl+i2VcOnCon3fOKeSp60uR
        VDlMetFMQqJsbrtHUOqU0ncnI407C5VWEwqs
X-Google-Smtp-Source: ABdhPJyVEF5uNhtWGN2EnPoHSNuyUSUMLyUy4ve5gwqV7Pk7bT/Dy5DdUO35TY0PeoQFllDc7PBPDA==
X-Received: by 2002:a05:6602:218d:: with SMTP id b13mr42070iob.19.1640122784196;
        Tue, 21 Dec 2021 13:39:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v4sm36003ilq.13.2021.12.21.13.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:39:43 -0800 (PST)
Date:   Tue, 21 Dec 2021 16:39:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>
Subject: Re: t5327 log expiry
Message-ID: <YcJJntHTRkPWEEpD@nand.local>
References: <CAFQ2z_MckMjRG9bOHeaKfFDkqG5L0AAz2V-uUSwMKTdh3MicGA@mail.gmail.com>
 <xmqqa6gtptv2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6gtptv2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 21, 2021 at 12:48:17PM -0800, Junio C Hamano wrote:
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> > Hi Taylor,
> >
> > Your recent work on cruft packs breaks with reftable. I suggest the
> > following change
> >
> > - rm -fr .git/logs &&
> > + git reflog expire --all --expire=all &&
> >
> > to make the test independent of ref storage format.
>
> Thanks.  I should have caught it when I read the patch.

And I should have never written it in the first place ;). I did a
find-and-replace throughout the series to replace one with the other.

I have some review from Stolee that I want to read through before
sending an updated version. I'm planning on looking at that when I get
back in the new year.

Thanks,
Taylor
