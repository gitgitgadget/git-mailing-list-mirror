Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF47EC4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 21:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C83222225
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 21:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgLHVy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 16:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730174AbgLHVy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 16:54:57 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F4DC0613D6
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 13:54:17 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id e2so5132842pgi.5
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 13:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ykGDHOCDOqtgJgNnNyQRvAoQq6BHcS+koALxdcaGzgA=;
        b=bY4fxmArIV0QVxX371BDe2gTKC7u4e1VmSmPpX5lKHKn0e3kj6JBDzkj9PyYMDB34c
         L49O1GfhKQdPzr0vsAu4k0tIIuLKd+fRHCuU2uC09xHPqX0wg1CGf/nLaneWe6v4Dsb0
         nFzr2tw17YAMBgjo4W+tSviaSSQytiEc/oNA2S7XMAdjwMNLzsYBacmq35bZ0/YFANfc
         jWVhOaMifcyiKy6hBf63GAeaCiTF+NthZfNjFCSu9YMqCHH949bYeAmd0pP/Cbwr/TJZ
         LPn8nacVQKlnfmVTy7Clda7qQBmqoiWlxKxzbiU1hF/9AreT3Dk3UCD9aBm79uugAnPA
         k3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ykGDHOCDOqtgJgNnNyQRvAoQq6BHcS+koALxdcaGzgA=;
        b=CZk9HbAi2RrCIfZ3p18PV6jUfzDsivlDxKnRko0iMWzCuEvy1Rh1LcCPPwIQna0nOp
         /lfpVIdfTLX26zW2T0IyKIfiDRT+9rCk2i26zxqZ+OTFLF+Hp3exAtmwlNfqbeBU8val
         OXgbbOk1eNRMPHRoV6xC64w1QYXiHz3IZMfKDaWeLI+qo/BrO2h0FpjpcIYPr39oGk0H
         VjnqgucExmi//x63D2Nc2sVxChttucr4FCISUqGIAK+3in/lupv6Iew0MuullGF4IpNK
         /zzPxsoxpT69JL3PdDZSJXf5ZpJ7XMzyyt6yNz4dZvRms6HpINNoyIJzvrVciE2ZqrGE
         t0UQ==
X-Gm-Message-State: AOAM530XpuE+fU5GtTn9igISlrLhyoqTG/1V0nPDT7oJgyZCxBmR5/mU
        WAWg8I+O/UAarrzXyGjJCdeWmg==
X-Google-Smtp-Source: ABdhPJz03Gby/gsKhwP7zeOgqRcqCazfZcQ6qqaQrztWksVRSssWHtofsqj4llObspxoI4EXOGyxNg==
X-Received: by 2002:a63:4852:: with SMTP id x18mr90699pgk.89.1607464456533;
        Tue, 08 Dec 2020 13:54:16 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id w35sm92861pjj.57.2020.12.08.13.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 13:54:15 -0800 (PST)
Date:   Tue, 8 Dec 2020 13:54:11 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: New sharness/test vim syntax
Message-ID: <20201208215411.GB3783238@google.com>
References: <CAMP44s1D-Zp3KDS+Hi74a=Lkc7Nc_0qiEzQEF0Pmj=bD8i+=JQ@mail.gmail.com>
 <X8++TTnv95IAIkZL@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8++TTnv95IAIkZL@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 08, 2020 at 12:56:29PM -0500, Jeff King wrote:
> 
> On Thu, Nov 26, 2020 at 04:24:42AM -0600, Felipe Contreras wrote:
> 
> > It gets a bit tedious to see all the tests in the same color, so I
> > wrote my own vim syntax file so that at least the body of
> > test_expect_success is highlighted properly.
> 
> Thanks for sharing this. Over the years I've gotten used to the horrible
> all-red view when editing our test scripts, but I'm looking forward to
> leaving that behind. :)

Thanks for bumping this mail, Peff - I saw it come in, said "oh heck
yeah, I'll install that later" ... and then forgot :)

But I've installed it now. This is awesome. Thanks for sharing it
Felipe!

 - Emily
