Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C111C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 23:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjCWXXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 19:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjCWXXj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 19:23:39 -0400
Received: from bluemchen.kde.org (unknown [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335917A84
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 16:23:34 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 5BF522073E
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 19:23:17 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfUH7-irH-00
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 00:23:17 +0100
Date:   Fri, 24 Mar 2023 00:23:17 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: Re: [PATCH 5/8] rebase: preserve interactive todo file on checkout
 failure
Message-ID: <ZBzfZZWthdEM+gKK@ugly>
Mail-Followup-To: git@vger.kernel.org
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <20230323162235.995574-6-oswald.buddenhagen@gmx.de>
 <xmqq8rfn8bps.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq8rfn8bps.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 01:16:47PM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>> Creating a suitable todo file is a potentially labor-intensive process,
>> so be less cavalier about discarding it when something goes wrong (e.g.,
>> the user messed with the repo while editing the todo).
>
>Is there a reason why we do not always keep it?  Why is the file
>sometimes precious but not precious at all in other times?
>
the unedited initial todo just isn't precious. that implies that in a 
non-interactive rebase, it is always worthless at the time of the 
initial reset.

>Tying the previous bit to "-i was explicitly given" feels a bit
>unintuitive---when the sequencer machinery was implicitly chosen,
>and gives the control back to the user, should a user be forbidden
>to muck with the todo list?
>
that would be an --edit-todo and --continue during a mid-rebase stop.  
rather different case.

>No // comments, please.
>
(apparently with a special exception for examples in the apidocs, 
presumably because escaping nested comments would be just too ugly.)

>> -	test_path_is_missing .git/rebase-merge &&
>> +	test_path_is_dir .git/rebase-merge &&
>
>Are we happy to just see that the directory still exists?  I thought
>the original motivation explained in the proposed log message was to
>keep the todo list file, so shouldn't you be checking if the file is
>there
>
fair point.

>(and if you can reliably ensure that the file has contents
>that are expected, that would be even better)?
>
i could grep for a shortened sha1 i would obtain from the branch. but 
given that the error scenario of a present but somehow corrupted todo 
seems implausible given the circumstances, that seems like overkill.

>Also, as the keeping of the todo list is now conditional, we should
>have another test that checks that the file is gone when that
>condition ("INTERACTIVE_EXPLICIT"?) does not trigger, I think.
>
that would be for t3400-rebase.sh.
i suppose we could extend 'Show verbose error when HEAD could not be 
detached'.
