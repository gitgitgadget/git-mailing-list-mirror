Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D211C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 22:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjCXW5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 18:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjCXW5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 18:57:24 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6901BADC
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 15:57:16 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id r187so4107575ybr.6
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 15:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679698636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FO5MrlIN4q8v+47co4/biy+8UbvZ06GI5Rd3mwyQCSE=;
        b=HUQwlGPWWqcW0GDOBzV0bxFYMWv/wG92dUYP7QX33AW629sbEF/+pFLue6Ea9/r+xT
         nltp5xQlk2+qSKVA7Pgbmlz9eok4oMMe3eVsG95MuamSEKIZFq/CJT7rdSvHmqvAsyj5
         NAEIHsst6Z7/cyia8z1XAPqd+mhMaDzq1bj57EPPvs0jbEvWLkEofrHYZbysrSHRVcui
         XEm2nyBNzZq1GoFMbcMcHA9Cy7AFPIEAgvOr2ToSkfdXFmXcp/xI+oAOwN3xnQhwamK4
         6w7tYasqA11zBpF5Xp8x2bxG/EJU0E9hka2W7WSNf5C1MDo3KuyQ6ueOvlZCK+gKitAn
         P1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679698636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FO5MrlIN4q8v+47co4/biy+8UbvZ06GI5Rd3mwyQCSE=;
        b=VdR+POQIXHrMYcirXyoT64pQf7uaFiO22ryiYuOQBAQBIrAMB77A+4C/6VmbXXc2GH
         ubpfi1kp/dBZJrECZTx6csHF6xv15llRBcwur0O/WsxxHqa0ioecukAOovadUfxCHyLr
         VNPzPybXOzqiHK6kxqVRJjHzJNKdFmju/lSn8sJhq86tz9YIXV3RKYwCbLSl2g6dCgXt
         rI6ng1H9qQvoisvpsI9e12PgRVnEHflV9Qz0VOwKCL7yuEN+tfQ9IGk5dtfpIGt00obz
         hQD2CQ/fp4j9H4mbClpsIki3IXEFZnSmCYR0hE5gf8nY5lhqxrZc4vFusf5Nqi1NnzPt
         s3cA==
X-Gm-Message-State: AAQBX9fMGIqh0N8cdYbQ1ssm+dCYEelXo4TU0oSQTH+fA4NsXzqyqxHo
        ICQL8g29GMxQmvYy43fOjzXhIw==
X-Google-Smtp-Source: AKy350YkfXe+IvKjQC6fzJS37qX6UL7zTPq0581MLJ6QxXS+5IgffkQzNWfbh0Cvm8enoX9tfL3RPg==
X-Received: by 2002:a25:f627:0:b0:b72:1151:a430 with SMTP id t39-20020a25f627000000b00b721151a430mr3830559ybd.24.1679698635657;
        Fri, 24 Mar 2023 15:57:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d130-20020a811d88000000b00545ac8682e0sm486100ywd.103.2023.03.24.15.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 15:57:15 -0700 (PDT)
Date:   Fri, 24 Mar 2023 18:57:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 5/6] pack-bitmap.c: use `bitmap_index_seek()` where
 possible
Message-ID: <ZB4qyqHCWIofXg6q@nand.local>
References: <cover.1679342296.git.me@ttaylorr.com>
 <9a3e45b78b7810e0116848f1de80096b04285a55.1679342296.git.me@ttaylorr.com>
 <20230321180525.GG3119834@coredump.intra.peff.net>
 <8a7cf287-421c-9a7f-0788-c5e219e6a8e3@github.com>
 <20230324183514.GB536252@coredump.intra.peff.net>
 <xmqqr0tedjf1.fsf@gitster.g>
 <20230324203737.GA549549@coredump.intra.peff.net>
 <xmqqcz4xesom.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcz4xesom.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 02:38:17PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > Yes, I think the SEEK_SET cases really do need to be doing more
> > checking. AFAICT they are blindly trusting the offsets in the file
> > (which is locally generated, so it's more of a corruption problem than a
> > security one, but still). And this series improves that, which is good
> > (but I still think it should be a die() and not a BUG()).
>
> Yes, I think by mistake I merged the topic way too early than it has
> been discussed sufficiently.  I haven't reverted the merge into 'next'
> but it may not be a bad idea if the concensus is that the seek-like
> whence interface is too ugly to live.  BUG() that triggers on data
> errors should be updated to die(), whether we do it as a follow-on
> patch or with a replacement iteration.

Yeah, I was a little surprised to see it merged down so quickly ;-).

It's fine with me if you want to hold it in 'next' while I send a
replacement. Otherwise, if you want to revert it out of 'next', that's
fine with me too.

I doubt it should take that long to reroll and address the concerns in
this thread.

Thanks,
Taylor
