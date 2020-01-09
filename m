Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FC4C282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 22:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B409D2075D
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 22:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="HpdJobnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgAIWCl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 17:02:41 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38676 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgAIWCl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 17:02:41 -0500
Received: by mail-lj1-f193.google.com with SMTP id w1so8908856ljh.5
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 14:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vm1DeDGLAjskWCyJan69Qc+sFlRwNSCfrUn/kaAgr/8=;
        b=HpdJobnVW7i3e3ZPbajQHq052r+5esYRGIQ9PU/fgcmx1Eptpsas5NC1umKeqAItsb
         RjNkmN3naqWRw4Q6X0PpLMsWGK/QNM98sM7qhxaZF1JgQXkoyocc6ESTG5nkJH3P8QMq
         OhXcpDVD8bEQWkUj0CTVobNjvKkjIuumbvzPGAloznsQdJDlGCSPY6NA3FogLm0tODTE
         Dgo/9M/66keLwnGYUYs7RT/EiSlXJzfq91pDd6dn4P03d4NE+A6hkBeuSFCFPpiLEOe1
         rix4EDiUGbd2IeCkI0uWTejF9qNF5S4rti0rbti/M+stoVNRfvT83g85uTKTcvFFH/g/
         wTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vm1DeDGLAjskWCyJan69Qc+sFlRwNSCfrUn/kaAgr/8=;
        b=HCEmV+eZ8mYhJNmL1+Y5GWMn8dQmqRVjIrRZTxFcKonMChLfDJlqxwN5DOv74oYcg/
         9CVS7xsK/JFtjYnoKyIuyQMzm/aXsKVAidltrm5vJPN28CBkuWJlcqJxNHA/WxQTj1Ev
         RxwU7SBZKX1mOApYo5ZBTWBjV5wIaRNyxK3JkE+IDeBHitbpwwhTVrztATK7kZIeCu0Q
         57z8G3HsEiKGEqW1XwEHlqu80seTNI1xa30f0N8C4WI0YP5FUEtBmWkdgpRQluiFDZY2
         IT78uWBZrYm1E8/cbVE6XfF9S5bqLVytinpbIQxlwuMBG4UWtYsDgdNpJpc7MWLHR2Lf
         uDMg==
X-Gm-Message-State: APjAAAWWrKDR/g0G1k32AZdcXR/qo5aZl9uJMUAmvNT4aeFWk24imaHp
        9211TlKDaN5q9kfkn7CMmzRCvZwY8AVbdLk47HxvXw==
X-Google-Smtp-Source: APXvYqzxX32NfwxQ+Sl2vbrkA4pahbWdXh6Tdt/2AdlY1rjzlvcZEw81wfszmMxUG1AG+0kStxAnQLV9wr9esVWt9n8=
X-Received: by 2002:a2e:8eda:: with SMTP id e26mr129552ljl.65.1578607359170;
 Thu, 09 Jan 2020 14:02:39 -0800 (PST)
MIME-Version: 1.0
References: <20191114060134.GB10643@sigill.intra.peff.net> <20191114181552.137071-1-jonathantanmy@google.com>
 <20191115041215.GB21654@sigill.intra.peff.net> <CAHd-oW5qT5LmUd6GTL=O+-yXPmq5Uy9gk3ohL_2r+_K+6UJS3Q@mail.gmail.com>
In-Reply-To: <CAHd-oW5qT5LmUd6GTL=O+-yXPmq5Uy9gk3ohL_2r+_K+6UJS3Q@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 9 Jan 2020 17:02:24 -0500
Message-ID: <CAHd-oW7WhSs2PDSwhksu0Kh5pAJE3rw3nmc-8VJ9dkJitz_N8A@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] object-store: allow threaded access to object reading
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, folks

On Thu, Dec 19, 2019 at 5:27 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
[...]
> However, re-inspecting the code, it seemed to me that we might already
> have a thread-safe mechanism. The window disposal operations (at
> close_pack_windows() and unuse_one_window()) are only performed if
> window.inuse_cnt == 0. So as a thread which reads from the window will
> also previously increment its inuse_cnt, wouldn't the reading
> operation be already protected?
>
> Another concern would be close_pack_fd(), which can close packs even
> with in-use windows. However, as the mmap docs[1] says: "closing the
> file descriptor does not unmap the region".
>
> Finally, we also considered reprepare_packed_git() as a possible
> conflicting operation. But the function called by it to handle
> packfile opening, prepare_pack(), won't reopen already available
> packs. Therefore, IIUC, it will leave the opened windows intact.
>
> So, aren't perhaps the window readings performed outside the
> obj_read_mutex critical section already thread-safe?

Any thoughts on this?

> Thanks,
> Matheus
>
> [1]: https://linux.die.net/man/2/mmap
