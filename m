Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD85C433F5
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 11:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiBFLCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 06:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiBFLCs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 06:02:48 -0500
X-Greylist: delayed 2370 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 03:02:46 PST
Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C543C06173B
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 03:02:45 -0800 (PST)
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4Js52T3w4qz5tsB
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 11:23:13 +0100 (CET)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Js52Q36N3z5tlC;
        Sun,  6 Feb 2022 11:23:09 +0100 (CET)
Message-ID: <06e09df2-5fa5-8ce8-4cbe-4918d5dbaa25@kdbg.org>
Date:   Sun, 6 Feb 2022 11:23:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Commit SHA1 == SHA1 checksum?
Content-Language: en-US
To:     "Gamblin, Todd" <gamblin2@llnl.gov>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>
References: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
 <121ce485-bea8-3168-aa35-d11eb13022da@iee.email>
 <188C988E-F679-4AD6-AA04-E51F11F7D9A7@llnl.gov>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <188C988E-F679-4AD6-AA04-E51F11F7D9A7@llnl.gov>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.02.22 um 10:00 schrieb Gamblin, Todd:
>> I don't think there is an obvious cross-check for the tarball sha1
>> comparison with the release tag's sha1, if that's the question.
> 
> This is pretty much the question — does git do an integrity check on
> clone to verify that the commit hash (and its tree hash) are valid?
> Does git verify objects as they’re written to disk when it’s cloning a repo?

Yes, it does. (How could you even contemplate that it does not? It is
the most obvious way to protect the cloner.) Granted, `git clone` first
writes objects (actually, packs) to the disk before it checks them, but
I don't think that this detail is important.

>> The tag contains the sha1 hash of the release commit, which in turn
>> contains the sha1 hashes of the tree that is being released, and the 
>> previous commit in the git history, and onward the hashes roll...
> 
> It seems like git fsck is supposed to check all of these, so would
> that be the potential analog? It seems like overkill if all I really
> want is the integrity of one commit snapshot.  Would it be sufficient to
> heck the hash of the checked out commit and then to check its tree hash…
> I guess I’m just curious why git doesn’t have a command that verifies
> the integrity of the current working tree against its commit sha1.

That command is pretty much 'git status --ignored': if it shows anything
but "nothing to commit, working tree clean", your worktree is different
from the commit. The point is, there certainly are commands that let you
check a worktree against a commit.

-- Hannes
