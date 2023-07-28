Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A796C001DF
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 15:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbjG1PhK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 11:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbjG1PhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 11:37:09 -0400
X-Greylist: delayed 21087 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Jul 2023 08:37:06 PDT
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA6126A0
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 08:37:06 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 4831E24229;
        Fri, 28 Jul 2023 11:37:04 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qPPWZ-diF-00; Fri, 28 Jul 2023 17:37:03 +0200
Date:   Fri, 28 Jul 2023 17:37:03 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Arver <linusa@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] sequencer: beautify subject of reverts of reverts
Message-ID: <ZMPgn1QQltyE7koe@ugly>
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <3f5e4116-54e6-9753-f925-ed4a9f6e3518@gmail.com>
 <ZGSlqAPwaLhgWm6v@ugly>
 <2d416834-ef3e-01a2-6be0-9e88bc0de25e@gmail.com>
 <ZGUIqBU0+Vr5LSBF@ugly>
 <10523968-0f02-f483-69c4-24e62e839f70@gmail.com>
 <xmqqmt21txid.fsf@gitster.g>
 <owly7cqkfvyu.fsf@fine.c.googlers.com>
 <ZMOOQTMk2wFwtSfa@ugly>
 <xmqqpm4c5ax9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqpm4c5ax9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 28, 2023 at 08:10:42AM -0700, Junio C Hamano wrote:
>And from the above discussion, I wonder if the following would be a
>good place to stop:
>
> - The first revert is as before:         Revert "original title"
> - A revert of a revert becomes:          Reapply "original title"
> - A revert of a reapply becomes:         Revert Reapply "original title"
> - A revert of "Revert Reapply" becomes:  Reapply Reapply "original title"
> - A revert of "Reapply Reapply" becomes: Revert Reapply "original title"
>
>In other words, we accept the fact that we do not need exact number
>of times reversions were done, and use that to simplify the output
>to make sure we will not spend more than two words in the front of
>the title.  That would help to keep the original title visible,
>while still allowing us to distinguish the ones that was reverted up
>to four times (and "Revert Reapply" and "Reapply Reapply" only tell
>us "final state is to (discard|accept) the original but it took us
>_many_ times", without saying exactly how many).
>
i would not bother automating it, because it falls into the "you should 
get creative when that happens" category (which is codified in the 
manual by my reworked patches).

also, the "no more than two words" is sort of arbitrary - one can make a 
pretty convincing argument for just one word as well.

finally, just dropping that info would typically result in multiple 
(non-trivial) commits with the same summary, which i don't really like.  
leaving the uglier long variant (and the user hopefully amending it) 
avoids it.

i think i'll steal some of the text i didn't quote for the commit 
message, though. ^^

regards
