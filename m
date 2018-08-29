Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D8711F404
	for <e@80x24.org>; Wed, 29 Aug 2018 17:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeH2VMO (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 17:12:14 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33190 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeH2VMO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 17:12:14 -0400
Received: by mail-wm0-f51.google.com with SMTP id i134-v6so5012446wmf.0
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=a3w5clVNHGqf3nJ3zVJARH2fp9AUW8gdhDA0O43nNZU=;
        b=Tc0R710d7frxzHdGsUU5Edg5kwDvqF12eMpRHgLHRUs+2Q6xanC8aKT/m2N/0b9Q3e
         Dm97ugJ8BtjRxWZwfDo4IjojD6iYgPLl4Peuso0QIbXeunHNtRxxgSDsMX8XPhJzkzqx
         frmknXOiozxYjivKGWtJ++8R88TVUUkN/4KvHf9gBSlvE0sotPxxj0AX3UYdAhq5dUCP
         mPCHmaob9VyXoJf0V1NK/ECxIRtkvCe/tmjeg21INy4B03RYBjI25q7jihtRuvzZux1G
         FcW4KycNygaqe0AV70xV1kci13HCTx3sOhWQK8AgZ4cfopU1mwigzb6xraxShc320bhR
         4RiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=a3w5clVNHGqf3nJ3zVJARH2fp9AUW8gdhDA0O43nNZU=;
        b=Y+MTios2RaHrEnzVBFE2uAwsu/PUT3HBsLEgVPfTl3lLrnPjDziB+3wO4jK3ZrYpYB
         0xKJkU5EI5Zcqk1dO02tIzrAUKlv3ZvWPXnpa/Hok13gy9qu5nV32q+0IJip5bWZOlO4
         zposDcnKe1RWjkRo2JnFtl5bNLG1VHUUbmh5/FcQIVyIqyZIT/U41hDfbLkgJoHEFhz4
         jP5OtcqpLeIKD0xlD2f40goYEdbDD0Difi9WVqxOicDvyElXgbCwIEW8MHR6SsvWoh/W
         qC+G+Q6DzI7DErSzmX/WXFrE2dbREoWYGmZeTAaAPHyOWU8MSTlk8d3+1TzN2gAqLWp0
         w0+w==
X-Gm-Message-State: APzg51AnzcYrayPPwHBXZVL7U4Vv06r7NVu3N/IExyIcaTyE4I3rnjpl
        c3lkQ/ukCkzS8Ij++m/tgAk=
X-Google-Smtp-Source: ANB0VdYcipAJVx4Xd0k8vXFlz6Z7T+dYvjh9ir8YRhhcVw39GCNSauPe1RxdmwEI2SCl7muBdURJ9A==
X-Received: by 2002:a1c:8e04:: with SMTP id q4-v6mr4886272wmd.150.1535562859894;
        Wed, 29 Aug 2018 10:14:19 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 200-v6sm8446570wmv.6.2018.08.29.10.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 10:14:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH] read-cache.c: optimize reading index format v4
References: <20180824155734.GA6170@duynguyen.home>
        <20180825064458.28484-1-pclouds@gmail.com>
        <xmqqwosbiouc.fsf@gitster-ct.c.googlers.com>
        <CACsJy8B38QAW8qq-CctLJyJNaC329o6Rr1gs0kd=EkV+ARAaVw@mail.gmail.com>
Date:   Wed, 29 Aug 2018 10:14:18 -0700
Message-ID: <xmqqd0u1ccyd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Yeah I kinda hated dummy_entry too but the feeling wasn't strong
> enough to move towards the index->version check. I guess I'm going to
> do it now.

Sounds like a plan.  Thanks again for a pleasant read.
