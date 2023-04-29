Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC94C77B7E
	for <git@archiver.kernel.org>; Sat, 29 Apr 2023 07:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjD2HSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Apr 2023 03:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjD2HSI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2023 03:18:08 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEEB1986
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 00:18:06 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id ADC5C23F68;
        Sat, 29 Apr 2023 03:18:04 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pseqK-XmD-00; Sat, 29 Apr 2023 09:18:04 +0200
Date:   Sat, 29 Apr 2023 09:18:04 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] advice: handle "rebase" in
 error_resolve_conflict()
Message-ID: <ZEzErKvmBPwP0Hsp@ugly>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
 <20230428125649.1719796-1-oswald.buddenhagen@gmx.de>
 <xmqqjzxvde6p.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqjzxvde6p.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2023 at 12:01:02PM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>> This makes sure that we get a properly translated message rather than
>> inserting the command (which we failed to translate) into a generic
>> fallback message.
>
>Hmph, can this be accompanied with a change to add a test to an
>existing test script to demonstrate that the function can be called
>with me set to "rebase" and results in a generic message?
>
i suppose it could, but see next paragraph.

>> We now also BUG() out when encountering an unexpected command.
>
>This needs to be reviewed by somebody who is more familiar with the
>rebase/chrry-pick/revert/sequencer codepaths so that they can give a
>definitive "good--I know that we never call this function with any
>other value in 'me'" and that person would not be me.
>
assuming we care only about in-tree code, i'm just about as confident 
about this as one can reasonably be - because i grepped through the 
code, recursively looking for entry points. there are several calls via 
die_resolve_conflict() which have hard-coded `me`s (none of which is 
rebase), and two from the sequencer, where `me` comes from 
action_name(), which in turn returns one of three hard-coded strings 
(one of which is rebase). the latter is also kinda the test case, 
because it is obvious that this will be actually invoked when the 
situation occurs. it's probably also how i actually ran into the problem 
in the first place (i surely wasn't *looking* for it ...).

>> Arguably, it would be cleaner to pass the command as an enum in the
>> first place ...
>
>True, but that can be left to a different topic, I would think.
>
yes, otherwise i'd have already done it. ^^
i can make it more explicit if you prefer that.

if you agree with the reasoning, i'll prepare an update to the commit 
message and leave the patch as-is.

-- ossi

