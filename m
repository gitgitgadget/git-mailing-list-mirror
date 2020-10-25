Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9E1C388F7
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 13:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0E7222B9
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 13:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416385AbgJYNke (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 09:40:34 -0400
Received: from crypt.org ([89.187.75.214]:42616 "EHLO crypt.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416382AbgJYNkd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 09:40:33 -0400
Received: from crypt.org (crypt.org [127.0.0.1])
        by crypt.org (8.11.6/8.11.2) with ESMTP id 09PCjIP26203;
        Sun, 25 Oct 2020 12:45:18 GMT
Message-Id: <202010251245.09PCjIP26203@crypt.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, hv@crypt.org,
        git@vger.kernel.org
Subject: Re: safer git? 
In-Reply-To: <20201025030606.GF860779@camp.crustytoothpaste.net> 
Date:   Sun, 25 Oct 2020 12:45:18 +0000
From:   hv@crypt.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" wrote:
:You can try setting core.fsyncObjectFiles to true.

Super, that's exactly the sort of thing I was hoping to find.

:I suspect a lot of the zero-byte files and any files that end up as
:all-zeros are due to your file system.  The default file system on
:Ubuntu is ext4, IIRC, and if that's what you're using, you can set
:data=journal instead of data=ordered as a mount option.

It is indeed ext4. I'll consider this option; for now I've turned off
write caching as suggested by Randall, which feels like a lighter-weight
approach that should give almost all of the benefit.

:"Randall S. Becker" wrote:
:> I would suggest turning off write-through buffering on your disk. Let writes
:> complete immediately instead of being deferred to sync. Also, this does feel
:> like a disk issue, so fsck or chkdsk /f (or whatever) on your disk urgently.

fsck doesn't seem to be complaining, but I've set it to run every
20 mounts. What I do see is a handful of "orphaned inodes" being
reclaimed on boot after every crash.

:Turning off buffering and caching for your disk drive may make things
:_really_ slow, but it will definitely improve data integrity.

I haven't noticed a big slowdown so far; I'm rarely doing a _lot_ of
writes.

Thanks greatly to both of you for the suggestions.

Hugo
