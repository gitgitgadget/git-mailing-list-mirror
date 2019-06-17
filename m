Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B75491F462
	for <e@80x24.org>; Mon, 17 Jun 2019 07:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbfFQHZW (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 03:25:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35914 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfFQHZW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 03:25:22 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so19064463ioh.3
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 00:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2SIzWz/nPfrLdMWW4D8UkmRkMISBERetjfuYxZDaH8=;
        b=iTfninQu7/Ct0beWp2qG++Hconjitw4qfm8ZW1GsoTCIDvCk9EnNHPAAYZPoz6Ate7
         YdX4z1YUxtiV8bZ//XJc/mIktVl35pfonom5pQ1rqZhFmpSXdsdjjDRYkGkpp/blm6Nh
         5FpIkaMW1d/FFpa9ipvJzPHix5jA744JW6vTURoAMVEVCqJjgTHwRBV4qZ0hxlsZYHmU
         vHbcbi9R2X/TcqnJQYktz+WVBW08xFZoesyC3BDFD5EinSx4IdtPfXhigpTKwcv84ZiW
         4azxhN869TvVXw+33Gr9DKNrt4LbS+qiouJyl+S/JMt4H7WrnzH0UvsDpToFyb3c/uzw
         v2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2SIzWz/nPfrLdMWW4D8UkmRkMISBERetjfuYxZDaH8=;
        b=NTp/XHzkJFV+SiJaBu6jtUdHLD53TSRcUA43nt/gdOtop2FeSw2n73Q/bf6z+TlWSB
         VHuVu9bZqJEeKqbGC+NUpUixAP25GIS5nW+wOKUZwDob2w7ngPAW1pCboIZS5Fn/OcXt
         jb8lEyt6QfN4W4mfSFe3NwQCsm54uCns7fQnCNXOi0qpNdEQIssRXOptrT/xEK5wO2x6
         wxTb0tuep0b6OmTvglWcNof+uawf6GGQqvqBIwe44zBzR0K6hpGc+BQpEu/vu8FhkJXo
         D+kpVpGIcqW5jrg+JVtK3E2lhIklg9K/QSD99paP3kLTa8q3SsB92IQccqyBJkHLf8PS
         xz1g==
X-Gm-Message-State: APjAAAWpUpFYZgWTemPUBcGPm1uQqM+O1rEHDgP3wquCsRO+lBcrWIIa
        JXtEKOKLkAf6M0XKE1+gQrwG7Ax9j4BB6jf/xJs=
X-Google-Smtp-Source: APXvYqwrkWkR3lVME8Zo2GboJXT3kvG1EJR+GdH0zzMkfQGR48ZmxMi/6egI8eU359vX6BBhEBCbmNQWTv4SrkYDLNo=
X-Received: by 2002:a05:6602:220a:: with SMTP id n10mr13695347ion.205.1560756321600;
 Mon, 17 Jun 2019 00:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190615161135.57269-1-carenas@gmail.com> <0915f2bc-5818-3bf5-34c2-7c783363cc34@gmail.com>
In-Reply-To: <0915f2bc-5818-3bf5-34c2-7c783363cc34@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 17 Jun 2019 00:25:09 -0700
Message-ID: <CAPUEspip4ae7W+DwP1A=DC48v64KxcgV+5EdMYHvkYCpf9UX+A@mail.gmail.com>
Subject: Re: [PATCH] fsmonitor: avoid signed integer overflow / infinite loop
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 16, 2019 at 6:17 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> Thanks for catching this. I wonder if there is a compiler setting or
> static analysis that caught this so we can avoid the issue in the future.

-Wsign-compare would definitely raise a warning about this, but we have
currently 956 of those in master (which is why they are currently being
suppressed), with about 112 of those in similar code.

it is important to also mention that cache_nr/active_nr is unsigned
since the first
version of git, so the issue isn't new, neither specific to fsmonitor,
and as you
pointed out, unlikely to manifest itself.

Carlo
