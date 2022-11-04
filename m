Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD07C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 21:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiKDVom (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 17:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKDVok (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 17:44:40 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC6BD9E
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 14:44:39 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p141so4836075iod.6
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 14:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLz7Si5Ywssy01rrCkV2U4O7B0aSydo3XCcvfKs9Y/8=;
        b=ZiUjcczr2//icpgq54YZR1XPEuCj0hUXYr7oioahcQ+wjij6roMCo9k3yzzQWZHDyF
         sDQFweLMC06kvoGY0g6nOkTdZY+2/JhE55QUwbBEl/yP4nsh2gwRZBJdJRy5c3A2ChWO
         b0/RyFBsBFzpDfQyGrOtb0YuNhnyof8SB+7i60VFGqy1rTz4q7N4RgMuoIYSy8mRrfip
         jtjRfnrFqj2fDWC35PuOC2jPSsWP9gVn0jXrBG++mxqXGNn4NgNduRPmAeGd70zWqW1s
         ZRFsdas86dYWZ13E3Vl3CKHSpO72XrcHVZLz7Jd4wlMqDYEIg8VIW1J7h5hU83N/L0ba
         h3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLz7Si5Ywssy01rrCkV2U4O7B0aSydo3XCcvfKs9Y/8=;
        b=aCdu4tDQDCBNzuXpSeil8LKEx8PSU/+y+J3n1AEQtcV6Q3FCiuvEuj4yf9jU7UnjXT
         Y9cd8BcpDUp9twiHbiFKAY0p3bmLk6RDnQ8TcbCDeCCqux1F0G+d0HJO/QgUOMhIMcd5
         I48uxTyoDAp9XJvqo8lvSzDR5KiYPKIyyRg3tNbxDmX1lNR0ehQhogsxIDFhSY0adexM
         m0415DmD5HLtF7uBmJsEpis0lWhAPWOnjOVSaSoPgmd51Osacm7vbxXIgLu5YmwDrIwO
         1Ktol4NeDQGa61vvLa8P1TxVY3sSM5qZ4OkO1hRcNth2DlmjXKsZRZ6dOJy4/MNF+Oyz
         PHkw==
X-Gm-Message-State: ACrzQf202wyPHQn9u1bWasQ/bq5TNJo7FQ6ER9XmKM+busVowZgsc7cR
        RXad6iNT1nZQfsYiCO4z+xqZTw==
X-Google-Smtp-Source: AMsMyM4oICn9jA/5scQQmoNRaai0K0Jq9KsXd9C9uUAi0YTkNpfbeZw5inr0va4cdvJJvzvXphZ/6g==
X-Received: by 2002:a02:9085:0:b0:375:8557:5a8b with SMTP id x5-20020a029085000000b0037585575a8bmr8771381jaf.262.1667598279260;
        Fri, 04 Nov 2022 14:44:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z18-20020a92cd12000000b00300b9b7d594sm226309iln.20.2022.11.04.14.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:44:38 -0700 (PDT)
Date:   Fri, 4 Nov 2022 17:44:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     phillip.wood@dunelm.org.uk
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 10/17] sequencer.c: fix "opts->strategy" leak in
 read_strategy_opts()
Message-ID: <Y2WHxveDDH5YLpZq@nand.local>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
 <patch-10.17-9c70bfa334e-20221103T164632Z-avarab@gmail.com>
 <b9f08244-36bc-b74f-ac1a-b665423bc2e7@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9f08244-36bc-b74f-ac1a-b665423bc2e7@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 02:50:02PM +0000, Phillip Wood wrote:
> > Along with the preceding commit this change various
> > rebase-related tests pass.
>
> Really? at a glance the previous patch looks unrelated and there are no
> tests marked as passing in this one.

Yeah, I wondered the same thing. What are we missing here?

Thanks,
Taylor
