Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC36C433E1
	for <git@archiver.kernel.org>; Wed, 20 May 2020 08:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 647A5207FB
	for <git@archiver.kernel.org>; Wed, 20 May 2020 08:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETIxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 04:53:45 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:39352 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETIxp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 04:53:45 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49RmkT6lhTz1rvxj;
        Wed, 20 May 2020 10:53:37 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49RmkT6Kv7z1r3kv;
        Wed, 20 May 2020 10:53:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 5YKsHF4LH5SM; Wed, 20 May 2020 10:53:36 +0200 (CEST)
X-Auth-Info: 6WsgKKpTr3bFwNYrB7tjhNHqaRp/ZZ2X/zw8BkX/RGsRHoj/CdxvTHzOJTnAjakx
Received: from igel.home (ppp-46-244-161-158.dynamic.mnet-online.de [46.244.161.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 20 May 2020 10:53:36 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 5C4262C0B3F; Wed, 20 May 2020 10:53:36 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Fetching 24 Linux commits = 1.2 GiB
References: <b7f5bfb9-61fb-2552-4399-b744428728e4@suse.cz>
        <20200415135627.vx75hsphbpmgrquv@chatter.i7.local>
        <xmqq1roo947y.fsf@gitster.c.googlers.com>
X-Yow:  My Aunt MAUREEN was a military advisor to IKE & TINA TURNER!!
Date:   Wed, 20 May 2020 10:53:36 +0200
In-Reply-To: <xmqq1roo947y.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 15 Apr 2020 08:08:17 -0700")
Message-ID: <87sgfvq967.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 15 2020, Junio C Hamano wrote:

> Do these (and I think we saw other reports) make us rethink the
> status of protocol v2 as the default?  Are all of these fallouts 
> we saw so far easy-to-fix bugs, or are there more fundamental issues
> in the v2 protocol design?

I'm now seeing the issue myself, and can provide a backup of the
offending repository.

$ git count-objects -v
count: 17
size: 76
in-pack: 387240
packs: 37
size-pack: 203738
prune-packable: 0
garbage: 0
size-garbage: 0
alternate: /home/andreas/src/linux/git/torvalds/linux.git/objects
alternate: /home/andreas/src/linux/git/stable/linux-stable.git/objects
$ GIT_TRACE=1 git fetch
10:40:32.829450 git.c:439               trace: built-in: git fetch
10:40:33.133448 run-command.c:663       trace: run_command: unset GIT_DIR GIT_IMPLICIT_WORK_TREE GIT_PREFIX; git --git-dir=/daten/src/linux/git/torvalds/linux.git for-each-ref '--format=%(objectname)'
10:40:33.135756 git.c:439               trace: built-in: git for-each-ref '--format=%(objectname)'
10:40:33.143936 run-command.c:663       trace: run_command: unset GIT_DIR GIT_IMPLICIT_WORK_TREE GIT_PREFIX; git --git-dir=/daten/src/linux/git/stable/linux-stable.git for-each-ref '--format=%(objectname)'
10:40:33.146087 git.c:439               trace: built-in: git for-each-ref '--format=%(objectname)'
remote: Enumerating objects: 30796, done.
remote: Counting objects: 100% (30796/30796), done.
remote: Compressing objects: 100% (6965/6965), done.
10:40:40.102198 run-command.c:663       trace: run_command: git index-pack --stdin -v --fix-thin '--keep=fetch-pack 12342 on igel.home' --pack_header=2,7350969
10:40:40.104872 git.c:439               trace: built-in: git index-pack --stdin -v --fix-thin '--keep=fetch-pack 12342 on igel.home' --pack_header=2,7350969
^Cceiving objects:   0% (3092/7350969), 1.32 MiB | 891.00 KiB/s  

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
