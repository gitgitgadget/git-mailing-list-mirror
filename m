Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7612E1F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 21:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbeKZIbu (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 03:31:50 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:7320 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbeKZIbu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 03:31:50 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 4333Nd3kcSz5tl9;
        Sun, 25 Nov 2018 22:39:45 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 07D0C4186;
        Sun, 25 Nov 2018 22:39:45 +0100 (CET)
Subject: Re: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the
 ending of the removed line is CR+LF
To:     =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
Cc:     git@vger.kernel.org
References: <1f068f3a-d636-9b9c-f501-51d33412b964@googlemail.com>
 <4dca3f64-4851-6d48-8266-dfe55f597739@kdbg.org>
 <edadf857-2d4b-f058-5e07-286afb312901@googlemail.com>
 <80ffe850-b966-a37b-09bd-44e04d769944@kdbg.org>
 <2858f03b-89a7-be52-501f-55b6d281bebc@googlemail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <30442f9c-a1cb-4635-d8e3-a301d94a56fd@kdbg.org>
Date:   Sun, 25 Nov 2018 22:39:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <2858f03b-89a7-be52-501f-55b6d281bebc@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.11.18 um 15:03 schrieb Frank Schäfer:
> Am 24.11.18 um 23:07 schrieb Johannes Sixt:
>> I don't think that there is anything to fix. If you have a file with
>> CRLF in it, but you did not declare to Git that CRLF is the expected
>> end-of-line indicator, then the CR *is* trailing whitespace (because
>> the line ends at LF), and 'git diff' highlights it.
> 
> Sure, it's correct to highlight it.
> But it doesn't highlight it in removed lines, just in added lines.
> I can see no good reason why removed and added lines should be treated
> differently.

But incorrect whitespace is never highlighted in removed lines, why 
should CR be an exception?

> 1) If CR+LF line termination is used in a file, changing the content of
> a line (but not its termination) currently produces a diff like
> 
> -something
> +something_new^M
> 
> which causes the user to think he has changed the line ending (added a
> CR) although he didn't.

But this is not limited to CR at EOL:

-<SP><TAB>something
+<SP><TAB>something_new

will also show the incorrect whitespace highlighted only for the + line.

> 2) If someone/something unintentionally changes the line termination
> from CR+LF to LF, it doesn't show up in the diff:
> 
> -something
> +something

Same here for other cases, for example

-something<SP>
+something

will not have on obvious indicator that whitespace was corrected.

If you are worried about a change in EOL style, you should better listen 
to your other tools. Either it is important, or it is not. If it is, 
they will report it to you. If it isn't, why care?

-- Hannes
