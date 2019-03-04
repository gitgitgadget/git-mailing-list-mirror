Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D29F20248
	for <e@80x24.org>; Mon,  4 Mar 2019 01:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfCDBLu (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 20:11:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33848 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbfCDBLu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 20:11:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id o10so2868460wmc.1
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 17:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Vwcr/ZDpPcuq8dwFykKrXM+OGWrbogDhjzt6pTTnGds=;
        b=JTmTs+4eRhrys10dYk2K7prmsoQ6x8lwYuZHlL1hPTaTsaLnWnl0uqi9wDfeyZyUJ/
         95bmQ7qwHT9hxpnmtZTiqVbEDdSh439v1fYllQrGfWaL1PlXJfOxuo9uNIS1TpAtXkUS
         i3k8Di6zAZz7OOvoFUP+LwSflDzmXJPeGLHwar9/TZe4rZ9UOxijDt/ujcMM5wEiYCIG
         PAxWnLZ50oBsxJHAXFZabZ1lVEhoux4qEGpkMXdC6+6MLrhMGjXXhZLJrQyIpRw/ZMmJ
         NlgUcXeHWFWWfhEYsIz2t3CP5XHixMX3KJk0ra7KdU4CWUT8wjiAXSXgtXh5e4Cm9CYJ
         Gi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Vwcr/ZDpPcuq8dwFykKrXM+OGWrbogDhjzt6pTTnGds=;
        b=UOBibJbpidEt01xSMdPImZbBzqdiXDhvmvjuha/WQGVXMZdVCZaSoJYpTg71nSGtyV
         XIaqEltrNBnfgvcCP8lS1aHNQ1VN+tvcTcrbz93hucGqBSpICcXVCQWTPua7L8b0XkOa
         oqnoroVYrn694KWzwBmuf0icptU0LOADVwAFCj4IYK/sZa7UbRoF3JbhrX+XublahZAc
         ExLIyuAPfttMC415B4WbHZGZYKNQv7yq/b9E/XIVZO9o9+sS7QTn5ws8Wxe2zVP5lHdD
         ETyES6c+XTa6d0Jb9CtRYGjyfMqAZeOSIaAllUZjzWBQlLA9tUI0V8vLYkB0FJZ0zDd8
         ZSBA==
X-Gm-Message-State: AHQUAubClHrdGdybd7q8z4LD9S0BzFHZvIyZbsRYy/FMBFYz7Uh1J8ty
        C1Vn4F7VMpjGaZEVmv6tXGU=
X-Google-Smtp-Source: APXvYqxrxFZA3O6RoBRaqjJt5zQPxfeeeCxyJP+Wdq+QgdQTf7KezFZFP0lXTRyR5QvANKX+hco2hQ==
X-Received: by 2002:a7b:c38d:: with SMTP id s13mr8997238wmj.151.1551661907752;
        Sun, 03 Mar 2019 17:11:47 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v18sm5108710wrr.90.2019.03.03.17.11.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 17:11:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>
Subject: Re: [PATCH 2/2] fetch: ignore SIGPIPE during network operation
References: <20190303165447.GA31116@sigill.intra.peff.net>
        <20190303165843.GB23755@sigill.intra.peff.net>
Date:   Mon, 04 Mar 2019 10:11:46 +0900
In-Reply-To: <20190303165843.GB23755@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 3 Mar 2019 11:58:43 -0500")
Message-ID: <xmqqk1hfzbn1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... But by dying immediately, we never actually
> read the ERR packet and report its content to the user. This is a (racy)
> problem on all platforms.

Yeah, I do not think of a good solution for it (nor I am not
convinced that it is worth fixing, to be honest.  The cable may get
cut before we have a chance to see the ERR packet, or the other side
may have died before producing one.

The fix obviously looks good.  Thanks.
