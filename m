Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 536F020C11
	for <e@80x24.org>; Thu, 30 Nov 2017 18:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753871AbdK3SBv (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 13:01:51 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:53029 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbdK3SBu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 13:01:50 -0500
Received: from [192.168.178.21] (xd93220e4.dyn.telefonica.de [217.50.32.228])
        by mxf98a.netcup.net (Postfix) with ESMTPSA id 14D16140CD0;
        Thu, 30 Nov 2017 19:01:49 +0100 (CET)
Authentication-Results: mxf98a;
        spf=pass (sender IP is 217.50.32.228) smtp.mailfrom=rabel@robertabel.eu smtp.helo=[192.168.178.21]
Received-SPF: pass (mxf98a: connection is authenticated)
Subject: Re: [PATCH] git-prompt: fix reading files with windows line endings
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
References: <20171128201818.4132-1-rabel@robertabel.eu>
 <20171128201818.4132-2-rabel@robertabel.eu>
 <alpine.DEB.2.21.1.1711291519290.6482@virtualbox>
 <d57e4cb9-b0b4-314e-370a-e0db58a2a7da@robertabel.eu>
 <alpine.DEB.2.21.1.1711300100320.6482@virtualbox>
 <cacbf41e-3b4a-99e2-a0e0-50bb4cd9e152@robertabel.eu>
 <alpine.DEB.2.21.1.1711301619590.6482@virtualbox>
From:   Robert Abel <rabel@robertabel.eu>
Message-ID: <3557a15f-3019-7d31-b990-66c2e0cb893f@robertabel.eu>
Date:   Thu, 30 Nov 2017 19:01:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1711301619590.6482@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <20171130180149.3653.41383@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 30 Nov 2017 16:21, Johannes Schindelin wrote:
> On Thu, 30 Nov 2017, Robert Abel wrote:
>> So reading a dummy variable along with the actual content variable
>> works for git-prompt:
>>
>>     __git_eread ()
>>     {
>>         local f="$1"
>>         local dummy
>>         shift
>>         test -r "$f" && IFS=$'\r\n' read "$@" dummy < "$f"
>>     }
>>
>> I feel like this would be the most readable solution thus far.
> 
> Hmm. I am just a little concerned about "dummy" swallowing the rest of the
> line, e.g. when reading "1 2 3" via `__git_eread line`... the way I read
> it, dummy would consume "2 3" and line would *not* receive "1 2 3" but
> only "1"...
You missed that tab and space aren't field separator anymore,
because IFS=$'\r\n'. The way I see it, __git_eread was never meant to
split tokens. Its primary purpose was to test if a file exists and if
so, read all its contents sans the newline into a variable.

That's how all call to __git_eread use it. And none of them are equipped
to handle multi-line file contents or want to read more than one variable.

So this version does exactly that, but for CRLF line endings, too.
I successfully use the above version now on two of my PCs.

If you agree and nobody else has any concerns, I'll resend an edited
patch to accomodate for the changes and probably put a comment with
usage info above __git_eread.

Regards,

Robert


