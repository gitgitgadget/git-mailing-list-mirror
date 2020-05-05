Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F41C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A60E32073B
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="qavy+NdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgEEQLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 12:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbgEEQLp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 12:11:45 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5534BC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 09:11:45 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l12so1209698pgr.10
        for <git@vger.kernel.org>; Tue, 05 May 2020 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vfy1amF/gl33OqeuS0xK10nlYDvo8Se9s5+ecuPX9jQ=;
        b=qavy+NdNNloARLFHuRvttioX0JPZksZOKlhx17BrtRxrOZSE/T5Mh0eSuTMCP3jxO4
         e776DHzuY7cxYUUhXBhkxn+cEFiS+yhy7O2QQn1eo8wFJeGcwZg5/TdDF6C9VtUxCNp/
         AdLrt1LbFcwaKQ4mN5tQDANNzzyCxcH/3AdfDEBhCRVNEgK2UNVxvIkNZRnmrHTzlB8+
         7n+55S3WUVJrgkJJShI3jVoTT4JwmIt8WdRwVIn1/Jxw9lAV0p8cDh93ReVnfCoOR3/t
         BrbAz4ZMPW8au+Fuw9djNY1C4jM4QNn+NiqfY2zRnP92tE2UK910G5KT2bta2O1YoYv/
         qN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vfy1amF/gl33OqeuS0xK10nlYDvo8Se9s5+ecuPX9jQ=;
        b=YPbYEk0iUeLiRG/nW1o8MASIBZWm80j/H9vshD7ssaY1hkdLQFWb6U9dg+KmbLUe9Q
         w5xg8gLzW9A+7JXbsTiCXU7WCYG7V9YAF1KpGvEZnQx3lsnF4GnGfGek2cvs0M5+rkzy
         27ot0kk+oWXZ4UC3W3eDyWWmZBzUqBf72015TbRb7UMU5wuF6y4yBzyAF+ZMryFNRdsp
         Dr8YOAkScREg9r2vbr8AP+9tza3TAtAUTPIgh3gPLu855Qm/TU0fsrEECwdFkxS2HVEl
         HhwDJeD6jLNvBY3+V1uSc4SlWZKho+HWuEj2gaQFaMg7x2xatABhhlApgAViQeVUiF+p
         aLbg==
X-Gm-Message-State: AGi0PuZGUxmnPwtqm+DFLjGjWMtqFLx27mzwccfuvfM5UxdOKJpaU8Nd
        vQBFIZzgNvMmHJeREGyLrxRG0g==
X-Google-Smtp-Source: APiQypJ6Uj6UaxSwUq726Wy4/Ve43V43YUW6oNHHNZqmYdpXLoZKUvd7q9tdD8fjretHYRDuD8RTCA==
X-Received: by 2002:aa7:979b:: with SMTP id o27mr3965438pfp.192.1588695104823;
        Tue, 05 May 2020 09:11:44 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id z7sm2334514pff.47.2020.05.05.09.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:11:43 -0700 (PDT)
Date:   Tue, 5 May 2020 10:11:42 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: Re: [PATCH 0/8] commit-graph: drop CHECK_OIDS, peel in callers
Message-ID: <20200505161142.GD69300@syl.local>
References: <cover.1588641176.git.me@ttaylorr.com>
 <bc41469c-a55a-49a4-5e2e-096bbdd52751@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc41469c-a55a-49a4-5e2e-096bbdd52751@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 07:35:29AM -0400, Derrick Stolee wrote:
> On 5/4/2020 9:13 PM, Taylor Blau wrote:
> > Hi,
> >
> > These are a few patches to address [1]
>
> We seem to be missing links [1] and [2].

Whoops. I wrote the cover letter and then postponed it for an hour or
two while I shuffled (what are now) the last two patches around. It
looks like I dropped the hyperlinks in the meantime, but here they are
now:

[1]: https://lore.kernel.org/git/20200501223848.GH41612@syl.local/
[2]: https://lore.kernel.org/git/20200504145937.GA11373@coredump.intra.peff.net/

Thanks,
Taylor
