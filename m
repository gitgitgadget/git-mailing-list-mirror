Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF473C43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 22:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2E5206BE
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 22:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgIOWfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:35:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36233 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbgIOQKm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 12:10:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id k13so1588350plk.3
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 09:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sn3uYorQGpiHBd8aEHXB6ss/cGmyh4fkdoq6JGD2uMk=;
        b=WjFSc+qWDVeYdTBBdBcxUNClq9Q81H5f1W+9ddxeHTE78LKPCIZVDOoNdEqpaWnqq7
         nTvpXCEIMT2zTib6DcCKHQtGRCH/DmbPMluvbE3yNuZVdzi5bIy09xiwhEm8XhBYsrFm
         A1kY5dGfkd1JS/VjSsbvEiM7jdjSAbzJtL3FJPo7+XJE+zS6ApPJlLl+RqNx80dGt7CR
         0V44/WYA82f48kcq20jgEwxmxOosMIEfxFvZyhs8Zug1iAUOobt/2kQNESYFoLmLMLik
         7jYVfH/QNacSyRhQ81jErhBcjpuoHdOR2p92UnPZYwE+1kiuzl7DZC20eUEFBsbaHLmG
         tmrQ==
X-Gm-Message-State: AOAM531bEWvoo8lURb9rb+KXjHWpnD01Kw3otrjJ/b6Dj+3oB3OPb9jP
        WH6HNe+qHfp7T9tApccF0OI=
X-Google-Smtp-Source: ABdhPJx3nRUoNCjdDcfOtv4dTI3MwiNl0h0rba1/CBwwjLU/HUeMAsIjDmbEihPay8dEa8S8zMYBqA==
X-Received: by 2002:a17:90a:eb06:: with SMTP id j6mr137290pjz.46.1600186235150;
        Tue, 15 Sep 2020 09:10:35 -0700 (PDT)
Received: from localhost.localdomain (50-125-94-129.hllk.wa.frontiernet.net. [50.125.94.129])
        by smtp.gmail.com with ESMTPSA id co3sm30861pjb.31.2020.09.15.09.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 09:10:34 -0700 (PDT)
From:   Sean Barag <sean@barag.org>
To:     peff@peff.net
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de, sean@barag.org, stolee@gmail.com
Subject: Re: [PATCH 1/4] clone: add tests for --template and some disallowed option pairs
Date:   Tue, 15 Sep 2020 09:09:44 -0700
Message-Id: <20200915160943.1253867-1-sean@barag.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200911195622.GB2697399@coredump.intra.peff.net>
References: <20200911195622.GB2697399@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 11 Sep 2020 15:56:22 -0400, Jeff King wrote:
 > do we really care about code 128, or just failure? test_must_fail
   might be a better choice

Good point - `test_must_fail` is probably fine here.  I went with an
explicit error code so this test wouldn't pass in the event of an
outright crash, but I'm happy to adjust for v2.

> I didn't even know we had test_debug. ;) The last time somebody added
  a call to it was in 2012. I think it's being used as intended here,
  but I'm not sure that the clutter to the test is worth it (we have
  other tools like "-i" to stop at the right spot and let you inspect
  the broken state).

Frankly I'd forgotten I'd included it!  It's definitely not necessary.
Will remove for v2 as well.

> the backslash escapes confused me for a moment. I guess they are
  trying to hide the dashes from grep's option parser. That's OK,
  though I'd have probably just started with "bare" since we're
  matching a substring anyway. I think you could also use "-e" with
  test_i18ngrep.

Adding `-e` would solve this handily.  Thanks for the suggestion!

Sean Barag
