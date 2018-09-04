Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DF4C1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 19:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeIDX6g (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 19:58:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37783 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbeIDX6g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 19:58:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so5147711wrr.4
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 12:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=8q9iFDDPQ7DFOFKVilFxB64PqxHyG8OoJXm9S83lBaA=;
        b=YP+Fllz3zX93jBxi+i3pL2/I6WnIlSh7I7e/W8cN8tAbWd6Q+xVz1UjnqQCBBBKw90
         p9uiPfudTziFQXbHnIDdBalNdClWMKGJ2znMoStduxiupO1s8WZqTd3DhrW9077iMlWh
         guzOrkVG6Oob38jUN26Y/jemv1Dp1y+kR638PLV3Eu1C3acTUCSla8ogZrXknHeL0Q5a
         YUt6AU2/5/7Uwv51MwATBOVmbH7IJLptmVbm5WTwerroLjYS2gGpX7ySa0ZWW6DBz9Ve
         64HYcTcHuPmp+bbfMrdtZL45uGYEDkAUWZOboyEa0d2ssxIXmBeWQwALck5bWoGrLLIh
         mm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=8q9iFDDPQ7DFOFKVilFxB64PqxHyG8OoJXm9S83lBaA=;
        b=QyNDPVutK4/ljXltmUd1o6DTb3Ztl1dKXq0tmEXFl6S34rwGx2rI+61M4HgmdXx+3Z
         soVBksvEsnvdaSIBdVVsXEtsVL6vePg4oPnwDA9fdvDks6snIdArEFRuLMTsoOyThDoV
         jTSC36zto0jpD1dL4BrkPRQcWZRNoNxms/8E2cuwlAtCq/B+WAc3SzIUUixrd/DFZP7F
         Qxl/zPpfQm+wGw6NBhMui0T6IsuT1hE3hWkAOgrBefGtK2as+hEXV8pebhDWbkpS4sZO
         v738/LeHAtooH4i+JUZFwdMGTcRLJdw+3cW6A/ztqw1uM4WnNaG/sbgGpt/CEdgDds5K
         RSsg==
X-Gm-Message-State: APzg51AMxNdlPFHzsNQyAPRuW6VCO1xTii4EDJClQ6IgdGWgwv6FpWzN
        d7ovIx57D2VQIwVN0RfvqdoJjVq7
X-Google-Smtp-Source: ANB0VdZDQvFpQ9ilSav0mxeMJ1Vh2RVCCbt2pTAKtXdlnPTlWZ/Crwd0i0MU+nS/ttrSUkYXYpqzhg==
X-Received: by 2002:a05:6000:110e:: with SMTP id z14mr4734136wrw.287.1536089522276;
        Tue, 04 Sep 2018 12:32:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v133-v6sm8365wma.36.2018.09.04.12.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 12:32:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     tiagonbotelho@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        haraldnordgren@gmail.com, tiagonbotelho@hotmail.com
Subject: Re: [PATCH v6] Implement --first-parent for git rev-list --bisect
References: <20180828123234.44582-1-tiagonbotelho@hotmail.com>
        <xmqqlg8qh22q.fsf@gitster-ct.c.googlers.com>
        <CACsJy8AFo+mb8R-O-JKRPZk__csq6mbVXbnZhSd-nZ08zWfSeg@mail.gmail.com>
Date:   Tue, 04 Sep 2018 12:32:01 -0700
Message-ID: <xmqqy3ch83f2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Hmm.. no? the commit-slab stores the pointer to the weight, not the
> weight itself, so we still have the ability to check the third case, I
> think.

Good, thanks.
