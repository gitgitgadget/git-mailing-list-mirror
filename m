Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80A20202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 22:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753923AbdJSWOP (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 18:14:15 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:45197 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753818AbdJSWOO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 18:14:14 -0400
Received: by mail-qk0-f175.google.com with SMTP id f199so12259720qke.2
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 15:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ERucwF/KC46XOf3yOOjtAaDc/stq5QtggEQi7O5JqQc=;
        b=i1CfaziXCFWfqRkm4kNprShkhIMJ+4VsX1ybfyRmi2fnPYVYDkQi5zuUfx8qLJstzJ
         eSpGGCGRYU0wAlnZ1fjayLKZdqOoMLjLb9tagaWkQLVrG1SDBk0bHtykAUfltdFvnMmi
         ZP8WSaT5Odi50+tTWt0ZkTvO+lDueA4HCjQ5+J4/cib8qsiIaEnCKsheQfbck93zpjbJ
         CvRtMyCO22ALYHZOWctb2NQ0f5sq38sADOGBABPOnomZ1F+Jq9XkVqgwFbKtTZX3pXHF
         JztnxawSA8lStwfqAmCJoj4KIhykJtAvtuPdFl6sycM4ZKOIrm1B6SFfBlmPHChQljkK
         aHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ERucwF/KC46XOf3yOOjtAaDc/stq5QtggEQi7O5JqQc=;
        b=Yb66dT93k0VlfeZEEYldXR/ulJpnGLOsLN/JrQiO0BShaXuQdZzQ4htHXnNekasfZ8
         VwdzezGBpkakCJ88URcEPgNeRiePX91D0KKqDtn0Hn/26rCCsn/QRKoGIHDuKDE2fgg2
         wHYw8D2iTzNkGwCONVh8lAAtyKXOcG+7+pdHDE35Z8rRTbziKBN7UPzC51qRsZJllDs/
         20xFZrwuPatQqmggLR9B7dNtTg5HYm524gWM0ad9/FX4NHHoNrNuKOmAYqUARKW/rQHv
         m9N5f0V0pOyw7EOa2Q0Sug8mSgfP+QxRjJ85rspREFcdnXaWYXRYEbWB026cKhmWhHOJ
         s0ug==
X-Gm-Message-State: AMCzsaUOQJKQDeyx5S/bNi8L/Ol1zDk2NG51IhWW6JrUYdF/pVX09PJ+
        PKvI8CQc4a8xKpDEZ2Hi9v6To5bqTw2KRwVaTiinrA==
X-Google-Smtp-Source: ABhQp+R8r2MLvBUma6MYv0a4bO+RrCDVHTpn2gDWUT1yJQArxpnkYoPVvm8VZjQWewlszayud6oukMfvGYX6tsrGrm0=
X-Received: by 10.55.175.132 with SMTP id y126mr4307099qke.45.1508451253469;
 Thu, 19 Oct 2017 15:14:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 19 Oct 2017 15:14:12 -0700 (PDT)
In-Reply-To: <db8da340-f8f5-0114-392d-e415b5564993@gmail.com>
References: <20171018142725.10948-1-benpeart@microsoft.com>
 <xmqq4lqvk8ze.fsf@gitster.mtv.corp.google.com> <db8da340-f8f5-0114-392d-e415b5564993@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Oct 2017 15:14:12 -0700
Message-ID: <CAGZ79kZfw7Cb8Qs4BKuESukBL8rCgmYh0=BcNYm9mXJ1LYCg0g@mail.gmail.com>
Subject: Re: [PATCH v1] read_index_from(): Skip verification of the cache
 entry order to speed index loading
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 8:12 AM, Ben Peart <peartben@gmail.com> wrote:

> If we are guarding against "git" writing out an invalid index, we can move
> this into an assert so that only git developers pay the cost of validating
> they haven't created a new bug.  I think this is better than just adding a
> new test case as a new test case would not achieve the same coverage.  This
> is my preferred solution.
>
> If we are guarding against "some other application" writing out an invalid
> index, then everyone will have to pay the cost as we can't insert the test
> into "some other applications."  Without user reports of it happening or any
> telemetry saying it has happened I really have no idea if it every actually
> happens in the wild anymore and whether the cost on every index load is
> still justified.

How well does this play out in the security realm?, c.f.
https://public-inbox.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/
