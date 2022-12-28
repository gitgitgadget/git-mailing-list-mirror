Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B10C4332F
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 22:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiL1WZM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 17:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiL1WZL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 17:25:11 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931F213D0D
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 14:25:08 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2BSMP5P0079592
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Dec 2022 17:25:05 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Jonathan Nieder'" <jrnieder@gmail.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Taylor Blau'" <me@ttaylorr.com>, <git@vger.kernel.org>
References: <00f901d91a47$09400110$1bc00330$@nexbridge.com> <xmqqilhwp5g4.fsf@gitster.g> <011201d91aca$a5db7800$f1926800$@nexbridge.com> <Y6y+zkUsPhknTYH/@google.com>
In-Reply-To: <Y6y+zkUsPhknTYH/@google.com>
Subject: RE: [BUG] fatal: transport 'file' not allowed during submodule add
Date:   Wed, 28 Dec 2022 17:25:00 -0500
Organization: Nexbridge Inc.
Message-ID: <013501d91b0b$3cd4ceb0$b67e6c10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIU6GJDc0yG7ZReRHFxQVmMhwXR0AFwOXgbAkFw3nkCX13a/q3bujWQ
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 28, 2022 5:11 PM, Jonathan Nieder wrote:
>Hi Randall,
>
>rsbecker@nexbridge.com wrote:
>> Junio C Hamano wrote:
>
>>> This suspiciously sounds like what a1d4f67c (transport: make
>>> `protocol.file.allow` be "user" by default, 2022-07-29) is doing
deliberately.
>>
>> I have tried using 'git config --local protocol.file.allow always'
>> and/or 'git config --local protocol.allow always' to get past this,
>> without success.
>
>Does `git config --global protocol.file.allow always` do the trick?

I tried git config --local protocol.file.allow always after the initial
clone. This should work but does not.
I also tried git config --global protocol.file.allow always before the
initial clone.  This also did not work.

>>>                                                           Taylor,
>>> does this look like a corner case the 2.30.6 updates forgot to consider?
>
>I think it's the intended effect (preventing file:// submodules), but I
wonder if this
>hints that we'd want that protection to be more targeted.  A file://
submodule (as
>opposed to a bare path without URL
>scheme) wouldn't trigger the "git clone --local" behavior that that commit
>mentions wanting to protect against, so at first glance it would appear to
be no
>more or less dangerous than cloning from a remote repository.
>
>One thing I'd be curious about is whether --local happening automatically
is
>actually worth it nowadays.  "git worktree" does a better job of sharing
with an
>existing local repository, since the sharing continues even after the
worktree has
>been created, after any "git gc" operations, and so on.  Meanwhile, the
distinction
>between file:// and bare paths is subtle enough that I regularly encounter
people
>not being aware of it (for example when wanting a way to test protocol code
>locally and not understanding why a bare-path clone doesn't do that).
Would it be
>more in the spirit of secure defaults to require --local when someone wants
to
>request the hardlinking trick of local clone?

I think the risk of someone hacking a hardlink is less risky than someone
misdirecting a remote site not under a user's direct control.

The tests I did show the same behaviour no matter which combination of the
above. --local appears to be implied, at least there is no apparent
behavioural difference between specifying the argument and not.

--Randall


