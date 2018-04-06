Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E16CA1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 19:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbeDFTpQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 15:45:16 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:44555 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeDFTpP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 15:45:15 -0400
Received: by mail-yw0-f182.google.com with SMTP id z21so729223ywg.11
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 12:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y3y6OZcqyNrblyGOFXlEoPOb00zrNpX3Df9h6MhRDd8=;
        b=Si1Xx3cfWzbEZ60L+sFg+afNOXIGS4LFYIIJNQ2vXMAWLZd+zjblTtLGvEc8Mys4mc
         uezUXPvdBf+sm62ooaPBmFhJ+/yVcsL9fQiJCPM1eIAFikS9huAT/UfFVym/YzkaB1Db
         v4wsbeaU+BaR9NKm9wW7rd3uQEvSYUA2abaszm5XPTxuUQk7P7euWuNf6yacoysu9qIb
         PFU39CFsgELIoXjjPM1XSysSVrV51n1Qbz4bB+XVvCnhMM9p/04l1+iQPSo6v5KhwEpX
         8ISMetWUOJcrLNFWtZ6B6s53D/V/OjhwXLEkq5Wvks3hFYrINYtGUDJRpHfKLzH5j9Id
         iq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y3y6OZcqyNrblyGOFXlEoPOb00zrNpX3Df9h6MhRDd8=;
        b=jPpzKcVLphOyU+kpKJ964DzPBuaejUKKRyTdV3wn8S8lZ/ttRGgv/q5SMz3PIIQ2c+
         RKBKqBTEWwQpn/ivrV/MnhQJvdvVPrN3VlAblpk6IlwqyOPV/nkli1CpmMBdGrrIOakM
         2b1HPOjVayzeufkdL2W+7goLPpX8E3AfI9E0p49/XmtKOUMTzs3dC5qWMJmFRiet5APj
         6yad2bFCCs7U4C/3UvhuSuU0HGwuN9BmjSR+LoTm9a0mCGDHcd25skqh1sitRgDPnDp/
         kbCCcQOWAutWr55whupCkVeJJB+EgNofdNdPanqt2psvSOxJXsE20VLffCcPwQQekDo9
         aCrA==
X-Gm-Message-State: ALQs6tAiIyp0JHTEKKfp9AnUVTb9GBl2T3cIdS2RaPkQNST62ZDBE7uK
        uVnaTOymeDVoJr5bxqlvCPTcTci2N+WL+RbQ62RF5g==
X-Google-Smtp-Source: AIpwx4/VPrftvyPAcJxWRW08BP5CJEcEfi9QZGTevEWO8Q5fyz7ocGzBDhC7ZYmO/mm7QGowFGOZFalSv3STqty+ftU=
X-Received: by 10.129.232.5 with SMTP id a5mr7785674ywm.421.1523043914448;
 Fri, 06 Apr 2018 12:45:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Fri, 6 Apr 2018 12:45:13 -0700 (PDT)
In-Reply-To: <20180406192146.GC921@sigill.intra.peff.net>
References: <20180403120057.173849-1-dstolee@microsoft.com>
 <20180406190919.167092-1-dstolee@microsoft.com> <20180406192146.GC921@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 6 Apr 2018 12:45:13 -0700
Message-ID: <CAGZ79kbrFRsnYQ-VJsUU5hXfKKVoHqE1BE3-4s4Q=QXvXJ4L3Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Lazy-load trees when reading commit-graph
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 6, 2018 at 12:21 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 06, 2018 at 07:09:30PM +0000, Derrick Stolee wrote:
>
>> Derrick Stolee (4):
>>   treewide: rename tree to maybe_tree
>>   commit: create get_commit_tree() method
>>   treewide: replace maybe_tree with accessor methods
>>   commit-graph: lazy-load trees for commits
>
> I gave this only a cursory read, but it addresses my concern from the
> previous round.

Same here.

Thanks,
Stefan
