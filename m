Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162FCC433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 02:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD0B20707
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 02:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="OMycVU/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgFPCbY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 22:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgFPCbX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 22:31:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0E0C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 19:31:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ga6so761070pjb.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 19:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0e6h5kKr584E2fsbJzfsc7OLWpd2IH93b1T9qoFD+R4=;
        b=OMycVU/r/egqmxmw4YKUVqxRSrodhE3t83s9gchCQNYPOb1OVUGrW4Efv5xPfSZh2C
         Od4zAwMvAa2yMSwWmWFmpn+r2k96CDqvFOcPhXiDaGqht3629gfzT3e8Ylh1l8GfcCal
         qF1wXl3NPiwo/hNEj9xWq3oH5WO/i+TqfoLhRN1/ut+98XCkR2Yr/V6V2h7NlrXb4+I3
         qpwDluOxItfj/0fhRxqEtiLup5/OrKdNjjxGcSLRDIS20Dnqot8IzUC39Ahl/8M7aO2B
         uYnV4KBZQL54ybmUwaZ/nYE8L3PAwc3Hwt7F5oxjoXax8xBQtH6SdMFOPdvmpEtSCW4A
         VUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0e6h5kKr584E2fsbJzfsc7OLWpd2IH93b1T9qoFD+R4=;
        b=gDLit6JuW9pMhyaqiNXMLVkH/u2vzwJ8S+SXOp7Qc/n7BrvnInIlx+6RakOSkQsfXB
         t2gPXAjyIbARbHYY3i3cWa2KcWfRDwR9kmNc9eyrZa5/wgbz+ykd7G+sZ8+p/G/tL4IY
         7daK4Kro4tizcZuYa1azVsQ6Y9D2zMPu3/php1Ja0rru9l0z/gMsULwRKcpGPS5b6Ed5
         Vq7LMLzaNavtWRSu/kVhyuaprSKmFFne/cB8DIdWJhJTxVYalTDxMLYFEqNrUGtZq49l
         CCMfs8aJeuC3TkddCbyKic8Hdt9M2ywsp1o/5GY8kQ7twJ4B6q4PPSVaOqg0RLEaIiDs
         vS0g==
X-Gm-Message-State: AOAM530ZfrToC1zVj1pFcU0fIoM3SjhvZjTPqdgWprwkgC5r0I7HAYan
        c3D2mt3j3DXaapcac+p97lJZFQ==
X-Google-Smtp-Source: ABdhPJwXF7ovVZG5y7J5S7g8WdcekmT4mi5/0cmSoy/CeQ+dGUMJRb60lBmjakN1CNESKUALplFhYQ==
X-Received: by 2002:a17:90a:c695:: with SMTP id n21mr658125pjt.206.1592274681143;
        Mon, 15 Jun 2020 19:31:21 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id z14sm15107156pfj.64.2020.06.15.19.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 19:31:20 -0700 (PDT)
Date:   Mon, 15 Jun 2020 20:31:18 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Nomen Nescio <nobody@dizum.com>, git@vger.kernel.org
Subject: Re: Consensus on a new default branch name
Message-ID: <20200616023118.GA89988@syl.local>
References: <6b6f161981a07070871633fe02c4c3f9@dizum.com>
 <20200616022239.GD164606@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616022239.GD164606@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Mon, Jun 15, 2020 at 07:22:39PM -0700, Jonathan Nieder wrote:
> Hi Nomen,
>
> Nomen Nescio wrote:
>
> > Taylor, how do you propose to build this consensus you're talking about
> > on the name change?
>
> I'm glad you're interested in learning more about the Git development
> process!
>
> There are some open source projects that function (mostly) as a
> democracy --- they build the features that those voting request.  A
> famous example of this would be PHP[1].  There is something admirable
> about that approach, but it is not always easy to get right.  Many
> other projects have their own approaches to governance.
>
> In Git, we make most decisions by a rough consensus of active
> contributors, as judged by the maintainer.  There are times that
> consensus may go in a direction that is unworkable, and the maintainer
> has the ability to make a different decision during those times.  If
> decision making ever goes off the rails (perhaps you've judged this to
> be such a moment!), users of Git have the recourse of forking the
> code; such moments have happened in some open source projects in the
> past, for the better, such as the EGCS fork of GCC that was widely
> used by distributors and eventually became the standard version of
> GCC.
>
> If you are looking to have more influence in the Git project, my
> advice would be to become a respected contributor, by providing
> patches, well thought out reviews, documentation improvements, advice
> to bug reporters, or other contributions.  As others learn to trust
> your feedback, you will have more influence on consensus.  Even
> better, you get the immediate benefit of your own work as soon as you
> do it.
>
> I believe Taylor was also interested in another kind of consensus,
> between hosting providers, but that would be likely to coincide with
> what the Git project does so the difference is a bit academic.

What I am broadly interested in is a consensus among the community, so
that we don't have a variety of different names for the default branch
based on where and how you use Git. Of course, by introducing a
configuration option, some variety is to be expected, but I would like
to avoid, for example, GitHub/GitLab/Bitbucket choosing a different name
from what the Git project decides on.

> [...]
> > slacktivism
>
> This is a very weird way to describe the people who are spending their
> time to maintain Git.
>
> Thanks and hope that helps,
> Jonathan
>
> [1] https://lwn.net/Articles/821821/

Thanks,
Taylor
