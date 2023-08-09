Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2D2C0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 16:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjHIQN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 12:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHIQNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 12:13:25 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D39BC
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 09:13:23 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 53D6724212;
        Wed,  9 Aug 2023 12:13:21 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qTloH-jQW-00; Wed, 09 Aug 2023 18:13:21 +0200
Date:   Wed, 9 Aug 2023 18:13:21 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3] rebase: clarify conditionals in todo_list_to_strbuf()
Message-ID: <ZNO7IVphPf8KOC3Q@ugly>
References: <20230428125601.1719750-1-oswald.buddenhagen@gmx.de>
 <20230807170935.2336745-1-oswald.buddenhagen@gmx.de>
 <xmqqv8dqd2bh.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqv8dqd2bh.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 07, 2023 at 01:28:50PM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>>  			if (item->command == TODO_FIXUP) {
>>  				if (item->flags & TODO_EDIT_FIXUP_MSG)
>>  					strbuf_addstr(buf, " -c");
>> -				else if (item->flags & TODO_REPLACE_FIXUP_MSG) {
>> +				else if (item->flags & TODO_REPLACE_FIXUP_MSG)
>>  					strbuf_addstr(buf, " -C");
>> -				}
>> -			}
>> -
>> -			if (item->command == TODO_MERGE) {
>> +			} else if (item->command == TODO_MERGE) {
>>  				if (item->flags & TODO_EDIT_MERGE_MSG)
>>  					strbuf_addstr(buf, " -c");
>>  				else
>
>This patch as it stands is a strict Meh at least to me, as we know
>item->command is not something we will mess with in the loop,
>
the "we know" is actually something the reader needs to establish in 
their mind. it's simply unnecessary cognitive load.

>so
>turning two if() into if/elseif does not add all that much value in
>readability.
>
but it adds *some* value, and i don't think it's very constructive to 
fight that. in fact, i find the whole thread rather demotivating, and 
it's ironic that felipe's response was the most reasonable one.

>Having said that.
>
>The code makes casual readers curious about other things.
>
> * Are FIXUP and MERGE the only two commands that need to be treated
>   differently here?
>
yes, and it's obvious why. i don't think that explaining it in prose 
would make the answer any more accessible.

> * Can item->commit be some other TODO_* command?
>
the fact that it's an else-if implies that much. the definite yes is 
clear from the bigger context.

>What is the reason why they can be no-op?
>
i have no clue what you're referring to.

> * When one wants to invent a new kind of TODO_* command, what is
>   the right way to deal with it in this if/else cascade?
>
i think that someone who actually wants to modify the code can be 
expected to come up with an answer themselves, as this is a much rarer 
occurrence than just reading the code.

>And that leads me to wonder if this is better rewritten with
>
>	switch (item->command) {
>
as the commit message was meant to imply, my answer to that is no.

regards
