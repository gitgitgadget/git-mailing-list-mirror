Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8D1C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 16:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjC1QLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 12:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjC1QLV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 12:11:21 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA56BA
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 09:11:20 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 6B141202E9
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 12:11:18 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1phBuo-Upb-00
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 18:11:18 +0200
Date:   Tue, 28 Mar 2023 18:11:18 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: Re: [RFC PATCH] rebase: implement --rewind
Message-ID: <ZCMRpnS9gzN1Rlbh@ugly>
Mail-Followup-To: git@vger.kernel.org
References: <20230323162235.995645-1-oswald.buddenhagen@gmx.de>
 <7bd63d7e-ad13-d5b8-54ea-ba5f81da0c17@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7bd63d7e-ad13-d5b8-54ea-ba5f81da0c17@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 04:53:52PM +0200, Johannes Schindelin wrote:
>I do not think that the concept in its
>current form mixes well with being in the middle of a `--rebase-merges`
>run.
>
fundamentally, it shouldn't pose a problem: the already done part leads 
up to a single commit, from which a complete todo with merges up to that 
point can be built again, while the remainder of the pre-existing todo 
should be unfazed by the fact that you're repeatedly messing with 
whatever branch you stopped in.
i *think* i even tried a few simple cases and found the result adequate, 
but i don't remember for sure (it's been a few months since i authored 
the patch).
just give it a shot.

>On the other hand, it might often be good enough to redo only the 
>commits
>between `onto` and `HEAD`, not the complete rebase script that's now in
>`done`. But then it does not strike me so much as "rewinding" but as
>"nesting.
>
according to the terminology i'm using, this still qualifies as a flat 
rewind, only that it limits itself to --first-parent. we'll see whether 
this turns out to be a necessary simplification, but i don't think so.

true nesting would mean that the rewind itself can be aborted, in case 
you change your mind back. adding that as an option on top of what i'm 
doing isn't a hard problem _per se_. you would need to figure out the 
challenges from my OP, though.
also note the reference in the OP; we discussed this here a while ago 
already.

