Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BE5F20374
	for <e@80x24.org>; Mon, 15 Apr 2019 21:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfDOVap (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 17:30:45 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:55395 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfDOVan (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 17:30:43 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 44jhW45sbQz5tlB;
        Mon, 15 Apr 2019 23:30:40 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 304292AA9;
        Mon, 15 Apr 2019 23:30:40 +0200 (CEST)
Subject: Re: [BUG] GIT_SSH_COMMAND is not being decomposed
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     =?UTF-8?B?J1NaRURFUiBHw6Fib3In?= <szeder.dev@gmail.com>,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>, git@vger.kernel.org
References: <000d01d4f237$5cf2dc10$16d89430$@nexbridge.com>
 <874l71fxmg.fsf@evledraar.gmail.com> <20190413214736.GD15936@szeder.dev>
 <004d01d4f3c0$3ff358d0$bfda0a70$@nexbridge.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <275443bc-ec87-09a0-d4c5-cc3bb86be105@kdbg.org>
Date:   Mon, 15 Apr 2019 23:30:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <004d01d4f3c0$3ff358d0$bfda0a70$@nexbridge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.04.19 um 21:20 schrieb Randall S. Becker:
> What is strange is that GIT_SSH_COMMAND='/usr/bin/ssh -v' should not
> execute if we are just looking at an object path. It should be broken
> into '/usr/bin/ssh' and '-v' otherwise spawn* or exec* will not
> execute it. I'm still trying to understand why I can successfully do
> things like the following:>
> $ GIT_SSH_COMMAND="ssh -i ~/.ssh/myid" git fetch
> 
> on virtually any platform at my disposal (Windows, Ubuntu, MacOS, the
> older NonStop variant), and have that work with no problem. Somewhere
> after get_ssh_command(), the command is being interpreted it its
> parts either as a shell or something else (still trying to find
> that).
Have a look at fill_ssh_args() and determine_ssh_variant() in connect.c.
Quite a lot is going on there. I don't see immediately why it doesn't
follow the usual logic in your case, though.

-- Hannes
