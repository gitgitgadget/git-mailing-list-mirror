Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC796C71153
	for <git@archiver.kernel.org>; Sun,  3 Sep 2023 20:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242398AbjICUSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Sep 2023 16:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjICUSu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Sep 2023 16:18:50 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D46F0
        for <git@vger.kernel.org>; Sun,  3 Sep 2023 13:18:46 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 566A724389;
        Sun,  3 Sep 2023 16:18:24 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qctY8-BTe-00; Sun, 03 Sep 2023 22:18:24 +0200
Date:   Sun, 3 Sep 2023 22:18:24 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] sequencer: update abort safety file more sparingly
Message-ID: <ZPTqEIvW3zJ4eafT@ugly>
References: <20230903151132.739166-1-oswald.buddenhagen@gmx.de>
 <29fb7a38-1e92-457a-93ff-0e64ac09b907@gmail.com>
 <ZPTdmnHfDcTBqaSl@ugly>
 <fdf80c36-0e28-44f3-9cef-85d38d2d48f1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fdf80c36-0e28-44f3-9cef-85d38d2d48f1@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 03, 2023 at 08:48:14PM +0100, Phillip Wood wrote:
>On 03/09/2023 20:25, Oswald Buddenhagen wrote:
>> On Sun, Sep 03, 2023 at 07:40:00PM +0100, Phillip Wood wrote:
>>> it only matters for "cherry-pick --skip"
>>>
>> that doesn't seem right. a --skip is just a --continue with a prior 
>> reset, more or less.
>
>sequencer_skip() calls rollback_is_safe() which checks the abort safety 
>file.
>
that's weird. can you think of a good reason for doing that?

>> i'll try to find a better "choke point".
>
>I think that is probably tricky,
>
yeah

>I'm not really clear what the aim/purpose of this refactoring is.
>
to make my head not explode.
more specifically, to get it out of the way of the rebase path, which is 
what i'm actually concerned with.

generally, i think this whole ad-hoc state management is a nightmare, 
and i'd be surprised if there weren't some more loose ends.
i think i'd aim for an object-oriented-ish design with an encapsulated 
state, lazy loading getters, lazy setters, and a commit entry point (or 
maybe several partial ones). no idea how that would play out.

>> if you did a fresh commit before or after the single pick, you'd lose 
>> it.
>
>Oh, I can see that you'd lose a commit made before a single pick but I 
>don't see how you'd lose a commit made after it.
>
right. thinko. it's a bit late here. ^^

regards
