Return-Path: <SRS0=1Io1=D7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEE9C2D0A3
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 22:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A7EF208B6
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 22:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762060AbgJXWMJ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 24 Oct 2020 18:12:09 -0400
Received: from elephants.elehost.com ([216.66.27.132]:23685 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761866AbgJXWMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 18:12:09 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.189.82])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 09OMC0J7036052
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 24 Oct 2020 18:12:00 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <hv@crypt.org>, <git@vger.kernel.org>
References: <202010242019.09OKJTP13180@crypt.org>
In-Reply-To: <202010242019.09OKJTP13180@crypt.org>
Subject: RE: safer git?
Date:   Sat, 24 Oct 2020 18:11:54 -0400
Message-ID: <016001d6aa52$b1cbc510$15634f30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG0te9slIV6tbfjyjRjcOVBcUwWFKnrOPaQ
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 24, 2020 4:19 PM, hv@crypt.org wrote:
> Hi, due to a hardware or firmware issue, my machine is currently crashing
> rather a lot. If that happens around the time I'm performing any git
activity,
> it seems quite likely to cause substantial corruption of the git state.
> 
> I've responded both by running sync(1) every 60 seconds and by pushing
work
> to github more frequently, but the latter isn't appropriate for
everything;
> twice recently I've lost a fair bit of work as a result.
> 
> Q: Is there a mode in which I can run git that would make it a bit more
robust
> against crashes, at the cost of being a bit slower?
> 
> 
> The primary symptom is that files modified shortly before a crash show up
> existing but zero-length after the crash. For source files I mostly know
what
> to do in that situation, but `git fsck` shows a lot of files under
'.git/objects'
> that are empty, which seems to make things hard to recover:
> 
> % git fsck
> error: object file
> .git/objects/0e/f31631726cea2e9bf89d7bbe7b924b5282d533 is empty
> error: unable to mmap
> .git/objects/0e/f31631726cea2e9bf89d7bbe7b924b5282d533: No such file
> or directory
> error: 0ef31631726cea2e9bf89d7bbe7b924b5282d533: object corrupt or
> missing: .git/objects/0e/f31631726cea2e9bf89d7bbe7b924b5282d533
> [... a dozen similar entries ...]
> error: object file
> .git/objects/f5/a9d125645e69a0e40f9bf7a8c90b1c1c4a4ea5 is empty
> error: unable to mmap
> .git/objects/f5/a9d125645e69a0e40f9bf7a8c90b1c1c4a4ea5: No such file or
> directory
> error: f5a9d125645e69a0e40f9bf7a8c90b1c1c4a4ea5: object corrupt or
> missing: .git/objects/f5/a9d125645e69a0e40f9bf7a8c90b1c1c4a4ea5
> Checking object directories: 100% (256/256), done.
> Checking objects: 100% (1577/1577), done.
> error: refs/stash: invalid sha1 pointer
> 0000000000000000000000000000000000000000
> error: bad ref for .git/logs/refs/stash
> dangling commit 1c0ea4e6159952501957012d2b9db7d68b52d107
> %
> 
> Last time I checked out the previous state from github in a new directory
and
> was able to find and copy over most of my work before continuing. On this
> occasion I did a `git stash save` shortly before the crash, and I'm not
sure
> how to get that back. I see René Scharfe's suggestion of:
>   git fsck --unreachable |
>   grep commit | cut -d\  -f3 |
>   xargs git log --merges --no-walk --grep=WIP from a recent message, but
> that is only showing me an older stash item.

I would suggest turning off write-through buffering on your disk. Let writes
complete immediately instead of being deferred to sync. Also, this does feel
like a disk issue, so fsck or chkdsk /f (or whatever) on your disk urgently.

Good luck,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



