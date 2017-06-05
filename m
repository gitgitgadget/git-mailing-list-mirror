Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFB9420D09
	for <e@80x24.org>; Mon,  5 Jun 2017 02:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbdFECEc (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 22:04:32 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36231 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbdFECEb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 22:04:31 -0400
Received: by mail-pg0-f50.google.com with SMTP id a70so6208740pge.3
        for <git@vger.kernel.org>; Sun, 04 Jun 2017 19:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EqB67fELr2+qE36wo1KZThvc5qdNPueeZy6IhElBW0w=;
        b=dNLhvyTMoypBKoxKAshdFH6D3FR3blXXFUnPbYMTEwgde7MzRB7tubSar0tsJS3hh0
         SpfHcnayFgYgLp1YA2QepbglDyrTEPHt0pjOEliRmEBgKpgsUUNYKVipbsf18GqTGB7P
         LaanD5RodP5TkZ3Y+UwBb1/xDWFmKZUSVN1rfjBeyLTrbsAyANud/lO7yYycScJXUb/T
         U4q+z9dFUf6rHazw8kfdxCSWDZx5T04MOo+w4hVoq+31yTM/Nekwi25P3oG6saIUnAQI
         4vcdJ3hJhndJvyQCebOxsi6VYpPegxKUq6DwhLi0K3yy+EJqHSdAp019csMauD9uKrxp
         vPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EqB67fELr2+qE36wo1KZThvc5qdNPueeZy6IhElBW0w=;
        b=tZECGaJ6Ci5IXv7qFv14TV7qzePnzninr8nKizNVy03Fw2g+EdFCTI/05I9vlDnDIN
         /ilkrkTIiqi2K5ZD+eOJCplfoyaFGWUVp3Ntxy1KIZgFKSYCWrV0nzCHw1U8KwwxaXcj
         GSqNg3Zz6tgHmguK2gf+Cv2elxEm23qUY2svv1oxV+zHHt1L5gZODAZu5S/1NFuBuAtv
         HHujMWuqDPaguViBFP21aFSZjmgh6T/B3W63jERwcnj9IFI3fWYDoJ/5pymGsOT1CPi6
         /7F76QUkenl9XctigjP0+0wo5kPEvCQ0mGZn0sFz8CPpxfFhIMnR/818MaEuj+s731sl
         QhmA==
X-Gm-Message-State: AODbwcApXM+eV1qOERmm79BSe6j68Z7Vjmptw/1H2EsWIybxeS4Ua38w
        ta58YfcZp5fX/g==
X-Received: by 10.84.236.15 with SMTP id q15mr12260564plk.163.1496628270316;
        Sun, 04 Jun 2017 19:04:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a83a:973:bb14:324a])
        by smtp.gmail.com with ESMTPSA id u73sm11779746pgb.24.2017.06.04.19.04.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 04 Jun 2017 19:04:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] perf: work around the tested repo having an index.lock
References: <20170602103330.25663-1-avarab@gmail.com>
        <20170602184506.x2inwswmcwafyvfy@sigill.intra.peff.net>
        <xmqqd1amx80f.fsf@gitster.mtv.corp.google.com>
        <CACBZZX52O9Pf=5Xtq1Lg1=ZU26tm7pupvubk1ZjNJZp7kR450g@mail.gmail.com>
        <xmqqefv0wrj7.fsf@gitster.mtv.corp.google.com>
        <20170604082919.y5g34udvyjfaqtve@sigill.intra.peff.net>
Date:   Mon, 05 Jun 2017 11:04:29 +0900
In-Reply-To: <20170604082919.y5g34udvyjfaqtve@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 4 Jun 2017 04:29:19 -0400")
Message-ID: <xmqq60gbur4i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't really mind addressing this one case that much. I'm not sure
> that we want to accrue a pile of band-aids here that causes a
> maintenance burden and doesn't really solve the problem completely. One
> way to do that is to say no to the first band-aid. 

Yup, that was where my objection came from.

> But we could also
> apply it and see what happens. At the very worst it's a few extra lines
> of code, and we can start to get worried on the second or third
> band-aid.

That's OK as well.  But we should resolve now that we will rip all
of them out once we start seeing the second or third band-aid.  I
really do not want to see the "accring a pile of band aids" in our
future.
