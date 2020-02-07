Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1645DC2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 16:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB0E20720
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 16:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgBGQvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 11:51:10 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:41911 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgBGQvK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 11:51:10 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 48DhBz0XTYz1qqkP;
        Fri,  7 Feb 2020 17:51:07 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 48DhBz09b4z1qqkM;
        Fri,  7 Feb 2020 17:51:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id hczBz0ILBGGC; Fri,  7 Feb 2020 17:51:06 +0100 (CET)
X-Auth-Info: xCWZ3ti91tFlPUwaYZ1StjSbhdb7twspHh8k3M7iaZdb8v11ZjjlADMgso4Fbiel
Received: from igel.home (ppp-46-244-161-37.dynamic.mnet-online.de [46.244.161.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri,  7 Feb 2020 17:51:06 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 831C22C0C37; Fri,  7 Feb 2020 17:51:05 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v6 10/15] bugreport: add config values from safelist
References: <20200206004108.261317-1-emilyshaffer@google.com>
        <20200206004108.261317-11-emilyshaffer@google.com>
        <20200207144725.GF2868@szeder.dev> <20200207150857.GH2868@szeder.dev>
        <CAPig+cQ8vHjzBdMAemznFbyUSHOuJu167RHkTNg_qmqi-DOB3g@mail.gmail.com>
X-Yow:  Feel th' WHIRLING BUFFERS buffing away all that stress...
 Years of ROAD TAR gently washing away...
Date:   Fri, 07 Feb 2020 17:51:05 +0100
In-Reply-To: <CAPig+cQ8vHjzBdMAemznFbyUSHOuJu167RHkTNg_qmqi-DOB3g@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 7 Feb 2020 11:24:46 -0500")
Message-ID: <87zhdue3ye.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Feb 07 2020, Eric Sunshine wrote:

> On Fri, Feb 7, 2020 at 10:09 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
>> macOS 'sed', that's what I was missing :)
>>
>>   sed -n 's/^\(.*\) \+annotate:bugreport\[include\].* ::$/  "\1",/p' | sort
>>
>> and the 'sed' included in macOS apparently interprets that '\+'
>> differently than GNU 'sed', and as a result won't match anything.
>
> More generally, this would be a problem with any 'sed' of BSD lineage.
>
>> FWIW, that '\+' doesn't seem to be necessary, though, and after
>> removing it the resulting generated array looked good to me [...]
>
> A reasonable replacement for "<SP>\+" would be "<SP><SP>*" (where <SP>
> represents 'space').

Another problem with that regexp is that it contains two adjacent
repetitions matching the same character.  When there are two or more
spaces before "annotate:" all but the last of them can be matched by
either '\(.*\)' or ' \+'.  To fix that '\(.*\)' needs to be modified to
not match a trailing space.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
