Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E9C1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 21:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfDZVxo (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 17:53:44 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:16169 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfDZVxo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 17:53:44 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 44rSVY0nxlz5tlD;
        Fri, 26 Apr 2019 23:53:41 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id F0FB941E9;
        Fri, 26 Apr 2019 23:53:39 +0200 (CEST)
Subject: Re: [PATCH 1/5] run-command: add preliminary support for multiple
 hooks
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <20190424004948.728326-2-sandals@crustytoothpaste.net>
 <xmqqo94w2l3k.fsf@gitster-ct.c.googlers.com>
 <8f79d251-58d9-f63b-7171-7f1fbd11c6f9@kdbg.org>
 <xmqqo94uzyxa.fsf@gitster-ct.c.googlers.com>
 <2a511c3c-ef8d-07c5-80e2-398780ee6ed4@kdbg.org>
 <20190426205859.GO6316@genre.crustytoothpaste.net>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <cf9818d5-6b58-49bf-8897-28ddb407f557@kdbg.org>
Date:   Fri, 26 Apr 2019 23:53:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426205859.GO6316@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.04.19 um 22:58 schrieb brian m. carlson:
> On Thu, Apr 25, 2019 at 09:40:34PM +0200, Johannes Sixt wrote:
> I would like to point out that we still have to perform an executability
> check before we run the hook or we'll get errors printed to the user.

That's fine. On Windows, when a hook is present, it is also executable.

> Right now, we have a standard way to handle the way we handle hooks: if
> they are not executable, we warn and pretend there's no hook. With this
> new paradigm, we have to check whether the main hook is executable, and
> if it's not, we then have to check whether it's present, and if so, we
> skip the multiple hooks.
> 
> I understand the executable bit is not useful on Windows, but on Unix,
> we should be consistent with how we treat the hooks.

We want to check for two vastly different conditions:

- Do we have to inspect the multi-hook directory? That decision should
be based on existence.

- Do we have to issue a warning? That can be based on the executable
flag. (As I understand, this is just a convenience warning because we do
not want the user to see a cryptic "cannot execute this thing" error or
something.)

I can see that you sense an inconsistency when you treat "not
executable" as "does not exist". But that is just too subtle in my book,
hard to explain, and not the practice that we are exercising these days.

I'm more concerned about the platform differences that we would have to
note in the documentation:

  "To have multple hooks, do X and Y and make sure the standard hook
   file is not executable. Oh, and by the way, if you are on Windows,
   you have to remove the file to make it not executable."

Let's not go there.

-- Hannes
