Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FA8C4332F
	for <git@archiver.kernel.org>; Sun, 18 Dec 2022 14:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiLROLA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 18 Dec 2022 09:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiLROK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2022 09:10:57 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC41272B
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 06:10:55 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2BIEAiwl011154
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 18 Dec 2022 09:10:44 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>,
        "'Askar Safin'" <safinaskar@gmail.com>
Cc:     "'Andreas Schwab'" <schwab@linux-m68k.org>, <git@vger.kernel.org>
References: <CAPnZJGABhczzs-6Pri2SAOkujJXT1+JDH9FiwdDns6=miZmvFQ@mail.gmail.com> <878rj6rnuo.fsf@igel.home> <CAPnZJGAMRY02s6UvMg7B6f=NSAgK0PJQAoftwnhXk-ufD2YknQ@mail.gmail.com> <20221218093734.GC3411@szeder.dev> <CAPnZJGBwFMPAJKj9Qa_Vv9yJWrGaNXqaNaPUSrYcjZ8J+OfLrg@mail.gmail.com> <20221218105239.GD3411@szeder.dev>
In-Reply-To: <20221218105239.GD3411@szeder.dev>
Subject: RE: https://github.com/rust-lang/rust is not bisectable
Date:   Sun, 18 Dec 2022 09:10:39 -0500
Organization: Nexbridge Inc.
Message-ID: <00c701d912ea$85527080$8ff75180$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKJJRFafP9vwLCEPxFzcu7no34l5QHSulPOAZVK5wgBqcZbaAGukCSSAeFqksasznxXIA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 18, 2022 5:53 AM, SZEDER Gábor wrote:
>On Sun, Dec 18, 2022 at 01:03:54PM +0300, Askar Safin wrote:
>> SZEDER Gábor, yes, in this particular case this helps.
>
>Not just in this particular case, but this solves a general issue of bisecting non-
>linear histories that is the file/testcase/whatever of interest is not present in all
>candidate revisions in the range '^good bad'.
>
>> (But
>> I still wonder how to tell git-bisect to ignore commits, which are not
>> descendants of good commit.)
>
>In general you do not want to tell that to bisect, because any one of them could
>have introduced the change you are looking for.  Consider the following piece of
>history, where commits 'm<N>' are on the master branch, 'b<N>' are on a
>different branch, and the commit marked with C made a buggy change, and
>commits marked with G and B are the ones you marked as good and bad you
>started the bisection.
>
>            (G)            (M)  (B)
>  m1---m2---m3---m4---m5---m6---m7
>        \                 /
>         b1---b2---b3---b4
>                   (C)
>
>If bisect were to ignore commits "which are not descendants of good commit",
>then it wouldn't look at any of the 'b<N>' commits made on the side branch.  It
>would only look at commits m{3,4,5,6,7}, and thus report m6 as the first bad
>commit, which is clearly not the case.

Could you not use bisect skip to ignore the commits that cannot be tested? 

