Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192A3C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 16:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbiEIQkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 12:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbiEIQkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 12:40:09 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8286B1261C
        for <git@vger.kernel.org>; Mon,  9 May 2022 09:36:15 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id n8so10855343qke.11
        for <git@vger.kernel.org>; Mon, 09 May 2022 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1gOd4E2vM9e73f2jiliFO841n5I6TXXalK3wpBjgQr8=;
        b=IuCX06ap7ns2bX0FTiQZQFlBb5TrAyLy76WVG9ZYVVpIA6RerqWRkKjXxKMMl2q8Hj
         ZlKQ1moz6qaAjkdgJLTdOacT2bU9afL5bc20cIdON30LIUPgSN37lN01U9Hs0C3A2oJe
         +9If0ovC6zXAv98a4hC4uN9QV1BXBlHBvTmn/0SbrIITx02c/qAq4PWCjsDA9P5Lo5m6
         vGZIbo/bnNLcxDimhcQKkDCXZGNxHohfiLYBJXKq4h40AGxeKqEFytxs4+Lq99M9nGWw
         Aqkt6covy52AOtOMgUkpkLm+fk0kTd4j0MetFhnPZkUUkHuF6S+KT1kvUwF4bsjwFxUZ
         7wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1gOd4E2vM9e73f2jiliFO841n5I6TXXalK3wpBjgQr8=;
        b=VdpJ6vTZvZb/2BSkMKH/mNhbbZ20SHEXCwvkLNOkxE0vXsLHlqct7Ss9KRpmCAoSEn
         WyiZzJhWaxEAkn8w3nR04RL0OCsKCsBesQ85GhHDIPQw45zPhCP62k+g3YAJcG2xFba7
         PSio6JQtv8chFs80XxStx56Cj/a/sVpnM1Fv6SoLwtSpyggDnO6yegEmxzWiRrwNHBdH
         D0GzRRBEHM/5W1om6QoxgY4xhzPao3lP8rBECPuEXTk+ws+ZEMrK3ttDEIZgyUHNVJYi
         4lFfR3pzJXYYwl9WmRC4A7+s9NNQ+ZoDtHCvvZD2cDl+uaF2gQ8ZBkcqMNmcAuZl2sPP
         d/lA==
X-Gm-Message-State: AOAM533RBem2cQyu9WR+uRaThcqr0MSbJDA8nWIDu6H5Zy7j5+2nA4Ct
        AMXl8w9QFMTYtSPKWxuXhOkvpS2mtbbGvu4z
X-Google-Smtp-Source: ABdhPJycDC+LHffAm6jchOHF8bT5sPvomBjGuHt9gYJa+GPh2+Xmc8S/WPqDVuyyZ42S4FeB5DLv8A==
X-Received: by 2002:a37:6c46:0:b0:60d:d526:7e48 with SMTP id h67-20020a376c46000000b0060dd5267e48mr12361464qkc.451.1652114174645;
        Mon, 09 May 2022 09:36:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e2-20020ac845c2000000b002f39b99f6basm7920425qto.84.2022.05.09.09.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 09:36:14 -0700 (PDT)
Date:   Mon, 9 May 2022 12:36:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Plato Kiorpelidis <kioplato@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>
Subject: Re: [GSoC] Contributor candidate introduction
Message-ID: <YnlC/WA3nwRA8NQx@nand.local>
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
 <660025e5-637d-8e93-e7ba-65a3ad474bad@gmail.com>
 <965b5394-9f72-e4a3-9ed4-6abcf67fb524@gmail.com>
 <CAC316V7dRjsLiVJLvB-PXRDVZ0NB0xin9XEWq9QBiARthNuGaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC316V7dRjsLiVJLvB-PXRDVZ0NB0xin9XEWq9QBiARthNuGaw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 09, 2022 at 08:42:38PM +0530, Shubham Mishra wrote:
> Hi Kaartic,
>
> At my job, my timings are flexible. I already discussed about GSoC
> with my team and Microsoft is supportive for open source
> contributions. I have done side projects and open source contributions
> in past also, so this shouldn't be a problem. I also planned to spend
> weekends on this (I usually spend weekends on my desk, so this is fine
> for me).

Be careful to not over-extend yourself. I think it's great that you're
excited about GSoC, but in order for it to be the most successful for
you, you should make sure that your work on Git happens during the times
that work best for you.

I'm not familiar with your exact working arrangement, but I would
caution you that participating in GSoC (if your GSoC project expects
35-40 hours a week from you) _is_ equivalent to a full-time job.

If your existing full-time job allows you to spend time working on GSoC,
that's great. But if your normal work is separate from GSoC, having two
full-time commitments seems like a recipe for disaster.

> I do not have any other commitments or planned vacations throughout
> the GSoC timeline. I would be able to dedicate 35-40 hours per week :)

Likewise, GSoC shouldn't get in the way of your personal commitments.
Taking breaks is part of doing productive work ;-).

Thanks,
Taylor
