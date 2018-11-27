Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D6E01F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 18:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbeK1FOT (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 00:14:19 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:33662 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725740AbeK1FOT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 00:14:19 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 434Bm518qKz5tlG;
        Tue, 27 Nov 2018 19:15:32 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 0A0BF2098;
        Tue, 27 Nov 2018 19:15:31 +0100 (CET)
Subject: Re: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the
 ending of the removed line is CR+LF
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>,
        git@vger.kernel.org
References: <1f068f3a-d636-9b9c-f501-51d33412b964@googlemail.com>
 <4dca3f64-4851-6d48-8266-dfe55f597739@kdbg.org>
 <edadf857-2d4b-f058-5e07-286afb312901@googlemail.com>
 <80ffe850-b966-a37b-09bd-44e04d769944@kdbg.org>
 <2858f03b-89a7-be52-501f-55b6d281bebc@googlemail.com>
 <30442f9c-a1cb-4635-d8e3-a301d94a56fd@kdbg.org>
 <xmqqzhtwzghr.fsf@gitster-ct.c.googlers.com>
 <f06b734a-fc8e-221a-c983-f2ab9daba17f@kdbg.org>
 <xmqqva4jv2kc.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3e24a770-47fc-50e4-d757-1e4a28dcd019@kdbg.org>
Date:   Tue, 27 Nov 2018 19:15:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqva4jv2kc.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.11.18 um 00:31 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>> Am 26.11.18 um 04:04 schrieb Junio C Hamano:
>> ... this goes too far, IMO. It is the pager's task to decode control
>> characters.
> 
> It was tongue-in-cheek suggestion to split a CR into caret-em on our
> end, but we'd get essentially the same visual effect if we added a
> rule:
> 
> 	When producing a colored output (not limited to whitespace
> 	error coloring of diff output), insert <RESET> before a CR
> 	that comes immediately before a LF.
> 
> Then, what Frank saw in the troublesome output would become
> 
> 	<RED> -something <RESET> CR <RESET> LF
> 	<GREEN> +something_new <RESET> <BG_RED> CR <RESET> LF
> 
> and we'll let the existing pager+terminal magic turn that trailing
> CR on the preimage line into caret-em, just like the trailing CR on
> the postimage line is already shown as caret-em with the current
> output.

I wouldn't want that to happen for all output (context lines, - lines, + 
lines): I really am not interested to see all the CRs in my CRLF files.

> And a good thing is that I do not think that new rule is doing any
> decode of control chars on our end.  We are just producing colored
> output normally.

But we already have it, as Brian pointed out:

    git diff --ws-error-highlight=old,new

or by setting diff.wsErrorHighlight accordingly.

-- Hannes
