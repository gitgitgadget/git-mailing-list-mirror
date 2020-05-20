Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052CAC433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 08:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6DDD2075F
	for <git@archiver.kernel.org>; Wed, 20 May 2020 08:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgETI5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 04:57:10 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:42793 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETI5K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 04:57:10 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49RmpW66P3z1qs0P;
        Wed, 20 May 2020 10:57:07 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49RmpW5Xt8z1r3kv;
        Wed, 20 May 2020 10:57:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id FuzHztvVnjgd; Wed, 20 May 2020 10:57:06 +0200 (CEST)
X-Auth-Info: oPKWYxI7cfrVRyMfjaEVbmKrvrlEOcFqjENYChzQZ/ePC1/nzahMugZt8e0QmmBc
Received: from igel.home (ppp-46-244-161-158.dynamic.mnet-online.de [46.244.161.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 20 May 2020 10:57:06 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 4EA9A2C0B3F; Wed, 20 May 2020 10:57:06 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Fetching 24 Linux commits = 1.2 GiB
References: <b7f5bfb9-61fb-2552-4399-b744428728e4@suse.cz>
        <20200415135627.vx75hsphbpmgrquv@chatter.i7.local>
        <xmqq1roo947y.fsf@gitster.c.googlers.com> <87sgfvq967.fsf@igel.home>
X-Yow:  Why was I BORN?
Date:   Wed, 20 May 2020 10:57:06 +0200
In-Reply-To: <87sgfvq967.fsf@igel.home> (Andreas Schwab's message of "Wed, 20
        May 2020 10:53:36 +0200")
Message-ID: <87o8qjq90d.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mai 20 2020, Andreas Schwab wrote:

> On Apr 15 2020, Junio C Hamano wrote:
>
>> Do these (and I think we saw other reports) make us rethink the
>> status of protocol v2 as the default?  Are all of these fallouts 
>> we saw so far easy-to-fix bugs, or are there more fundamental issues
>> in the v2 protocol design?
>
> I'm now seeing the issue myself, and can provide a backup of the
> offending repository.
>
> $ git count-objects -v
> count: 17
> size: 76
> in-pack: 387240
> packs: 37
> size-pack: 203738
> prune-packable: 0
> garbage: 0
> size-garbage: 0
> alternate: /home/andreas/src/linux/git/torvalds/linux.git/objects
> alternate: /home/andreas/src/linux/git/stable/linux-stable.git/objects
> $ GIT_TRACE=1 git fetch
> 10:40:32.829450 git.c:439               trace: built-in: git fetch
> 10:40:33.133448 run-command.c:663       trace: run_command: unset GIT_DIR GIT_IMPLICIT_WORK_TREE GIT_PREFIX; git --git-dir=/daten/src/linux/git/torvalds/linux.git for-each-ref '--format=%(objectname)'
> 10:40:33.135756 git.c:439               trace: built-in: git for-each-ref '--format=%(objectname)'
> 10:40:33.143936 run-command.c:663       trace: run_command: unset GIT_DIR GIT_IMPLICIT_WORK_TREE GIT_PREFIX; git --git-dir=/daten/src/linux/git/stable/linux-stable.git for-each-ref '--format=%(objectname)'
> 10:40:33.146087 git.c:439               trace: built-in: git for-each-ref '--format=%(objectname)'
> remote: Enumerating objects: 30796, done.
> remote: Counting objects: 100% (30796/30796), done.
> remote: Compressing objects: 100% (6965/6965), done.
> 10:40:40.102198 run-command.c:663       trace: run_command: git index-pack --stdin -v --fix-thin '--keep=fetch-pack 12342 on igel.home' --pack_header=2,7350969
> 10:40:40.104872 git.c:439               trace: built-in: git index-pack --stdin -v --fix-thin '--keep=fetch-pack 12342 on igel.home' --pack_header=2,7350969
> ^Cceiving objects:   0% (3092/7350969), 1.32 MiB | 891.00 KiB/s  

$ git -c protocol.version=1 fetch
remote: Enumerating objects: 13226, done.
remote: Counting objects: 100% (10881/10881), done.
remote: Compressing objects: 100% (2322/2322), done.
remote: Total 10276 (delta 7860), reused 10215 (delta 7818), pack-reused 0
Receiving objects: 100% (10276/10276), 4.13 MiB | 615.00 KiB/s, done.
Resolving deltas: 100% (7860/7860), completed with 192 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k
 + c7630f6386a3...4684d38e4d47 m68k-queue -> m68k-queue  (forced update)
   39d91d3c3b47..e886fc082483  master     -> master

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
