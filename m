Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 120341F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 20:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733021AbeGKU4b (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 16:56:31 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:33387 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbeGKU4b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 16:56:31 -0400
Received: by mail-wr1-f49.google.com with SMTP id g6-v6so10569980wrp.0
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 13:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CmBR7AR5YaoQkhkEMDSCwixLOHeP0/VynfwxSGe+AtY=;
        b=REtrn4YdhAX7VzW+gcSBskEylmmWPn7RF5+uTwJXeVyuNXY/zQHKq/yKAGgTY86M4C
         uhpJYiQk6MLQMdCgMBkuZ+PKTClbV76QuD/RTqCuNz5Zr/HZxgzGQsRnhUbQQO3w3iZW
         9TtkYKiSXOTqbUl78r9XjfEVWJKrpgZHQKSeEaMSVYBL7V3+Kl4jHWuQN0WcCXpgOW34
         WzgvuSENh9OXLRmsvveJMHAFSaPKTND1y/4KNzMEZtrx4XAHw500dOoY89lR1vCNLCpY
         ahEe+nTT7CfofaGr89ExO3pozKwX8Q81SgOaZLnCrh+hrxAiz79BUES6fqSi1ItwOSeE
         Xwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CmBR7AR5YaoQkhkEMDSCwixLOHeP0/VynfwxSGe+AtY=;
        b=st8ZhoH2640H0juynmG58iODTZZWRRZBEqawur45DO+IlwAbI2AKxPWzdBEm+bG5WI
         h0IDhWLob7rZ99qAQLScPOR3uD1Cbew0ohDNa0teJMF7qQGUkGul0JU9nIWOC7KN9+ih
         ImQt2JrnKtMYwcgzYyt9ml7yu6vEC/yJBxg6XOPQAD9Iunj5OzpscqB6pRuOtoX1ubcQ
         CxZi55K6zkxnUfBt6Xj0Rh17hA0Dl6gxU5AF39xOB6GP3GMoe95oPAUVfCxF1+oE8/z3
         DczGyd077orYXlR2IJsfD4YMKpb83QUeDgZaElJDIzbJZoafUDsUkj1RPWgrAI7gsdo9
         KQiw==
X-Gm-Message-State: AOUpUlGnweZjVV6giebR2UaWdfAgziEFQGmeJ0cWhuMgUh/N3WxT5bc6
        nQEf1Lmh6fC3zzVUL4d5Z0E=
X-Google-Smtp-Source: AAOMgpfA+zyeP7ZKXfpGhdNk3h8wpVCXJlHwlsMccZ7yLDLSs8Jof8+cz2zMnVXLejHY3Om/dKyoSg==
X-Received: by 2002:adf:f210:: with SMTP id p16-v6mr134460wro.184.1531342222216;
        Wed, 11 Jul 2018 13:50:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t6-v6sm3016239wrn.97.2018.07.11.13.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:50:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Felchner <jfelchner1@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Martin Agren <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Oliver Joseph Ash <oliverjash@gmail.com>,
        Mahmoud Al-Qudsi <mqudsi@neosmart.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] add -p: fix counting empty context lines in edited patches
References: <20180601174644.13055-1-phillip.wood@talktalk.net>
        <20180611094602.17469-1-phillip.wood@talktalk.net>
        <C9B989D9-5148-4AF1-80EB-ADFAE0DB8FF8@gmail.com>
Date:   Wed, 11 Jul 2018 13:50:21 -0700
In-Reply-To: <C9B989D9-5148-4AF1-80EB-ADFAE0DB8FF8@gmail.com> (Jeff Felchner's
        message of "Wed, 11 Jul 2018 15:27:57 -0500")
Message-ID: <xmqqy3eh1oqa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Felchner <jfelchner1@gmail.com> writes:

> Hey all, I assumed this was going to be in 2.18, but I'm still having the same issue.  What's the plan for release of this?

You assumed wrong ;-)  A patch written on June 11th that is already
deep into pre-release freeze, unless it is about fixing a regression
during the same cycle, would never be in the release tagged on 21st.

It is already a part of the 'master' branch after v2.18, so v2.19
would be the first feature release that would see it (unless we
discover problems in that change and need to revert it, that is).
