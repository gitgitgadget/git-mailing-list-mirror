Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED4CC433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 17:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ABC723B31
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 17:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbhANRc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 12:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbhANRc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 12:32:58 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4066C061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 09:32:17 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id p14so9010745qke.6
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 09:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sgE74OWA55UNDqorMI74FNQ2clise5e4yRgWRQWVaFs=;
        b=UTsuJSk3mpMSyqoj0ZtrSbCqpZnHOTWctlguJA1TUgy11MJ+zjeA/ydQq2ViTjlFsj
         rfD4OXyJzaECml5yU+HdrxvbISW8WzR6y9iFNXLtbxJ4vUqEQbatErMbVRzKITE/jzOq
         yGGLiWZq1bZLX0BCE8SohPsJ+yPP0BIouzU7LWgJ41q+7q6Ny/4dkQ9NLVaRYql1ilsH
         ta97g5FGhuoKc4RDt8perXqrwTwNgzhG5oMsQBSyjOvJalsxS0q/wRvRvxTG8kCb/BnH
         7Uui6RopTpDtSU4HIVW3DSvucFZzEkFNjynjPxSWpwXHzhzdb4H/fvGomJnO9pAkNSEe
         qEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sgE74OWA55UNDqorMI74FNQ2clise5e4yRgWRQWVaFs=;
        b=tQZ8uTWiWgkRxnbDcmeGvvJAKItG8QWz0K3h+L7F/FZtGayJiAuMq+ZY91vLKCfDbR
         OtkyCB7wngSNPXfZO8wFJwk9fahkvfhi9bYHjxQz4veE17HihFpmYVx1AHeGP8pSWlU2
         CA6yzDTywNPwnlgg1eceC03l69uaYC2txTmlI7nQO8jw0sjdyTp129EQ6TO1HMccUrmd
         x43Y171JTFpHPmiUYgkbQ5HjvdBk3mjw5bciIG493WCS3uAVLhDaSxf+6ywnMd8YgfdV
         fc9nAVOgE0G1+KwOrSvzqvbb1uzzx+E+U8zGmQmVdd4TywCKiBFWD8Huz7LonNyGF3DB
         RKSg==
X-Gm-Message-State: AOAM531pym6VaAV8gsM3SNYYAFsaLzsIZ0JuXhCNq/L8T6eKPC0riTMQ
        KJIPHksbr1OytiFXMmxbOkJJBQ==
X-Google-Smtp-Source: ABdhPJxOQNjpkxdxzR7r88aM3eGegkxVfrCcX6kcVwK8XblkhabM+WzcG02rIXYfPa/Jo6Jvs5lewg==
X-Received: by 2002:a05:620a:804:: with SMTP id s4mr8405839qks.158.1610645537155;
        Thu, 14 Jan 2021 09:32:17 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id l20sm1170661qki.129.2021.01.14.09.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:32:16 -0800 (PST)
Date:   Thu, 14 Jan 2021 12:32:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: How to implement the "amend!" commit ?
Message-ID: <YACAHdDEMIgvQruK@nand.local>
References: <CAPSFM5c2iqBn8_Dih2id7q6RRp0q=vfCSVUHDE5AOXZ8z3Ko9w@mail.gmail.com>
 <CAPSFM5f+cm87N5TO3V+rJvWyrcazybNb_Zu_bJZ+sBH4N4iyow@mail.gmail.com>
 <99b40665-45dd-6c4d-d46a-56c7dbf89568@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99b40665-45dd-6c4d-d46a-56c7dbf89568@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 14, 2021 at 10:39:50AM +0000, Phillip Wood wrote:
> > Secondly, As an alternative to above, we can use `--fixup=<commit>
> > --amend` and `--fixup=<commit> --reword`.
>
> This is not backwards compatible. At the moment If you create a fixup with
> `git commit --fixup=aaa` and then realize it should refer to commit bbb
> instead you can fix it with `git commit --amend --fixup=bbb`. That would no
> longer be possible.

Too bad. I felt that this was the most ergonomic idea put forwards, but
I also thought that we died with '--amend --fixup=xxx'. Its current
behavior does make sense to me, but it's too bad that we can't use it
for this new purpose.

I suppose the first option (the '--fixup=reword:xxx' one really is the
only one that can be implemented while preserving backwards
compatibility, so I think we have no choice but to go with that one.)

Thanks,
Taylor
