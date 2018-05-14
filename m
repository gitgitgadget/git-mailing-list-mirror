Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 440471F406
	for <e@80x24.org>; Mon, 14 May 2018 06:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbeENGQD (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 02:16:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56128 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeENGQD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 02:16:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id a8-v6so11273292wmg.5
        for <git@vger.kernel.org>; Sun, 13 May 2018 23:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=c0gpzMethT3zOv8YP9Gg2VPQygdxcUgEUvOaA6ap828=;
        b=EDxxfAtrBEBpzP68yzP7hVgtSbgL5exrvDQ4m6RArQL2mVTuMcczXazS0j/DFHhzd0
         GedGDEHIMGbRCJdYVKtt8tgDUzeLDfp89Qbu+ifcP3z9h6Bmkk8TM0jF0m2zloJ1ZlmU
         ENoImx7Iaju1TO1Pmg9AEgaG3SqA9V5Wa2pUr0dOFGDyeM5aizAg1qCDKbaQceH6PAgD
         lmL3YN4X6gV7sHDXmNDdru9w/EONbH1Dt96yaN1/+0nUtGmt/PuDq4HqkvQO3bqah0GA
         QJRUL7qL/lwUbqDVIFKPtOuN5Vx+hczNF16/HIDRGYqaSr7kk1ldX6113Y4nfJ3h7+F8
         u+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=c0gpzMethT3zOv8YP9Gg2VPQygdxcUgEUvOaA6ap828=;
        b=G8M0CoaBK/T+W6xV4YG1gzYJxJXgFE3YqcHqUCZVeA12YDo+WZ4u6Pq5aUSAOfLGhs
         EGfQUBM0qEWJkN9xF9jZq6Y0Rt000U5YRhrTUARuUqWuqGqIVA61TitI+j7LhQcHl0ue
         sQVy5DrV6K4DzyZs9R7YoPgkmhwfD2kBneW5gu3Yz+ialiRoJTTW8y9InVoCEguQvsYR
         HmtSCEB5LRjYu8UhvNCqKgDW+YQsqYnbiYrM0bzrS0BbIcPhr0DwiiytZwIKmuGypIbI
         ghZx2n5w/cE0ByWcz0qD9WN6y3QWCUJezOiA4i33bRMBB5pmgEGetObNwwVY1ExkLzKn
         +yBg==
X-Gm-Message-State: ALKqPwfog3IuUGDbxMCuMSH+Fe68aw5TDue9IjD3J/Bm8OIjhacqVF5c
        E1H2D1HLg8yaiaNlm/AScCQ=
X-Google-Smtp-Source: AB8JxZpbkhxDj82M1tRPWFcsrfYyp+iVoYVeNF6ZqKbsqNeN/e62tn3e3pEh74wTcHxLRZZ/zPphWA==
X-Received: by 2002:a1c:9015:: with SMTP id s21-v6mr4007173wmd.75.1526278561804;
        Sun, 13 May 2018 23:16:01 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a129-v6sm7251360wme.34.2018.05.13.23.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 May 2018 23:16:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 09/14] bisect.c: use commit-slab for commit weight instead of commit->util
References: <20180512080028.29611-1-pclouds@gmail.com>
        <20180513055208.17952-1-pclouds@gmail.com>
        <20180513055208.17952-10-pclouds@gmail.com>
Date:   Mon, 14 May 2018 15:16:00 +0900
In-Reply-To: <20180513055208.17952-10-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 13 May 2018 07:52:03 +0200")
Message-ID: <xmqq7eo6daov.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> -		p->item->util = &weights[n++];
> +		*commit_weight_at(&commit_weight, p->item) = &weights[n++];

Interesting to see that this cleverness was inherited from the
original code that used the util field :-).  I was wondering why
the code was using "int*" without on-demand allocation.
