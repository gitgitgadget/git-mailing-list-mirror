Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98375209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 16:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbdFFQJy (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 12:09:54 -0400
Received: from imap.thunk.org ([74.207.234.97]:50088 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbdFFQJx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 12:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=4cuKbzRC8dqxC4k2pfGnhnYKxXG7+TuNAzmYjka4F74=;
        b=rbt/O3v6DeNm8KzLaV+f5p3ef9x6/RnunDzwL4N5Qkf4GmG+9z8LKs1q3phhXyyEQa82mpFEP1b75y5uklrTSr+pq0v7IjHWyZ1AV1YqRCjMRxHgMV6WJiVMuLMG/sTErdWPU2HJIvCffmnT2/Ad69JyJFtmkcX+yQdeCkoJf7Q=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.84_2)
        (envelope-from <tytso@thunk.org>)
        id 1dIH3G-0001mO-Fa; Tue, 06 Jun 2017 16:09:50 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 459DDC00F21; Tue,  6 Jun 2017 12:09:49 -0400 (EDT)
Date:   Tue, 6 Jun 2017 12:09:49 -0400
From:   Theodore Ts'o <tytso@mit.edu>
To:     Hector Santos <winserver.support@winserver.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git "Keeping Original Dates"
Message-ID: <20170606160949.cripodprbwxdi4dv@thunk.org>
References: <5935C999.5060801@winserver.com>
 <1C2B896999CB4549BCAC61EB369E932E@blackfat>
 <CACBZZX7VpmEjbzwGd+S15xVLRrkYRxqcf0LUKF1B7pAsd7Lr4w@mail.gmail.com>
 <5935EB1A.5010100@winserver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5935EB1A.5010100@winserver.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 05, 2017 at 07:36:58PM -0400, Hector Santos wrote:
> Do you see any technical issues with using programmable hooks or something
> like this would have to be patched in? I am giving it a serious thought to
> exploring a fix to the Git Daemon over the wire completion issues on
> Windows. It appears to be a Half Close socket issue.

You can certainly do it with so kind of hook script.  

This is how I do thing to maintain the modtimes for a set of patches
that I maintain using guilt (git://repo.or.cz/guilt.git).  The
following is done using Linux, but I imagine you could translate it
into something that would work with powershell, or cygwin, or just use
the Windows Subsystem for Linux.

#!/bin/sh
stat -c "touch -d @%Y %n" * | sort -k 3 | grep -v "~$" | sort -k3 > timestamps

I have this shell script saved as ~/bin/save-timestamps.  The generated file
has lines which look this:

touch -d @1496078695 fix-fdatasync-after-extent-manipulation-operations
touch -d @1496081597 status
touch -d @1496082752 series

... and when you execute the command, it will restore the timestamps
to the value checked into the git repository.  If you want to only
restore the timestamp of a single file, you can do something like this:

grep timestamps ^fix-fdatasync-after-extent | bash

Cheers,

						- Ted
