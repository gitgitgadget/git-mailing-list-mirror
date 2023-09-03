Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB473C83F2D
	for <git@archiver.kernel.org>; Sun,  3 Sep 2023 19:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243257AbjICTZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Sep 2023 15:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjICTZa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Sep 2023 15:25:30 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AE694
        for <git@vger.kernel.org>; Sun,  3 Sep 2023 12:25:25 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id A70A424397;
        Sun,  3 Sep 2023 15:25:15 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qcsig-Ap9-00; Sun, 03 Sep 2023 21:25:14 +0200
Date:   Sun, 3 Sep 2023 21:25:14 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] sequencer: update abort safety file more sparingly
Message-ID: <ZPTdmnHfDcTBqaSl@ugly>
References: <20230903151132.739166-1-oswald.buddenhagen@gmx.de>
 <29fb7a38-1e92-457a-93ff-0e64ac09b907@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <29fb7a38-1e92-457a-93ff-0e64ac09b907@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 03, 2023 at 07:40:00PM +0100, Phillip Wood wrote:
>On 03/09/2023 16:11, Oswald Buddenhagen wrote:
>> The only situation where the file's content matters is --continue'ing
>> (after a multi-cherry-pick merge conflict).
>
>I don't think "cherry-pick --continue" consults the abort safety file, 
>
duh, obvious blunder.

>it only matters for "cherry-pick --skip"
>
that doesn't seem right. a --skip is just a --continue with a prior 
reset, more or less.

>and "cherry-pick --abort".
>
that one, of course.

>> This means that it is
>> sufficient to write it in a single place, when we are prematurely
>> exiting the main workhorse.
>
>I think this introduces a regression because the safety file will not 
>get updated when "cherry-pick --continue" stops for the user to resolve 
>conflicts.
>
true, there is indeed this second entry point.
i'll try to find a better "choke point".

>> which wasn't even reliable: a single pick executed during an 
>> interrupted sequence would bypass the safety.
>
>An alternate view is that the abort safety file exists to prevent the 
>user losing commits that have not been cherry-picked and it is 
>desirable to be able to abort after cherry-picking a single pick in the 
>middle of a sequence of cherry-picks.
>
if you did a fresh commit before or after the single pick, you'd lose 
it.
also, the feature doesn't actually prevent aborting, only the automatic 
reset.

regards
