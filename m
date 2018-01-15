Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FE551F404
	for <e@80x24.org>; Mon, 15 Jan 2018 07:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbeAOHFq (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 02:05:46 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:49945 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753391AbeAOHFq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 02:05:46 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3zKks35V9Nz5tlG;
        Mon, 15 Jan 2018 08:05:43 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2776C274;
        Mon, 15 Jan 2018 08:05:43 +0100 (CET)
Subject: Re: [BUG] test_must_fail: does not correctly detect failures - Was
 Git 2.16.0-rc2 Test Summary on NonStop
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org, 'Joachim Schmitz' <jojo@schmitz-digital.de>
References: <004a01d38cab$705262a0$50f727e0$@nexbridge.com>
 <001a01d38d57$d36c7d10$7a457730$@nexbridge.com>
 <59d3adab-4a95-4ef5-2d8f-ef4c7b797156@kdbg.org>
 <004a01d38d7f$3306e810$9914b830$@nexbridge.com>
 <007901d38da9$d517e9e0$7f47bda0$@nexbridge.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <499fb29f-ca34-8d28-256d-896107c29a3e@kdbg.org>
Date:   Mon, 15 Jan 2018 08:05:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <007901d38da9$d517e9e0$7f47bda0$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.01.2018 um 03:37 schrieb Randall S. Becker:
> On January 14, 2018 4:33 PM, I wrote:
>> The exotic error code coming back from perl is 162. I can muck with it, if
>> there was a value more useful to git.
>> *  553          } else if (WIFEXITED(status)) {
>> *  554                  code = WEXITSTATUS(status);
>> (eInspect 3,887):p code
>> $4 = 162
>>
>> The perl code uses die to terminate with a non-specific non-zero error code.
>> What it seems is that there is an assumed value that the git tests depend on,
>> but perl.org describes the following:
>>
>> "die raises an exception. Inside an eval the error message is stuffed into $@
>> and the eval is terminated with the undefined value. If the exception is
>> outside of all enclosing evals, then the uncaught exception prints LIST to
>> STDERR and exits with a non-zero value. If you need to exit the process with
>> a specific exit code, see exit."

I take "die exits with non-zero" as a piece of information for the 
*users* so that they can write "if perl foo.pl; then something; fi" in 
shell scripts. I do *not* interpret it as leeway for implementers of 
perl to choose any random value as exit code. Choosing 162 just to be 
funky would be short-sighted. [I'm saying all this without knowing how 
perl specifies 'die' beyond the paragraph you cited. Perhaps there's 
more about 'die' that justifies exit code 162.] I'd say that the perl 
port is broken.

>>
>> So it seems that we might need to either not use die or change the tests not
>> to care about the exit code for specific tests involving perl. Suggestions?
> 
> Sadly, while changing the funky 162 completion code to 255 works
> fine for t9001, it causes a bunch of other tests to fail (parts of
> 1308 and most of 1404). I can't tall whether this is test suite or
> code related but I'm caught in the middle. Going to the platform
> developers may eventually get the fix for t9001 (fixing perl), but
> otherwise, I'm not sure why changing 162 to 255 causes 1308 and 1404
> to blow so badly. In any event, I'm putting this away for a few days
> due to $DAYJOB.

Why do you not choose 1? He, on my Linux box perl -e die exits with 255. 
So...

-- Hannes
