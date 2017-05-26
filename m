Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23118209FD
	for <e@80x24.org>; Fri, 26 May 2017 01:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939600AbdEZBJr (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 21:09:47 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35638 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939494AbdEZBJh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 21:09:37 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so42421904pfd.2
        for <git@vger.kernel.org>; Thu, 25 May 2017 18:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nCshZ1mcu6ZHbrlqS1FI+sbqG7GF4j0UVpLFOhNuQSw=;
        b=XdhnVCXOcTah8jKnvqwkOfijlBChpSiQLi0QRAx23Dt3Z9xNoU8skIOv8rFLiYWLdI
         fw3aUqI1+23KGuPWmR7IZ50lTn5iorTznBXtFqUgC/QB71yjgcndWUZsJj1/aNblm5JX
         gqpzwzgVp1qAGDy17QGBjwmkAqkJMpp8o3PO1Ivon48ekkNAjqa5HM9fdEHCTcR/ug+M
         NhUlYv6y3GMdoZdMenmDcgl8y4TLPFwLw+863CpFeevoJIbdW1wKuCREAtIEmMhCxIHo
         Jr9wSFSNfKFRIYsjhGgZ9HRmQzIuK3JlLM9W3UJ+BjfeDBwePYRY5cEYWM+ozcA1FC9t
         VBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nCshZ1mcu6ZHbrlqS1FI+sbqG7GF4j0UVpLFOhNuQSw=;
        b=SVhfSr9WIEyCr5rTcXVkx0El9zxW/coLIIAcRJhzMcG6iaYA/MTEwUPeXyrp2CuFDs
         DOUwOIOuy+Qeni4lS5q1s7JdUCsKD8I//CvG/G2EY72CUydr/7E48ViFoiuRuAi80uGa
         EJAIU0gwes0Q8AzAXFWnxecCl7NCvkzHmfLh+OOcVOtOOrSNsmQ7Z0371zaeMN5zwA/3
         kdM1UaJp/rKdTFcOKQkqkplNTLEHaZy6d9pDZweL1CzYOOKCRQa5SMbcip2ANUtZhlDp
         hv0scBBd01sWwobKMWfXCbZVc64drsqBKjrAamGX/KdT15hSia24z+h7IiwdMAZDcj6W
         Q4Vw==
X-Gm-Message-State: AODbwcDMN4IQv1OWLMHEwuaHLvFQmwoNltnQNKUl4f7SkPkQYH+eJ/Nu
        EtyLC9RdRNBX6A==
X-Received: by 10.99.113.74 with SMTP id b10mr49423545pgn.139.1495760976807;
        Thu, 25 May 2017 18:09:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id l198sm15830053pga.50.2017.05.25.18.09.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 18:09:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCHv5 16/17] diff: buffer all output if asked to
References: <20170523024048.16879-1-sbeller@google.com/>
        <20170524214036.29623-1-sbeller@google.com>
        <20170524214036.29623-17-sbeller@google.com>
        <xmqqo9uhfz8g.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZM5KPP7iDo7rT5gxsooRrftJrA=+3-WBXW3nqfXeTy4Q@mail.gmail.com>
Date:   Fri, 26 May 2017 10:09:35 +0900
In-Reply-To: <CAGZ79kZM5KPP7iDo7rT5gxsooRrftJrA=+3-WBXW3nqfXeTy4Q@mail.gmail.com>
        (Stefan Beller's message of "Wed, 24 May 2017 22:34:33 -0700")
Message-ID: <xmqqd1awctkg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Yes, this is essentially the v4 with small indentation fixes, so I
> assumed your signoff is still valid.

OK.  I just didn't expect to see one without "no changes since v4"
under the three-dash line.

Thanks.
