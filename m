Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9A7D1F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 22:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbeKYI4y (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 03:56:54 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:26202 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbeKYI4x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 03:56:53 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 432S332xCkz5tlD;
        Sat, 24 Nov 2018 23:07:27 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 01FC9207A;
        Sat, 24 Nov 2018 23:07:27 +0100 (CET)
Subject: Re: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the
 ending of the removed line is CR+LF
To:     =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
Cc:     git@vger.kernel.org
References: <1f068f3a-d636-9b9c-f501-51d33412b964@googlemail.com>
 <4dca3f64-4851-6d48-8266-dfe55f597739@kdbg.org>
 <edadf857-2d4b-f058-5e07-286afb312901@googlemail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <80ffe850-b966-a37b-09bd-44e04d769944@kdbg.org>
Date:   Sat, 24 Nov 2018 23:07:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <edadf857-2d4b-f058-5e07-286afb312901@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.11.18 um 15:51 schrieb Frank Schäfer:
> Am 23.11.18 um 22:47 schrieb Johannes Sixt:
>> Am 23.11.18 um 19:19 schrieb Frank Schäfer:
>>> The CR marker ^M doesn't show up in '-' lines of diffs when the ending
>>> of the removed line is CR+LF.
>>> It shows up as expected in '-' lines when the ending of the removed line
>>> is CR only.
>>> It also always shows up as expected in '+' lines.
>>
>> Is your repository configured to (1) highlight whitespace errors in
>> diff output and (2) to leave CRLF alone in text files?
> I'm using the default configuration, so whitespace is set to
> trailing-space, but cr-at-eol is not set.
> 
>>
>> If so, then it is just a side-effect of this combination, an illusion,
>> so to say: The CR in the CRLF combo is trailing whitespace. The 'git
>> diff' marks it by inserting an escape sequence to switch the color
>> before ^M and another escape sequence to reset to color after ^M. This
>> breaks the CRLF combination apart, so that the pager does not process
>> it as a combined CRLF sequence; it displays the lone CR as ^M.
> Urghh... so that needs to be fixed.
> Why does it work correctly with '+' lines ?

I don't think that there is anything to fix. If you have a file with 
CRLF in it, but you did not declare to Git that CRLF is the expected 
end-of-line indicator, then the CR *is* trailing whitespace (because the 
line ends at LF), and 'git diff' highlights it.

-- Hannes
