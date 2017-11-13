Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D66F1F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 21:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754583AbdKMVVn (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 16:21:43 -0500
Received: from smtp82.iad3a.emailsrvr.com ([173.203.187.82]:56630 "EHLO
        smtp82.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754513AbdKMVVm (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2017 16:21:42 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Nov 2017 16:21:42 EST
Received: from smtp11.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp11.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id AB7525403;
        Mon, 13 Nov 2017 16:13:19 -0500 (EST)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp11.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 8E93755BC;
        Mon, 13 Nov 2017 16:13:19 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 13 Nov 2017 16:13:19 -0500
To:     Git Mailing List <git@vger.kernel.org>
From:   Marc Branchaud <marcnarc@xiplink.com>
Subject: Recovering from gc errors
Message-ID: <4f548c23-7bb5-a672-21bb-6c1dd6de6139@xiplink.com>
Date:   Mon, 13 Nov 2017 16:13:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(I'm using git 2.15.0.)

So today "git gc" started complaining:

error: Could not read 2bc277bcb7e9cc6ef2ea677dd1c3dcd1f9af0c2b
fatal: Failed to traverse parents of commit 
9c355a7726e31b3033b8e714cf7edb4f0a41d8d4
error: failed to run repack

I suspect I'm a victim of the worktree+submodule bugs -- as a longtime 
user of contrib/workdir/git-new-workdir, I've been playing with the 
"worktree" command since it was first introduced.  The "git gc" error 
occurs when it's run in my main repo; I have not tried it in any of my 
worktrees/workdirs.

Various incantations of "git show ... 9c355a7726e31" only fail with the 
same error, so I can't determine much about the problematic commit. 
Luckily I'm not particularly concerned with losing objects, as I push 
any important progress to named refs in backup repos.

But I would like to clean this up in my local repo so that gc stops 
failing.  I tried simply removing this and other loose commits that trip 
up gc (i.e. the objects/9c/355a7726e31b3033b8e714cf7edb4f0a41d8d4 file 
-- there are 49 such files, all of which are several months old), but 
now gc complains of a bad tree object:

error: Could not read c1a99c3520f0b456b8025c50302a4cc9b0b2d777
fatal: bad tree object c1a99c3520f0b456b8025c50302a4cc9b0b2d777
error: failed to run repack

This object is not lying around loose.  "git fsck" lists several 
dangling blob/commit/tree objects, but none of them are c1a99c3520f0b4.

So I'm not sure what to do next.

Any suggestions?

Thanks,

		M.
