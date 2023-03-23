Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20EAC74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 22:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjCWWQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 18:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjCWWQn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 18:16:43 -0400
Received: from bluemchen.kde.org (unknown [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F0E23A62
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 15:16:31 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id DF16224267
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 18:15:58 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfTBw-h1e-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 23:13:52 +0100
Date:   Thu, 23 Mar 2023 23:13:52 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: Re: [PATCH 6/8] sequencer: simplify allocation of result array in
 todo_list_rearrange_squash()
Message-ID: <ZBzPIPQ+GlnPo7Mj@ugly>
Mail-Followup-To: git@vger.kernel.org
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <20230323162235.995574-7-oswald.buddenhagen@gmx.de>
 <d1fb77a0-9ed8-4f3d-5bad-bc443b5522d2@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d1fb77a0-9ed8-4f3d-5bad-bc443b5522d2@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 07:46:28PM +0000, Phillip Wood wrote:
>> +		assert(nr == todo_list->nr);
>
>If this assert fails we may have already had some out of bounds memory 
>accesses.
>
the loop could have run short, too.
but anyway, this isn't a runtime check, it's an assertion of a loop 
invariant.

>> +		todo_list->alloc = nr;
>>   		FREE_AND_NULL(todo_list->items);
>
>I think it would be cleaner to keep the original ordering and free the 
>old list before assigning todo_list->alloc
>
my reasoning is that it's closer to the assert which also refers to it, 
and it really makes sense to have _that_ first. also, the value is more 
likely to be still in a register at that point.

>>   		todo_list->items = items;
>> -		todo_list->nr = nr;
>> -		todo_list->alloc = alloc;
>>   	}
>
