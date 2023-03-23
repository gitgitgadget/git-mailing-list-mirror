Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D42C6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 22:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjCWWmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 18:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWWmX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 18:42:23 -0400
Received: from bluemchen.kde.org (unknown [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30342C649
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 15:42:20 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id E8E8E20309
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 18:41:40 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfTZm-hiA-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 23:38:30 +0100
Date:   Thu, 23 Mar 2023 23:38:30 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: Re: [PATCH 5/8] rebase: preserve interactive todo file on checkout
 failure
Message-ID: <ZBzU5lzZBtI8/Q7+@ugly>
Mail-Followup-To: git@vger.kernel.org
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <20230323162235.995574-6-oswald.buddenhagen@gmx.de>
 <47558c14-ba2c-18ec-0532-b21fdfd223f8@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <47558c14-ba2c-18ec-0532-b21fdfd223f8@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 07:31:04PM +0000, Phillip Wood wrote:
>On 23/03/2023 16:22, Oswald Buddenhagen wrote:
>> Creating a suitable todo file is a potentially labor-intensive process,
>> so be less cavalier about discarding it when something goes wrong (e.g.,
>> the user messed with the repo while editing the todo).
>
>I was thinking about this problem the other day in the context of 
>rescheduling commands when they cannot be executed because they would 
>overwrite an untracked file. My thought was that we should prepend a 
>"reset" command to the todo list so that the checkout happened when the 
>user continued the rebase.
>
so you basically want to convert the magic `onto` into an explicit todo 
command? i'm not sure what the advantage would be, and i certainly can 
think of disadvantages re. usability and backwards compat.

>How does this patch ensure the checkout happens when the user continues 
>the rebase?
>
the idea was never that the user --continue's. we're talking about a 
fatal error, and the patch's purpose is only to allow the user to 
salvage their work manually.
it's an interesting question, though, esp. in light of patch 8/8 of this 
series.
